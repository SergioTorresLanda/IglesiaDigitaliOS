//
//  LiveRouter.swift
//  EncuentroCatolicoLive
//
//  Created Diego Martinez on 25/02/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

open class LiveRouter: LiveWireframeProtocol {
    
    weak var viewController: UIViewController?
    
    static public func createModule() -> UIViewController {
        // Change to get view from storyboard if not using progammatic UI
        let view = LiveViewController(nibName: "LiveViewController", bundle: Bundle.local)
        let interactor = LiveInteractor()
        let router = LiveRouter()
        let presenter = LivePresenter(interface: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        
        return view
    }
}
