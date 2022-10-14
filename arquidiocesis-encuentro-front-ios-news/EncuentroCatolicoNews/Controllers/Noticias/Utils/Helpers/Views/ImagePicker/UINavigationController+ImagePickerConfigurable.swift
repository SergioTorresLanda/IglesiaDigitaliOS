//
//  UINavigationController+ImagePickerConfigurable.swift
//  zeus-ios-sdk-new-social-network
//
//  Created by Miguel Angel Vicario Flores on 12/10/20.
//  Copyright © 2020 Gabriel Briseño. All rights reserved.
//

import UIKit

internal extension UINavigationController {
    
    func configure(with settings: ImagePickerConfigurable?) {
        if let barStyle = settings?.navigationBarStyle {
            navigationBar.barStyle = barStyle
        }

        if let isTranslucent = settings?.navigationBarTranslucent {
            navigationBar.isTranslucent = isTranslucent
        }

        if let barTintColor = settings?.navigationBarTintColor {
            navigationBar.tintColor = barTintColor
        }

        if let backgroundColor = settings?.navigationBarBackgroundColor {
            navigationBar.barTintColor = backgroundColor
        }
    }

}

