//
//  ListServicesProtocols.swift
//  EncuentroCatolicoServices
//
//  Created by Pablo Luis Velazquez Zamudio on 26/07/21.
//

import UIKit

// MARK: ROUTER -
protocol ListServiceRouterProtocol: class {
    
}

// MARK: PRESENTER -
protocol ListServicePresenterProtocol: class {
    func callInterGetList(isHistorial: String, role: String) 
    func passResponseRequestList(responseData: [ListServicesStandard], codeResponse: HTTPURLResponse)
    func makeDelete(servieID: String)
    func deleteResponse(responseCode: HTTPURLResponse)
    func fatalErrorDelete()
}

// MARK: INTERACTOR -
protocol ListServiceInteractorProtocol: class {
    var presenter: ListServicePresenterProtocol? { get set }
    func getListServices(queryParam: String, xrole: String)
    func deleteService(idService: String)
   
}

// MARK: VIEW -
protocol ListServiceViewProtocol: class {
    var presenter: ListServicePresenterProtocol? { get set }
    func successRequestList(data: [ListServicesStandard])
    func failRequestList()
    func succesDeleteRequest()
    func failDeleteRequest()
    func fatalErroDelteRequest()
    
}

