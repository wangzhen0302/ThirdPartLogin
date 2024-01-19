
import FBSDKLoginKit

 class WZFaceBookAuthLogin: ThirdPartAuthBase {
    var manager: LoginManager?
    override func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) {
        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    override func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any?) -> Bool {
       return ApplicationDelegate.shared.application(
            application,
            open: url,
            sourceApplication: sourceApplication,
            annotation: annotation)
    }
    
    override func registerThirdPart(clientID:String? = nil, serverClientID: String? = nil) {
        manager = LoginManager.init()
    }
    override func thirdPartAuth(vc: UIViewController, authColsure:@escaping ((_ authInfo: AuthModelInfo?) -> Void)) {
        manager?.logOut()
        manager?.logIn(permissions: ["public_profile", "email"], from: vc) { result, error in
            let authModel = AuthModelInfo()
            guard let token = result?.token?.tokenString else {
                authModel.isSuccess = false
                authModel.reason = error?.localizedDescription
                authColsure(authModel)
                return
            }
            let facebookUserid = result?.token?.userID
            authModel.isSuccess = true
            authModel.accessToken = token
            authModel.thirdPartUserId = facebookUserid
            authColsure(authModel)
            
        }
    }
    
    public func facebookLogOut() {
        manager?.logOut()
    }
}
