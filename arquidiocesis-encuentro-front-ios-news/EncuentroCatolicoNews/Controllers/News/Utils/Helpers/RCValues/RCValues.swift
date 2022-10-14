//
//  RCValues.swift
//  RedSocialFramework
//
//  Created by Miguel Angel Vicario Flores on 22/10/20.
//  Copyright © 2020 Gabriel Briseño. All rights reserved.
//

import Foundation

//enum ValueKey: String {
//  case limit_characters_post
//  case date_init_post
//  case limit_comments_of_comments
//  case limit_comments
//  case max_length_all_post
//}

//public class RCValues {
//
//    static let sharedInstance = RCValues()
//    public var loadingDoneCallback: (() -> Void)?
//
//    private init() {
//        loadDefaultValues()
//        fetchCloudValues()
//    }
//
//    func loadDefaultValues() {
//        guard let firebase_instance = SocialNetworkConstant.shared.instance else {
//            debugPrint("ProspectosInteractor error: firebase instance was nil.")
//            return
//        }
//
//        let appDefaults: [String: Any?] = [
//            ValueKey.limit_characters_post.rawValue: 500,
//            ValueKey.date_init_post.rawValue: 1599082993227,
//            ValueKey.limit_comments_of_comments.rawValue: 10,
//            ValueKey.limit_comments.rawValue: 10,
//            ValueKey.max_length_all_post.rawValue: 20,
//        ]
//
//        RemoteConfig.remoteConfig(app: firebase_instance).setDefaults(appDefaults as? [String: NSObject])
//    }
//
//    func fetchCloudValues() {
//        guard let firebase_instance = SocialNetworkConstant.shared.instance else {
//            debugPrint("ProspectosInteractor error: firebase instance was nil.")
//            return
//        }
//
//        // WARNING: Don't actually do this in production!
//        let fetchDuration: TimeInterval = 0
//        RemoteConfig.remoteConfig(app: firebase_instance).fetch(withExpirationDuration: fetchDuration) { [weak self] (status, error) in
//            if status == .success, error == nil {
//                RemoteConfig.remoteConfig().activate { error in
//                    guard error == nil else {
//                        self?.loadingDoneCallback?()
//                        return
//                    }
//
//                    self?.loadingDoneCallback?()
//                }
//            } else {
//                print ("Uh-oh. Got an error fetching remote values")
//                self?.loadingDoneCallback?()
//                return
//            }
//        }
//    }
//
//    func double(forKey key: ValueKey) -> Int {
//        if let numberValue = RemoteConfig.remoteConfig()[key.rawValue].numberValue {
//            return numberValue.intValue
//        } else {
//            return 0
//        }
//    }
//
//}
