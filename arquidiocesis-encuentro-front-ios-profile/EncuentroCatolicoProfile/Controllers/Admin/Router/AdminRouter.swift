//
//  ColaboradoresRouter.swift
//  EncuentroCatolicoProfile
//
//  Created by Ulises Atonatiuh González Hernández on 05/05/21.
//

import Foundation
import UIKit

public class AdminRouter: ProtocolosAdminRouter {

    func pushToModules(id: Int?, name: String, comesFromList: Int, locationId: Int, isAdmin: Bool?, isSuperAdmin: Bool?, from contoller: AnyObject) {
        RouterAdminModules.getController(id: id, name: name, comesFromList: comesFromList, locationId: locationId, isAdmin: isAdmin, isSuperAdmin: isSuperAdmin, from: contoller)
    }
    
    func pushToAdminList(locationId: Int, from contoller: AnyObject) {
        RouterAdminList.getController(locationId: locationId, from: contoller)
    }
    

  public  static func getController(from vc: AnyObject) {
//        let storyboard = UIStoryboard(name: "Storyboard", bundle: Bundle(for: MainConfigView.self))
        let view = MainConfigView(nibName: "MainConfigView", bundle: Bundle.local)
//        let view: ProtocolosAdminView = storyboard.instantiateViewController(withIdentifier: "SOSServicesView") as! ProtocolosAdminView
        let presenter: ProtocolosAdminPresenter & ProtocolosAdminInteractorOutput = AdminPresenter()
        let interactor: ProtocolosAdminInteractorInput = AdminInteractor()
        let router: ProtocolosAdminRouter = AdminRouter()

        // Connecting
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        if let vc = vc as? UIViewController{
            vc.navigationController?.pushViewController(view as UIViewController, animated: true)
        }
        
        
        
    }
    
    public static func newGetController(form vc: AnyObject){
//        let storyboard = UIStoryboard(name: "Storyboard", bundle: Bundle(for: MainConfigView.self))
        let view = MainConfigView(nibName: "MainConfigView", bundle: Bundle.local) 
//        let view: ProtocolosAdminView = storyboard.instantiateViewController(withIdentifier: "SOSServicesView") as! ProtocolosAdminView
        let presenter: ProtocolosAdminPresenter & ProtocolosAdminInteractorOutput = AdminPresenter()
        let interactor: ProtocolosAdminInteractorInput = AdminInteractor()
        let router: ProtocolosAdminRouter = AdminRouter()

        // Connecting
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        
         let vc = vc as? UIViewController
         vc?.navigationController?.pushViewController(view, animated: true)
        
    }
    
}
