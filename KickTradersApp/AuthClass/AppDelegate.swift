//
//  AppDelegate.swift
//  KickTradersApp
//
//  Created by anil kumar on 15/10/20.
//  Copyright © 2020 VikasSIngh. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

   

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
      
        //TODO:- Set Paypal credential
        PayPalMobile.initializeWithClientIds(forEnvironments: [PayPalEnvironmentSandbox:"AS86-0SRgY00ibp3Sm8hWzF3b-gfdd0FvM7-sRJ5dGGS65GaRB3gVDPxP2P1lfDTPPxzswZlveBKhWaO"])
      
        
        //RunLoop.current.run(until: Date(timeIntervalSinceNow: 5.0))
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
       
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        
    }


}

