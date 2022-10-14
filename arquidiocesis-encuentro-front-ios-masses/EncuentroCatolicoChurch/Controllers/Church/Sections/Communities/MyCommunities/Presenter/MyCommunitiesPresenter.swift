//
//  MyCommunitiesPresenter.swift
//  EncuentroCatolicoChurch
//
//  Created by Jorge Garcia on 02/08/21.
//

import Foundation

class MyCommunitiesPresenter: MyCommunitiesPresenterProtocol, MyCommunitiesInteractorOutputProtocol {
    
    var view: MyCommunitiesViewProtocol?
    
    var interactor: MyCommunitiesInteractorInputProtocol?
    
    var wireFrame: MyCommunitiesWireFrameProtocol?
    
    
}
