//
//  ThirdPartAuthBase.swift
//  ThirdPartLogin
//
//  Created by tzone on 2024/1/18.
//

import Foundation

class ThirdPartAuthBase: NSObject {
    
    required override init() {
        super.init()
    }
    public func registerThirdPart(clientID:String? = nil, serverClientID: String? = nil) {
        
    }
    public func thirdPartAuth(vc: UIViewController, authColsure:@escaping ((_ authInfo: AuthModelInfo?) -> Void)) {
        
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any?) -> Bool {
       return false
    }
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) {
        
    }
}
