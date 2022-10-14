//
//  ForgotPRouter.swift
//  EncuentroCatolicoLogin
//
//  Created by Pablo Luis Velazquez Zamudio on 21/06/21.
//

import UIKit

open class ForgotPRouter: ForgotRouterProtocol {
    
    weak var viewController: UIViewController?
    
    static public func createModule() -> UIViewController {
        let storyboard = UIStoryboard(name: "ForgotPassword", bundle: Bundle(for: ForgotPViewController.self))
        let view: ForgotPViewController = storyboard.instantiateViewController(withIdentifier: "ForgetView") as! ForgotPViewController
        let interactor = ForgotPInteractor()
        let router = ForgotPRouter()
        let presenter = ForgotPPresenter(interface: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        
        return view
    }
}


