//
//  RouterAdminModules.swift
//  EncuentroCatolicoProfile
//
//  Created by Ulises Atonatiuh González Hernández on 06/05/21.
//

import Foundation
import UIKit
class RouterAdminModules: ProtocolosAdminModulesRouter {
    static func getController(id: Int?, name: String, comesFromList: Int, locationId: Int, isAdmin: Bool?, isSuperAdmin: Bool?, from contoller: AnyObject) {
//        let storyboard = UIStoryboard(name: "Storyboard", bundle: Bundle(for: AdminModulesView.self))
//        let view: ProtocolosAdminModulesView = storyboard.instantiateViewController(withIdentifier: "SOSServicesView") as! ProtocolosAdminModulesView
        
        let view = AdminModulesView(nibName: "AdminModulesView", bundle: Bundle.local)
        let presenter: ProtocolosAdminModulesPresenter & ProtocolosAdminModulesInteractorOutput = PresenterAdminModules()
        let interactor: ProtocolosAdminModulesInteractorInput = InteractorAdminModules()
        let router: ProtocolosAdminModulesRouter = RouterAdminModules()

        // Connecting
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        view.userId = id ?? 1
        view.name = name
        view.comesFromList = comesFromList
        view.locationId = locationId
        view.isSuperAdmin = isSuperAdmin ?? false
        if let vc = contoller as? UIViewController{
            vc.navigationController?.pushViewController(view as UIViewController, animated: true)
        }
    }
    
    
}
