//
//  CommunitiesProtocol.swift
//  EncuentroCatolicoChurch
//
//  Created by Jorge Garcia on 27/07/21.
//

import Foundation

protocol CommunitiesFormularyViewProtocol: AnyObject {
    var presenter: CommunitiesFormularyPresenterProtocol? { get set }
}

protocol CommunitiesFormularyWireFrameProtocol: AnyObject {
    static func presentCommunitiesFormularyModule(fromView vc: AnyObject)
}

protocol CommunitiesFormularyPresenterProtocol: AnyObject {
    var view: CommunitiesFormularyViewProtocol? { get set }
    var interactor: CommunitiesFormularyInteractorInputProtocol? { get set }
    var wireFrame: CommunitiesFormularyWireFrameProtocol? { get set }
    
}

protocol CommunitiesFormularyInteractorOutputProtocol: AnyObject {
 
}

protocol CommunitiesFormularyInteractorInputProtocol: AnyObject {
    var presenter: CommunitiesFormularyInteractorOutputProtocol? { get set }
}
