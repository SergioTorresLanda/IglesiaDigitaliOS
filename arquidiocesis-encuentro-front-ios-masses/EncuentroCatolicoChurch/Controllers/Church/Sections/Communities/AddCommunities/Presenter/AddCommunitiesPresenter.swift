//
//  AddCommunitiesPresenter.swift
//  EncuentroCatolicoChurch
//
//  Created by Jorge Garcia on 02/08/21.
//

import Foundation

class AddCommunitiesPresenter: AddCommunitiesPresenterProtocol, AddCommunitiesInteractorOutputProtocol {
    
    var view: AddCommunitiesViewProtocol?
    
    var interactor: AddCommunitiesInteractorInputProtocol?
    
    var wireFrame: AddCommunitiesWireFrameProtocol?
    
    
}
