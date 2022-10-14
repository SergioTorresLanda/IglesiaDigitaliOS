//
//  NotificationsModalRouter.swift
//  zeus-ios-sdk-new-social-network
//
//  Created by Consultor on 21/10/20.
//  Copyright © 2020 Gabriel Briseño. All rights reserved.
//

import UIKit

public class NotificationsModalRouter: NotificationsModalWireframeProtocol {
    
    weak var viewController: UIViewController?
    
    static func createModule() -> UIViewController {
        // Change to get view from storyboard if not using progammatic UI
        let view = NotificationsModalViewController(nibName: "NotificationsModalViewController", bundle: Bundle(for: NotificationsModalViewController.self))
        let interactor = NotificationsModalInteractor()
        let router = NotificationsModalRouter()
        let presenter = NotificationsModalPresenter(interface: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        
        return view
    }
}
