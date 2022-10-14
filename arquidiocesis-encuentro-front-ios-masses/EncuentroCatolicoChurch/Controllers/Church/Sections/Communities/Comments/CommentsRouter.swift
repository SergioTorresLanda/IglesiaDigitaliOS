//
//  CommentsRouter.swift
//  EncuentroCatolicoChurch
//
//  Created by Pablo Luis Velazquez Zamudio on 31/08/21.
//

import Foundation
import UIKit

open class CommentsRouter: CommentsRouterProtocol {
    
    weak var viewContorller: UIViewController?
    
    static public func createModule(param: String, locationID: Int, churchName: String ) -> UIViewController {
        let storyboard = UIStoryboard(name: "CommentsStoryboard", bundle: Bundle.local)
        let view = storyboard.instantiateViewController(withIdentifier: "CMMTS") as! CommentsViewController
        let interactor = CommentsInteractor()
        let router = CommentsRouter()
        let presenter = CommentsPresenter(interface: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewContorller = view
        view.queryParam = param
        view.locationID = locationID
        view.nameChurch = churchName
        
        return view
        
    }
}

