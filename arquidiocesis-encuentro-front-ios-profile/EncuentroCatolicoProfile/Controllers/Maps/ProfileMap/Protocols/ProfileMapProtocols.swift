//
//  ProfileMapProtocols.swift
//  encuentro
//
//  Created by Edgar Hernandez Solis on 10/03/2020.
//  Copyright © 2020 Linko. All rights reserved.
//

import Foundation
import UIKit

protocol ProfileMapViewProtocol: AnyObject {
    var presenter: ProfileMapPresenterProtocol? { get set }
    /**
    * Add here your methods for communication PRESENTER -> VIEW
    */
    func showLocation(location: [LocationResponse])
    func showError(error: String)
}

protocol ProfileMapWireFrameProtocol: AnyObject {
    static func presentProfileMapModule(selector: Int, from contoller: AnyObject, mapType: String)
    /**
    * Add here your methods for communication PRESENTER -> WIREFRAME
    */
    func pushChurchDetailMap(id: Int, from contoller: AnyObject, selector: Int)
    
}

protocol ProfileMapPresenterProtocol: AnyObject {
    var view: ProfileMapViewProtocol? { get set }
    var interactor: ProfileMapInteractorInputProtocol? { get set }
    var wireFrame: ProfileMapWireFrameProtocol? { get set }
    /**
    * Add here your methods for communication VIEW -> PRESENTER
    */
    func getLocations()
    func getLocationsCom()
    func goToChurchDetailMap(id: Int, selector: Int)
    func dismissMapModule(id: Int, name: String, url: String, from: AnyObject)
}

protocol ProfileMapInteractorOutputProtocol: AnyObject {
    /**
    * Add here your methods for communication INTERACTOR -> PRESENTER
    */
    func responseLocations(result: [LocationResponse])
    func errorGetLocations(msg: String)
}

protocol ProfileMapInteractorInputProtocol: AnyObject
{
    var presenter: ProfileMapInteractorOutputProtocol? { get set }
  
    func requestLocations()
    func requestLocationsCom()
}
