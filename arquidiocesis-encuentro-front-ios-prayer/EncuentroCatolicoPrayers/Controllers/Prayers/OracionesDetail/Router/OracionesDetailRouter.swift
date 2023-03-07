//
//  OracionesDetailRouter.swift
//  OracionesModulo
//
//  Created by Ulises Atonatiuh González Hernández on 02/03/21.
//

import Foundation
import UIKit
open class OracionesDetailRouter: RouterOracionesDetailProtocol {
   public static func getDetailView( id: Int) -> UIViewController {
        // Generating module components
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle(for: Oraciones_Oracion.self))
        let view: ViewOracionesDetailProtocol = storyboard.instantiateViewController(withIdentifier: "OracionesDetailViewController") as! Oraciones_Oracion
        
        
        let presenter: PresenterOracionesDetailProtocol & InteractorOutputOracionesDetailProtocolo = OracionesDetailPresenter()
        let interactor: InteractorInputOracionesDetailProtocolo = OrcionesDetailInteractor()
        let router: RouterOracionesDetailProtocol = OracionesDetailRouter()

        // Connecting
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        (view as? Oraciones_Oracion)?.id = id
        
       
        // vc.navigationController?.pushViewController(view as! UIViewController, animated: true)
        return view as! UIViewController
       // vc.navigationController?.pushViewController(view as! UIViewController, animated: true)
    }
    
    
}
