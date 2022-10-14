//
//  NewDetailServiceProtocols.swift
//  EncuentroCatolicoServices
//
//  Created by Pablo Luis Velazquez Zamudio on 27/07/21.
//

import Foundation
import UIKit

// MARK: ROUTER -
protocol NewDetailServiceRouterProtocol: class {
    
}

// MARK: PRESENTER -
protocol NewDetailServicePresenterProtocol: class {
    func callRequestDertailService(serviceID: String)
    func passResponseRequestDetail(contentResponse: DetailService, responseCode: HTTPURLResponse)
    func makePatchService(status: String, serviceID: String, typePatch: String, comment: String)
    func responsePatchService(responseCode: HTTPURLResponse, typePatch: String) 
}

// MARK: INTERACTOR -
protocol NewDetailServiceInteractorProtocol: class {
    var presenter: NewDetailServicePresenterProtocol? { get set }
    func getServiceDetail(idService: String)
    func patchStatusService(status: String, idService: String, typeService: String, comment: String)
    
}


// MARK: VIEW -
protocol NewDetailServiceViewProtocol: class {
    var presenter: NewDetailServicePresenterProtocol? { get set }
    
    func successRequestDetail(contentResponse: DetailService)
    func failRequestDetail()
    func succesPatchService(typePatch: String) 
    func failPatchService()
}



