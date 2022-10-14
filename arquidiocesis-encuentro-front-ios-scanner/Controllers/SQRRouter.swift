//
//  SRouter.swift
//  baz-buy
//
//  Created by Monserrat Caballero on 28/10/20.
//

import UIKit

protocol SQRPresenterToRouter: class {
    func setNextFlow(navigationController: UINavigationController, _ code: String, _ amm0unt: String)
    func cancelNextFlow(navigationController: UINavigationController, toRoot: Bool)
}

open class SQRRouter: UINavigationController {
    public static func createModule(navigation: UINavigationController) -> UIViewController {
        let view = SQRMainVC()
        let presenter : SQRViewToPresenterProtocol & SQRInteractorToPresenterProtocol = SQRPresenter()
        let interactor: SQRPresenterToInteractorProtocol = SQRInteractor()
        let route: SQRPresenterToRouter = SQRRouter()
        
        view._presenter = presenter
        presenter.navigation = navigation
        presenter._view = view
        presenter._router = route
        presenter._interactor = interactor
        
        interactor._presenter = presenter
        
        return view
    }
}

extension SQRRouter: SQRPresenterToRouter{
    
    func cancelNextFlow(navigationController: UINavigationController, toRoot: Bool) {        
        if toRoot {
            navigationController.popToRootViewController(animated: false)
        } else {
            navigationController.popViewController(animated: false)
        }
    }
    
    func setNextFlow(navigationController: UINavigationController, _ code: String, _ amm0unt: String) {
    
      //  let second = CWRouter.createModule(navigation: navigationController, code, amm0unt)
      //  navigationController.pushViewController(second, animated: true)
        
    }
    
}
