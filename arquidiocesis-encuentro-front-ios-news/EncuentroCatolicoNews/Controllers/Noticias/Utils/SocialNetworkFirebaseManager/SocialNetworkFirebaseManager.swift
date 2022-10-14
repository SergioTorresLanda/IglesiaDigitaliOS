//
//  SocialNetworkFirebaseManager.swift
//  RedSocialFramework
//
//  Created by Miguel Angel Vicario Flores on 21/12/20.
//  Copyright © 2020 Gabriel Briseño. All rights reserved.
//

import Foundation

public class SocialNetworkFirebaseManager {
    public static let shared = SocialNetworkFirebaseManager()
    
    /*public func getSocialNetworkInstance() -> FirebaseApp? {
        return FirebaseApp.app(name: "RedSocial")
    }*/
    
    public func initSocialNetworkInstance(enviroment: SocialNetworkFirebaseManagerEnviroment) {
        enviroment.initSocialNetworkInstance()
    }
}

public enum SocialNetworkFirebaseManagerEnviroment {
    case Development
    case Qa
    case Release
    
    public func initSocialNetworkInstance() {
        
        /*var builder = FirebaseOptions()
        
        switch self {
        case .Development:
            builder = FirebaseOptions(googleAppID: "1:13723654053:ios:c9d6e9060b803e5e6f3a4c", gcmSenderID: "13723654053")
            builder.bundleID        = "com.arquidiocesis.redreligiosa"
            builder.apiKey          = "AIzaSyC-d7rJrjpgqI5HuDrSIDi2fzPFpiEpgUM"
            builder.clientID        = "13723654053-v1711vlsvkujtsh8v7ki8hf7p6vqilc5.apps.googleusercontent.com"
            builder.databaseURL     = "https://arquidiocesis---dev.firebaseio.com"
            builder.storageBucket   = "arquidiocesis-dev.appspot.com"
            builder.projectID       = "arquidiocesis-dev"
        case .Qa:
            builder = FirebaseOptions(googleAppID: "1:13723654053:ios:c9d6e9060b803e5e6f3a4c", gcmSenderID: "13723654053")
            builder.bundleID        = "com.arquidiocesis.redreligiosa"
            builder.apiKey          = "AIzaSyC-d7rJrjpgqI5HuDrSIDi2fzPFpiEpgUM"
            builder.clientID        = "13723654053-v1711vlsvkujtsh8v7ki8hf7p6vqilc5.apps.googleusercontent.com"
            builder.databaseURL     = "https://arquidiocesis---dev.firebaseio.com"
            builder.storageBucket   = "arquidiocesis-dev.appspot.com"
            builder.projectID       = "arquidiocesis-dev"
        case .Release:
            builder = FirebaseOptions(googleAppID: "1:13723654053:ios:c9d6e9060b803e5e6f3a4c", gcmSenderID: "13723654053")
            builder.bundleID        = "com.arquidiocesis.redreligiosa"
            builder.apiKey          = "AIzaSyC-d7rJrjpgqI5HuDrSIDi2fzPFpiEpgUM"
            builder.clientID        = "13723654053-v1711vlsvkujtsh8v7ki8hf7p6vqilc5.apps.googleusercontent.com"
            builder.databaseURL     = "https://arquidiocesis---dev.firebaseio.com"
            builder.storageBucket   = "arquidiocesis-dev.appspot.com"
            builder.projectID       = "arquidiocesis-dev"
        }
        
        FirebaseApp.configure(name: "RedSocial", options: builder)*/
    }
}
