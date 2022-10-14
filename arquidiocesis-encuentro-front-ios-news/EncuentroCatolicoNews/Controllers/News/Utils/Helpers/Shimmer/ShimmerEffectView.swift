//
//  ShimmerEffectView.swift
//  EncuentroCatolicoNews
//
//  Created by Diego Martinez on 02/03/21.
//

import Foundation
import UIKit

let kWidth = UIScreen.main.bounds.width
let kHeight = UIScreen.main.bounds.height

public extension UIView {
    func addShimmerEffect() {
        
        layer.masksToBounds = true
        // Front View
        let shimmerView = UIView(frame: CGRect(x: 0, y: -50, width: kHeight*2, height: kHeight*2))
        shimmerView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)
        shimmerView.clipsToBounds = true
        shimmerView.tag = 1001
        addSubview(shimmerView)
        
        let gradientLayer = CAGradientLayer()
        // An array of CGColorRef objects defining the color of each gradient stop. Animatable
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.gray.cgColor, UIColor.clear.cgColor]
        // An optional array of NSNumber objects defining the location of each gradient stop. Animatable.
        gradientLayer.locations = [0, 0.1]
        gradientLayer.startPoint = CGPoint(x: 0.7, y: 1)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.8)
        
        // Frame of the layer
        gradientLayer.frame = shimmerView.frame
        //gradientLayer.transform = CATransform3DMakeRotation(CGFloat(90), 0, 0, 1)
        
        // Mask of the layer into shimmerView
        shimmerView.layer.mask = gradientLayer
        
        // Animation
        let animation = CABasicAnimation(keyPath: "transform.translation.x")
        animation.duration = 1
        animation.fromValue = -(shimmerView.frame.width)
        animation.toValue = shimmerView.frame.width
        animation.repeatCount = Float.infinity
        //animation.autoreverses = true
        animation.isRemovedOnCompletion = false
        
        gradientLayer.add(animation, forKey: "")
    }
    
    func removeShimmerEffect() {
        for subview in self.subviews where subview.tag == 1001 {
            subview.removeFromSuperview()
            subview.layer.mask = nil
        }
    }
}

