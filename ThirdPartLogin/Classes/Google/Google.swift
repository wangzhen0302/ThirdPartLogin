
import Foundation
import GoogleSignIn




public class WZGoogleSignIn: NSObject {
    public static let shared = WZGoogleSignIn()
    public func registerGoogleSignIn(clientID:String, serverClientID: String)  {
        let clientID = "933998484905-7sfbm975ci4ho6uu5po0l2u0bg8r5mrl.apps.googleusercontent.com"
        let serverClientID = "933998484905-d99bcmubi0mck6ih75e47uiln9m8ekr1.apps.googleusercontent.com"
        let config = GIDConfiguration.init(clientID: clientID, serverClientID: serverClientID)
        GIDSignIn.sharedInstance.configuration =  config
    }
    public func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any?) -> Bool {
       return GIDSignIn.sharedInstance.handle(url)
    }
    
    public func googleAuth(vc: UIViewController, authColsure:@escaping ((_ authInfo:AuthModelInfo?) -> Void)) {
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
    public func googleSignOut() {
        GIDSignIn.sharedInstance.signOut()
    }
    
}

