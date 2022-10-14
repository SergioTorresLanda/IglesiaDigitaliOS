//
//  PriestPSOSProtocols.swift
//  EncuentroCatolicoVirtualLibrary
//
//  Created by Pablo Luis Velazquez Zamudio on 28/06/21.
//

import UIKit

// MARK: ROUTER -
protocol PriestPSOSRouterProtocol: class {
    
}

// MARK: PRESENTER -
protocol PriestPSOSPresenterProtocol: class  {
    func requestListServices(paramStatus: String)
    func transportResponseData(statusResponse: HTTPURLResponse, data: [ListSrevices]) 
}

// MARK: INTERACTOR -
protocol PriestPSOSInteractorProtocol: class {
    var presenter: PriestPSOSPresenterProtocol? { get set }
    func getServicesList(paramStatus: String)
}

// MARK: VIEW -
protocol PriestPSOSViewProtocol: class {
    var presenter: PriestPSOSPresenterProtocol? { get set }
    func successLoadRequestServices(requestData: [ListSrevices]) 
    func failLoadRequestServices()
    
}
