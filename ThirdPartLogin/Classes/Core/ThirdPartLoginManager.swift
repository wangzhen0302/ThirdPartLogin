//
//  ThirdPartLoginManager.swift
//  ThirdPartLogin
//
//  Created by tzone on 2024/1/5.
//

import Foundation

public class AuthModelInfo {
    var isSuccess: Bool = false
    var errorCode:Int?
    var reason: String?
    
    var accessToken: String?
    var refreshToken: String?
    var email: String?
    var name: String?
    var iconUrl: String?
    var thirdPartUserId: String?
}
public enum ThirdPartType {
    case apple
    case google
    case facebook
    case unknown
}
class AIAdInstance {
    var authType: ThirdPartType = .unknown
    var authInstance: ThirdPartAuthBase?
}
public class ThirdPartLoginManager: NSObject {
    public static let shared = ThirdPartLoginManager()
    var thirdPartInstance: [AIAdInstance] = [AIAdInstance]()
    public func registerThirdPart(type:ThirdPartType,clientID:String? = nil, serverClientID: String? = nil) {
        
        if let item = getAdInstance(authType: type) {
            if item.authInstance == nil {
                item.authInstance = ThirdPartLoginManager.shared.getThirdPartClassInstance(type: type)
            }
        } else {
            let newItem = AIAdInstance()
            newItem.authType = type
            newItem.authInstance = ThirdPartLoginManager.shared.getThirdPartClassInstance(type: type)
            if type == .google {
                guard let clid = clientID, let selid = serverClientID else {
                    print("goole auth init need clientID and serverClientID")
                    return
                }
                newItem.authInstance?.registerThirdPart(clientID: clid, serverClientID: selid)
                thirdPartInstance.append(newItem)
            } else {
                newItem.authInstance?.registerThirdPart(clientID: clientID, serverClientID: serverClientID)
                thirdPartInstance.append(newItem)
            }
            
        }
    }
    public func thirdPartAuth(type:ThirdPartType, vc: UIViewController, authColsure:@escaping ((_ authInfo: AuthModelInfo?) -> Void)) {
        let item = getAdInstance(authType: type)
        item?.authInstance?.thirdPartAuth(vc: vc, authColsure: authColsure)
        
    }
    public func application(application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any?) -> Bool {
        if let authInstance = getAdInstance(authType: .facebook)?.authInstance {
           return authInstance.application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
        } else {
            return false
        }
    }
    public func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) {
        if let authInstance = getAdInstance(authType: .facebook)?.authInstance {
            authInstance.application(application, didFinishLaunchingWithOptions: launchOptions)
        }
    }
    public func loginOut(type:ThirdPartType) {
        guard let instance = self.getThirdPartClassInstance(type: type) else { return }
        instance.loginOut()
    }
    func getAdInstance(authType: ThirdPartType) -> AIAdInstance? {
        for item in self.thirdPartInstance {
            if item.authType == authType {
                return item
            }
        }
        return nil
    }
}
