//
//  HomeServiceProtocols.swift
//  Encuentro 
//
//  Created by Miguel Eduardo Valdez Tellez on 04/21/2021.
//  Copyright © 2021 Linko. All rights reserved.
//

import Foundation

protocol HomeServiceViewProtocol: class {
    var presenter: HomeServicePresenterProtocol? { get set }
    /**
    * Add here your methods for communication PRESENTER -> VIEW
    */
}

protocol HomeServiceWireFrameProtocol: class {
    static func presentHomeServiceModule(fromView vc: AnyObject)
    /**
    * Add here your methods for communication PRESENTER -> WIREFRAME
    */
}

protocol HomeServicePresenterProtocol: class {
    var view: HomeServiceViewProtocol? { get set }
    var interactor: HomeServiceInteractorInputProtocol? { get set }
    var wireFrame: HomeServiceWireFrameProtocol? { get set }
    /**
    * Add here your methods for communication VIEW -> PRESENTER
    */
}

protocol HomeServiceInteractorOutputProtocol: class {
    /**
    * Add here your methods for communication INTERACTOR -> PRESENTER
    */
}

protocol HomeServiceInteractorInputProtocol: class
{
    var presenter: HomeServiceInteractorOutputProtocol? { get set }
    /**
    * Add here your methods for communication PRESENTER -> INTERACTOR
    */
}
