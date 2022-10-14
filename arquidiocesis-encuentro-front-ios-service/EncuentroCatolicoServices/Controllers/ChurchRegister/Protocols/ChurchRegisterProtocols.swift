//
//  ChurchRegisterProtocols.swift
//  encuentro
//
//  Created by Edgar Hernandez Solis on 10/03/2020.
//  Copyright © 2020 Linko. All rights reserved.
//

import Foundation

protocol ChurchRegisterViewProtocol: class {
    var presenter: ChurchRegisterPresenterProtocol? { get set }
    /**
    * Add here your methods for communication PRESENTER -> VIEW
    */
}

protocol ChurchRegisterWireFrameProtocol: class {
    static func presentChurchRegisterModule(fromView vc: AnyObject)
    /**
    * Add here your methods for communication PRESENTER -> WIREFRAME
    */
}

protocol ChurchRegisterPresenterProtocol: class {
    var view: ChurchRegisterViewProtocol? { get set }
    var interactor: ChurchRegisterInteractorInputProtocol? { get set }
    var wireFrame: ChurchRegisterWireFrameProtocol? { get set }
    /**
    * Add here your methods for communication VIEW -> PRESENTER
    */
}

protocol ChurchRegisterInteractorOutputProtocol: class {
    /**
    * Add here your methods for communication INTERACTOR -> PRESENTER
    */
}

protocol ChurchRegisterInteractorInputProtocol: class
{
    var presenter: ChurchRegisterInteractorOutputProtocol? { get set }
    /**
    * Add here your methods for communication PRESENTER -> INTERACTOR
    */
}
