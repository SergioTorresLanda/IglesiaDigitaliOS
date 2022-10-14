//
//  NewListIntentionsRouter.swift
//  EncuentroCatolicoServices
//
//  Created by Pablo Luis Velazquez Zamudio on 27/07/21.
//

import Foundation
import UIKit

open class NewListIntentionsRouter: NewListIntentionsRouterProtocol {
    
    weak var viewController: UIViewController?
    
    static public func createModule() -> UIViewController {
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle(for: NewListIntentionsView.self))
        let view: NewListIntentionsView = storyboard.instantiateViewController(withIdentifier: "NewListIntentions") as! NewListIntentionsView
        let interactor = NewListIntentionsInteractor()
        let router = NewListIntentionsRouter()
        let presenter = NewListIntentionsPresneter(interface: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        
        return view
        
    }
    
}
