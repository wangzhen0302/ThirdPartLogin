//
//  AppDelegate.swift
//  ThirdPartLogin
//
//  Created by wangzhen0302 on 01/05/2024.
//  Copyright (c) 2024 wangzhen0302. All rights reserved.
//

import UIKit
import ThirdPartLogin
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        ThirdPartLoginManager.shared.registerThirdPart(type: .apple)
        ThirdPartLoginManager.shared.registerThirdPart(type: .facebook)
        let clientID = "933998484905-7sfbm975ci4ho6uu5po0l2u0bg8r5mrl.apps.googleusercontent.com"
        let serverClientID = "933998484905-d99bcmubi0mck6ih75e47uiln9m8ekr1.apps.googleusercontent.com"
        ThirdPartLoginManager.shared.registerThirdPart(type: .google, clientID: clientID, serverClientID: serverClientID)
//        ThirdPartLoginManager.shared.application(application: application, didFinishLaunchingWithOptions: launchOptions)
        
        return true
    }
//    func application(
//        _ app: UIApplication,
//        open url: URL,
//        options: [UIApplication.OpenURLOptionsKey: Any] = [:]
//    ) -> Bool {
//        
//        if ThirdPartLoginManager.shared.application(application: app, open: url, sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String, annotation: options) {
//            return true
//        }
//        
//        return false
//    }
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

