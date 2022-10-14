//
//  ChurchRegisterProtocols.swift
//  encuentro
//
//  Created by Edgar Hernandez Solis on 10/03/2020.
//  Copyright © 2020 Linko. All rights reserved.
//

import Foundation
import UIKit

protocol ChurchRegisterViewProtocol: class {
    var presenter: ChurchRegisterPresenterProtocol? { get set }
    /**
    * Add here your methods for communication PRESENTER -> VIEW
    */
    func showLocation(location: Array<LocationResponse>)
    func showError(error: String)
}

protocol ChurchRegisterWireFrameProtocol: class {
    static func presentChurchRegisterModule(selector: Int) -> UIViewController
    /**
    * Add here your methods for communication PRESENTER -> WIREFRAME
    */
    func pushChurchDetailMap(id: Int, from contoller: AnyObject)
}

protocol ChurchRegisterPresenterProtocol: class {
    var view: ChurchRegisterViewProtocol? { get set }
    var interactor: ChurchRegisterInteractorInputProtocol? { get set }
    var wireFrame: ChurchRegisterWireFrameProtocol? { get set }
    /**
    * Add here your methods for communication VIEW -> PRESENTER
    */
    func getLocations()
    func goToChurchDetailMap(id: Int)
}

protocol ChurchRegisterInteractorOutputProtocol: class {
    /**
    * Add here your methods for communication INTERACTOR -> PRESENTER
    */
    func responseLocations(result: Result<Array<LocationResponse>,ErrorEncuentro>)
}

protocol ChurchRegisterInteractorInputProtocol: class
{
    var presenter: ChurchRegisterInteractorOutputProtocol? { get set }
    /**
    * Add here your methods for communication PRESENTER -> INTERACTOR
    */
    func requestLocations()
}
