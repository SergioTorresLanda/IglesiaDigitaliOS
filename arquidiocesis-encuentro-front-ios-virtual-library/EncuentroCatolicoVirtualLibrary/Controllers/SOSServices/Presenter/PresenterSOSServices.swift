//
//  PresenterSOSServices.swift
//  SOSLinko
//
//  Created by Ulises Atonatiuh González Hernández on 21/03/21.
//

import Foundation

class PresenterSOSServices: SOSPresenterServiciosProtocol , SOSInterctorOutputServiciosProtocol {
    var view: SOSViewServiciosProtocol?
    var interactor: SOSInterctorInputServiciosProtocol?
    var router: SOSRouterServiciosProtocol?
    
    //Form View
    func getData(id: UInt, status: StatusSOS) {
        self.interactor?.requestInteractorData(id: id, status: status)
    }
    
    func changeStatus(id: Int, status: Bool) {
        self.interactor?.requestInteractorChangestatus(id: id, status: status)
    }
    func getStatus(id: Int) {
        self.interactor?.requestInteractorStatus(id: id)
    }
    
    func changeStatusService(id: Int, status: String) {
        self.interactor?.requestInteractorServiceStatus(idService: id, status: status)
    }
    
    
    //To Interactor
    func responseInteractorData(result: [StatusModel]) {
        self.view?.showResult(result: result)
    }
    
    func responseInteractorStatus(status: Bool) {
        self.view?.showResponseStatus(status: status)
    }
    
    func responseChangeStatus(satatus: Bool) {
       // self.view?.showResponseStatus(status: satatus)
    }
    
    func isErrorServer(msg: String) {
        
    }

    func responseChangeServiceStatus() {
        self.view?.successChangeServiceStatus()
    }
    
    func responsePOst() {
        
    }
    
    func isError(msg: String) {
        self.view?.showError(msg)
    }
    
    
}
