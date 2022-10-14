//
//  ViewExtension.swift
//  zeus-ios-sdk-new-social-network
//
//  Created by Miguel Angel Vicario Flores on 17/12/20.
//  Copyright © 2020 Gabriel Briseño. All rights reserved.
//

import UIKit
import RealmSwift

public extension UIView {
    func roundCorners(corners: CACornerMask, radius: CGFloat) {
        self.layer.cornerRadius = radius
        if #available(iOS 11.0, *) {
            self.layer.maskedCorners = corners
        }
    }
    
    func setShadow() {
        self.layer.shadowColor = UIColor(red: 0.11, green: 0.11, blue: 0.11, alpha: 1.00).cgColor
        self.layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        self.layer.shadowRadius = 5.0
        self.layer.shadowOpacity = 1.0
    }
    
    func makeRounded() {
        self.layer.masksToBounds = false
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
    }
    
    func setBorder(borderColor: UIColor) {
        self.layer.borderWidth = 0.5
        self.layer.borderColor = borderColor.cgColor
    }
    
    func setCorner(cornerRadius: CGFloat) {
        self.layer.masksToBounds = false
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
    }
    
    var globalFrame: CGRect {
        return (self.superview?.convert(self.frame, to: nil))!
    }
    
    func showEditView(groupId: Int?) {
        guard let id = groupId else { return }
        let roleInGroup = RealmManager.fetchDataForPK(object: GroupRealm.self, id: id)?.role
        self.isHidden = roleInGroup == "Admin" ? false : true
    }
}
