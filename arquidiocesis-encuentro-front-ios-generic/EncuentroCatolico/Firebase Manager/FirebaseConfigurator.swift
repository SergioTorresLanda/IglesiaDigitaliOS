//
//  FirebaseConfigurator.swift
//  EncuentroCatolico
//
//  Created by Juan Martell on 13/10/22.
//

import Foundation
import FirebaseCore
import FirebaseRemoteConfig

public class FirebaseConfigurator: NSObject {
    public static var plistRemoteConfig: String = "PropertiesRemoteConfig"
    public static var remoteConfig: RemoteConfig?
    static func setupFirebase() {
        if let plist = Bundle(for: AppDelegate.self).path(forResource: "GoogleService-Info", ofType: "plist"),
            let options = FirebaseOptions(contentsOfFile: plist) {
            FirebaseApp.configure(options: options)
        }
        
        FirebaseConfiguration.shared.setLoggerLevel(.error)
        
        let firInstance: FirebaseApp? = FirebaseApp.allApps?.first?.value
        
        if let firInstance = firInstance {
            let settings = RemoteConfigSettings()
            settings.minimumFetchInterval = 0
            
            remoteConfig = RemoteConfig.remoteConfig(app: firInstance)
            remoteConfig?.configSettings = settings
//            remoteConfig?.setDefaults(fromPlist: plistRemoteConfig)
            remoteConfig?.setDefaults(fromPlist: plistRemoteConfig)
            
            remoteConfig?.fetch(withExpirationDuration: 0.0) { [weak remoteConfig] (remoteConfigFetchStatus, error) in
                if remoteConfigFetchStatus == .success {
                    remoteConfig?.activate()
                }
            }
        }
    }
}
