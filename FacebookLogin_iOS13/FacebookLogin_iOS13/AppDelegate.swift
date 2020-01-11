//
//  AppDelegate.swift
//  FacebookLogin_iOS13
//
//  Created by youngjun goo on 2020/01/10.
//  Copyright © 2020 youngjun goo. All rights reserved.
//

import UIKit
import FBSDKLoginKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication,
                     supportedInterfaceOrientationsFor window: UIWindow?)
        -> UIInterfaceOrientationMask {
            return [.portrait, .landscape]
    }
    
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?)
        -> Bool {
            ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
            return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        AppEvents.activateApp()
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        guard let scheme = url.scheme else { return true }
        if #available(iOS 9.0, *) {
            let sourceApplication: String? = options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String
            if scheme.contains("fb") {
                return ApplicationDelegate.shared.application(app, open: url.absoluteURL, sourceApplication: sourceApplication, annotation: nil)
            }
        }
        return true
    }

    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        guard let scheme = url.scheme else { return true }
        if scheme.contains("fb") {
            return ApplicationDelegate.shared.application(application, open: url.absoluteURL, sourceApplication: sourceApplication, annotation: annotation)
        }
        return true
    }
}

