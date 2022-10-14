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
    func communityLocationSuccess(response: CommunityLocationList)
    func communityLocationError(msg: String)
}

protocol ChurchRegisterWireFrameProtocol: class {
    static func presentChurchRegisterModule(selector: Int, from contoller: AnyObject)
    static func presentChurchRegisterModuleCommunity(selector: Int, from contoller: AnyObject, isPricipalBool: Bool)
    /**
    * Add here your methods for communication PRESENTER -> WIREFRAME
    */
    func pushChurchDetailMap(id: Int, from contoller: AnyObject, selector: Int)
    func pushCommunityDetail(id: Int, from contoller: AnyObject, myChourch: Bool, isPricipalBool: Bool)
}

protocol ChurchRegisterPresenterProtocol: class {
    var view: ChurchRegisterViewProtocol? { get set }
    var interactor: ChurchRegisterInteractorInputProtocol? { get set }
    var wireFrame: ChurchRegisterWireFrameProtocol? { get set }
    /**
    * Add here your methods for communication VIEW -> PRESENTER
    */
    func getLocations()
    func goToChurchDetailMap(id: Int, selector: Int)
    func goToCommunityDetail(id: Int, myChourch: Bool, isPricipalBool: Bool)
    func getCommunityDetailMap(lat: Double, lon: Double)
}

protocol ChurchRegisterInteractorOutputProtocol: class {
    /**
    * Add here your methods for communication INTERACTOR -> PRESENTER
    */
    func responseLocations(result: Result<Array<LocationResponse>,ErrorEncuentro>)
    func responseCommunityLocations(response: CommunityLocationList)
    func errorCommunityLocation(msg: String)
}

protocol ChurchRegisterInteractorInputProtocol: class
{
    var presenter: ChurchRegisterInteractorOutputProtocol? { get set }
    /**
    * Add here your methods for communication PRESENTER -> INTERACTOR
    */
    func requestLocations()
    func requestCommunityLocations(lat: Double, long: Double)
}
