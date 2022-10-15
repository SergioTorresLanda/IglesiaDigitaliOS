//
//  RemoteValue.swift
//  EncuentroCatolico
//
//  Created by Miguel Vicario on 14/10/2022.
//

import Foundation
import Firebase

enum ValueKey: String {
    case version_ios
    case force_update_ios
}

class RemoteValues {
    static let sharedInstance = RemoteValues()
    var loadingDoneCallback: (() -> Void)?
    var fetchComplete = false

    private init() {
        loadDefaultValues()
    }

    func loadDefaultValues() {
        let appDefaults: [String: Any?] = [
            ValueKey.version_ios.rawValue: "0.0",
            ValueKey.force_update_ios.rawValue: false
        ]
      
        guard let app = FirebaseManager.shared.defaultInstance else { return }
        RemoteConfig.remoteConfig(app: app).setDefaults(appDefaults as? [String: NSObject])
        fetchCloudValues()
    }

    func fetchCloudValues() {
        guard let app = FirebaseManager.shared.defaultInstance else { return }
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        
        let remote = RemoteConfig.remoteConfig(app: app)
        remote.configSettings = settings
        remote.fetch(withExpirationDuration: 0.0) { [weak remote](remoteConfigFetchStatus, error) in
            
            switch remoteConfigFetchStatus {
            case .success:
                remote?.activate {changed, error in
                    self.fetchComplete = true
                    DispatchQueue.main.async {
                        self.loadingDoneCallback?()
                    }
                }
                break
                
            default:
                DispatchQueue.main.async {
                    self.loadingDoneCallback?()
                }
                break
            }
        }
    }

  func bool(forKey key: ValueKey) -> Bool {
      RemoteConfig.remoteConfig()[key.rawValue].boolValue
  }

  func string(forKey key: ValueKey) -> String {
      RemoteConfig.remoteConfig()[key.rawValue].stringValue ?? ""
  }

  func double(forKey key: ValueKey) -> Double {
      RemoteConfig.remoteConfig()[key.rawValue].numberValue.doubleValue
  }
}
