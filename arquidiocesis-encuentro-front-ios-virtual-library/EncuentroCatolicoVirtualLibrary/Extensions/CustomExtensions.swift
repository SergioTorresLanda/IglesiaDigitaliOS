//
//  CustomExtensions.swift
//  EncuentroCatolicoVirtualLibrary
//
//  Created by Pablo Luis Velazquez Zamudio on 14/06/21.
//

import Foundation
import UIKit

extension UIView {
    
    func ShadowCard() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 4.0
    }
    
    func ShadowNavBar() {
        clipsToBounds = true
        layer.shadowRadius = 5
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        layer.shadowOpacity = 0.5
        layer.masksToBounds = false
    }
    
}

extension UIButton {
    
    func roundedNborder(borderColor: UIColor) {
        layer.borderWidth = 1
        layer.borderColor = borderColor.cgColor
        backgroundColor = .clear
        setTitleColor(borderColor, for: .normal)
        
    }
    
    func borderButtonColorWhite(color: UIColor) {
        self.layer.cornerRadius = 8
        let colorBorde = color
        self.layer.borderWidth = 0.5
        self.clipsToBounds = true
        self.layer.borderColor = colorBorde.cgColor
        self.backgroundColor = .clear
        self.setTitleColor(color, for: .normal)
    }
    
}

