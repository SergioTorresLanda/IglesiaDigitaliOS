//
//  EditionPromisseMain.swift
//  EncuentroCatolicoProfile
//
//  Created by Jorge Cruz on 23/03/21.
//

import UIKit

open class EditionPromisseMain: NSObject {
    
    public static func createModule(navigation: UINavigationController) -> UIViewController {
        
        let viewController  :   EditionPromisseViewController?   =  EditionPromisseViewController()
        
        if let view = viewController {
            
            let presenter   =   EditionPromissePresenter()
            let interactor  =   EditionPromisseInteractor()
            
            view.presenter  =   presenter
            
            presenter.view  =   view
            presenter.interactor = interactor
            
            interactor.presenter = presenter
            
            return view
        }
        
        return UIViewController()
    }
}
