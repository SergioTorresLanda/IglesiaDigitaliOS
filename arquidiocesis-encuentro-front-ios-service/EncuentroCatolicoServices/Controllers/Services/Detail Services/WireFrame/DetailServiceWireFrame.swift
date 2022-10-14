//
//  DetailServiceWireFrame.swift
//  Encuentro 
//
//  Created by Miguel Eduardo Valdez Tellez on 04/21/2021.
//  Copyright © 2021 Linko. All rights reserved.
//

import Foundation
import UIKit
import EncuentroCatolicoProfile

open class DetailServiceWireFrame: DetailServiceWireFrameProtocol {
    
    func pushToMap(fromView vc: AnyObject, isPrincipal: Int, mapType: String) {
        ProfileMapWireFrame.presentProfileMapModule(selector: isPrincipal, from: vc, mapType: mapType)
    }
    
    static func presentDetailServiceModule(fromView vc:AnyObject, blessType: Int) {

        // Generating module components
        let storyboard = UIStoryboard(name: "DetailService", bundle: Bundle.main)
        let view: DetailServiceViewProtocol = storyboard.instantiateViewController(withIdentifier: "DetailService") as! DetailServiceViewProtocol
        let presenter: DetailServicePresenterProtocol & DetailServiceInteractorOutputProtocol = DetailServicePresenter()
        let interactor: DetailServiceInteractorInputProtocol = DetailServiceInteractor()
        let wireFrame: DetailServiceWireFrameProtocol = DetailServiceWireFrame()

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
        let storyboard = UIStoryboard(name: "DetailService", bundle: Bundle(for: DetailServiceViewController.self))
        let view: DetailServiceViewProtocol = storyboard.instantiateViewController(withIdentifier: "DetailService") as! DetailServiceViewProtocol
        let presenter: DetailServicePresenterProtocol & DetailServiceInteractorOutputProtocol = DetailServicePresenter()
        let interactor: DetailServiceInteractorInputProtocol = DetailServiceInteractor()
        let wireFrame: DetailServiceWireFrameProtocol = DetailServiceWireFrame()
        
        view.presenter = presenter
        presenter.view = view
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        interactor.presenter = presenter
        return view as! UIViewController
    }
    
    func pushToDeatailServices(navegationController: UINavigationController) {
        let registerModue = DetailServiceWireFrame.createModule()
        navegationController.pushViewController(registerModue, animated: true)
    }
}
