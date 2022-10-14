//
//  ViewControllerExtension.swift
//  zeus-ios-sdk-new-social-network
//
//  Created by Diego Martinez on 15/01/21.
//  Copyright © 2021 Gabriel Briseño. All rights reserved.
//

import Foundation
import UIKit

public extension UIViewController{
    func globalIndicator(message: String){
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.gray
        loadingIndicator.startAnimating();
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
    }
    
}

public extension Bundle {
    static let local: Bundle = Bundle.init(for: FeedRouter.self)
}
