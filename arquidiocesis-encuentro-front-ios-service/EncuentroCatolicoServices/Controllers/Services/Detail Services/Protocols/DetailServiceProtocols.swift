//
//  DetailServiceProtocols.swift
//  Encuentro 
//
//  Created by Miguel Eduardo Valdez Tellez on 04/21/2021.
//  Copyright © 2021 Linko. All rights reserved.
//

import Foundation

protocol DetailServiceViewProtocol: class {
    var presenter: DetailServicePresenterProtocol? { get set }
    func succesRequestSububs(responseData: DetailServiceEntity)
    func failRequestSububs()
    func saveComuSucces()
    func saveComuError()
    func saveBelssSucces()
    func saveBlessError()
    /**
    * Add here your methods for communication PRESENTER -> VIEW
    */
}

protocol DetailServiceWireFrameProtocol: class {
    static func presentDetailServiceModule(fromView vc: AnyObject, blessType: Int)
    func pushToMap(fromView vc: AnyObject, isPrincipal: Int, mapType: String)
    /**
    * Add here your methods for communication PRESENTER -> WIREFRAME
    */
}

protocol DetailServicePresenterProtocol: class {
    var view: DetailServiceViewProtocol? { get set }
    var interactor: DetailServiceInteractorInputProtocol? { get set }
    var wireFrame: DetailServiceWireFrameProtocol? { get set }
    func requestSububs(zipCode: String)
    func goToMaps(isPrincipal: Int)
    func postBlessService(familyName: String, email: String, phone: String, description: String, zipcode: String, neighborhood: String, longitude: Double, latitude: Double, location_id: Int, service_id: Int)
    func postComuService(personName: String, email: String, phone: String, expanation: String, zipcode: String, neighborhood: String, longitude: Double, latitude: Double, location_id: Int, service_id: Int)
    
    /**
    * Add here your methods for communication VIEW -> PRESENTER
    */
}

protocol DetailServiceInteractorOutputProtocol: class {
    func getResponse(responseCode: HTTPURLResponse, responseData: DetailServiceEntity)
    func responsePostServiceBless(errores: ServerErrors, data: String?)
    func responsePostServiceComu(errores: ServerErrors, data: String?)
    /**
    * Add here your methods for communication INTERACTOR -> PRESENTER
    */
}

protocol DetailServiceInteractorInputProtocol: class
{
    var presenter: DetailServiceInteractorOutputProtocol? { get set }
    func getSuburb(zipCode: String)
    func saveBlessService(familyName: String, email: String, phone: String, description: String, zipcode: String, neighborhood: String, longitude: Double, latitude: Double, location_id: Int, service_id: Int)
    func saveComuService(personName: String, email: String, phone: String, expanation: String, zipcode: String, neighborhood: String, longitude: Double, latitude: Double, location_id: Int, service_id: Int)
    /**
    * Add here your methods for communication PRESENTER -> INTERACTOR
    */
}
