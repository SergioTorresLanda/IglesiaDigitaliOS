//
//  CommunitiesMainViewWireFrame.swift
//  EncuentroCatolicoChurch
//
//  Created by Jorge Garcia on 09/08/21.
//

import Foundation
import UIKit
import EncuentroCatolicoProfile

public class CommunitiesMainViewWireFrame: CommunitiesMainViewWireFrameProtocol {
    
    func presentProfile(formView: AnyObject) {
        AdminRouter.getController(from: formView)
    }
    
    func presetnAddCommunities(formView: AnyObject) {
        AddCommunitiesWireFrame.presentAddCommunitiesModule(fromView: formView)
    }
    
    public static func getController() -> UIViewController {
        let storyboard = UIStoryboard(name: "CommunitiesMainStoryboard", bundle: Bundle(for: CommunitiesMainViewController.self))
        let view: CommunitiesMainViewProtocol = storyboard.instantiateViewController(withIdentifier: "CommunitiesMainViewController") as! CommunitiesMainViewController
        let presenter: CommunitiesMainViewPresenterProtocol & CommunitiesMainViewInteractorOutputProtocol = CommunitiesMainViewPresenter()
        let interactor: CommunitiesMainViewInteractorInputProtocol = CommunitiesMainViewInteractor()
        let wireFrame: CommunitiesMainViewWireFrameProtocol = CommunitiesMainViewWireFrame()

        // Connecting
        view.presenter = presenter
        presenter.view = view
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view as! UIViewController
    }
    
    public static func presentCommunitiesMainVieModule(fromView vc: AnyObject, myChourch: Bool, id: Int, isEditProfile: Bool, isFavorite: Bool, isPrincipal: Bool) {
        // Generating module components
        let storyboard = UIStoryboard(name: "CommunitiesMainStoryboard", bundle: Bundle(for: CommunitiesMainViewController.self))
        let view: CommunitiesMainViewProtocol = storyboard.instantiateViewController(withIdentifier: "CommunitiesMainViewController") as! CommunitiesMainViewController
        let presenter: CommunitiesMainViewPresenterProtocol & CommunitiesMainViewInteractorOutputProtocol = CommunitiesMainViewPresenter()
        let interactor: CommunitiesMainViewInteractorInputProtocol = CommunitiesMainViewInteractor()
        let wireFrame: CommunitiesMainViewWireFrameProtocol = CommunitiesMainViewWireFrame()

        // Connecting
        view.presenter = presenter
        presenter.view = view
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        (view as? CommunitiesMainViewController)?.comesFromMyChourch = myChourch
        (view as? CommunitiesMainViewController)?.id = id
        (view as? CommunitiesMainViewController)?.isEditProfile = isEditProfile
        (view as? CommunitiesMainViewController)?.isFavorite = isFavorite
        (view as? CommunitiesMainViewController)?.isPrincipal = isPrincipal
        
        if let vc = vc as? UIViewController{
            vc.navigationController?.pushViewController(view as! UIViewController, animated: true)
        }
    }
    
    public static func getControllerFormHome(id: Int) -> UIViewController {
       
        let storyboard = UIStoryboard(name: "CommunitiesMainStoryboard", bundle: Bundle(for: CommunitiesMainViewController.self))
        let view: CommunitiesMainViewProtocol = storyboard.instantiateViewController(withIdentifier: "CommunitiesMainViewController") as! CommunitiesMainViewController
        let presenter: CommunitiesMainViewPresenterProtocol & CommunitiesMainViewInteractorOutputProtocol = CommunitiesMainViewPresenter()
        let interactor: CommunitiesMainViewInteractorInputProtocol = CommunitiesMainViewInteractor()
        let wireFrame: CommunitiesMainViewWireFrameProtocol = CommunitiesMainViewWireFrame()

        // Connecting
        view.presenter = presenter
        presenter.view = view
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        (view as? CommunitiesMainViewController)?.id = id
        
        return view as! UIViewController
    }
    
}
