//
//  ChurchRegisterWireFrame.swift
//  encuentro
//
//  Created by Edgar Hernandez Solis on 10/03/2020.
//  Copyright © 2020 Linko. All rights reserved.
//

import Foundation
import UIKit

class ChurchRegisterWireFrame: ChurchRegisterWireFrameProtocol {

    static func presentChurchRegisterModule(fromView vc:AnyObject) {

        // Generating module components
        let storyboard = UIStoryboard(name: "", bundle: Bundle.main)
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
        
        if let vc = vc as? UIViewController{
            vc.navigationController?.pushViewController(view as! UIViewController, animated: true)
        }
        
    }
}
open class ServicesRouter: UINavigationController {
    public static func createModule(navigation: UINavigationController) -> UIViewController {
        let storyBoard = UIStoryboard(name: "ChurchRegister", bundle: Bundle(for: ChurchRegisterViewController.self))
        let controller = storyBoard.instantiateViewController(withIdentifier: "map")
        return controller
    }
}
