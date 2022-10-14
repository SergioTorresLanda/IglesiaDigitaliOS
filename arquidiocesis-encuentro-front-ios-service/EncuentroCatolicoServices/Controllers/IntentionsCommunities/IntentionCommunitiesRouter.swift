//
//  IntentionCommunitiesRouter.swift
//  EncuentroCatolicoServices
//
//  Created by Pablo Luis Velazquez Zamudio on 08/09/21.
//

import Foundation
import UIKit

open class IntentionsCommunitiesRouter: IntentionsCommunitiesRouterProtocol, IntentionsWireframeProtocol {
    
    weak var viewController: UIViewController?
    
    static public func createModule() -> UIViewController {
        let storyboard = UIStoryboard(name: "IntentionsCommunities", bundle: Bundle(for: IntentionsCommunitiesView.self))
        let view: IntentionsCommunitiesView = storyboard.instantiateViewController(withIdentifier: "IntentionCommunities") as! IntentionsCommunitiesView
        let interactor = IntentionsCommunitiesInteractor()
        let router = IntentionsCommunitiesRouter()
        let presenter = IntentionsCommunitiesPresenter(interface: view, interactor: interactor, router: router)
       
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        
        return view
    }
}

