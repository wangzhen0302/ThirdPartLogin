
import FBSDKLoginKit
extension WZFaceBookAuthLogin: ThirdPartLoginManagerDelegate {
    public func registerFaceBookAuth(clientID: String, serverClientID: String, target: NSObject) {
        WZFaceBookAuthLogin.shared.registerFaceBookSignIn(clientID: clientID, serverClientID: serverClientID)
    }
    
    public func registerGoogleAuth(clientID: String, serverClientID: String, target: NSObject) {
        WZFaceBookAuthLogin.shared.registerFaceBookSignIn(clientID: clientID, serverClientID: serverClientID)
    }
    
}
public class WZFaceBookAuthLogin: NSObject {
    public static let shared = WZFaceBookAuthLogin()
    var manager: LoginManager?
    public func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) {
        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    public func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any?) -> Bool {
       return ApplicationDelegate.shared.application(
            application,
            open: url,
            sourceApplication: sourceApplication,
            annotation: annotation)
    }
    
    public func registerFaceBookSignIn(clientID:String, serverClientID: String)  {
        manager = LoginManager.init()
    }
    
    public func facebookAuth(vc: UIViewController, authColsure:@escaping ((_ authInfo:AuthModelInfo?) -> Void)) {
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
