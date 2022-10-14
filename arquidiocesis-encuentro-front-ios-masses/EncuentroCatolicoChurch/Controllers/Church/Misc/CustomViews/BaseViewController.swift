//
//  BaseViewController.swift
//  encuentro
//
//  Created by Edgar Hernandez Solis on 03/10/20.
//  Copyright © 2020 Linko. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    //MARK: - Life cycle
    deinit {
        #if DEV
        print("ENCUENTRO: Removing \(self.description)")
        #endif
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        //Force light mode
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
        
//        let backButtonImage = UIImage(named: "back-button")?.withRenderingMode(.alwaysOriginal)
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = UIColor.white
//        navigationController?.navigationBar.backIndicatorImage = backButtonImage
//        navigationController?.navigationBar.backIndicatorTransitionMaskImage = backButtonImage
        navigationController?.navigationBar.tintColor = .eGreenishBlue
        
        tabBarController?.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        tabBarController?.navigationController?.navigationBar.shadowImage = UIImage()
        tabBarController?.navigationController?.navigationBar.isTranslucent = true
        tabBarController?.navigationController?.view.backgroundColor = UIColor.white
//        tabBarController?.navigationController?.navigationBar.backIndicatorImage = backButtonImage
//        tabBarController?.navigationController?.navigationBar.backIndicatorTransitionMaskImage = backButtonImage
        tabBarController?.navigationController?.navigationBar.tintColor = .eGreenishBlue
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.leftBarButtonItem = nil
        navigationItem.rightBarButtonItem = nil
        
        tabBarController?.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        tabBarController?.navigationItem.leftBarButtonItem = nil
        tabBarController?.navigationItem.rightBarButtonItem = nil
        
        tabBarController?.tabBar.isHidden = true
    }
    
    func setTitle(_ title: String, color: UIColor = UIColor.eMainBlue) {
        let textAttributes = [NSAttributedString.Key.foregroundColor: color,
                              NSAttributedString.Key.font: UIFont(name: "Roboto-Bold", size: 18) ?? UIFont.systemFont(ofSize: 18, weight: .bold)]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        navigationItem.title = title
        tabBarController?.title = title
    }
    
    func showMessage(_ message: String, title: String = "App Encuentro", completion: (() -> Void)? = nil) {
        DispatchQueue.main.async {
            [weak self] in
            self?.view.endEditing(true)
            let alert = UIAlertController(title: title + "\n", message: message, preferredStyle: .alert)
            let acceptAction = UIAlertAction(title: "Aceptar", style: .cancel) {
                _ in
                completion?()
            }
            alert.addAction(acceptAction)
            self?.present(alert, animated: true)
        }
    }
    
    func showLoader() {
        LoaderView.shared.show()
    }
    
    func removeLoader() {
        LoaderView.shared.hide()
    }

}
