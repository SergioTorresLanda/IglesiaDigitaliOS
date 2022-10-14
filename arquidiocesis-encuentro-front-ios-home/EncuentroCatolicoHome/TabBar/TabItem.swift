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
    public var viewController: UIViewController {
        switch self {
        case .profile:
            let groups = ProfileInfoRouter.createModule()
            let navigationController = UINavigationController()
            navigationController.navigationBar.isHidden = true
            navigationController.pushViewController(groups, animated: false)
            return navigationController
            
        case .groups:
            let profile = HomeRouter.createModule() as! HomeViewController
            let navigationController = UINavigationController()
            navigationController.navigationBar.isHidden = true
            navigationController.pushViewController(profile, animated: false)
            return navigationController
            
        case .feed:
            let sosType = UserDefaults.standard.bool(forKey: "isComm")
            let navigationController = UINavigationController()
            switch sosType {
            case true:
                
                let profile  = PriestPSOSRouter.createModule()
                navigationController.navigationBar.isHidden = true
                navigationController.pushViewController(profile, animated: true)
                return navigationController
                
            case false:
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

