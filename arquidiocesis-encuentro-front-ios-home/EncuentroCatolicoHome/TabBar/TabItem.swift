//
//  TabItem.swift
//  zeus-ios-sdk-new-social-network
//
//  Created by Miguel Angel Vicario Flores on 02/10/20.
//  Copyright © 2020 Gabriel Briseño. All rights reserved.
//

import UIKit
import EncuentroCatolicoProfile
import EncuentroCatolicoVirtualLibrary
import EncuentroCatolicoLive

public enum TabItem: String, CaseIterable {
    case profile = "Perfil"
    case feed = "Ayuda"
    case groups = "Inicio"
    //MARK: - Methods
    //let wantToLogin = defaults.bool(forKey: "wantToLogin")
    public var viewController: UIViewController {
        switch self {
        case .profile:
            let groups = ProfileInfoRouter.createModule()
            let navigationController = UINavigationController()
            navigationController.navigationBar.isHidden = true
            navigationController.pushViewController(groups, animated: false)
            return navigationController
            
        case .groups:
            let profile = HomeRouter.createModule() as! Home_Home
            let navigationController = UINavigationController()
            navigationController.navigationBar.isHidden = true
            navigationController.pushViewController(profile, animated: false)
            return navigationController
            
        case .feed:
            let rol = UserDefaults.standard.string(forKey: "profile") ?? "DEVOTED"
            let arrAdmins=["PRIEST_ADMIN",
                           "DEAN_PRIEST",
                           "DEVOTED_ADMIN",
                           "CLERGY_VICARAGE",
                           "PASTORAL_VICARAGE",
                           "CONSECRATED_LIFE_VICARAGE"]
            //let sosType = UserDefaults.standard.bool(forKey: "isComm")
            let navigationController = UINavigationController()
            if arrAdmins.contains(rol){
                let profile  = PriestPSOSRouter.createModule()
                navigationController.navigationBar.isHidden = true
                navigationController.pushViewController(profile, animated: true)
                return navigationController
                
            }else{//case false:
                let profile = PrincipalRouterSOS.createModue()
                navigationController.navigationBar.isHidden = true
                navigationController.pushViewController(profile, animated: false)
                return navigationController
            }
        }
    }
    
    public var icon: UIImage? {
        switch self {
        case .feed:
            return UIImage(named:"panicIcon", in: Bundle.local, compatibleWith: nil)
        case .profile:
            return UIImage(named:"personIcon", in: Bundle.local, compatibleWith: nil)
        case .groups:
            return UIImage(named:"homeIcon", in: Bundle.local, compatibleWith: nil)
        }
    }
    
}

