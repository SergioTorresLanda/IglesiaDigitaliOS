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
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle(for: Home_SOSPriest.self))
        let view: Home_SOSPriest = storyboard.instantiateViewController(withIdentifier: "PriestViewSOS") as! Home_SOSPriest
        let interactor = PriestPSOSInteractor()
        let router = PriestPSOSRouter()
        let presenter = PriestPSOSPresenter(interface: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        
        return view
        
    }
    
}


