//
//  NewDetailServicePresenter.swift
//  EncuentroCatolicoServices
//
//  Created by Pablo Luis Velazquez Zamudio on 27/07/21.
//

import Foundation
import UIKit

class NewDetailServicePresnter: NewDetailServicePresenterProtocol {
    
    weak private var view: NewDetailServiceViewProtocol?
    var interactor: NewDetailServiceInteractorProtocol?
    private let router: NewDetailServiceRouterProtocol?
    
    init(interface: NewDetailServiceViewProtocol, interactor: NewDetailServiceInteractorProtocol, router: NewDetailServiceRouterProtocol) {
        
        self.view = interface
        self.interactor = interactor
        self.router = router
        
    }
    
// MARK: GET DETAIL FUNCTIONS -
    func callRequestDertailService(serviceID: String) {
        interactor?.getServiceDetail(idService: serviceID)
    }
    
    func passResponseRequestDetail(contentResponse: DetailService, responseCode: HTTPURLResponse) {
        DispatchQueue.main.async {
            if responseCode.statusCode == 200 {
                self.view?.successRequestDetail(contentResponse: contentResponse)
            }else{
                self.view?.failRequestDetail()
            }
        }
    }
    
// MARK: PATCH STATUS FUNCTIONS -
    func makePatchService(status: String, serviceID: String, typePatch: String, comment: String) {
        interactor?.patchStatusService(status: status, idService: serviceID, typeService: typePatch, comment: comment)
    }
    
    func responsePatchService(responseCode: HTTPURLResponse, typePatch: String) {
        DispatchQueue.main.async {
            if responseCode.statusCode == 200 {
                self.view?.succesPatchService(typePatch: typePatch)
            }else{
                self.view?.failPatchService()
            }
        }
    }
    
}
