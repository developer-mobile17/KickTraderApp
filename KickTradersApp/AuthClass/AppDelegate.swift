//
//  AppDelegate.swift
//  KickTradersApp
//
//  Created by anil kumar on 15/10/20.
//  Copyright © 2020 VikasSIngh. All rights reserved.
//

import UIKit
import UserNotifications
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {


    var deviceAppToken : String!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {


        IQKeyboardManager.shared.enable = true
//        IQKeyboardManager.shared.toolbarPreviousNextAllowedClasses.add(UIStackView.self)
        //TODO:- Set Paypal credential
        PayPalMobile.initializeWithClientIds(forEnvironments: [PayPalEnvironmentSandbox:"AS86-0SRgY00ibp3Sm8hWzF3b-gfdd0FvM7-sRJ5dGGS65GaRB3gVDPxP2P1lfDTPPxzswZlveBKhWaO"])
      
       // TODO:- Ask user for Notification permission
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) {
        (granted, error) in
        guard granted else { return }
        DispatchQueue.main.async {
        UIApplication.shared.registerForRemoteNotifications()
        }
        }


        return true

    }



//MARK:- Register the app with APN server.


    func application(
      _ application: UIApplication,
      didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
    ) {
      let tokenParts = deviceToken.map { data in String(format: "%02.2hhx", data) }
      let token = tokenParts.joined()
      print("Device Token: \(token)")
      UserDefaults.standard.set(token, forKey: "AppDeviceToken")
    }



    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
    print("failed to register for remote notifications: \(error.localizedDescription)")
    }


    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
    print("Received push notification: \(userInfo)")
    let aps = userInfo["aps"] as! [String: Any]
    print("\(aps)")
    }



    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
       
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        
    }


}
extension String {
    public init(deviceToken: Data) {
        self = deviceToken.map { String(format: "%.2hhx", $0) }.joined()
    }
}

