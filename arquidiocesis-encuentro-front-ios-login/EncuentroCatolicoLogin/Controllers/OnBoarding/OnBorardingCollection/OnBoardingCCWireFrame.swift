//
//  OnBoardingCCWireFrame.swift
//  EncuentroCatolicoLogin
//
//  Created by Pablo Luis Velazquez Zamudio on 03/06/21.
//

import Foundation
import UIKit
import EncuentroCatolicoHome

open class OnBoardingCCWireFrame: OnBoardingCCWireFrameProtocol {

    open class func createModule() -> UIViewController {
        let storyboard = UIStoryboard(name: "OnBoarding", bundle: Bundle(for: OnBoardingCC.self))
        let view: OnBoardingCCProtocol = storyboard.instantiateViewController(withIdentifier: "MainView") as! OnBoardingCC
       // let view = navController
        let presenter: OnBoardingCCPresenterProtocol & OnBoardingCCInteractorOutputProtocol = OnBoardingCCPresenter()
        let interactor: OnBoardingCCInteractorInputProtocol & OnBoardingCCRemoteDataManagerOutputProtocol = OnBoardingCCInteractor()
        let remoteDataManager: OnBoardingCCRemoteDataManagerInputProtocol = OnBoardingCCRemoteDataManager()
        let wireFrame: OnBoardingCCWireFrameProtocol = OnBoardingCCWireFrame()
        
        view.presenter = presenter
        presenter.view = view
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.remoteDatamanager = remoteDataManager
        remoteDataManager.remoteRequestHandler = interactor
        
        return view as! UIViewController
    }
    
    public static func presentOnBoardingModule(fromView vc:AnyObject) {

        // Generating module components
        let storyboard = UIStoryboard(name: "OnBoarding", bundle: Bundle(for: OnBoardingCC.self))
        let view: OnBoardingCCProtocol = storyboard.instantiateViewController(withIdentifier: "MainView") as! OnBoardingCC
        let presenter: OnBoardingCCPresenterProtocol & OnBoardingCCInteractorOutputProtocol = OnBoardingCCPresenter()
        let interactor: OnBoardingCCInteractorInputProtocol = OnBoardingCCInteractor()
        let wireFrame: OnBoardingCCWireFrameProtocol = OnBoardingCCWireFrame()

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
    
    func omitir(controller: UIViewController) {
       // De esta fomra no se ejecuta el custom tab bar
       /* let v = HomeRouter.createModule()
        controller.navigationController?.pushViewController(v, animated: true) */
        
        // Solo de esta manera se ejecuta el custom tab bar
        let view = SocialNetworkController(nibName: "SocialNetworkController", bundle: Bundle(for: SocialNetworkController.self))
        controller.navigationController?.pushViewController(view, animated: true) 
        
    }
    
    func fin(controller: UIViewController) {
        let view = SocialNetworkController(nibName: "SocialNetworkController", bundle: Bundle(for: SocialNetworkController.self))
        controller.navigationController?.pushViewController(view, animated: true)
    }
    
}
