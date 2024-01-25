
import Foundation
import GoogleSignIn



class WZGoogleSignIn: ThirdPartAuthBase {
    
    
    override func registerThirdPart(clientID:String? = nil, serverClientID: String? = nil) {
        guard let clid = clientID, let selid = serverClientID else {
            print("goole auth init need clientID and serverClientID")
            return
        }
        let config = GIDConfiguration.init(clientID: clid, serverClientID: selid)
        GIDSignIn.sharedInstance.configuration =  config
    }
    override func thirdPartAuth(vc: UIViewController, authColsure:@escaping ((_ authInfo: AuthModelInfo?) -> Void)) {
        GIDSignIn.sharedInstance.signOut()
        GIDSignIn.sharedInstance.signIn(withPresenting: vc) { result, error in
            
            let authModel = AuthModelInfo()
            guard error == nil else {
                authModel.isSuccess = false
                authColsure(authModel)
                return
            }
            guard let idToken = result?.user.idToken?.tokenString else {
                authColsure(authModel)
                authModel.isSuccess = false
                authModel.reason = error?.localizedDescription
                authColsure(authModel)
                return
            }
            authModel.isSuccess = true
            authModel.accessToken = result?.user.accessToken.tokenString
            authModel.refreshToken = result?.user.refreshToken.tokenString
            authModel.name = result?.user.profile?.name
            authModel.email = result?.user.profile?.email
            authColsure(authModel)
            //            authModel.iconUrl = result?.user.profile?.imageURL(withDimension: 80)
        }
    }

    override func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any?) -> Bool {
       return GIDSignIn.sharedInstance.handle(url)
    }
    override func loginOut() {
        GIDSignIn.sharedInstance.signOut()
    }
    
}

