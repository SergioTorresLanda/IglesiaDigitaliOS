//
//  SocialNetwork.swift
//  zeus-ios-sdk-new-social-network
//
//  Created by Miguel Angel Vicario Flores on 16/12/20.
//  Copyright © 2020 Gabriel Briseño. All rights reserved.
//

import UIKit

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

    var baseURL: String = ""
    var userName: String = ""
    var userImage: UIImage = UIImage()
    var userId: Int = 0
    var employeeNumber: String = ""
}

open class SocialNetwork {
    /*public static func openSocialNetowrk(userName: String, userImage: UIImage, userId: Int, employeeNumber: String, enviroment: SocialNetworkEnviroment, firebaseApp: FirebaseApp?) -> UIViewController {
    
        let view = InitViewRouter.createModule()
        SocialNetworkConstant.shared.baseURL = enviroment.getBaseUrl()
        SocialNetworkConstant.shared.userName = userName
        SocialNetworkConstant.shared.userImage = userImage
        SocialNetworkConstant.shared.userId = userId
        SocialNetworkConstant.shared.employeeNumber = employeeNumber
        
        return view
    }*/
    
    public static func openSocialNetowrk(userName: String, userImage: UIImage, userId: Int, employeeNumber: String, enviroment: SocialNetworkEnviroment) -> UIViewController {
    
        let view = InitViewRouter.createModule()
        SocialNetworkConstant.shared.baseURL = enviroment.getBaseUrl()
        SocialNetworkConstant.shared.userName = userName
        SocialNetworkConstant.shared.userImage = userImage
        SocialNetworkConstant.shared.userId = userId
        SocialNetworkConstant.shared.employeeNumber = employeeNumber
        
        return view
    }
}
