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
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?
    var deviceAppToken : String!
    let notificationCenter = UNUserNotificationCenter.current()


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {


        IQKeyboardManager.shared.enable = true
        //IQKeyboardManager.shared.toolbarPreviousNextAllowedClasses.add(UIStackView.self)
       
        // TODO:- Ask user for Notification permission
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) {
            (granted, error) in
            guard granted else { return }
            DispatchQueue.main.async {
                self.notificationCenter.delegate = self
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

    func application(_ application: UIApplication,didReceiveRemoteNotification userInfo: [AnyHashable: Any],fetchCompletionHandler completionHandler:@escaping (UIBackgroundFetchResult) -> Void) {

        let state : UIApplication.State = application.applicationState
        if (state == .inactive || state == .background) {
            // go to screen relevant to Notification content
            print("background")
        } else {
            // App is in UIApplicationStateActive (running in foreground)
            print("foreground")
            // showLocalNotification()
        }
    }

    //MARK:- Set UserNotification Center
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void)
    {
        completionHandler([UNNotificationPresentationOptions.alert,UNNotificationPresentationOptions.sound,UNNotificationPresentationOptions.badge])

        // completionHandler([.alert, .sound])
        let userInfoApns = notification.request.content.userInfo
        print(userInfoApns)

        if UIApplication.shared.applicationState == .background || UIApplication.shared.applicationState == .inactive || UIApplication.shared.applicationState == .active {

            NotificationCenter.default.post(name: Notification.Name(rawValue: "reloadChatListTable"), object: nil)
        }
    }


    // This function will be called right after user tap on the notification
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {




        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        if let chatViewController = storyboard.instantiateViewController(withIdentifier: "ChatVC") as? ChatVC, let tabBar = storyboard.instantiateViewController(withIdentifier: "mainTabVC") as? mainTabVC {
            let navigationController = UINavigationController(rootViewController: chatViewController)
            navigationController.viewControllers = [chatViewController]
            tabBar.viewControllers = [navigationController]
            window?.rootViewController = tabBar
        }
        NotificationCenter.default.post(name: Notification.Name(rawValue: "GoToChatListAfterNotificationClicked"), object: nil)
        completionHandler()
    }





    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {

        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        
    }
}

