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

class PushNotificationManager: NSObject, MessagingDelegate, UNUserNotificationCenterDelegate {
    
    let userID: String
    init(userID: String) {
        self.userID = userID
        super.init()
    }
    
    func registerForPN() {
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().delegate = self
            let authOption: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOption,
                completionHandler: {_,_ in})
            
            Messaging.messaging().delegate = self
        } else {
            let settings: UIUserNotificationSettings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            UIApplication.shared.registerUserNotificationSettings(settings)
        }
        
        UIApplication.shared.registerForRemoteNotifications()
        updateFireStorePushTokenIfNeeded()
    }
    
    func updateFireStorePushTokenIfNeeded() {
        if let token = Messaging.messaging().fcmToken {
            let usersRef = Firestore.firestore().collection("users_table").document(userID)
            usersRef.setData(["fcmToken" : token], merge: true)
        }
    }
 
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        updateFireStorePushTokenIfNeeded()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print(response)
    }
    
    public func postAction() {
        let Url = String(format: "\(APIType.shared.Auth())/user/token")
        guard let serviceUrl = URL(string: Url) else { return }
        let idUser = UserDefaults.standard.integer(forKey: "id")
    let parameterDictionary: [String : Any] = [
        "token" : Messaging.messaging().fcmToken ?? ""
        ]
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "POST"
        let tksession = UserDefaults.standard.string(forKey: "idToken")
        request.setValue("Bearer \( tksession ?? "")", forHTTPHeaderField: "Authorization")
        request.setValue("\(idUser)", forHTTPHeaderField: "X-User-Id")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDictionary, options: []) else {
            return
        }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
            }
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                } catch {
                    print(error)
                    APIType.shared.refreshToken()
                }
            }
        }.resume()
    }
    
}
