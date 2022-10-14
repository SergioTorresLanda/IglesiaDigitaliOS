//
//  TabNavigationMenu.swift
//  zeus-ios-sdk-new-social-network
//
//  Created by Miguel Angel Vicario Flores on 02/10/20.
//  Copyright © 2020 Gabriel Briseño. All rights reserved.
//

import UIKit

public class TabNavigationMenu: UIImageView {
    
    //MARK: - Properties
    public var itemTapped: ((_ tab: Int) -> Void)?
    private var activeItem: Int = 0
    
    //MARK: - Life cycle
    override public init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    convenience public init(menuItems: [TabItem], frame: CGRect) {
        self.init(frame: frame)
        
        self.isUserInteractionEnabled = true
        self.clipsToBounds = true
        
        for i in 0 ..< menuItems.count {
            let itemWidth = self.frame.width / CGFloat(menuItems.count)
            let leadingAnchor = itemWidth * CGFloat(i)
            
            let itemView = self.createTabItem(item: menuItems[i])
            itemView.tag = i
            
            self.addSubview(itemView)
            
            itemView.translatesAutoresizingMaskIntoConstraints = false
            itemView.clipsToBounds = true
            
            NSLayoutConstraint.activate([
                itemView.heightAnchor.constraint(equalTo: self.heightAnchor),
                itemView.widthAnchor.constraint(equalToConstant: itemWidth), // fixing width
                
                itemView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: leadingAnchor),
                itemView.topAnchor.constraint(equalTo: self.topAnchor),
            ])
        }
        
        self.setNeedsLayout()
        self.layoutIfNeeded()
        activateTab(tab: 1)
    }
    
    //MARK: - Methods
    private func createTabItem(item: TabItem) -> UIView {
        let tabBarItem = UIView(frame: CGRect.zero)
        let itemIconView = UIImageView(frame: CGRect.zero)
        let selectedItemView = UIImageView(frame: CGRect.zero)
        
        tabBarItem.tag = 11
        itemIconView.tag = 12
        selectedItemView.tag = 13
        
        selectedItemView.image = "selectedTab".getImage()
        selectedItemView.translatesAutoresizingMaskIntoConstraints = false
        selectedItemView.clipsToBounds = true
        tabBarItem.addSubview(selectedItemView)
        NSLayoutConstraint.activate([
            selectedItemView.centerXAnchor.constraint(equalTo: tabBarItem.centerXAnchor),
            selectedItemView.centerYAnchor.constraint(equalTo: tabBarItem.centerYAnchor, constant: -10),
            selectedItemView.heightAnchor.constraint(equalToConstant: 50),
            selectedItemView.widthAnchor.constraint(equalToConstant: 50)
        ])
        
        selectedItemView.setCorner(cornerRadius: 10)
        tabBarItem.sendSubviewToBack(selectedItemView)
        
        selectedItemView.isHidden = true
        
        itemIconView.image = item.icon?.withRenderingMode(.alwaysTemplate)
        itemIconView.tintColor = .lightGray
        itemIconView.contentMode = .scaleAspectFit
        itemIconView.translatesAutoresizingMaskIntoConstraints = false
        itemIconView.clipsToBounds = true
        tabBarItem.layer.backgroundColor = UIColor.clear.cgColor
        tabBarItem.addSubview(itemIconView)
        tabBarItem.translatesAutoresizingMaskIntoConstraints = false
        tabBarItem.clipsToBounds = true
        NSLayoutConstraint.activate([
            itemIconView.heightAnchor.constraint(equalToConstant: 30),
            itemIconView.widthAnchor.constraint(equalToConstant: 30),
            itemIconView.centerXAnchor.constraint(equalTo: tabBarItem.centerXAnchor),
            itemIconView.centerYAnchor.constraint(equalTo: tabBarItem.centerYAnchor, constant: -10),
        ])
        
        tabBarItem.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.handleTap)))
        return tabBarItem
    }
    
    @objc private func handleTap(_ sender: UIGestureRecognizer) {
        if activeItem != sender.view!.tag {
            switchTab(from: activeItem, to: sender.view!.tag)
        }else{
            NotificationCenter.default.post(name: Notification.Name("NotificationFeed"), object: nil)
        }
    }
    
    private func switchTab(from: Int, to: Int) {
        deactivateTab(tab: from)
        activateTab(tab: to)
    }
    
    private func activateTab(tab: Int) {
        let tabToActivate = self.subviews[tab]
        tabToActivate.viewWithTag(13)?.isHidden = false
        
        UIView.animate(withDuration: 0.25, animations: {
            tabToActivate.viewWithTag(13)?.transform = CGAffineTransform(scaleX: 1, y: 1)
            tabToActivate.viewWithTag(12)?.tintColor = .white
            self.layoutIfNeeded()
        }) { (Bool) in
            tabToActivate.viewWithTag(13)?.isHidden = false
        }
        
        itemTapped?(tab)
        activeItem = tab
    }
    
    private func deactivateTab(tab: Int) {
        let inactiveTab = self.subviews[tab]
        
        UIView.animate(withDuration: 0.25, animations: {
            inactiveTab.viewWithTag(13)?.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
            inactiveTab.viewWithTag(12)?.tintColor = .lightGray
            self.layoutIfNeeded()
        }) { (Bool) in
            inactiveTab.viewWithTag(13)?.isHidden = true
        }
    }
}
