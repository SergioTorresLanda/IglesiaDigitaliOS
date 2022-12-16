//
//  ECDonationToMyChurchRouter.swift
//  EncuentroCatolicoDonations
//
//  Created by llavin on 25/11/22.
//

import UIKit

class ECDonationToMyChurchRouter: ECDonationToMyChurchWireframeProtocol {
    
    weak var viewController: UIViewController?
    
    static func createModule() -> UIViewController {
        // Change to get view from storyboard if not using progammatic UI
        let view = ECDonationToMyChurchVC(nibName: "ECDonationToMyChurchVC", bundle: Bundle.init(identifier: "mx.arquidiocesis.EncuentroCatolicoServices"))
        let interactor = ECDonationToMyChurchInteractor()
        let router = ECDonationToMyChurchRouter()
        let presenter = ECDonationToMyChurchPresenter(interface: view, interactor: interactor, router: router)
        
        
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        
        return view
    }
}
