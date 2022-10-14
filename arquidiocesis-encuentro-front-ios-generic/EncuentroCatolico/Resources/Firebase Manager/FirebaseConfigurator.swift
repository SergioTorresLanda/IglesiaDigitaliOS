//
//  FirebaseConfigurator.swift
//  EncuentroCatolico
//
//  Created by Juan Martell on 13/10/22.
//

import Foundation
import FirebaseCore
import FirebaseRemoteConfig
import Firebase

public class FirebaseConfigurator: NSObject {
    public static var pathAppStoreFileGoogleService = Bundle(for: FirebaseConfigurator.self).path(forResource: "GoogleService-Info", ofType: "plist")
    public static var plistRemoteConfig: String = "RemoteConfigDefaults"
    public static var remoteConfig: RemoteConfig?
    public static func setupFirebase() {
//        FirebaseApp.configure()
        if let plistPath = pathAppStoreFileGoogleService,
                   let options = FirebaseOptions(contentsOfFile: plistPath) {
                    FirebaseApp.configure(options: options)
                }
        FirebaseConfiguration.shared.setLoggerLevel(.error)
                
                let firInstance: FirebaseApp? = FirebaseApp.allApps?.first?.value
                
                if let firInstance = firInstance {
                    let settings = RemoteConfigSettings()
                    settings.minimumFetchInterval = 0
                    
                    remoteConfig = RemoteConfig.remoteConfig(app: firInstance)
                    remoteConfig?.configSettings = settings
                    remoteConfig?.setDefaults(fromPlist: plistRemoteConfig)
                    
                    remoteConfig?.fetch(withExpirationDuration: 0.0) { [weak remoteConfig] (remoteConfigFetchStatus, error) in
                        if remoteConfigFetchStatus == .success {
                            remoteConfig?.activate()
                        }
                        if let error = error {
                           
                        }
                    }
                }
    }
}

