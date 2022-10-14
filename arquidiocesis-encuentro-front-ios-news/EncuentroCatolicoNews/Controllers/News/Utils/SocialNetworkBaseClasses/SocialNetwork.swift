//
//  SocialNetwork.swift
//  zeus-ios-sdk-new-social-network
//
//  Created by Miguel Angel Vicario Flores on 16/12/20.
//  Copyright © 2020 Gabriel Briseño. All rights reserved.
//

import UIKit
import Firebase

public enum SocialNetworkEnviroment {
    case Development
    case Qa
    case Release
    
    func getBaseUrl() -> String {
        switch self {
        case .Development:
            return "https://api.arquidiocesis.mx/"
        case .Qa:
            return "https://api.arquidiocesis.mx/"
        case .Release:
            return "https://api.arquidiocesis.mx/"
        }
    }
}

public class SocialNetworkConstant: NSObject {
    static var shared = SocialNetworkConstant()

    var baseURL: String = "https://api.arquidiocesis.mx/"
    var userName: String = ""
    var userId: Int = 0
    var employeeNumber: String = ""
    var userImage: UIImage = UIImage()
    var instance: FirebaseApp?
}

open class SocialNetworkNews {
    public static func openSocialNetowrk(firebaseApp: FirebaseApp?) -> UIViewController {
        let view = FeedRouter.createModule()
        SocialNetworkConstant.shared.baseURL = "https://api.arquidiocesis.mx/"
        SocialNetworkConstant.shared.userName = "Diego Martinez"
        SocialNetworkConstant.shared.userId = 100
        SocialNetworkConstant.shared.employeeNumber = "8974563"
        SocialNetworkConstant.shared.instance = firebaseApp
        return view
    }
}
