//
//  SocialNetworkController.swift
//  RedSocialFramework
//
//  Created by Miguel Angel Vicario Flores on 16/12/20.
//  Copyright © 2020 Gabriel Briseño. All rights reserved.
//

import UIKit

public class SocialNetworkController: UITabBarController {
    
    //MARK: - Properties
    public var customTabBar: TabNavigationMenu!
    private var tabBarHeight: CGFloat = 0.0
    
    //MARK: - Life cycle
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self
        loadTabBar()
    }
    
    //MARK: - Methods
    private func loadTabBar() {
        let tabItems: [TabItem] = [.groups, .feed, .profile]
        self.setupCustomTabBar(tabItems) { (controllers) in
            self.viewControllers = controllers
        }
        
        self.selectedIndex = 1
    }
    
    private func setupCustomTabBar(_ items: [TabItem], completion: @escaping ([UIViewController]) -> Void){
        let frame = CGRect(x: tabBar.frame.origin.x, y: tabBar.frame.origin.x, width: tabBar.frame.width, height: tabBarHeight)
        var controllers = [UIViewController]()
        tabBar.isHidden = true
        
        customTabBar = TabNavigationMenu(menuItems: items, frame: frame)
        customTabBar.backgroundColor = UIColor.white
        customTabBar.alpha = 0.95
        customTabBar.roundCorners(corners: [.layerMinXMinYCorner], radius: 60)
        customTabBar.setBorder(borderColor: UIColor(red: 0.91, green: 0.89, blue: 0.91, alpha: 1.00))
        customTabBar.translatesAutoresizingMaskIntoConstraints = false
        customTabBar.clipsToBounds = true
        customTabBar.itemTapped = self.changeTab
        self.view.addSubview(customTabBar)

        NSLayoutConstraint.activate([
            customTabBar.leadingAnchor.constraint(equalTo: tabBar.leadingAnchor),
            customTabBar.trailingAnchor.constraint(equalTo: tabBar.trailingAnchor),
            customTabBar.widthAnchor.constraint(equalToConstant: tabBar.frame.width),
            customTabBar.heightAnchor.constraint(equalToConstant: tabBarHeight),
            customTabBar.bottomAnchor.constraint(equalTo: tabBar.bottomAnchor)
        ])
        
        for i in 0 ..< items.count {
            controllers.append(items[i].viewController)
        }
        
        self.view.layoutIfNeeded()
        completion(controllers)
    }
    
    private func changeTab(tab: Int) {
        self.selectedIndex = tab
    }
}

//MARK: - UITabBarControllerDelegate
extension SocialNetworkController: UITabBarControllerDelegate {
    public func tabBarController(_ tabBarController: UITabBarController, animationControllerForTransitionFrom fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CustomTabBarTransition(viewControllers: tabBarController.viewControllers)
    }
}

