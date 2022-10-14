//
//  SocialSearchRouter.swift
//  EncuentroCatolicoPrayers
//
//  Created by Pablo Luis Velazquez Zamudio on 25/01/22.
//

import Foundation
import UIKit

@available(iOS 13.0, *)
open class SocialSearchRouter: SocialSearchRouterProtocol {
    
    weak var viewContorller: UIViewController?
    
    static public func createModule() -> UIViewController {
        let storyboard = UIStoryboard(name: "SocialNetworkSearchView", bundle: Bundle.local)
        let view = storyboard.instantiateViewController(withIdentifier: "SEARCHSNVIEW") as! SocialSearchView
        let interactor = SearchSocialInteractor()
        let router = SocialSearchRouter()
        let presenter = SocialSearchPresenter(interface: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewContorller = view
        
        return view
        
    }
}
