//
//  MyCommunitiesWireFrame.swift
//  EncuentroCatolicoChurch
//
//  Created by Jorge Garcia on 02/08/21.
//

import Foundation
import UIKit

class MyCommunitiesWireFrame: MyCommunitiesWireFrameProtocol {
    static func presentMyCommunitiesModule(fromView vc: AnyObject) {
        // Generating module components
        let storyboard = UIStoryboard(name: "MyCommunitiesStoryboard", bundle: Bundle(for: MyCommunitiesViewController.self))
        let view: MyCommunitiesViewProtocol = storyboard.instantiateViewController(withIdentifier: "MyCommunitiesStoryboard") as! MyCommunitiesViewController
        let presenter: MyCommunitiesPresenterProtocol & MyCommunitiesInteractorOutputProtocol = MyCommunitiesPresenter()
        let interactor: MyCommunitiesInteractorInputProtocol = MyCommunitiesInteractor()
        let wireFrame: MyCommunitiesWireFrameProtocol = MyCommunitiesWireFrame()

        // Connecting
        view.presenter = presenter
        presenter.view = view
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        if let vc = vc as? UIViewController{
            vc.navigationController?.pushViewController(view as! UIViewController, animated: true)
        }
    }
    
    
}
