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
        fetchCloudValues()
    }

    func loadDefaultValues() {
        let appDefaults: [String: Any?] = [
            ValueKey.version_ios.rawValue: "0.0",
            ValueKey.force_update_ios.rawValue: false
        ]
      
        guard let app = FirebaseManager.shared.defaultInstance else { return }
        RemoteConfig.remoteConfig(app: app).setDefaults(appDefaults as? [String: NSObject])
    }

    func fetchCloudValues() {
        guard let app = FirebaseManager.shared.defaultInstance else { return }
        RemoteConfig.remoteConfig(app: app).fetch {_, error in
            if let error = error {
            // In a real app, you would probably want to call the loading done callback anyway,
            // and just proceed with the default values. I won't do that here, so we can call attention
            // to the fact that Remote Config isn't loading.
            return
        }
            
            RemoteConfig.remoteConfig(app: FirebaseManager.shared.defaultInstance!).activate {changed, error in
                self.fetchComplete = true
                
                DispatchQueue.main.async {
                    self.loadingDoneCallback?()
                }
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
