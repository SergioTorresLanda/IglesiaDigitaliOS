//
//  MyCommunitiesProtocol.swift
//  EncuentroCatolicoChurch
//
//  Created by Jorge Garcia on 02/08/21.
//

import Foundation

protocol MyCommunitiesViewProtocol: AnyObject {
    var presenter: MyCommunitiesPresenterProtocol? { get set }
}

protocol MyCommunitiesWireFrameProtocol: AnyObject {
    static func presentMyCommunitiesModule(fromView vc: AnyObject)
}

protocol MyCommunitiesPresenterProtocol: AnyObject {
    var view: MyCommunitiesViewProtocol? { get set }
    var interactor: MyCommunitiesInteractorInputProtocol? { get set }
    var wireFrame: MyCommunitiesWireFrameProtocol? { get set }
    
}

protocol MyCommunitiesInteractorOutputProtocol: AnyObject {
 
}

protocol MyCommunitiesInteractorInputProtocol: AnyObject {
    var presenter: MyCommunitiesInteractorOutputProtocol? { get set }
}
