//
//  AppDelegate.swift
//  MyStudyApp
//
//  Created by Carki on 2022/11/07.
//

import UIKit
import UserNotifications

import IQKeyboardManagerSwift
import FirebaseCore
import FirebaseAuth
import FirebaseMessaging
import RealmSwift


@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = false
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true //뷰 터치제스쳐, 키보드 자동으로 내림
        
        FirebaseApp.configure()
        Messaging.messaging().delegate = self
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { _, _ in
            
        }
        application.registerForRemoteNotifications()
        
        //마이그레이션
        // 1. config 설정(이전 버전에서 다음 버전으로 마이그레이션될때 어떻게 변경될것인지)
        let config = Realm.Configuration(
            schemaVersion: 3, // 새로운 스키마 버전 설정
            migrationBlock: { migration, oldSchemaVersion in
                if oldSchemaVersion < 2 {
                    
                }
            }
        )
        
        // 2. Realm이 새로운 Object를 쓸 수 있도록 설정
        Realm.Configuration.defaultConfiguration = config
        
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


}

extension AppDelegate: UNUserNotificationCenterDelegate, MessagingDelegate {
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Auth.auth().setAPNSToken(deviceToken, type: AuthAPNSTokenType.unknown)
    }
    
    //메시징 관련
    public func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        let firebaseToken = fcmToken ?? ""
        UserDefaults.standard.set(firebaseToken, forKey: "firebaseToken")
        print("firebase token: \(firebaseToken)")
        
        
    }
    
    public func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .badge, .sound])
    }
    
    public func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }
}

