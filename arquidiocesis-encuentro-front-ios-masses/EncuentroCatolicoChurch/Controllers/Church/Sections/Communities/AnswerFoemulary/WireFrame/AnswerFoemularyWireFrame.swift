//
//  AnswerFoemularyWireFrame.swift
//  EncuentroCatolicoChurch
//
//  Created by Jorge Garcia on 03/08/21.
//

import Foundation
import UIKit

public class AnswerFoemularyWireFrame: AnswerFoemularyWireFrameProtocol {
    
    public static func presentAnswerFoemularyModule(fromView vc: AnyObject) {
        // Generating module components
        let storyboard = UIStoryboard(name: "AnswerFoemularyStoryboard", bundle: Bundle(for: AnswerFoemularyViewController.self))
        let view: AnswerFoemularyViewProtocol = storyboard.instantiateViewController(withIdentifier: "AnswerFoemularyViewController") as! AnswerFoemularyViewController
        let presenter: AnswerFoemularyPresenterProtocol & AnswerFoemularyInteractorOutputProtocol = AnswerFoemularyPresenter()
        let interactor: AnswerFoemularyInteractorInputProtocol = AnswerFoemularyInteractor()
        let wireFrame: AnswerFoemularyWireFrameProtocol = AnswerFoemularyWireFrame()

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
    
    weak var viewController: UIViewController?
    
    static public func createModule() -> UIViewController {
        
        let storyboard = UIStoryboard(name: "AnswerFoemularyStoryboard", bundle: Bundle(for: AnswerFoemularyViewController.self))
        let view: AnswerFoemularyViewProtocol = storyboard.instantiateViewController(withIdentifier: "AnswerFoemularyViewController") as! AnswerFoemularyViewController
        let presenter: AnswerFoemularyPresenterProtocol & AnswerFoemularyInteractorOutputProtocol = AnswerFoemularyPresenter()
        let interactor: AnswerFoemularyInteractorInputProtocol = AnswerFoemularyInteractor()
        let wireFrame: AnswerFoemularyWireFrameProtocol = AnswerFoemularyWireFrame()

        // Connecting
        view.presenter = presenter
        presenter.view = view
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view as! UIViewController
        
    }
    
}
