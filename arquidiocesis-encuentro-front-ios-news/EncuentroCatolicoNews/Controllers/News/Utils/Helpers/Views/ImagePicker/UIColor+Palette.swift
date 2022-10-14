//
//  UIColor+Palette.swift
//  zeus-ios-sdk-new-social-network
//
//  Created by Miguel Angel Vicario Flores on 12/10/20.
//  Copyright © 2020 Gabriel Briseño. All rights reserved.
//

import UIKit

internal extension UIColor {

    enum Palette {
        static let blue = UIColor(hex: 0x2984C0)
        static let lightGrey = UIColor(hex: 0x8F939C)
        static let grey = UIColor(hex: 0x8F939C)
        static let magnesium = UIColor(hex: 0xB2B2B2)
        static let darkGrey = UIColor(hex: 0x4B4D52)
    }

    convenience init(hex: Int) {
        self.init(
            red: CGFloat((hex & 0xFF0000) >> 16) / 255,
            green: CGFloat((hex & 0x00FF00) >> 8) / 255,
            blue: CGFloat(hex & 0x0000FF) / 255,
            alpha: 1
        )
    }

}
