//
//  ChurchDetailWireFrame.swift
//  Encuentro
//
//  Created by Edgar Hernandez Solis on 02/12/2021.
//  Copyright © 2021 Linko. All rights reserved.
//

import Foundation
import UIKit

class ChurchDetailWireFrame: ChurchDetailWireFrameProtocol {
  
    static func presentChurchDetailModule(with id: Int, fromView vc:AnyObject, selector isPrincipal: Int) {

        // Generating module components
        let storyboard = UIStoryboard(name: "ChurchDetail", bundle: Bundle(for: ChurchDetailViewController.self))
        let view: ChurchDetailViewProtocol = storyboard.instantiateViewController(withIdentifier: "ChurchDetailViewController") as! ChurchDetailViewProtocol
        let presenter: ChurchDetailPresenterProtocol & ChurchDetailInteractorOutputProtocol = ChurchDetailPresenter()
        let interactor: ChurchDetailInteractorInputProtocol = ChurchDetailInteractor()
        let wireFrame: ChurchDetailWireFrameProtocol = ChurchDetailWireFrame()

        // Connecting
        view.presenter = presenter
        presenter.view = view
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        (view as? ChurchDetailViewController)?.churchId = id
        (view as? ChurchDetailViewController)?.isPrincipal = isPrincipal
        
        if let vc = vc as? UIViewController{
            vc.navigationController?.pushViewController(view as! UIViewController, animated: true)
        }
        
    }
    
    //MARK: Navigation
    func pushEdition(id: Int, from controller: AnyObject, churchDetail: ChurchDetail) {
        ChurchPriestRouter.presentModule(with: id, fromView: controller, churchDetail: churchDetail)
    }
    func presentMyChurchesModule(fromView vc: AnyObject) {
        MyChurchesWireFrame.presentMyChurchesModule(fromView: vc)
    }
    
}
