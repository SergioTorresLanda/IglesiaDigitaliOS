//
//  MassesRouter.swift
//  EncuentroCatolicoMasses
//
//  Created Diego Martinez on 02/03/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class MassesRouter: MassesWireframeProtocol {
    
    weak var viewController: UIViewController?
    
    static func createModule() -> UIViewController {
        // Change to get view from storyboard if not using progammatic UI
        let view = MassesViewController(nibName: nil, bundle: nil)
        let interactor = MassesInteractor()
        let router = MassesRouter()
        let presenter = MassesPresenter(interface: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        
        return view
    }
}
