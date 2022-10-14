//
//  NewOnboardingRouter.swift
//  EncuentroCatolicoProfile
//
//  Created by Pablo Luis Velazquez Zamudio on 13/09/21.
//

import Foundation
import UIKit

open class NewOnboardingRouter: NewOnboardingRouterProtocol {
    
    weak var viewController: UIViewController?
    
     static public func createModule(typeOnboarding: String) -> UIViewController {
        
        let storyboard = UIStoryboard(name: "NewOnboardings", bundle: Bundle.local)
        let view: NewOnboardingsView = storyboard.instantiateViewController(withIdentifier: "VIEWON") as! NewOnboardingsView
        let interactor = NewOnboardingInteractor()
        let router = NewOnboardingRouter()
        let presenter = NewOnboardingPresenter(interface: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        view.typeView = typeOnboarding
        interactor.presenter = presenter
        router.viewController = view
        
        return view
        
    }
    
}

