//
//  RouterSOS.swift
//  SOSLinko
//
//  Created by Ulises Atonatiuh González Hernández on 21/03/21.
//

import Foundation
import UIKit

open class RouterSOS: SOSRouterProtocol {
   public static func presentModule() -> UIViewController {
 
        let storyboard = UIStoryboard(name: "Storyboard", bundle: Bundle(for: SOSView.self))
        let view: SOSViewProtocol = storyboard.instantiateViewController(withIdentifier: "SOSView") as! SOSViewProtocol
        let presenter: SOSPresenterProtocol & SOSInterctorOutputProtocol = PresenterSOS()
        let interactor: SOSInterctorInputProtocol = InteractorSOS()
        let router: SOSRouterProtocol = RouterSOS()

        // Connecting
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view as! UIViewController
        
        
    }
    
    
}
