//
//  GradientView.swift
//  RedSocialFramework
//
//  Created by Miguel Angel Vicario Flores on 24/10/20.
//  Copyright © 2020 Gabriel Briseño. All rights reserved.
//

import UIKit

final public class GradientView: UIView {

    private var firstColor: UIColor = .white
    private var secondColor: UIColor = .black

    override public class var layerClass: AnyClass { get { CAGradientLayer.self } }

    override public func layoutSubviews() {
        super.layoutSubviews()
        
        updateView()
        layer.frame = bounds
    }

    private func updateView() {
        let layer = self.layer as! CAGradientLayer
        layer.colors = [firstColor, secondColor].map {$0.cgColor}
        layer.locations = [0.0, 1.0]
    }
}
