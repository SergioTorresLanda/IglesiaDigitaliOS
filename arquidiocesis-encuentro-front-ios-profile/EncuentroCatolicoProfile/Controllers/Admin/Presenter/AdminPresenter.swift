//
//  ColaboradoresPresenter.swift
//  EncuentroCatolicoProfile
//
//  Created by Ulises Atonatiuh González Hernández on 05/05/21.
//

import Foundation


class AdminPresenter: ProtocolosAdminPresenter & ProtocolosAdminInteractorOutput {
    func goToModules(id: Int?, name: String, comesFromList: Int, locationId: Int, isAdmin: Bool?, isSuperAdmin: Bool?) {
        if let view = view {
            router?.pushToModules(id: id, name: name, comesFromList: comesFromList, locationId: locationId, isAdmin: isAdmin, isSuperAdmin: isSuperAdmin, from: view)
        }
    }
    
    func goToAdmin(locationId: Int) {
        if let view = view {
            router?.pushToAdminList(locationId: locationId, from: view)
        }
    }
    
    
    func isError(error: String) {
        view?.showError(error)
    }
    
    var view: ProtocolosAdminView?
    
    var interactor: ProtocolosAdminInteractorInput?
    
    var router: ProtocolosAdminRouter?
    
    func getData(id: Int) {
        self.interactor?.requestData(id: id)
    }
    
    func deleteColaboradorData(id: Int, email: String?, phone: String?) {
        self.interactor?.requestDeleteColaborador(id: id, email: email, phone: phone)
    }
    
    func responseColaboradores(_ churches: AssignedChurches) {
        self.view?.isSuccessDataColaboradores(churches: churches)
    }
    
    func responseDeleteColaborador(status: Bool) {
        self.view?.isSuccesDelete(result: status)
    }
    
    
}
