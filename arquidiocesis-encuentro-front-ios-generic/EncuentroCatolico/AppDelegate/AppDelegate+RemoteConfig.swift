//
//  AppDelegate+RemoteConfig.swift
//  EncuentroCatolico
//
//  Created by Alejandro on 16/10/22.
//

import Foundation
import Firebase
import EncuentroCatolicoLogin

//MARK: - Remote Config
extension AppDelegate {
    //MARK: - Methods
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
    
    func openLoginForReal() {
        guard let app = FirebaseManager.shared.defaultInstance else {
            return
        }
        
        let remote = RemoteConfig.remoteConfig(app: app)
        let version = remote[ValueKey.version_ios.rawValue].numberValue.doubleValue
        let forceUpdate = remote[ValueKey.force_update_ios.rawValue].boolValue
        let initView = LoginRouter.createModule(version: version, forceUpdate: forceUpdate)
        navigationController = UINavigationController(rootViewController: initView)
        navigationController?.isNavigationBarHidden = true
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
    func checkForceReloadFirebase() {
       let forceFirebaseUpdateDefaultsKey = "USRDEFAULTS_FORCE_FIREBASE_UPDATE"
       let shouldReload: Bool
       
       if let lastTimeForcedFirebaseUpdate = UserDefaults.standard.value(forKey: forceFirebaseUpdateDefaultsKey) as? Date,
          let differenceInMinutes = Date.getDifferenceBetweenDates(from: lastTimeForcedFirebaseUpdate, components: [.minute]).minute {
           shouldReload = differenceInMinutes >= 15
       } else {
           shouldReload = true
       }
       
       if shouldReload {
           UserDefaults.standard.set(Date(), forKey: forceFirebaseUpdateDefaultsKey)
           setRemoteConfig()
       }
   }
}

