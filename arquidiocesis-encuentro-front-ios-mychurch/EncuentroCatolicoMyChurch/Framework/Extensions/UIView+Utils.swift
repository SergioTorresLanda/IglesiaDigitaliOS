//
//  UIView+Utils.swift
//  Terrabite
//
//  Created by Diego Luna on 02/11/20.
//

import Foundation
import UIKit

extension UIView {
    func setup(roundedCorners: RoundedCorners) {
        setupRoundedCorners(radius: roundedCorners.radius, corners: roundedCorners.corners)
    }
    
    func setupRoundedCorners(radius: CGFloat, corners: UIRectCorner = .allCorners) {
        layer.cornerRadius = radius
        clipsToBounds = true
        if let mask = corners.mask {
            layer.maskedCorners = mask
        }
        if layer.shadowPath != nil {
            createCachedShadow()
        }
    }
    
    func makeItCircular() {
        layoutIfNeeded()
        setupRoundedCorners(radius: min(frame.size.height, frame.size.width) / 2)
    }
    
    func setCornerRadius(color: UIColor, borderWidth: CGFloat) {
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = color.cgColor
    }
    
    func resetCornerRadius() {
        layer.cornerRadius = 0.0
        if layer.shadowPath != nil {
            createCachedShadow()
        }
    }
    
    func setRounded(roundedType: RoundedType, color: UIColor, borderWith: CGFloat? = 1) {
        layer.cornerRadius = self.frame.width / 2
        layer.borderWidth = borderWith ?? 1
        layer.borderColor = color.cgColor
        clipsToBounds = true
    }
    
    func setupRoundedCornersWith(radius: CGFloat, color: UIColor, borderWith: CGFloat? = 1) {
        layer.cornerRadius = radius
        layer.borderWidth = borderWith ?? 1
        layer.borderColor = color.cgColor
        clipsToBounds = true
    }
    
    func setupShadow(radius: CGFloat, opacity: CGFloat, offsetX: CGFloat = 0, offsetY: CGFloat, cache: Bool = false, color: UIColor? = .black) {
        layer.shadowOffset = CGSize(width: offsetX, height: offsetY)
        layer.shadowRadius = radius
        if let color = color {
            layer.shadowColor = color.cgColor
            clipsToBounds = false
        }
        layer.shadowOpacity = Float(opacity)
        if cache {
            createCachedShadow()
        }
    }
    
    func createCachedShadow() {
        let origin = CGPoint(x: bounds.origin.x + layer.shadowOffset.width, y: bounds.origin.y + layer.shadowOffset.height)
        let size = CGSize(width: bounds.size.width + layer.shadowOffset.width, height: bounds.size.height + layer.shadowOffset.height)
        let rect = CGRect(origin: origin, size: size)
        let path: UIBezierPath
        if layer.cornerRadius > 0 {
            let maskedRect = layer.maskedCorners.rect
            if maskedRect == .allCorners {
                path = UIBezierPath(roundedRect: rect, cornerRadius: layer.cornerRadius)
            } else {
                path = UIBezierPath(roundedRect: rect, byRoundingCorners: maskedRect, cornerRadii: CGSize(width: layer.cornerRadius, height: layer.cornerRadius))
            }
        } else {
            path = UIBezierPath(rect: rect)
        }
        layer.shadowPath = path.cgPath
    }
}

enum ViewFeatures {
    case rounded, shadow, color(UIColor), bordered(UIColor, CGFloat), image(UIImage),
         roundedView(RoundedType, UIColor), topRounded,
         fullRounded, customRounded(UIRectCorner)
}

enum RoundedType {
    case full, onlyLayer
}

struct RoundedCorners {
    
    public let radius: CGFloat
    public let corners: UIRectCorner
    
    public init(radius: CGFloat, corners: UIRectCorner) {
        self.radius = radius
        self.corners = corners
    }
}

extension UIRectCorner {
    var mask: CACornerMask? {
        guard self != .allCorners else { return nil }
        var cornerMask = CACornerMask()
        if contains(.topLeft) {
            cornerMask.insert(.layerMinXMinYCorner)
        }
        if contains(.topRight) {
            cornerMask.insert(.layerMaxXMinYCorner)
        }
        if contains(.bottomLeft) {
            cornerMask.insert(.layerMinXMaxYCorner)
        }
        if contains(.bottomRight) {
            cornerMask.insert(.layerMaxXMaxYCorner)
        }
        return cornerMask
    }
}

extension CACornerMask {
    var rect: UIRectCorner {
        var cornersCount = 0
        var rect = UIRectCorner()
        if contains(.layerMinXMinYCorner) {
            rect.insert(.topLeft)
            cornersCount += 1
        }
        if contains(.layerMaxXMinYCorner) {
            rect.insert(.topRight)
            cornersCount += 1
        }
        if contains(.layerMinXMaxYCorner) {
            rect.insert(.bottomLeft)
            cornersCount += 1
        }
        if contains(.layerMaxXMaxYCorner) {
            rect.insert(.bottomRight)
            cornersCount += 1
        }
        guard cornersCount != 4 else { return .allCorners }
        return rect
    }
}
