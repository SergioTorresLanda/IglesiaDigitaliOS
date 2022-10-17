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
        
        //UserDefaults.standard.set("Prod", forKey: "stage")
        UserDefaults.standard.set("Qa", forKey: "stage")
        let pushManager = PushNotificationManager(userID: "currently_logged_in_user_id")
        pushManager.registerForPN()
        pushManager.postAction()

        let firebaseOptions = FirebaseManager.shared.getGenricAppFirebaseInstance()
        FirebaseApp.configure(options: firebaseOptions)
        FirebaseManager.shared.initSNFirebaseInstance()
        setRemoteConfig()
        
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = false
        IQKeyboardManager.shared.shouldShowToolbarPlaceholder = false
        IQKeyboardManager.shared.keyboardDistanceFromTextField = 50.0
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        openLogin()
        
        return true
        
    }
    
    func setRemoteConfig() {
        guard let app = FirebaseManager.shared.defaultInstance else { return }
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        
        let remote = RemoteConfig.remoteConfig(app: app)
        remote.configSettings = settings
        remote.fetch(withExpirationDuration: 0.0) { [weak remote](remoteConfigFetchStatus, error) in
            switch remoteConfigFetchStatus {
            case .success:
                remote?.activate()
                break
                
            default:
                return
            }
        }
    }
    
    func openLogin() {
        RemoteValues.sharedInstance.loadingDoneCallback = openLoginForReal
    }
    
    func openLoginForReal() {
        let app = FirebaseManager.shared.defaultInstance!
        let remote = RemoteConfig.remoteConfig(app: app)
        let version = remote[ValueKey.version_ios.rawValue].numberValue.doubleValue
        let forceUpdate = remote[ValueKey.force_update_ios.rawValue].boolValue
        let initView = LoginRouter.createModule(version: version, forceUpdate: forceUpdate)
        navigationController = UINavigationController(rootViewController: initView)
        navigationController?.isNavigationBarHidden = true
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
