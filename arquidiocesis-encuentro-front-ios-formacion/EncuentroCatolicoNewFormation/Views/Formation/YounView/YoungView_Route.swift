//
//  FirstMan_Route.swift
//  EncuentroCatolicoNewFormation
//
//  Created by Daniel Isaac Mora Osorio on 01/05/21.
//

import UIKit

public class YoungView_Route {
    public static func createView(navigation: UINavigationController) -> UIViewController {
        let view = Home_BibliotecaVirtual()
        let presenter_FYV : FYV_VIPER_ViewToPresenterProtocol & FYV_VIPER_InteractorToPresenterProtocol = FYV_ProfilePresenter()
        let interactor_FYV: FYV_VIPER_PresenterToInteractorProtocol = FYV_ProfileInteractor()
        let route: SSVIPER_PresenterToRouter = YoungView_Route()
        view._presenter = presenter_FYV
        presenter_FYV.navigation = navigation
        presenter_FYV._view = view
        presenter_FYV._router = route
        presenter_FYV._interactor = interactor_FYV
        interactor_FYV._presenter = presenter_FYV
        
        return view
    }
}

//MARK: - SSVIPER_PresenterToRouter
extension YoungView_Route: SSVIPER_PresenterToRouter {
    func goToNextView(navigation: UINavigationController, url: String) {
        navigation.pushViewController(FFNView_Route.createView(url: url), animated: true)
    }
    
    func showSpinner(navigation: UINavigationController) {
        navigation.showSpinner()
    }
    
    func hideSpinner(navigation: UINavigationController) {
        navigation.hideSpinner()
    }
    
    func goToErrorView(navigation: UINavigationController, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: { _ in
            navigation.popViewController(animated: true)
        }))
        
        navigation.present(alert, animated: true)
    }
}
