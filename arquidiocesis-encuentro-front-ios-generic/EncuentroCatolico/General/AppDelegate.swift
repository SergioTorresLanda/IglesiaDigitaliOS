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
import EncuentroCatolicoLogin

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    //MARK: - Properties
    var window: UIWindow?
    var navigationController: UINavigationController?
    var sosType = UserDefaults.standard.bool(forKey: "isPriest")
    var APIValue = UserDefaults.standard.string(forKey: "stage")
    //MARK: - Life cycle
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        UNUserNotificationCenter.current().delegate = self
        
        UserDefaults.standard.set("Prod", forKey: "stage")
        let pushManager = PushNotificationManager(userID: "currently_logged_in_user_id")
        pushManager.registerForPN()
        pushManager.postAction()

        let firebaseOptions = FirebaseManager.shared.getGenricAppFirebaseInstance()
        FirebaseApp.configure(options: firebaseOptions)
        
        FirebaseManager.shared.initSNFirebaseInstance()
        
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = false
        IQKeyboardManager.shared.shouldShowToolbarPlaceholder = false
        IQKeyboardManager.shared.keyboardDistanceFromTextField = 50.0
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        openLogin()
        
        return true
        
    }
    
    func openLogin() {
        if RemoteValues.sharedInstance.fetchComplete {
            openLoginForReal()
        }

        RemoteValues.sharedInstance.loadingDoneCallback = openLoginForReal
    }
    
    func openLoginForReal() {
        let version = RemoteValues.sharedInstance.double(forKey: .version_ios)
        let forceUpdate = RemoteValues.sharedInstance.bool(forKey: .force_update_ios)
        let initView = LoginRouter.createModule(forceUpdate: forceUpdate)
        navigationController = UINavigationController(rootViewController: initView)
        navigationController?.isNavigationBarHidden = true
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
