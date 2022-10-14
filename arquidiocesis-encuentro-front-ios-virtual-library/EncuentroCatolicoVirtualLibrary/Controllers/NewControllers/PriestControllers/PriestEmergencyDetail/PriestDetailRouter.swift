//
//  PriestDetailRouter.swift
//  EncuentroCatolicoVirtualLibrary
//
//  Created by Pablo Luis Velazquez Zamudio on 29/06/21.
//

import UIKit

open class PriestDetailRouter: PriestDetailRouterProtocol {
    
    weak var viewController: UIViewController?
    
    static public func createModule() -> UIViewController {
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle(for: PriestDetailView.self))
        let view: PriestDetailView = storyboard.instantiateViewController(withIdentifier: "PriestContactDetailView") as! PriestDetailView
        let interactor = PriestDetailInteractor()
        let router = PriestDetailRouter()
        let presenter = PriestDetailPresenter(interface: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        
        return view
        
    }
    
}
