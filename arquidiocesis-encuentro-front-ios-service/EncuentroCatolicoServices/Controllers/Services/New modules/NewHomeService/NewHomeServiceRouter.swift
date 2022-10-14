//
//  NewHomeServiceRouter.swift
//  EncuentroCatolicoServices
//
//  Created by Pablo Luis Velazquez Zamudio on 26/07/21.
//

import UIKit

open class NewHomeServiceRouter: NewHomeServiceRouterProtocol {
    
    weak var viewController: UIViewController?
    
    static public func createModule() -> UIViewController {
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle(for: NewHomeServiceView.self))
        let view: NewHomeServiceView = storyboard.instantiateViewController(withIdentifier: "NewHomeView") as! NewHomeServiceView
        let interactor = NewHomeServiceInteractor()
        let router = NewHomeServiceRouter()
        let presenter = NewHomeServicePresenter(interface: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        
        return view
        
    }
    
}



