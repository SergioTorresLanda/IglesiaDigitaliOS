//
//  SacramentsRouter.swift
//  EncuentroCatolicoServices
//
//  Created Desarrollo on 30/04/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

open class SacramentsRouter: SacramentsWireframeProtocol {
    
    weak var viewController: UIViewController?
    
    static public func createModule() -> UIViewController {
        // Change to get view from storyboard if not using progammatic UI
        let view = SacramentsViewController(nibName: "SacramentsViewController", bundle: Bundle.init(identifier: "mx.arquidiocesis.EncuentroCatolicoServices"))
        let interactor = SacramentsInteractor()
        let router = SacramentsRouter()
        let presenter = SacramentsPresenter(interface: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        
        return view
    }
}
