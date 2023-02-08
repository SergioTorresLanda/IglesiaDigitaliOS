//
//  OracionesRouter.swift
//  OracionesModulo
//
//  Created by Ulises Atonatiuh González Hernández on 01/03/21.
//

import Foundation
import UIKit

open class OracionesRouter: RouterOracionesProtocol {
    static func presentModule(fromView vc: AnyObject) {
        
    }   
    
    public static func getController() -> UIViewController {
        
        // Generating module components
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle(for: Home_Oraciones.self))
        let view: ViewOracionesProtocol = storyboard.instantiateViewController(withIdentifier: "PrayerViewController") as! Home_Oraciones
        let presenter: PresenterOracionesProtocol & InteractorOutputOracionesProtocolo = OracionesPresenter()
        let interactor: InteractorInputOracionesProtocolo = OracionesInteractor()
        let router: RouterOracionesProtocol = OracionesRouter()

        // Connecting
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        
        return view as! UIViewController
    }

}
