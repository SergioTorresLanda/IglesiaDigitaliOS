//
//  MyChurchesWireFrame.swift
//  santander-kids
//
//  Created by Edgar Hernandez Solis on 10/03/2020.
//  Copyright © 2020 Linko. All rights reserved.
//

import Foundation
import UIKit

public class MyChurchesWireFrame: MyChurchesWireFrameProtocol {
    
    public static func getController() -> UIViewController {
        
       
        // Generating module components
        let storyboard = UIStoryboard(name: "MyChurches", bundle: Bundle(for: MyChurchesViewController.self))
        let view: MyChurchesViewProtocol = storyboard.instantiateViewController(withIdentifier: "MyChurchesViewController") as! MyChurchesViewProtocol
        let presenter: MyChurchesPresenterProtocol & MyChurchesInteractorOutputProtocol = MyChurchesPresenter()
        let interactor: MyChurchesInteractorInputProtocol = MyChurchesInteractor()
        let wireFrame: MyChurchesWireFrameProtocol = MyChurchesWireFrame()

        // Connecting
        view.presenter = presenter
        presenter.view = view
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view as! UIViewController
    }

    public static func presentMyChurchesModule(fromView vc:AnyObject) {

        // Generating module components
        let storyboard = UIStoryboard(name: "MyChurches", bundle: Bundle(for: MyChurchesViewController.self))
        let view: MyChurchesViewProtocol = storyboard.instantiateViewController(withIdentifier: "MyChurchesViewController") as! MyChurchesViewProtocol
        let presenter: MyChurchesPresenterProtocol & MyChurchesInteractorOutputProtocol = MyChurchesPresenter()
        let interactor: MyChurchesInteractorInputProtocol = MyChurchesInteractor()
        let wireFrame: MyChurchesWireFrameProtocol = MyChurchesWireFrame()

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
    
    //MARK: - Navigation
    func pushChurchDetail(id: Int, from contoller: AnyObject) {
        ChurchDetailWireFrame.presentChurchDetailModule(with: id, fromView: contoller)
    }
}
