//
//  PrincipalProtocolsSOS.swift
//  EncuentroCatolicoVirtualLibrary
//
//  Created by Pablo Luis Velazquez Zamudio on 16/06/21.
//

import UIKit

// MARK: ROUTER -
protocol PrincipalRouterProtocol: class {
    
}

// MARK: PRESENTER -
protocol PrincipalPresenterProtocol: class {
    func getData()
    func getResponse(data: [PModelSOS])
    func getLastSOS(serviceID: Int) 
    func onSuccessGetLastSOS(data: LastSosModel, response: HTTPURLResponse)
    func onFailGetLastSOS(error: Error) 
}

// MARK: INTERACTOR -
protocol PrincipalInteractorProtocol: class {
    var presenter: PrincipalPresenterProtocol? { get set }
    func requestData()
    func getLastSOS(serviceID: Int)
    
}

// MARK:  VIEW -
protocol PrincipalViewProtocol: class {
    var presenter: PrincipalPresenterProtocol? { get set }
    
    func loadData(data: [PModelSOS]?)
    func successGetLastSOS(data: LastSosModel) 
    func failGetLastSOS(message: String)
}
