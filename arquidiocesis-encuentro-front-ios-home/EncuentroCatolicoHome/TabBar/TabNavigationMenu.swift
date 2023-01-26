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
        NotificationCenter.default.addObserver(self, selector: #selector(handleProfileTap), name: NSNotification.Name(rawValue: "handleSuperTap"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleHomeTap), name: NSNotification.Name(rawValue: "SOSCreated"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleProfileTapVirtual), name: NSNotification.Name(rawValue: "handleSuperTapVirtual"), object: nil)
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
        activateTab(tab: 0)
    }
    
    //MARK: - Methods
    private func createTabItem(item: TabItem) -> UIView {
        let tabBarItem = UIView(frame: CGRect.zero)
        let itemIconView = UIImageView(frame: CGRect.zero)
        let itemTitleLabel = UILabel(frame: CGRect.zero)
        let selectedItemView = UIImageView(frame: CGRect.zero)
        
        tabBarItem.tag = 11
        itemIconView.tag = 12
        selectedItemView.tag = 13
        itemTitleLabel.tag = 14
        //selectedItemView.image = "selectedTab".getImage()
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
        
        itemIconView.image = item.icon?.withRenderingMode(.alwaysOriginal)
        itemIconView.tintColor = .lightGray
        itemIconView.contentMode = .scaleAspectFit
        itemIconView.translatesAutoresizingMaskIntoConstraints = false
        itemIconView.clipsToBounds = true
        
        itemTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        switch item.rawValue{
        case "Inicio":
            itemTitleLabel.text = "Inicio"
            itemIconView.accessibilityHint = item.rawValue
        case "Ayuda":
            itemTitleLabel.text = "S.O.S"
            itemIconView.accessibilityHint = item.rawValue
        case "Perfil":
            itemTitleLabel.text = "Mi Perfil"
            itemIconView.accessibilityHint = item.rawValue
        default:
            print("default case")
        }
        
        itemTitleLabel.textAlignment = .center
        itemTitleLabel.font = .systemFont(ofSize: 16)
        itemTitleLabel.textColor = .darkGray
        
        tabBarItem.layer.backgroundColor = UIColor.clear.cgColor
        tabBarItem.addSubview(itemIconView)
        tabBarItem.addSubview(itemTitleLabel)
        tabBarItem.translatesAutoresizingMaskIntoConstraints = false
        tabBarItem.clipsToBounds = false
        
        NSLayoutConstraint.activate([
            itemTitleLabel.heightAnchor.constraint(equalToConstant: 45),
            itemTitleLabel.widthAnchor.constraint(equalToConstant: 100),
            itemTitleLabel.centerXAnchor.constraint(equalTo: tabBarItem.centerXAnchor),
            itemTitleLabel.centerYAnchor.constraint(equalTo: tabBarItem.centerYAnchor, constant: 15),
        ])
        
        NSLayoutConstraint.activate([
            itemIconView.heightAnchor.constraint(equalToConstant: 30),
            itemIconView.widthAnchor.constraint(equalToConstant: 30),
            itemIconView.centerXAnchor.constraint(equalTo: tabBarItem.centerXAnchor),
            itemIconView.centerYAnchor.constraint(equalTo: tabBarItem.centerYAnchor, constant: -15),
        ])
        
        tabBarItem.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.handleTap)))
        return tabBarItem
    }
    
    @objc private func handleProfileTap(){
        switchTab(from: activeItem, to: 2)
    }
    
    @objc private func handleProfileTapVirtual(){
        switchTabVirtual(from: activeItem, to: 2)
    }
    
    @objc private func handleHomeTap(){
        switchTab(from: activeItem, to: 0)
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
    
    private func switchTabVirtual(from: Int, to: Int) {
        deactivateTab(tab: from)
        activateTabVirtual(tab: to)
    }
    
    private func activateTab(tab: Int) {
        let tabToActivate = self.subviews[tab]
        tabToActivate.viewWithTag(13)?.isHidden = false
        
        UIView.animate(withDuration: 0.25, animations: {
            tabToActivate.viewWithTag(13)?.transform = CGAffineTransform(scaleX: 1, y: 1)
            //tabToActivate.viewWithTag(12)?.tintColor = UIColor(red: 0.15, green: 0.55, blue: 0.82, alpha: 1.00)
            
            if tabToActivate.viewWithTag(12) is UIImageView {
                let imgView = tabToActivate.viewWithTag(12) as! UIImageView
                switch imgView.accessibilityHint{
                case "Inicio":
                    imgView.image = UIImage(named: "homeIcon", in: Bundle.local, compatibleWith: nil)
                case "Ayuda":
                    imgView.image = UIImage(named: "SOS_selected", in: Bundle.local, compatibleWith: nil)
                case "Perfil":
                    imgView.image = UIImage(named: "profile_selected", in: Bundle.local, compatibleWith: nil)
                case .none:
                    print("None case")
                case .some(_):
                    print("some case")
                }
            }
            
            if tabToActivate.viewWithTag(14) is UILabel{
              let label = tabToActivate.viewWithTag(14) as! UILabel
                label.textColor = UIColor(hue: 0.6056, saturation: 0.78, brightness: 0.64, alpha: 1.0)
            }
            self.layoutIfNeeded()
        }) { (Bool) in
            tabToActivate.viewWithTag(13)?.isHidden = false
        }
        
        itemTapped?(tab)
        activeItem = tab
    }
    
    private func activateTabVirtual(tab: Int) {
        let tabToActivate = self.subviews[tab]
        tabToActivate.viewWithTag(13)?.isHidden = false
        
        UIView.animate(withDuration: 0.25, animations: {
            tabToActivate.viewWithTag(13)?.transform = CGAffineTransform(scaleX: 1, y: 1)
            //tabToActivate.viewWithTag(12)?.tintColor = UIColor(red: 0.15, green: 0.55, blue: 0.82, alpha: 1.00)
            
            if tabToActivate.viewWithTag(12) is UIImageView {
                let imgView = tabToActivate.viewWithTag(12) as! UIImageView
                switch imgView.accessibilityHint{
                case "Inicio":
                    imgView.image = UIImage(named: "homeIcon", in: Bundle.local, compatibleWith: nil)
                case "Ayuda":
                    imgView.image = UIImage(named: "SOS_selected", in: Bundle.local, compatibleWith: nil)
                case "Perfil":
                    imgView.image = UIImage(named: "profile_selected", in: Bundle.local, compatibleWith: nil)
                case .none:
                    print("None case")
                case .some(_):
                    print("some case")
                }
            }
            
            if tabToActivate.viewWithTag(14) is UILabel{
              let label = tabToActivate.viewWithTag(14) as! UILabel
                label.textColor = UIColor(hue: 0.6056, saturation: 0.78, brightness: 0.64, alpha: 1.0)
            }
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
            
            if inactiveTab.viewWithTag(12) is UIImageView{
                let imgView = inactiveTab.viewWithTag(12) as! UIImageView
                switch imgView.accessibilityHint{
                case "Inicio":
                    imgView.image = UIImage(named: "home_unselected", in: Bundle.local, compatibleWith: nil)
                case "Ayuda":
                    imgView.image = UIImage(named: "panicIcon", in: Bundle.local, compatibleWith: nil)
                case "Perfil":
                    imgView.image = UIImage(named: "personIcon", in: Bundle.local, compatibleWith: nil)
                case .none:
                    print("None case")
                case .some(_):
                    print("some case")
                }
            }
            
            
            if inactiveTab.viewWithTag(14) is UILabel{
              let label = inactiveTab.viewWithTag(14) as! UILabel
                label.textColor = .darkGray
            }
            self.layoutIfNeeded()
        }) { (Bool) in
            inactiveTab.viewWithTag(13)?.isHidden = true
        }
    }
}
