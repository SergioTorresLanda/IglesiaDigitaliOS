//
//  UncionServiceSOSProtocols.swift
//  EncuentroCatolicoVirtualLibrary
//
//

import UIKit

// MARK: ROUTER -
protocol UncionServiceRouterProtocol: AnyObject {
    
}

// MARK: PRESENTER -
protocol UncionServicePresenterProtocol: AnyObject {
    func requestDetailService(serviceID : Int)
    func trasportResponse(responseCode: HTTPURLResponse, data: ServiceDetailFaithful)
    func patchUpdateCancel(status: String, flowID: Int, idService: Int)
    func responseCancelPatch(codeREsponse: HTTPURLResponse)
    func trasportResponseFail()
}

// MARK: INTERACTOR -
protocol UncionServiceInteractorProtocol: AnyObject {
    var preenter: UncionServicePresenterProtocol? { get set }
    func getServiceDetail(idService: Int)
    func patchUpdateServiceCancel(status: String, flowID: Int, idService: Int)
}

// MARK: VIEW -
protocol UncionServiceViewProtocol: AnyObject {
    var presenter: UncionServicePresenterProtocol? { get set }
    func loadSuccessResponse(data: ServiceDetailFaithful)
    func failResponse()
    func cancelPatchSuccess()
    func cancelPatchFail()
}
