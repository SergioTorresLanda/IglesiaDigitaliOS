//
//  PriestContactPresenter.swift
//  EncuentroCatolicoVirtualLibrary
//
//  Created by Pablo Luis Velazquez Zamudio on 28/06/21.
//

import UIKit

class PriestContactPresenter: PriestContactPresenterProtocol {
    weak private var view: PriestContactViewProtocol?
    var interactor: PriestContactInteractorProtocol?
    private let router: PriestContactRouterProtocol?
    
    init(interface: PriestContactViewProtocol, interactor: PriestContactInteractorProtocol, router: PriestContactRouterProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }
    
// MARK:  REQUEST SERVICES DATA -
    func requestContactDetail(idService: Int) {
        interactor?.getServiceDetailContact(idService: idService)
    }
    
    func transportResponseContact(responseCode: HTTPURLResponse, data: DetailContact) {
        DispatchQueue.main.async {
            if responseCode.statusCode == 200 {
                self.view?.loadSuccessRequest(data: data)
            }else{
                self.view?.failRequest()
            }
        }
        
    }
    
    
// MARK: PATCH SERVICES -
    func updateStatusService(status: String, flowID: Int) {
        interactor?.patchUpdateService(status: status, flowID: flowID)
    }
    
    func getStatusUpdate(responseCode: HTTPURLResponse, status: String, flowID: Int) {
        DispatchQueue.main.async {
            if responseCode.statusCode == 200 {
                self.view?.succesUpdateStatusPatch(status: status, flowID: flowID)
            }else{
                print(responseCode.statusCode)
                self.view?.failUpdateStatusPatch()
            }
        }
    }
    
    func updateHour(dateStr: String, nameID: Int) {
        interactor?.putUpdateHour(dateService: dateStr, priestID: nameID)
    }
    
    func statusUpdateHour(responseCode: HTTPURLResponse) {
        DispatchQueue.main.async {
            if responseCode.statusCode == 200 {
                print("Success al actualizar hora ")
                self.view?.succesUpdateHour()
            }else{
                print("Error al actualizar hora")
                self.view?.failUpdateHour()
            }
        }
    }
    
}


