//
//  ListServicesRouter.swift
//  EncuentroCatolicoServices
//
//  Created by Pablo Luis Velazquez Zamudio on 26/07/21.
//

import UIKit

open class ListServiceRouter: ListServiceRouterProtocol {
    
    weak var viewController: UIViewController?
    
    static public func createModule() -> UIViewController {
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle(for: ListServicesView.self))
        let view: ListServicesView = storyboard.instantiateViewController(withIdentifier: "ListServiceView") as! ListServicesView
        let interactor = ListServiceInteractor()
        let router = ListServiceRouter()
        let presenter = ListServicePresenter(interface: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        
        return view
    }
}
