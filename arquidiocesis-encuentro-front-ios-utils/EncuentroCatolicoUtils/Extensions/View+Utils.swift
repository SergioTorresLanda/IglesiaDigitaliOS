//
//  View+Utils.swift
//  EncuentroCatolicoUtils
//
//  Created by Alejandro on 16/10/22.
//

import UIKit

public extension UIView {
    ///Add a shadow
    /// - Parameter shadowType: Type of shadow to use. Check PTCUShadowType for more information __Default:__3
    /// - Parameter scale: For scale screen size __Default:__ true
    func dropShadow(shadowType: ECUSizeType = .md, scale: Bool = true, withRasterize: Bool = true) {
        //Default extra large values
        var shadowOffset = CGSize(width: -1, height: 1)
        var shadowRadius: CGFloat = 2
        var shadowOpacity: Float = 0.5
        
        switch shadowType {
        case .xs:
            shadowOffset = CGSize(width: -0.4, height: 0.4)
            shadowRadius = 1
            shadowOpacity = 0.2
        case .sm:
            shadowOffset = CGSize(width: -0.4, height: 0.4)
            shadowRadius = 3
            shadowOpacity = 0.2
        case .md:
            shadowOffset = CGSize(width: -0.6, height: 0.6)
            shadowRadius = 5
            shadowOpacity = 0.3
        case .lg:
            shadowOffset = CGSize(width: -0.8, height: 0.8)
            shadowRadius = 5
            shadowOpacity = 0.4
        case .xl:
            shadowOffset = CGSize(width: -1, height: 1)
            shadowRadius = 5
            shadowOpacity = 0.5
        }
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowOffset = shadowOffset
        self.layer.shadowRadius = shadowRadius
        
        if withRasterize {
            self.layer.shadowPath = UIBezierPath(rect: self.layer.bounds).cgPath
            self.layer.shouldRasterize = true
            self.layer.rasterizationScale = scale ? UIScreen.main.scale : 1
        }
    }
    
    func bounceInX() {
        self.center.x -= 10
        UIView.animate(withDuration: 1.0, delay: 0,
        usingSpringWithDamping: 0.2, initialSpringVelocity: 0, options: [], animations: {
            self.center.x += 10
        }, completion: nil)
    }

    func addBorder(border borderConfig: ECUBorder) {
        let border = CALayer()
        
        border.backgroundColor = borderConfig.color
        
        switch borderConfig.side {
        case .left: border.frame = CGRect(x: frame.minX, y: frame.minY, width: borderConfig.thickenss, height: frame.height)
        case .right: border.frame = CGRect(x: frame.maxX, y: frame.minY, width: borderConfig.thickenss, height: frame.height)
        case .top: border.frame = CGRect(x: frame.minX, y: frame.minY, width: frame.width, height: borderConfig.thickenss)
        case .bottom: border.frame = CGRect(x: frame.minX, y: frame.maxY, width: frame.width, height: borderConfig.thickenss)
        }

        layer.addSublayer(border)
    }
}
