//
//  ProfileMapWireFrame.swift
//  encuentro
//
//  Created by Edgar Hernandez Solis on 10/03/2020.
//  Copyright © 2020 Linko. All rights reserved.
//

import Foundation
import UIKit

open class ProfileMapWireFrame: ProfileMapWireFrameProtocol {
    weak var viewController: UIViewController?
    
    static public func presentProfileMapModule(selector: Int, from contoller: AnyObject, mapType: String) {
        // Generating module components
        let storyboard = UIStoryboard(name: "ProfileMap", bundle: Bundle(for: Perfil_Mapa.self))
        let view: ProfileMapViewProtocol = storyboard.instantiateViewController(withIdentifier: "ProfileMapViewController") as! ProfileMapViewProtocol
        let presenter: ProfileMapPresenterProtocol & ProfileMapInteractorOutputProtocol = ProfileMapPresenter()
        let interactor: ProfileMapInteractorInputProtocol = ProfileMapInteractor()
        let wireFrame: ProfileMapWireFrameProtocol = ProfileMapWireFrame()
        
        // Connecting
        view.presenter = presenter
        presenter.view = view
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        interactor.presenter = presenter
        (view as? Perfil_Mapa)?.isPrincipal = selector
        if let vc = contoller as? UIViewController{
            vc.navigationController?.pushViewController(view as! UIViewController, animated: true)
        }
    }
    
    func pushChurchDetailMap(id: Int, from contoller: AnyObject, selector: Int) {
        contoller.dismiss(animated: true, completion: nil)
        
    }
        
    static public func createModuleMap(mapType: String) -> UIViewController {
        
        let storyboard = UIStoryboard(name: "ProfileMap", bundle: Bundle(for: Perfil_Mapa.self))
        let view: Perfil_Mapa = storyboard.instantiateViewController(withIdentifier: "ProfileMapViewController") as! Perfil_Mapa
        let interactor: ProfileMapInteractorInputProtocol = ProfileMapInteractor()
        let router = ProfileMapWireFrame()
        let presenter : ProfileMapPresenterProtocol & ProfileMapInteractorOutputProtocol = ProfileMapPresenter()
        
        view.presenter = presenter
        view.mapType = mapType
        interactor.presenter = presenter
        presenter.interactor = interactor
        presenter.wireFrame = router
        presenter.view = view
        router.viewController = view
        
        return view
        
    }
    
}

public func presentProfileMapModule(selector isPrincipal: Int, from vc:AnyObject, mapType: String) {
    
    // Generating module components
    let storyboard = UIStoryboard(name: "ProfileMap", bundle: Bundle(for: Perfil_Mapa.self))
    let view: ProfileMapViewProtocol = storyboard.instantiateViewController(withIdentifier: "ProfileMapViewController") as! ProfileMapViewProtocol
    let presenter: ProfileMapPresenterProtocol & ProfileMapInteractorOutputProtocol = ProfileMapPresenter()
    let interactor: ProfileMapInteractorInputProtocol = ProfileMapInteractor()
    let wireFrame: ProfileMapWireFrameProtocol = ProfileMapWireFrame()
    
    // Connecting
    view.presenter = presenter
    presenter.view = view
    presenter.wireFrame = wireFrame
    presenter.interactor = interactor
    interactor.presenter = presenter
    (view as? Perfil_Mapa)?.isPrincipal = isPrincipal
    if let vc = vc as? UIViewController{
        vc.navigationController?.pushViewController(view as! UIViewController, animated: true)
    }
}
open class ServicesRouter: UINavigationController {
    public static func createModule(navigation: UINavigationController) -> UIViewController {
        let storyBoard = UIStoryboard(name: "ProfileMap", bundle: Bundle(for: Perfil_Mapa.self))
        let controller = storyBoard.instantiateViewController(withIdentifier: "ProfileMapViewController")
        return controller
    }
}
