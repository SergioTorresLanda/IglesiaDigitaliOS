//
//  ProfileUserInfoRouter.swift
//  EncuentroCatolicoProfile
//
//  Created Desarrollo on 07/04/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

open class ProfileUserInfoRouter: ProfileUserInfoWireframeProtocol {
    
    weak var viewController: UIViewController?
    
    static public func createModule() -> UIViewController {
        // Change to get view from storyboard if not using progammatic UI
        let view = ProfileUserInfoViewController(nibName: "ProfileUserInfoViewController", bundle: Bundle(for: ProfileUserInfoViewController.self))
        let interactor = ProfileUserInfoInteractor()
        let router = ProfileUserInfoRouter()
        let presenter = ProfileUserInfoPresenter(interface: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        
        return view
    }
}
