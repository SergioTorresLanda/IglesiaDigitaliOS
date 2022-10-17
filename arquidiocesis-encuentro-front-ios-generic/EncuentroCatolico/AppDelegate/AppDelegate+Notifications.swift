//
//  APNToken.swift
//  EncuentroCatolico
//
//  Created by 4n4rk0z on 23/03/21.
//

import UIKit
import Firebase
import FirebaseMessaging
import UserNotifications
import FirebaseFirestore
import EncuentroCatolicoLogin

class PushNotificationManager: NSObject {
    
    //MARK: - Methods
    func registerForPN() {
        Messaging.messaging().delegate = self
        
        UNUserNotificationCenter.current().delegate = self
        let authOption: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(options: authOption) { granted, error in
            guard granted else { return }
            
            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
            }
        }
    }
}


//MARK: - UNUserNotificationCenterDelegate
extension PushNotificationManager: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print(response)
    }
}


//MARK: - NotificationExtension
extension AppDelegate {
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let token = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
        
        Messaging.messaging().setAPNSToken(deviceToken, type: .prod)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) { () }
}

//MARK: - MessagingDelegate
extension PushNotificationManager: MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {()}
}
