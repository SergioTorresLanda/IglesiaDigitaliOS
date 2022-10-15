//
//  FirebaseInstanceHelper.swift
//  RedSocialAPP
//
//  Created by Miguel Angel Vicario Flores on 30/12/20.
//  Copyright © 2020 UPAX. All rights reserved.
//

import Foundation
import Firebase

public class FirebaseInstanceHelper {
    
    //SocialNetwork
    public static var REDSOCIALFRAMEWORK      = "RedSocial"
    
    //CollectorEvents
    public static var ENCUENTROCATOLICO        = "EncuentroCatolico"
}

//MARK: - Generic
extension FirebaseInstanceHelper {
    public static func genericAppCreateInstace() -> FirebaseOptions {
        let builder = FirebaseOptions(googleAppID: "1:726779829818:ios:a508364b1c41242f725f03", gcmSenderID: "726779829818")
        builder.bundleID        = "mx.arquidiocesis.EncuentroCatolico"
        builder.apiKey          = "AIzaSyBljAFS_jTXwe2iKiDO9V8D9Lmuwh5WTpg"
        builder.clientID        = "726779829818-s2voqgkvp0ueks5vcfciouuejaq39u8k.apps.googleusercontent.com"
        builder.databaseURL     = "https://encuentro-app-prod.firebaseio.com"
        builder.storageBucket   = "encuentro-app-prod.appspot.com"
        builder.projectID       = "encuentro-app-prod"
        
        return builder
    }
}

//MARK: - SocialNetwork
extension FirebaseInstanceHelper {
    public static func SNCreateInstace() {
        let builder = FirebaseOptions(googleAppID: "1:13723654053:ios:cd67a29837ada1646f3a4c", gcmSenderID: "13723654053")
        builder.bundleID        = "mx.arquidiocesis.EncuentroCatolicoNews"
        builder.apiKey          = "AIzaSyBljAFS_jTXwe2iKiDO9V8D9Lmuwh5WTpg"
        builder.clientID        = "726779829818-s2voqgkvp0ueks5vcfciouuejaq39u8k.apps.googleusercontent.com"
        builder.databaseURL     = "https://arquidiocesis-dev.firebaseio.com"
        builder.storageBucket   = "arquidiocesis-dev.appspot.com"
        builder.projectID       = "arquidiocesis-dev"
        
        FirebaseApp.configure(name: self.REDSOCIALFRAMEWORK, options: builder)
    }
    
    public static func getSNFirebaseInstance() -> FirebaseApp? {
        return FirebaseApp.app(name: self.REDSOCIALFRAMEWORK)
    }
}
