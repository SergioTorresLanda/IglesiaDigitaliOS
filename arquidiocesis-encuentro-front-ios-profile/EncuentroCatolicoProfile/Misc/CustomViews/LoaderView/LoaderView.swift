//
//  LoadView.swift
//  OracionesModulo
//
//  Created by Ulises Atonatiuh González Hernández on 02/03/21.
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
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1, execute: {
            [weak self] in
            guard let self = self else {return}
            self.view.removeFromSuperview()
        })
    }
}

