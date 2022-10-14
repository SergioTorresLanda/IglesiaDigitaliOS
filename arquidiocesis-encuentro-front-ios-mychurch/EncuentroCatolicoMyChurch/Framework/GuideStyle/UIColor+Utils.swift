//
//  UIColor+Utils.swift
//  Nomad
//
//  Created by Diego Luna on 08/07/20.
//

import Foundation
import UIKit

public struct PrimaryColor {
    public let blue: UIColor = UIColor(red: 19, green: 39, blue: 124)
}

public struct SecondaryColor {
    public let lightGray: UIColor = UIColor(red: 245, green: 245, blue: 245)
    public let purple: UIColor = UIColor(red: 107, green: 31, blue: 159)
}

public struct ShadowColor {
    
    public let radius: CGFloat = 20
    public let shadowColor: UIColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.17)
    public let opacity: CGFloat = 1
    public let offSet: CGSize = CGSize(width: 0, height: 16)
    
    public func setShadow(with layer: CALayer) {
        setupShadow(with: layer, radius: radius, color: shadowColor, offSet: offSet, opacity: opacity)
    }
    
    public func setShadow(with layer: CALayer, customRadius: CGFloat, customOpacity: CGFloat) {
        setupShadow(with: layer, radius: customRadius, color: shadowColor, offSet: offSet, opacity: customOpacity)
    }
}

public struct ShadowPalette {
    public let cloudyBlack = UIColor(red: 0, green: 0, blue: 0, alpha: 0.17)
}

extension ShadowColor {
    func setupShadow(with layer: CALayer, radius: CGFloat, color: UIColor, offSet: CGSize, opacity: CGFloat) {
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = Float(opacity)
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
        layer.masksToBounds = false
    }
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int, alpha: CGFloat = 1.0) {
        let newRed = CGFloat(red) / 255
        let newGreen = CGFloat(green) / 255
        let newBlue = CGFloat(blue) / 255
        
        self.init(red: newRed, green: newGreen, blue: newBlue, alpha: alpha)
    }
}
