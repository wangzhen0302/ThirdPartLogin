//
//  ThirdPartLoginManager+Extension.swift
//  ThirdPartLogin
//
//  Created by tzone on 2024/1/18.
//

import Foundation




extension ThirdPartLoginManager {
    enum ThirdPartAuthClassName: String {
        case facebook = "WZFaceBookAuthLogin"
        case google = "WZGoogleSignIn"
        case apple = "WZAppleAuthLogin"
    }
    func getThirdPartClassInstance(type: ThirdPartType) -> ThirdPartAuthBase? {
        var className: ThirdPartAuthClassName?
        switch type {
        case .apple:
            className = ThirdPartAuthClassName.apple
        case .facebook:
            className = ThirdPartAuthClassName.facebook
        case .google:
            className = ThirdPartAuthClassName.google
        default:
            break
        }
        if let className = className, className.rawValue.count > 0 {
            let classStringName = "ThirdPartLogin" + "." + className.rawValue
            let classObj: AnyClass? = NSClassFromString(classStringName)
            if let classObj = classObj as? ThirdPartAuthBase.Type {
                return classObj.init()
            }
        }
        return nil
    }
}
