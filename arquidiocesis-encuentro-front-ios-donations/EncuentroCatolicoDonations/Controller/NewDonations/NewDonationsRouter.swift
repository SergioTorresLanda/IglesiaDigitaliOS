//
//  NewDonationsRouter.swift
//  EncuentroCatolicoDonations
//
//  Created by Pablo Luis Velazquez Zamudio on 21/02/22.
//

import Foundation
import UIKit

open class NewDonationsRouter: NewDonationsRouterProtocol {
    
    weak var viewContorller: UIViewController?
    
    static public func createModule() -> UIViewController {
        let storyboard = UIStoryboard(name: "NewDonations", bundle: Bundle.local)
        let view = storyboard.instantiateViewController(withIdentifier: "NewDonationsView") as! NewDontaionsViewController
        let interactor = NewDontaionsInteractor()
        let router = NewDonationsRouter()
        let presenter = NewDonationsPresenter(interface: view, router: router, interactor: interactor)
        
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewContorller = view
        
        return view
        
    }
}

