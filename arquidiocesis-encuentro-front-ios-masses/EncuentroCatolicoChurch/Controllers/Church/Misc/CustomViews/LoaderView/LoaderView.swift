//
//  LoaderView.swift
//  encuentro
//
//  Created by Edgar Hernandez Solis on 10/05/20.
//  Copyright © 2020 Linko. All rights reserved.
//

import Foundation
import UIKit

public class LoaderView {

    //MARK: - Singleton
    public static let shared = LoaderView()
    
    //MARK Local variables
    ///Container
    var view: UIView!
    
    //MARK: - Inicialization
    private init() {
        view = Bundle(for: LoaderView.self).loadNibNamed("LoaderView", owner: nil, options: nil)?.first as? UIView
        view.frame = UIScreen.main.bounds
    }

    //MARK: - Loader controls
    func show() {
        DispatchQueue.main.async {
            [weak self] in
            guard let self = self else {return}
            UIApplication.shared.windows.first(where: {$0.isKeyWindow})?.addSubview(self.view)
        }
    }
    
    func hide() {
        DispatchQueue.main.async {
            [weak self] in
            guard let self = self else {return}
            self.view.removeFromSuperview()
        }
    }
}

