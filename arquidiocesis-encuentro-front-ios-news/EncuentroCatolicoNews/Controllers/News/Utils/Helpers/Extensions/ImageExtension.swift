//
//  ImageExtension.swift
//  RedSocialFramework
//
//  Created by Miguel Angel Vicario Flores on 17/12/20.
//  Copyright © 2020 Gabriel Briseño. All rights reserved.
//

import UIKit
import SDWebImage
import LetterAvatarKit

public extension UIImage {
    func resizedImage(for size: CGSize) -> UIImage? {
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { (context) in
            self.draw(in: CGRect(origin: .zero, size: size))
        }
    }
}

public extension UIImageView {
    func setImage(name: String?, image: String?, circle: Bool = true) {
        if let image = image, let url = URL(string: image) {
            self.sd_setImage(with: url, placeholderImage: nil, options: .refreshCached, context: nil)
        } else {
            var nameInitials = ""
            if let initials = name?.getInitials() {
                
                nameInitials = initials
            }
            self.image = LetterAvatarMaker()
                          .build { c in
                            c.circle = circle
                            c.username = nameInitials
                            c.borderWidth = 0.0
                            c.backgroundColors = [ UIColor(red: 132/255, green: 132/255, blue: 132/255, alpha: 1.00) ]
                        }
        }
    }
}

extension UIImageView {
    func borderImgColor(color: UIColor, radius: CGFloat) {
        self.layer.cornerRadius = radius
        let colorBorde = color
        self.layer.borderWidth = 1.5
        self.clipsToBounds = true
        self.layer.borderColor = colorBorde.cgColor
       
    }
}
