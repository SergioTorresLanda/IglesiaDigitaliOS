//
//  UIAlertViewController+Utils.swift
//  EncuentroCatolicoUtils
//
//  Created by Alejandro on 21/10/22.
//

import UIKit

public extension UIAlertController {
    static func createDefaultAlert(title: String, message: String) -> UIAlertController {
        let alertLoader = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let imageView = UIImageView(frame: CGRect(x: 75, y: 25, width: 140, height: 60))
                imageView.image = UIImage(named: "logoEncuentro", in: Bundle.local, compatibleWith: nil)
        
        alertLoader.view.addSubview(imageView)
        
        return alertLoader
    }
}
