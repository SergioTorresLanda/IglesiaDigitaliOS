//
//  UncionServiceSOSProtocols.swift
//  EncuentroCatolicoVirtualLibrary
//
//  Created by Pablo Luis Velazquez Zamudio on 16/06/21.
//

import UIKit

// MARK: ROUTER -
protocol UncionServiceRouterProtocol: class {
    
}

// MARK: PRESENTER -
protocol UncionServicePresenterProtocol: class {
    func requestDetailService(serviceID : Int)
    func trasportResponse(responseCode: HTTPURLResponse, data: ServiceDetailFaithful)
    func patchUpdateCancel(status: String, flowID: Int, idService: Int)
    func responseCancelPatch(codeREsponse: HTTPURLResponse)
}

// MARK: INTERACTOR -
protocol UncionServiceInteractorProtocol: class {
    var preenter: UncionServicePresenterProtocol? { get set }
    func getServiceDetail(idService: Int)
    func patchUpdateServiceCancel(status: String, flowID: Int, idService: Int)
}

// MARK: VIEW -
protocol UncionServiceViewProtocol: class {
    var presenter: UncionServicePresenterProtocol? { get set }
    func loadSuccessResponse(data: ServiceDetailFaithful)
    func failResponse()
    func cancelPatchSuccess()
    func cancelPatchFail()
}
