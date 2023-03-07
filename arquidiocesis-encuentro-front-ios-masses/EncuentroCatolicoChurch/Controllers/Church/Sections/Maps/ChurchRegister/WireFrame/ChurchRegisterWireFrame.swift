//
//  ChurchRegisterWireFrame.swift
//  encuentro
//
//  Created by Edgar Hernandez Solis on 10/03/2020.
//  Copyright © 2020 Linko. All rights reserved.
//

import Foundation
import UIKit

open class ChurchRegisterWireFrame: ChurchRegisterWireFrameProtocol {
    public static func presentChurchRegisterModuleCommunity(selector: Int, from contoller: AnyObject, isPricipalBool: Bool) {
        // Generating module components
        let storyboard = UIStoryboard(name: "ChurchRegister", bundle: Bundle(for: MiIglesia_MapaIglesias.self))
        let view: ChurchRegisterViewProtocol = storyboard.instantiateViewController(withIdentifier: "ChurchRegisterViewController") as! ChurchRegisterViewProtocol
        let presenter: ChurchRegisterPresenterProtocol & ChurchRegisterInteractorOutputProtocol = ChurchRegisterPresenter()
        let interactor: ChurchRegisterInteractorInputProtocol = ChurchRegisterInteractor()
        let wireFrame: ChurchRegisterWireFrameProtocol = ChurchRegisterWireFrame()
        
        // Connecting
        view.presenter = presenter
        presenter.view = view
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        interactor.presenter = presenter
        (view as? MiIglesia_MapaIglesias)?.isPrincpalBool = isPricipalBool
        (view as? MiIglesia_MapaIglesias)?.isPrincipal = selector
        if let vc = contoller as? UIViewController{
            vc.navigationController?.pushViewController(view as! UIViewController, animated: true)
        }
    }
    
    
    func pushCommunityDetail(id: Int, from contoller: AnyObject, myChourch: Bool, isPricipalBool: Bool) {
        CommunitiesMainViewWireFrame.presentCommunitiesMainVieModule(fromView: contoller, myChourch: myChourch, id: id, isEditProfile: true, isFavorite: false, isPrincipal: isPricipalBool)
    }
    
    func pushChurchDetailMap(id: Int, from contoller: AnyObject, selector: Int) {
        ChurchDetailWireFrame.presentChurchDetailModule(with: id, fromView: contoller, selector: selector)
    }
    
    public static func presentChurchRegisterModule(selector isPrincipal: Int, from vc:AnyObject) {
        // Generating module components
        let storyboard = UIStoryboard(name: "ChurchRegister", bundle: Bundle(for: MiIglesia_MapaIglesias.self))
        let view: ChurchRegisterViewProtocol = storyboard.instantiateViewController(withIdentifier: "ChurchRegisterViewController") as! ChurchRegisterViewProtocol
        let presenter: ChurchRegisterPresenterProtocol & ChurchRegisterInteractorOutputProtocol = ChurchRegisterPresenter()
        let interactor: ChurchRegisterInteractorInputProtocol = ChurchRegisterInteractor()
        let wireFrame: ChurchRegisterWireFrameProtocol = ChurchRegisterWireFrame()
        // Connecting
        view.presenter = presenter
        presenter.view = view
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        interactor.presenter = presenter
        (view as? MiIglesia_MapaIglesias)?.isPrincipal = isPrincipal
        if let vc = vc as? UIViewController{
            vc.navigationController?.pushViewController(view as! UIViewController, animated: true)
        }
    }
    
    open class ServicesRouter: UINavigationController {
        public static func createModule(navigation: UINavigationController) -> UIViewController {
            let storyBoard = UIStoryboard(name: "ChurchRegister", bundle: Bundle(for: MiIglesia_MapaIglesias.self))
            let controller = storyBoard.instantiateViewController(withIdentifier: "ChurchRegisterViewController")
            return controller
        }
    }
}
