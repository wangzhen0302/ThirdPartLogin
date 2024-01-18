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
}
public protocol ThirdPartLoginManagerDelegate {
    func registerFaceBookAuth(clientID: String, serverClientID: String,target:NSObject)
    func registerGoogleAuth(clientID: String, serverClientID: String,target:NSObject)
}
public class ThirdPartLoginManager: NSObject {
    static let shared = ThirdPartLoginManager()
    public var delegate: ThirdPartLoginManagerDelegate?
    func registerThirdPart(type:ThirdPartType,clientID:String, serverClientID: String) {
        if type == .facebook {
            ThirdPartLoginManager.shared.delegate?.registerFaceBookAuth(clientID: clientID, serverClientID: serverClientID, target: self)
        } else if type == .google {
            ThirdPartLoginManager.shared.delegate?.registerGoogleAuth(clientID: clientID, serverClientID: serverClientID, target: self)
        }
    }
}
