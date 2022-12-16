//
//  ECDonationToMyChurchPresenter.swift
//  EncuentroCatolicoDonations
//
//  Created by llavin on 25/11/22.
//

import UIKit

class ECDonationToMyChurchPresenter: ECDonationToMyChurchPresenterProtocol {

    weak private var view: ECDonationToMyChurchVCProtocol?
    var interactor: ECDonationToMyChurchInteractorProtocol?
    private let router: ECDonationToMyChurchWireframeProtocol

    init(
        interface: ECDonationToMyChurchVCProtocol,
        interactor: ECDonationToMyChurchInteractorProtocol?,
        router: ECDonationToMyChurchWireframeProtocol)
    {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }
    
    

}

