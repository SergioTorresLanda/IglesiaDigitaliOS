//
//  RouterAdminList.swift
//  EncuentroCatolicoProfile
//
//  Created by Ulises Atonatiuh González Hernández on 06/05/21.
//

import Foundation
import UIKit


class RouterAdminList: ProtocolosAdminListRouter {
    func pushFormularyController(id: Int, name: String, locationId: Int, isAdmin: Bool, isSuperAdmin: Bool, from contoller: AnyObject) {
        RouterAdminFormulario.getController(id: id, name: name, locationId: locationId, isAdmin: isAdmin, isSuperAdmin: isSuperAdmin, from: contoller)
    }
    
    static func getController(locationId: Int, from contoller: AnyObject) {
//        let storyboard = UIStoryboard(name: "Storyboard", bundle: Bundle(for: AdminListView.self))
//        let view: ProtocolosAdminListView = storyboard.instantiateViewController(withIdentifier: "SOSServicesView") as! ProtocolosAdminListView
        let view = AdminListView(nibName: "AdminListView", bundle: Bundle.local)
        let presenter: ProtocolosAdminListPresenter & ProtocolosAdminListInteractorOutput = PresenterAdminList()
        let interactor: ProtocolosAdminListInteractorInput = InteractorAdminList()
        let router: ProtocolosAdminListRouter = RouterAdminList()

        // Connecting
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        view.locationId = locationId
        
        if let vc = contoller as? UIViewController{
            vc.navigationController?.pushViewController(view as UIViewController, animated: true)
        }
    }
    
    
}
