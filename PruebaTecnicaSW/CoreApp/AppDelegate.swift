//
//  AppDelegate.swift
//  PruebaTecnicaSW
//
//  Created by Sergio Ulloa López on 08/08/2020.
//  Copyright © 2020 Sergio Ulloa. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appInitializer = AppInitializer()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        if self.window != nil {
            if self.appInitializer.passSecurityValidations() {
                self.appInitializer.installRootViewController()
            }
        }
        
        return true
    }


}

