//
//  CongregationsRouter.swift
//  EncuentroCatolicoProfile
//
//  Created by Pablo Luis Velazquez Zamudio on 11/09/21.
//

import Foundation
import UIKit

open class CongregationRouter: CongregationsRouterProtocol {
    
    weak var viewController: UIViewController?
    
    static public func createModule() -> UIViewController {
        let sotryboard = UIStoryboard(name: "Congregations", bundle: Bundle.local)
        let view = sotryboard.instantiateViewController(withIdentifier: "congregationView") as! CongregationsView
        let interactor = CongregationsInteractor()
        let router = CongregationRouter()
        let presenter = CongregationsPresenter(interface: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        
        return view
        
    }
}


