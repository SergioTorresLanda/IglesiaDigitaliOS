//
//  PresenterAdminFormulario.swift
//  EncuentroCatolicoProfile
//
//  Created by Ulises Atonatiuh González Hernández on 06/05/21.
//

import Foundation

class PresenterAdminFormulario: ProtocolosAdminFormularioPresenter & ProtocolosAdminFormularioInteractorOutput {
    
    func goToModules(id: Int?, name: String, comesFromList: Int, locationId: Int, isAdmin: Bool?, isSuperAdmin: Bool?) {
        if let view = view {
            router?.pushToModules(id: id, name: name, comesFromList: comesFromList, locationId: locationId, isAdmin: isAdmin, isSuperAdmin: isSuperAdmin, from: view)
        }
    }
    
    
    var view: ProtocolosAdminFormularioView?
    
    var interactor: ProtocolosAdminFormularioInteractorInput?
    
    var router: ProtocolosAdminFormularioRouter?
    
    func getData(id: Int, locationId: Int) {
        interactor?.requestData(id: id, locationId: locationId)
    }
    
    func responseData(result: Modules) {
        view?.isSuccessData(result)
    }
    
   
    func isError(msg: String) {
        
    }
    
    
}
