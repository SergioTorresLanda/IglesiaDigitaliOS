//
//  CommunitiesWireFrame.swift
//  EncuentroCatolicoChurch
//
//  Created by Jorge Garcia on 27/07/21.
//

import Foundation
import UIKit

class CommunitiesFormularyWireFrame: CommunitiesFormularyWireFrameProtocol {
    static func presentCommunitiesFormularyModule(fromView vc: AnyObject) {
        // Generating module components
        let storyboard = UIStoryboard(name: "CommunitiesFormularyStoryboard", bundle: Bundle(for: CommunitiesFormularyViewController.self))
        let view: CommunitiesFormularyViewProtocol = storyboard.instantiateViewController(withIdentifier: "CommunitiesFormularyViewController") as! CommunitiesFormularyViewController
        let presenter: CommunitiesFormularyPresenterProtocol & CommunitiesFormularyInteractorOutputProtocol = CommunitiesFormularyPresenter()
        let interactor: CommunitiesFormularyInteractorInputProtocol = CommunitiesFormularyInteractor()
        let wireFrame: CommunitiesFormularyWireFrameProtocol = CommunitiesFormularyWireFrame()

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
