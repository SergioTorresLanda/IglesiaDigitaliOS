//
//  ChurchRegisterWireFrame.swift
//  encuentro
//
//  Created by Edgar Hernandez Solis on 10/03/2020.
//  Copyright © 2020 Linko. All rights reserved.
//

import Foundation
import UIKit
//import EncuentroCatolicoChurch
open class ChurchRegisterWireFrame: ChurchRegisterWireFrameProtocol {
    func pushChurchDetailMap(id: Int, from contoller: AnyObject) {
      //  #warning("Mandar a llamar a wireFrame de detalle de iglesia aqui")
        //ChurchDetailWireFrame.presentChurchDetailModule(with: id, fromView: contoller)
    }
    

    public static func presentChurchRegisterModule(selector: Int) -> UIViewController {

        // Generating module components
        let storyboard = UIStoryboard(name: "ChurchRegister", bundle: Bundle(for: ChurchRegisterViewController.self))
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
        
    return view as! UIViewController
    }
}
open class ServicesRouter: UINavigationController {
    public static func createModule(navigation: UINavigationController) -> UIViewController {
        let storyBoard = UIStoryboard(name: "ChurchRegister", bundle: Bundle(for: ChurchRegisterViewController.self))
        let controller = storyBoard.instantiateViewController(withIdentifier: "ChurchRegisterViewController")
        return controller
    }
}
