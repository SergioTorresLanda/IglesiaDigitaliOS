//
//  ImagePresenterRouter.swift
//  zeus-ios-sdk-new-social-network
//
//  Created Miguel Angel Vicario Flores on 17/09/20.
//  Copyright © 2020 Gabriel Briseño. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

public class ImagePresenterRouter: NSObject, ImagePresenterWireframeProtocol {

    weak var viewController: UIViewController?
    
    static func createModule() -> UIViewController {
        // Change to get view from storyboard if not using progammatic UI
        let view = ImagePresenterViewController(nibName: "ImagePresenterViewController", bundle: Bundle(for: ImagePresenterViewController.self))
        let interactor = ImagePresenterInteractor()
        let router = ImagePresenterRouter()
        let presenter = ImagePresenterPresenter(interface: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        
        return view
    }
}
