//
//  CommunitiesPresenter.swift
//  EncuentroCatolicoChurch
//
//  Created by Jorge Garcia on 27/07/21.
//

import Foundation
class CommunitiesFormularyPresenter: CommunitiesFormularyPresenterProtocol, CommunitiesFormularyInteractorOutputProtocol {
    var view: CommunitiesFormularyViewProtocol?
    
    var interactor: CommunitiesFormularyInteractorInputProtocol?
    
    var wireFrame: CommunitiesFormularyWireFrameProtocol?
    
    
}
