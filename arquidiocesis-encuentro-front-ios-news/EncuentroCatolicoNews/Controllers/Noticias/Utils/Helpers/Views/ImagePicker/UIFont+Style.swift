//
//  UIFont+Style.swift
//  zeus-ios-sdk-new-social-network
//
//  Created by Miguel Angel Vicario Flores on 12/10/20.
//  Copyright © 2020 Gabriel Briseño. All rights reserved.
//

import UIKit

internal extension UIFont {

    static var forCameraButton: UIFont {
        return UIFont.systemSemiBoldFont(ofSize: 10)
    }

    static var forHintLabel: UIFont {
        if let descriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: .caption2).withSymbolicTraits(.traitBold) {
            return UIFont(descriptor: descriptor, size: 0)
        } else {
            return UIFont.preferredFont(forTextStyle: .caption2)
        }
    }

    static var forTagLabel: UIFont {
        return UIFont.systemSemiBoldFont(ofSize: 16)
    }

    private static func systemSemiBoldFont(ofSize fontSize: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: fontSize, weight: .semibold)
    }

}

