//
//  FirebaseManager.swift
//  EncuentroCatolicoLogin
//
//  Created by Jorge Garcia on 27/07/21.
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
