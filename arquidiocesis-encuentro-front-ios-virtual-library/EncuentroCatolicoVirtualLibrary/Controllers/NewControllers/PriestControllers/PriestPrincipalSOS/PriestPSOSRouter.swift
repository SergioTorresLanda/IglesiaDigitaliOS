//
//  PriestPSOSRouter.swift
//  EncuentroCatolicoVirtualLibrary
//
//  Created by Pablo Luis Velazquez Zamudio on 28/06/21.
//

import UIKit

open class PriestPSOSRouter: PriestPSOSRouterProtocol {
    
    weak var viewController: UIViewController?
    
    static public func createModule() -> UIViewController {
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle(for: PriestPSOSView.self))
        let view: PriestPSOSView = storyboard.instantiateViewController(withIdentifier: "PriestViewSOS") as! PriestPSOSView
        let interactor = PriestPSOSInteractor()
        let router = PriestPSOSRouter()
        let presenter = PriestPSOSPresenter(interface: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        
        return view
        
    }
    
}


