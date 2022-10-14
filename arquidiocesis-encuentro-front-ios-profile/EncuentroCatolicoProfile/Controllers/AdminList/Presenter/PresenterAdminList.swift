//
//  PresenterAdminList.swift
//  EncuentroCatolicoProfile
//
//  Created by Ulises Atonatiuh González Hernández on 06/05/21.
//

import Foundation

class PresenterAdminList: ProtocolosAdminListPresenter & ProtocolosAdminListInteractorOutput {
    
    func goToFormullary(id: Int, name: String, locationId: Int, isAdmin: Bool, isSuperAdmin: Bool) {
        if let view = view {
            router?.pushFormularyController(id: id, name: name, locationId: locationId, isAdmin: isAdmin, isSuperAdmin: isSuperAdmin, from: view)
        }
    }
    
    var view: ProtocolosAdminListView?
    
    var interactor: ProtocolosAdminListInteractorInput?
    
    var router: ProtocolosAdminListRouter?
    
    func getData(id: Int) {
        self.interactor?.requestData(id: id)
    }
    
    func responseData(result: [UserList]) {
        self.view?.isSuccessData(result)
    }
    func isError(msg: String) {
        self.view?.showError(msg)
    }
    func searchBarPerson(id: Int, name: String) {
        interactor?.getsearchBarPerson(id: id, name: name)
    }
    
}
