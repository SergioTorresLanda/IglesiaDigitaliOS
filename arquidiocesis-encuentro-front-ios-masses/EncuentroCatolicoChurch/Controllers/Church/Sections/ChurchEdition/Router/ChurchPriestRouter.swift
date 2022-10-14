//
//  ChurchPriestRouter.swift
//  ChurchPriest
//
//  Created by Ulises Atonatiuh González Hernández on 12/02/21.
//

import Foundation
import UIKit

public class ChurchPriestRouter : ChurchPriestWireFrameProtocol {
    
     static func presentModule(with churchId: Int, fromView vc: AnyObject, churchDetail: ChurchDetail)  {
        let storyboard = UIStoryboard(name: "ChurchPriest", bundle: Bundle(for: ChurchPriestViewController.self))
        let view: ChurchPriestViewProtocol = storyboard.instantiateViewController(withIdentifier: "ChurchPriestViewController") as! ChurchPriestViewProtocol
        let presenter: ChurchPriestPresenterProtocol & ChurchPriestInteractorOutputProtocol  = ChurchPriestPresenter()
        let interactor: ChurchPriestInteractorInputProtocol = ChurchPriestInteractor()
        let wireFrame: ChurchPriestWireFrameProtocol = ChurchPriestRouter()

        // Connecting
        view.presenter = presenter
        presenter.view = view
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        (view as? ChurchPriestViewController)?.churchId = churchId
        (view as? ChurchPriestViewController)?.churchDetailFill = churchDetail
        
        if let vc = vc as? UIViewController{
            vc.navigationController?.pushViewController(view as! UIViewController, animated: true)
        }
       
    }
    
    
}
