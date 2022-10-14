//
//  ConfirmationCodeRouter.swift
//  EncuentroCatolicoLogin
//
//  Created by Pablo Luis Velazquez Zamudio on 21/06/21.
//

import UIKit

open class ConfirmationCodeRouter: ConfirmationCodeRouterProtocol {
    
    weak var viewController: UIViewController?
    
    static public func createModule(userEmail: String) -> UIViewController {
        let storyboard = UIStoryboard(name: "ForgotPassword", bundle: Bundle(for: ConfirmationCodeView.self))
        let view: ConfirmationCodeView = storyboard.instantiateViewController(withIdentifier: "ConfirmationView") as! ConfirmationCodeView
        let interactor = ConfirmationCodeInteractor()
        let router = ConfirmationCodeRouter()
        let presenter = ConfirmationCodePresenter(interface: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        view.emailUser = userEmail
        
        return view
    }
}
