//
//  MapDonationsRouter.swift
//  EncuentroCatolicoDonations
//
//  Created by Pablo Luis Velazquez Zamudio on 15/03/22.
//

import UIKit

open class MapDonationsRouter: MapDonationsRouterProtocol {
    
    weak var viewContorller: UIViewController?
    
    static public func createModule() -> UIViewController {
        let storyboard = UIStoryboard(name: "NewDonations", bundle: Bundle.local)
        let view = storyboard.instantiateViewController(withIdentifier: "MapDonationsView") as! MapDonationsView
        let interactor = MapDonationsInteractor()
        let router = MapDonationsRouter()
        let presenter = MapDonationsPresenter(interface: view, router: router, interactor: interactor)
        
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewContorller = view
        
        return view
        
    }
}
