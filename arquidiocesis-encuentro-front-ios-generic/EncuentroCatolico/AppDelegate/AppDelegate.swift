//
//  AppDelegate.swift
//  EncuentroCatolico
//
//  Created by Diego Martinez on 04/02/21.
//

import UIKit
import Firebase
import IQKeyboardManagerSwift
import EncuentroCatolicoHome
import FirebaseAnalytics
@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    //MARK: - Properties
    var window: UIWindow?
    var navigationController: UINavigationController?
    var sosType = UserDefaults.standard.bool(forKey: "isPriest")
    var APIValue = UserDefaults.standard.string(forKey: "stage")
    let notificationPush: PushNotificationManager = PushNotificationManager()
    
    //MARK: - Methods
    func openLogin() {
        RemoteValues.sharedInstance.loadingDoneCallback = openLoginForReal
    }
    
    //MARK: - Life cycle
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //UserDefaults.standard.set("Qa", forKey: "stage")
        UserDefaults.standard.set("Prod", forKey: "stage")

        let firebaseOptions = FirebaseManager.shared.getGenricAppFirebaseInstance()
        FirebaseApp.configure(options: firebaseOptions)
        //FirebaseApp.configure()
        Analytics.setAnalyticsCollectionEnabled(true)
        FirebaseManager.shared.initSNFirebaseInstance() 
        setRemoteConfig()
        
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = false
        IQKeyboardManager.shared.shouldShowToolbarPlaceholder = false
        IQKeyboardManager.shared.keyboardDistanceFromTextField = 50.0
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        openLogin()
        
        notificationPush.registerForPN()
        return true
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        checkForceReloadFirebase()
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        NotificationCenter.default.post(name: Notification.Name("appBecomeActive"), object: nil)
    }
    
    func popToRoot(_ application: UIApplication) {
        NotificationCenter.default.post(name: Notification.Name("poptoroot"), object: nil)
    }
}
