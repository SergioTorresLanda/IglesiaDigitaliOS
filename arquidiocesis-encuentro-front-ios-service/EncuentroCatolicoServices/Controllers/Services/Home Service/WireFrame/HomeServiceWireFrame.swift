//
//  HomeServiceWireFrame.swift
//  Encuentro 
//
//  Created by Miguel Eduardo Valdez Tellez on 04/21/2021.
//  Copyright © 2021 Linko. All rights reserved.
//

import Foundation
import UIKit

open class HomeServiceWireFrame: HomeServiceWireFrameProtocol {

    static func presentHomeServiceModule(fromView vc:AnyObject) {

        // Generating module components
        let storyboard = UIStoryboard(name: "HomeService", bundle: Bundle.main)
        let view: HomeServiceViewProtocol = storyboard.instantiateViewController(withIdentifier: "HomeService") as! HomeServiceViewProtocol
        let presenter: HomeServicePresenterProtocol & HomeServiceInteractorOutputProtocol = HomeServicePresenter()
        let interactor: HomeServiceInteractorInputProtocol = HomeServiceInteractor()
        let wireFrame: HomeServiceWireFrameProtocol = HomeServiceWireFrame()

        // Connecting
        view.presenter = presenter
        presenter.view = view
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        if let vc = vc as? UIViewController{
            vc.navigationController?.pushViewController(view as! UIViewController, animated: true)
        }
    }
    
    open class func createModule() -> UIViewController {
        let storyboard = UIStoryboard(name: "HomeService", bundle: Bundle(for: HomeServiceViewController.self))
        let view: HomeServiceViewProtocol = storyboard.instantiateViewController(withIdentifier: "HomeServiceViewController") as! HomeServiceViewController
        let presenter: HomeServicePresenterProtocol & HomeServiceInteractorOutputProtocol = HomeServicePresenter()
        let interactor: HomeServiceInteractorInputProtocol = HomeServiceInteractor()
        let wireFrame: HomeServiceWireFrameProtocol = HomeServiceWireFrame()
        
        view.presenter = presenter
        presenter.view = view
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        interactor.presenter = presenter
        return view as! UIViewController
    }
    func pushToHomeServices(navegationController: UINavigationController) {
        let registerModue = HomeServiceWireFrame.createModule()
        navegationController.pushViewController(registerModue, animated: true)
    }
}
