//
//  ECDonationToMyChurchProtocols.swift
//  EncuentroCatolicoDonations
//
//  Created by llavin on 25/11/22.
//

import Foundation

//MARK: Wireframe -
protocol ECDonationToMyChurchWireframeProtocol: class {

}
//MARK: Presenter -
protocol ECDonationToMyChurchPresenterProtocol: class {
    
}

//MARK: Interactor -
protocol ECDonationToMyChurchInteractorProtocol: class {

    var presenter: ECDonationToMyChurchPresenterProtocol?  { get set }
    
    
}

//MARK: View -
protocol ECDonationToMyChurchVCProtocol: class {

  var presenter: ECDonationToMyChurchPresenterProtocol?  { get set }
    
    
}
