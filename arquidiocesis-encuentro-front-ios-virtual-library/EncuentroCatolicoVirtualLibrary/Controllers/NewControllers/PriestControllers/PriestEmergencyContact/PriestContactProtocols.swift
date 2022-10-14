//
//  PriestContactProtocols.swift
//  EncuentroCatolicoVirtualLibrary
//
//  Created by Pablo Luis Velazquez Zamudio on 29/06/21.
//

import UIKit

// MARK: ROUTER -
protocol PriestContactRouterProtocol: class {
    
}

// MARK: PRESENTER -
protocol PriestContactPresenterProtocol: class {
    func requestContactDetail(idService: Int)
    func transportResponseContact(responseCode: HTTPURLResponse, data: DetailContact)
    
    func updateStatusService(status: String, flowID: Int)
    func getStatusUpdate(responseCode: HTTPURLResponse, status: String, flowID: Int)
    
    func updateHour(dateStr: String, nameID: Int)
    func statusUpdateHour(responseCode: HTTPURLResponse)
}

// MARK: INTERACTOR -
protocol PriestContactInteractorProtocol: class {
    var presenter: PriestContactPresenterProtocol? { get set }
    func getServiceDetailContact(idService: Int)
    
    func patchUpdateService(status: String, flowID: Int)
    func putUpdateHour(dateService: String, priestID: Int)
}

// MARK: VIEW -
protocol PriestContactViewProtocol: class {
    var presenter: PriestContactPresenterProtocol? { get set }
    func loadSuccessRequest(data: DetailContact)
    func failRequest()
    
    func succesUpdateStatusPatch(status: String, flowID: Int)
    func failUpdateStatusPatch()
    
    func succesUpdateHour()
    func failUpdateHour()
}

