//
//  RouterSOSServices.swift
//  SOSLinko
//
//  Created by Ulises Atonatiuh González Hernández on 21/03/21.
//

import Foundation
import UIKit
open class NotificationRouter: NotificationRouterProtocol {
    
    public static func presentModule() -> UIViewController {
        let storyboard = UIStoryboard(name: "Storyboard", bundle: Bundle(for: NotificationView.self))
        let view: NotificationViewProtocol = storyboard.instantiateViewController(withIdentifier: "NotificationView") as! NotificationView
        let presenter: NotificationPresenterProtocol & NotificationOutputInteractorProtocol = NotificationPresenter()
        let interactor: NotificationInputInteractorProtocol = NotificationInteractor()
        let router: NotificationRouterProtocol = NotificationRouter()

        // Connecting
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view as! UIViewController
    }
    
   

}
