import AuthenticationServices

class WZAppleAuthLogin: ThirdPartAuthBase {
    //    public static let shared = WZAppleAuthLogin()
    var authColsure: ((_ authInfo:AuthModelInfo?) -> Void)?
    var currentVC: UIViewController?
    override func registerThirdPart(clientID:String? = nil, serverClientID: String? = nil) {
        
    }
    override func thirdPartAuth(vc: UIViewController, authColsure:@escaping ((_ authInfo:AuthModelInfo?) -> Void)) {
        self.currentVC = vc
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        //        let requests = [ASAuthorizationAppleIDProvider().createRequest(),ASAuthorizationPasswordProvider().createRequest()]
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
        self.authColsure = authColsure
    }
    override func loginOut() {
        KeychainItem.deleteUserIdentifierFromKeychain()
    }
}
extension WZAppleAuthLogin: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    public func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            let fullName = appleIDCredential.fullName?.nickname
            let userIdentifier = appleIDCredential.user
            let identityToken = appleIDCredential.identityToken
            let email = appleIDCredential.email
            let identityTokenStr =  String(data: identityToken!, encoding: .utf8)
            self.saveUserInKeychain(userIdentifier)
            let authModel = AuthModelInfo()
            authModel.accessToken = identityTokenStr
            authModel.email = email
            authModel.name = fullName
            authModel.thirdPartUserId = userIdentifier
            authModel.isSuccess = true
            self.authColsure?(authModel)
            
            
        case let passwordCredential as ASPasswordCredential:
            // Sign in using an existing iCloud Keychain credential.
            let username = passwordCredential.user
            let password = passwordCredential.password
        default:
            break
            
        }
    }
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        let err = error as NSError
        let authModel = AuthModelInfo()
        authModel.isSuccess = false
        authModel.errorCode = err.code
        authModel.reason = err.localizedDescription
        self.authColsure?(authModel)
    }
    public override class func cancelPreviousPerformRequests(withTarget aTarget: Any) {
        
    }
    
    private func saveUserInKeychain(_ userIdentifier: String) {
        do {
            try KeychainItem(service: Bundle.main.bundleIdentifier ?? "", account: "userIdentifier").saveItem(userIdentifier)
        } catch {
            print("Unable to save userIdentifier to keychain.")
        }
    }
    public func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        guard let window = UIApplication.shared.delegate?.window as? UIWindow else {
            return ASPresentationAnchor()
        }
        return window
    }
}
// swiftlint:enable line_lengt
