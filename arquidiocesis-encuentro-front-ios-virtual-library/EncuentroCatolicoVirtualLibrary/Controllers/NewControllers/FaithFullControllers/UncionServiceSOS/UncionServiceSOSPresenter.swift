//
//  UncionServiceSOSPresenter.swift
//  EncuentroCatolicoVirtualLibrary
//
//  Created by Pablo Luis Velazquez Zamudio on 16/06/21.
//

import UIKit

class UncionServiceSOSPresenter: UncionServicePresenterProtocol {
    
    weak private var view: UncionServiceViewProtocol?
    var interactor: UncionServiceInteractorProtocol?
    private let router: UncionServiceRouterProtocol?
    
    init(interface: UncionServiceViewProtocol, interactor: UncionServiceInteractorProtocol, router: UncionServiceRouterProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }
    
    func requestDetailService(serviceID : Int) {
        interactor?.getServiceDetail(idService: serviceID)
    }
    
    func trasportResponse(responseCode: HTTPURLResponse, data: ServiceDetailFaithful) {
        DispatchQueue.main.async {
            if responseCode.statusCode == 200 {
                self.view?.loadSuccessResponse(data: data)
            }else{
                self.view?.failResponse()
            }
        }
       
    }
    
    func trasportResponseFail() {
        self.view?.failResponse()
    }
    
// MARK: UPDATE PATCH SERVICES -
    
    func patchUpdateCancel(status: String, flowID: Int, idService: Int) {
        interactor?.patchUpdateServiceCancel(status: status, flowID: flowID, idService: idService)
    }
    
    func responseCancelPatch(codeREsponse: HTTPURLResponse) {
        DispatchQueue.main.async {
            if codeREsponse.statusCode == 200 {
                self.view?.cancelPatchSuccess()
            }else{
                self.view?.cancelPatchFail()
            }
        }
    }
    
}

