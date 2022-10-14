//
//  PriestContactRouter.swift
//  EncuentroCatolicoVirtualLibrary
//
//  Created by Pablo Luis Velazquez Zamudio on 29/06/21.
//

import UIKit

open class PriestContactRouter: PriestContactRouterProtocol {
    weak var viewController: UIViewController?
    
    static public func createModule() -> UIViewController {
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle(for: PriestContactView.self))
        let view: PriestContactView = storyboard.instantiateViewController(withIdentifier: "PriestContactView") as! PriestContactView
        let interactor = PriestContactInteractor()
        let router = PriestContactRouter()
        let presenter = PriestContactPresenter(interface: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        
        return view
        
    }
}




