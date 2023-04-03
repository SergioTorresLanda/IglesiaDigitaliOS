//
//  MyChurchesProtocols.swift
//  santander-kids
//
//  Created by Edgar Hernandez Solis on 10/03/2020.
//  Copyright © 2020 Linko. All rights reserved.
//

import Foundation

protocol MyChurchesViewProtocol: AnyObject {
    var presenter: MyChurchesPresenterProtocol? { get set }
    /**
    * Add here your methods for communication PRESENTER -> VIEW
    */
    func showError(_ error: String)
    func showChurches(_ churches: PriestChurches)
    func showSearchBarResponse(result: [Assigned])
}

protocol MyChurchesWireFrameProtocol: AnyObject {
    static func presentMyChurchesModule(fromView vc: AnyObject)
    /**
    * Add here your methods for communication PRESENTER -> WIREFRAME
    */
    func pushChurchDetail(id: Int, from contoller: AnyObject, selector: Int)
    func pushChurchMap(id: Int, from contoller: AnyObject, selector: Int)
}

protocol MyChurchesPresenterProtocol: AnyObject {
    var view: MyChurchesViewProtocol? { get set }
    var interactor: MyChurchesInteractorInputProtocol? { get set }
    var wireFrame: MyChurchesWireFrameProtocol? { get set }
    /**
    * Add here your methods for communication VIEW -> PRESENTER
    */
    func getChurches(with id: Int)
    func goToChurchDetail(id: Int, selector: Int)
    func goToChourchMap(id: Int, selector: Int)
    func searchBarChurch(name: String)
    func isError(error: String)
}

protocol MyChurchesInteractorOutputProtocol: AnyObject {
    /**
    * Add here your methods for communication INTERACTOR -> PRESENTER
    */
    func responseChurches(result: PriestChurches)
    func responseSearchBar(result: [Assigned])
    func isError(msg: String)
}

protocol MyChurchesInteractorInputProtocol: AnyObject
{
    var presenter: MyChurchesInteractorOutputProtocol? { get set }
    /**
    * Add here your methods for communication PRESENTER -> INTERACTOR
    */
    func requestChurches(with id: Int)
    func requestSearchBar(name: String)
    
}
