//
//  TabItem.swift
//  zeus-ios-sdk-new-social-network
//
//  Created by Miguel Angel Vicario Flores on 02/10/20.
//  Copyright © 2020 Gabriel Briseño. All rights reserved.
//

import UIKit

public enum TabItem: String, CaseIterable {
    case feed = "feed"
    case profile = "profile"
    case groups = "groups"
    
    //MARK: - Methods
    public var viewController: UIViewController {
        switch self {
        case .feed:
            let feed = FeedRouter.createModule() as! Home_RedSocial
            let navigationController = UINavigationController(rootViewController: feed)
            navigationController.navigationBar.isHidden = true
            return navigationController
        case .profile:
//            return ProfileRouter.createModule()
        return UIViewController()
        case .groups:
            let feed = FeedRouter.createModule() as! Home_RedSocial
            let navigationController = UINavigationController(rootViewController: feed)
            navigationController.navigationBar.isHidden = true
            return navigationController
        }
    }
    
    public var icon: UIImage? {
        switch self {
        case .feed:
            return "houseIcon".getImage()
        case .profile:
            return "profileIcon".getImage()
        case .groups:
            return "groupsIcon".getImage()
        }
    }
    
}

