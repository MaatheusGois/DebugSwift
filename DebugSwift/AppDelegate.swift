//
//  AppDelegate.swift
//  DebugSwift
//
//  Created by Matheus Gois on 2023/12/12.
//  Copyright © 2023 apple. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        self.window = UIWindow(frame: UIScreen.main.bounds)
        let navigation = UINavigationController(
            rootViewController: TabBarController()
        )
        self.window?.rootViewController = navigation
        self.window?.makeKeyAndVisible()

        UIView.swizzleMethods() // Change to configuration
        UIWindow.db_swizzleMethods()
        return true
    }

}