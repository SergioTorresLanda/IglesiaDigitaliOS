//
//  FirebaseManager.swift
//  RedSocialAPP
//
//  Created by Miguel Angel Vicario Flores on 30/12/20.
//  Copyright © 2020 UPAX. All rights reserved.
//

import Foundation
import Firebase


public class FirebaseManager {
    
    //MARK: - Properties
    public static let shared = FirebaseManager()
}



//MARK: SocialNetwork
extension FirebaseManager {
    public func initSNFirebaseInstance() {
        if FirebaseApp.app(name: FirebaseInstanceHelper.REDSOCIALFRAMEWORK) == nil {
            FirebaseInstanceHelper.SNCreateInstace()
        }
    }
    
    public func getSNFirebaseInstance() -> FirebaseApp? {
        return FirebaseInstanceHelper.getSNFirebaseInstance()
    }
}

