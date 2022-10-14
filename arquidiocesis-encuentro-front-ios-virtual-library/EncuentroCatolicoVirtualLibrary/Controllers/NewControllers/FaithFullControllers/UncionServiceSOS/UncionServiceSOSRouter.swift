//
//  UncionServiceSOSRouter.swift
//  EncuentroCatolicoVirtualLibrary
//
//  Created by Pablo Luis Velazquez Zamudio on 16/06/21.
//

import UIKit

open class UncionServiceSOSRouter: UncionServiceRouterProtocol {
    
    weak var viewController: UIViewController?
    
    static public func createModule() -> UIViewController {
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle(for: UncionSOSView.self))
        let view: UncionServiceSOSView = storyboard.instantiateViewController(withIdentifier: "UncionViewServiceSOS") as! UncionServiceSOSView
        let interactor = UncionServiceSOSInteractor()
        let router = UncionServiceSOSRouter()
        let presenter = UncionServiceSOSPresenter(interface: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.preenter = presenter
        router.viewController = view
        
        return view
        
    }
    
}

