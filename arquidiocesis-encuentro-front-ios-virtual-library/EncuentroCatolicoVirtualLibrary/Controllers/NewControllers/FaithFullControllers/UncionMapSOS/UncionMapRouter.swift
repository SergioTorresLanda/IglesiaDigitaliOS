//
//  UncionMapRouter.swift
//  EncuentroCatolicoVirtualLibrary
//
//  Created by Pablo Luis Velazquez Zamudio on 20/07/21.
//

import UIKit

open class UncionMapRouter: UncionMapRouterProtocol {
    
    weak var viewController: UIViewController?
    
    static public func createModuleMap() -> UIViewController {
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle(for: UncionMapView.self))
        let view: UncionMapView = storyboard.instantiateViewController(withIdentifier: "UncionMapView") as! UncionMapView
        let interactor = UncionMapInteractor()
        let router = UncionMapRouter()
        let presenter = UncionMapPresenter(interface: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        
        return view
        
    }
    
}
