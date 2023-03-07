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
        let imageView = UIImageView(frame: CGRect(x: 100, y: 15, width: 80, height: 80))//mitad es en 145dp
        imageView.image = UIImage(named: "iconoIglesia3", in: Bundle.local, compatibleWith: nil)
        
        alertLoader.view.addSubview(imageView)
        
        return alertLoader
    }
}
