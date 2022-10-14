//
//  Design.swift
//  EncuentroCatolicoHome
//
//  Created by Diego Martinez on 24/02/21.
//

import UIKit

extension UIView {
    
    func ShadowNavBar() {
        clipsToBounds = true
        layer.shadowRadius = 5
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        layer.shadowOpacity = 0.5
        layer.masksToBounds = false
    }
    
    func ShadowCard() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 4.0
    }
    
    func addShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.2
        self.layer.shadowOffset = CGSize(width: 0.3, height: 0.5)
        self.layer.shadowRadius = 5
    }
    
    func addShadowTabBar() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.2
        self.layer.shadowOffset = CGSize(width: 0.3, height: 0.3)
        self.layer.shadowRadius = 2
        self.layer.masksToBounds = false
    }
    
    func setCorner(cornerRadius: CGFloat) {
        self.layer.masksToBounds = false
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
    }
    
    func makeRounded() {
        self.layer.masksToBounds = false
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
    }
    
}

