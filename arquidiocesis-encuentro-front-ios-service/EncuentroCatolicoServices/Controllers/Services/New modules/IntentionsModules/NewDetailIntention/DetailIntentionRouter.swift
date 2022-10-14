//
//  DetailIntentionRouter.swift
//  EncuentroCatolicoServices
//
//  Created by Pablo Luis Velazquez Zamudio on 27/07/21.
//

import Foundation
import UIKit

open class DetailIntetnionRouter: DetailIntentionRouterProtocol {
    
    weak var viewController: UIViewController?
    
    static public func createModule(date: String, hour: String) -> UIViewController {
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle(for: DetailIntentionView.self))
        let view: DetailIntentionView = storyboard.instantiateViewController(withIdentifier: "DetailIntentionView") as! DetailIntentionView
        let interactor = DetailIntentionInteractor()
        let router = DetailIntetnionRouter()
        let presenter = DetailIntentionPresenter(interface: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        view.dateStr = date
        view.hourStr = hour
        
        return view
        
    }
    
}

