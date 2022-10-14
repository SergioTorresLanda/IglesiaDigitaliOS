//
//  AddCommunityProtocol.swift
//  EncuentroCatolicoChurch
//
//  Created by Jorge Garcia on 29/07/21.
//

import Foundation

protocol AddCommunitiesViewProtocol: AnyObject {
    var presenter: AddCommunitiesPresenterProtocol? { get set }
}

protocol AddCommunitiesWireFrameProtocol: AnyObject {
    static func presentAddCommunitiesModule(fromView vc: AnyObject)
}

protocol AddCommunitiesPresenterProtocol: AnyObject {
    var view: AddCommunitiesViewProtocol? { get set }
    var interactor: AddCommunitiesInteractorInputProtocol? { get set }
    var wireFrame: AddCommunitiesWireFrameProtocol? { get set }
    
}

protocol AddCommunitiesInteractorOutputProtocol: AnyObject {
 
}

protocol AddCommunitiesInteractorInputProtocol: AnyObject {
    var presenter: AddCommunitiesInteractorOutputProtocol? { get set }
}
