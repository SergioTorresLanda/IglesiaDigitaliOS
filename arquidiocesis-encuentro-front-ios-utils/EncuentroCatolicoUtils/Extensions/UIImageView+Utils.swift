//
//  UIImageView+Utils.swift
//  EncuentroCatolicoUtils
//
//  Created by Alejandro on 24/10/22.
//

import UIKit
import Kingfisher

public extension UIImageView {
    func setCacheImage(with url: URL) {
        self.kf.setImage(with: url)
    }
}

