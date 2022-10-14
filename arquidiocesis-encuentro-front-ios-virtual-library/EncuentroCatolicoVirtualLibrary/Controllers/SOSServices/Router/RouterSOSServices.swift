//
//  RouterSOSServices.swift
//  SOSLinko
//
//  Created by Ulises Atonatiuh González Hernández on 21/03/21.
//

import Foundation
import UIKit
open class RouterSOSServices: SOSRouterServiciosProtocol {
    
    public static func presentModule() -> UIViewController {
        let storyboard = UIStoryboard(name: "Storyboard", bundle: Bundle(for: SOSServicesView.self))
        let view: SOSViewServiciosProtocol = storyboard.instantiateViewController(withIdentifier: "SOSServicesView") as! SOSViewServiciosProtocol
        let presenter: SOSPresenterServiciosProtocol & SOSInterctorOutputServiciosProtocol = PresenterSOSServices()
        let interactor: SOSInterctorInputServiciosProtocol = InteractorSOSServices()
        let router: SOSRouterServiciosProtocol = RouterSOSServices()

        // Connecting
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view as! UIViewController
    }
    
   

}
