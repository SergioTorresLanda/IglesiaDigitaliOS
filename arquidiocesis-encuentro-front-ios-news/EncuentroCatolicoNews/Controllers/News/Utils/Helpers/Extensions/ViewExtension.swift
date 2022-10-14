//
//  ViewExtension.swift
//  zeus-ios-sdk-new-social-network
//
//  Created by Miguel Angel Vicario Flores on 17/12/20.
//  Copyright © 2020 Gabriel Briseño. All rights reserved.
//

import UIKit
import RealmSwift

public enum Anchor { case left, top, right, bottom }

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
    
    func addAnchors(left: CGFloat?, top: CGFloat?, right: CGFloat?, bottom: CGFloat?, withAnchor: Anchor? = nil, relativeToView: UIView? = nil) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        let superView = self.superview!
        if withAnchor != nil && relativeToView != nil {
            /**
             * Anchors relative to oposite anchors of reference view
             **/
            switch withAnchor! {
                case .left:
                    if left != nil {
                        self.leftAnchor.constraint(equalTo: relativeToView!.rightAnchor, constant: left!).isActive = true
                    }
                case .top:
                    if top != nil {
                        self.topAnchor.constraint(equalTo: relativeToView!.bottomAnchor, constant: top!).isActive = true
                    }
                case .right:
                    if right != nil {
                        self.rightAnchor.constraint(equalTo: relativeToView!.leftAnchor, constant: -right!).isActive = true
                    }
                case .bottom:
                    if bottom != nil {
                        self.bottomAnchor.constraint(equalTo: relativeToView!.topAnchor, constant: -bottom!).isActive = true
                    }
            }
        }
        
        /**
         * Anchors relative to same anchors of superview
         **/
        if let _anchor = withAnchor {
            if _anchor == .left {
                if top != nil {
                    self.topAnchor.constraint(equalTo: superView.topAnchor, constant: top!).isActive = true
                }
                if right != nil {
                    self.rightAnchor.constraint(equalTo: superView.rightAnchor, constant: -right!).isActive = true
                }
                if bottom != nil {
                    self.bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: -bottom!).isActive = true
                }
            }
            if _anchor == .top {
                if left != nil {
                    self.leftAnchor.constraint(equalTo: superView.leftAnchor, constant: left!).isActive = true
                }
                if right != nil {
                    self.rightAnchor.constraint(equalTo: superView.rightAnchor, constant: -right!).isActive = true
                }
                if bottom != nil {
                    self.bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: -bottom!).isActive = true
                }
            }
            if _anchor == .right {
                if left != nil {
                    self.leftAnchor.constraint(equalTo: superView.leftAnchor, constant: left!).isActive = true
                }
                if top != nil {
                    self.topAnchor.constraint(equalTo: superView.topAnchor, constant: top!).isActive = true
                }
                if bottom != nil {
                    self.bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: -bottom!).isActive = true
                }
            }
            if _anchor == .bottom {
                if left != nil {
                    self.leftAnchor.constraint(equalTo: superView.leftAnchor, constant: (left!)).isActive = true
                }
                if top != nil {
                    self.topAnchor.constraint(equalTo: superView.topAnchor, constant: top!).isActive = true
                }
                if right != nil {
                    self.rightAnchor.constraint(equalTo: superView.rightAnchor, constant: -right!).isActive = true
                }
            }
        } else {
            if left != nil {
                self.leftAnchor.constraint(equalTo: superView.leftAnchor, constant: left!).isActive = true
            }
            if top != nil {
                self.topAnchor.constraint(equalTo: superView.topAnchor, constant: top!).isActive = true
            }
            if right != nil {
                self.rightAnchor.constraint(equalTo: superView.rightAnchor, constant: -right!).isActive = true
            }
            if bottom != nil {
                self.bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: -bottom!).isActive = true
            }
        }
    }
    
    func addAnchorsAndSize(width: CGFloat?, height: CGFloat?, left: CGFloat?, top: CGFloat?, right: CGFloat?, bottom: CGFloat?, withAnchor: Anchor? = nil, relativeToView: UIView? = nil) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        if width != nil {
            self.widthAnchor.constraint(equalToConstant: width!).isActive = true
        }
        if height != nil {
            self.heightAnchor.constraint(equalToConstant: height!).isActive = true
        }
        self.addAnchors(left: left, top: top, right: right, bottom: bottom, withAnchor: withAnchor, relativeToView: relativeToView)
    }
    
    
    func addAnchorsAndCenter(centerX: Bool?, centerY: Bool?, width: CGFloat?, height: CGFloat?, left: CGFloat?, top: CGFloat?, right: CGFloat?, bottom: CGFloat?, withAnchor: Anchor? = nil, relativeToView: UIView? = nil) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        if centerX != nil {
            if centerX! == true {
                self.centerXAnchor.constraint(equalTo: self.superview!.centerXAnchor).isActive = true
            }
        }
        if centerY != nil {
            if centerY! == true {
                self.centerYAnchor.constraint(equalTo: self.superview!.centerYAnchor).isActive = true
            }
        }
        
        self.addAnchorsAndSize(width: width, height: height, left: left, top: top, right: right, bottom: bottom, withAnchor: withAnchor, relativeToView: relativeToView)
    }
    
    func addAnchorsWithMargin(_ margin:CGFloat) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.leftAnchor.constraint(equalTo: self.superview!.leftAnchor, constant: margin).isActive = true
        self.topAnchor.constraint(equalTo: self.superview!.topAnchor, constant: margin).isActive = true
        self.rightAnchor.constraint(equalTo: self.superview!.rightAnchor, constant: -margin).isActive = true
        self.bottomAnchor.constraint(equalTo: self.superview!.bottomAnchor, constant: -margin).isActive = true
    }
}
