//
//  AppDelegate.swift
//  BackgroundNotification
//
//  Created by youngjun goo on 2019/10/05.
//  Copyright © 2019 youngjun goo. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    
    func applicationWillResignActive(_ application: UIApplication) {
         //Setting content of the notification
               let content = UNMutableNotificationContent()
               content.title = "This is title : Zedd"
               content.subtitle = "This is Subtitle : UserNotifications tutorial"
               content.body = "This is Body : 블로그 글 쓰기"
               content.summaryArgument = "Alan Walker"
               content.summaryArgumentCount = 40
               
               //Setting time for notification trigger
               //블로그 예제에서는 TimeIntervalNotificationTrigger을 사용했지만, UNCalendarNotificationTrigger사용법도 같이 올려놓을게요!
               
               
               //1. Use UNCalendarNotificationTrigger
               let date = Date(timeIntervalSinceNow: 70)
               let dateCompenents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
               
               _ = UNCalendarNotificationTrigger(dateMatching: dateCompenents, repeats: true)
               
               
               //2. Use TimeIntervalNotificationTrigger
               let TimeIntervalTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
               
               //Adding Request
               // MARK: - identifier가 다 달라야만 Notification Grouping이 됩니닷..!!
               let request = UNNotificationRequest(identifier: "wakeup", content: content, trigger: TimeIntervalTrigger)
               
               UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }

}

