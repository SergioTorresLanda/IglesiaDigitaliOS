//
//  RemoteConfigConfigurator.swift
//  EncuentroCatolico
//
//  Created by Juan Martell on 13/10/22.
//

import Foundation
import FirebaseRemoteConfig
import FirebaseCore
public class RemoteConfigConfigurator {
    public static func reload() {
        if FirebaseConfigurator.remoteConfig == nil,
           let firInstance = FirebaseApp.allApps?.first(where: { (_, firebaseApp) in
               return firebaseApp.name == "__FIRAPP_DEFAULT"
           })?.value {
            
            let settings = RemoteConfigSettings()
            settings.minimumFetchInterval = 0
            
            FirebaseConfigurator.remoteConfig = RemoteConfig.remoteConfig(app: firInstance)
            FirebaseConfigurator.remoteConfig?.configSettings = settings
            FirebaseConfigurator.remoteConfig?.setDefaults(fromPlist: FirebaseConfigurator.plistRemoteConfig)
        }
        
        FirebaseConfigurator.remoteConfig?.fetch(withExpirationDuration: 0.0) { (remoteConfigFetchStatus, error) in
            if remoteConfigFetchStatus == .success {
                FirebaseConfigurator.remoteConfig?.activate()
            }

        }
    }
}
extension RemoteConfig {
    
    public func fetchRemoteConfig(defaultInfo: [String: NSObject],
                                  withExpirationDuration expirationDuration: Double = 60.0,
                                  handler: ((RemoteConfigFetchStatus, Error?) -> Void)? = nil ) {
        self.setDefaults(defaultInfo)
        self.fetch(withExpirationDuration: expirationDuration) { status, error in
            handler?(status, error)
        }
    }
    
    public func fetchRemoteConfig(plistName: String,
                                  fromBundle aBundle: Bundle = .main,
                                  withExpirationDuration expirationDuration: Double = 60.0,
                                  handler: ((RemoteConfigFetchStatus, Error?) -> Void)? = nil ) {
        DispatchQueue.main.async {
            if let plistPath = aBundle.path(forResource: plistName, ofType: "plist"),
               let defaultInfo = NSDictionary(contentsOfFile: plistPath) as? [String: NSObject] {
                self.setDefaults(defaultInfo)
            }
            self.fetch(withExpirationDuration: expirationDuration) { status, error in
                handler?(status, error)
            }
        }
    }
    
    public func remoteBool(forKey key: String) -> Bool {
        return self.configValue(forKey: key).boolValue
    }
    
    public func remoteData(forKey key: String) -> Data {
        return self.configValue(forKey: key).dataValue
    }
    
    public func remoteNumber(forKey key: String) -> NSNumber {
        return self.configValue(forKey: key).numberValue
    }
    
    public func remoteString(forKey key: String) -> String? {
        return self.configValue(forKey: key).stringValue
    }
    
    public func remoteJsonInfo(forKey key: String) -> Any? {
        return self.configValue(forKey: key).jsonValue
    }
}
