//
//  UncionSOSRouter.swift
//  EncuentroCatolicoVirtualLibrary
//
//  Created by Pablo Luis Velazquez Zamudio on 16/06/21.
//

import UIKit

open class UncionSOSRouter: UncionRouterProtocol {
    
    weak var viewController: UIViewController?
    
    static public func createModule(globalLatitude: String, globalLongitude: String) -> UIViewController {
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle(for: UncionSOSView.self))
        let view: UncionSOSView = storyboard.instantiateViewController(withIdentifier: "UncionViewSOS") as! UncionSOSView
        let interactor = UncionSOSInteractor()
        let router = UncionSOSRouter()
        let presenter = UncionSOSPresenter(interface: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        view.globalLatitude = globalLatitude
        view.globalLongitude = globalLongitude
        interactor.preenter = presenter
        router.viewController = view
        
        return view
        
    }
    
    func Go() {
        
    }
    
}
