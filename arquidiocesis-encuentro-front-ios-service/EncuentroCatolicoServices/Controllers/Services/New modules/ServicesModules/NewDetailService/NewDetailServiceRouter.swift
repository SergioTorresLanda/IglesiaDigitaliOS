//
//  NewDetailServiceRouter.swift
//  EncuentroCatolicoServices
//
//  Created by Pablo Luis Velazquez Zamudio on 27/07/21.
//

import Foundation
import UIKit

open class NewDetailServiceRoutrer: NewDetailServiceRouterProtocol {
    
    weak var viewController: UIViewController?
    
    static public func createModule(nameService: String, typeV: String, idService: Int) -> UIViewController {
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle(for: NewDetailServiceView.self))
        let view: NewDetailServiceView = storyboard.instantiateViewController(withIdentifier: "NewDetailServiceView") as! NewDetailServiceView
        let interactor = NewDetailServiceInteractor()
        let router = NewDetailServiceRoutrer()
        let presenter = NewDetailServicePresnter(interface: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        view.nameService = nameService
        view.typeView = typeV
        view.idService = idService
        interactor.presenter = presenter
        router.viewController = view
        
        return view
        
    }
}


