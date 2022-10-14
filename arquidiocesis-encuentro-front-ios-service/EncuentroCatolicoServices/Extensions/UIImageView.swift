//
//  UIImageView.swift
//  EncuentroCatolicoServices
//
//  Created by Ricardo Ramirez on 10/05/21.
//

import UIKit

extension UIImageView {
    
    func load(url: URL) {
        DispatchQueue.main.async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
    
}
