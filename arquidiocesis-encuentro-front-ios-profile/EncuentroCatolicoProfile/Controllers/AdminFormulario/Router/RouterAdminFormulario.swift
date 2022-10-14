//
//  RouterAdminFormulario.swift
//  EncuentroCatolicoProfile
//
//  Created by Ulises Atonatiuh González Hernández on 06/05/21.
//

import Foundation
import UIKit

class RouterAdminFormulario: ProtocolosAdminFormularioRouter {
    func pushToModules(id: Int?, name: String, comesFromList: Int, locationId: Int, isAdmin: Bool?, isSuperAdmin: Bool?, from contoller: AnyObject) {
        RouterAdminModules.getController(id: id, name: name, comesFromList: comesFromList, locationId: locationId, isAdmin: isAdmin, isSuperAdmin: isSuperAdmin, from: contoller)
    }
    
    static func getController(id: Int, name: String, locationId: Int, isAdmin: Bool, isSuperAdmin: Bool, from contoller: AnyObject) {
//        let storyboard = UIStoryboard(name: "Storyboard", bundle: Bundle(for: FormularioConfig.self))
//        let view: ProtocolosAdminFormularioView = storyboard.instantiateViewController(withIdentifier: "SOSServicesView") as! ProtocolosAdminFormularioView
        
        let view = FormularioConfig(nibName: "FormularioConfig", bundle: Bundle.local)
        let presenter: ProtocolosAdminFormularioPresenter & ProtocolosAdminFormularioInteractorOutput = PresenterAdminFormulario()
        let interactor: ProtocolosAdminFormularioInteractorInput = InteractorAdminFormulario()
        let router: ProtocolosAdminFormularioRouter = RouterAdminFormulario()

        // Connecting
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        view.userId = id
        view.name = name
        view.locationId = locationId
        view.isSuperAdmin = isSuperAdmin
        if let vc = contoller as? UIViewController{
            vc.navigationController?.pushViewController(view as UIViewController, animated: true)
        }
        
    }
    
    
}
