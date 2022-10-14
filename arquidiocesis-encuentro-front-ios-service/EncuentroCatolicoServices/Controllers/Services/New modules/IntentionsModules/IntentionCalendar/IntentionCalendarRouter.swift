//
//  IntentionCalendarRouter.swift
//  EncuentroCatolicoServices
//
//  Created by Pablo Luis Velazquez Zamudio on 29/07/21.
//

import Foundation
import UIKit

open class IntentionCalendarRouter: IntentionCalendarRouterProtocol {
    
    weak var viewController: UIViewController?
    
    static public func createModule() -> UIViewController {
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle(for: IntentionCalendarView.self))
        let view: IntentionCalendarView = storyboard.instantiateViewController(withIdentifier: "CalendarView") as! IntentionCalendarView
        let interactor = IntentionCalendarInteractor()
        let router = IntentionCalendarRouter()
        let presenter = IntentionCalendarPresenter(interface: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        
        return view
        
    }
    
}

