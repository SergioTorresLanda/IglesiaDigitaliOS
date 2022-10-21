//
//  UIViewController+Utils.swift
//  EncuentroCatolicoUtils
//
//  Created by Alejandro on 20/10/22.
//

import UIKit

public extension UIViewController {
    static var alertLoader: UIViewController?
    
    //MARK: - Methods
    func showSpinner() {
        guard Self.alertLoader == nil else {
            return
        }
        
        let alertLoader = UIAlertController.createDefaultAlert(title: "", message: "\n \n \n \n \nCargando...")
        
        self.present(alertLoader, animated: false, completion: nil)
        Self.alertLoader = alertLoader
    }
    
    func hideSpinner() {
        Self.alertLoader?.dismiss(animated: true)
        Self.alertLoader = nil
    }
}
