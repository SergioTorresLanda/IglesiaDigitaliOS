//
//  FirebaseInstanceHelper.swift
//  EncuentroCatolicoLogin
//
//  Created by Jorge Garcia on 27/07/21.
//

import Foundation
import Firebase

public class FirebaseInstanceHelper {
    //SocialNetwork
    public static var REDSOCIALFRAMEWORK      = "RedSocial"
}

//MARK: - SocialNetwork
extension FirebaseInstanceHelper {
    public static func SNCreateInstace() {
        let builder = FirebaseOptions(googleAppID: "1:13723654053:ios:cd67a29837ada1646f3a4c", gcmSenderID: "13723654053")
        builder.bundleID        = "mx.arquidiocesis.EncuentroCatolicoNews"
        builder.apiKey          = "AIzaSyC-d7rJrjpgqI5HuDrSIDi2fzPFpiEpgUM"
        builder.clientID        = "13723654053-j9l2ckfcbnjd40cqjlra28n9lrljrvrt.apps.googleusercontent.com"
        builder.databaseURL     = "https://arquidiocesis-dev.firebaseio.com"
        builder.storageBucket   = "arquidiocesis-dev.appspot.com"
        builder.projectID       = "arquidiocesis-dev"
        
        FirebaseApp.configure(name: self.REDSOCIALFRAMEWORK, options: builder)
    }
    
    public static func getSNFirebaseInstance() -> FirebaseApp? {
        return FirebaseApp.app(name: self.REDSOCIALFRAMEWORK)
    }
}
