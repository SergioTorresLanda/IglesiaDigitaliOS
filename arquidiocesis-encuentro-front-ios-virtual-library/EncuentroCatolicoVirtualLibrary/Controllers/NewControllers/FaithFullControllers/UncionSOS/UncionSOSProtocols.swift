//
//  UncionSOSProtocols.swift
//  EncuentroCatolicoVirtualLibrary
//
//  Created by Pablo Luis Velazquez Zamudio on 16/06/21.
//

import UIKit

// MARK: ROUTER -
protocol UncionRouterProtocol: class {
    
}

// MARK: PRESENTER -
protocol UncionPresenterProtocol: class {
    func getRequestChurchesList(lat: String, long: String)
    func transportData(responseStatus: HTTPURLResponse, data: [ListChurches])
    func postCreateService(address: String, latitude: Double, longitude: Double, devoteeID: Int, idService: Int, contactID: Int)
    func getPostReponse(responseCode: HTTPURLResponse, responseData: ServiceResponse)
    
}

// MARK: INTERACTOR -
protocol UncionInteractorProtocol: class {
    var preenter: UncionPresenterProtocol? { get set }
    func  getListChurches(latitude: String, longitude: String) 
    func postService(address: String, latitude: Double, longitude: Double, devoteeID: Int, idService: Int, contactID: Int)
    
}

// MARK: VIEW -
protocol UncionViewProtocol: class {
    var presenter: UncionPresenterProtocol? { get set }
    func loadRequestData(data: [ListChurches])
    func successCreateService(data: ServiceResponse)
    
}

