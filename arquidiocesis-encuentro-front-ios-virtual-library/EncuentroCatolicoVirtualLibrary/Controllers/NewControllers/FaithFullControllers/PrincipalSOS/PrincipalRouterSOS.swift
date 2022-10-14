//
//  PrincipalRouterSOS.swift
//  EncuentroCatolicoVirtualLibrary
//
//  Created by Pablo Luis Velazquez Zamudio on 16/06/21.
//

import UIKit

open class PrincipalRouterSOS: PrincipalRouterProtocol {
    
    weak var viewController: UIViewController?
    
    static public func createModue() -> UIViewController {
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle(for: PrincipalViewSOS.self))
        let view: PrincipalViewSOS = storyboard.instantiateViewController(withIdentifier: "PrincipalViewSOS") as! PrincipalViewSOS
        let interactor = PrincipalInteractorSOS()
        let router = PrincipalRouterSOS()
        let presenter = PrincipalPresenterSOS(interface: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        
        return view
        
    }
    
}
