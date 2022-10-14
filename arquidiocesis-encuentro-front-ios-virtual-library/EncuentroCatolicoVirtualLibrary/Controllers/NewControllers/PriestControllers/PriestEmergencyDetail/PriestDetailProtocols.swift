//
//  PriestDetailProtocols.swift
//  EncuentroCatolicoVirtualLibrary
//
//  Created by Pablo Luis Velazquez Zamudio on 29/06/21.
//

import UIKit

// MARK: ROUTER -
protocol PriestDetailRouterProtocol: class {
    
}

// MARK: PRESENTER -
protocol PriestDetailPresenterPRotocol: class {
    func requestDetailService(idService: Int)
    func TransportaData(responseCode: HTTPURLResponse, data: PriestDetail)
}

// MARK: INTERACTOR -
protocol PriestDetailInteractorProtocol: class {
    var presenter: PriestDetailPresenterPRotocol? { get set }
    func getServiceDetail(idService: Int)
}

// MARK: VIEW -
protocol PriestDetailViewProtocol: class {
    var presenter: PriestDetailPresenterPRotocol? { get set }
    func succesRequest(data: PriestDetail)
    func failRequest()
    
}


