//
//  PresenterAdminModules.swift
//  EncuentroCatolicoProfile
//
//  Created by Ulises Atonatiuh González Hernández on 06/05/21.
//

import Foundation

class PresenterAdminModules: ProtocolosAdminModulesPresenter & ProtocolosAdminModulesInteractorOutput {
    
    func responseModulesData(result: [ModulesLocation]) {
        view?.isSuccessModulesData(result)
    }
    
    
    func getModulesData(locationId: Int) {
        interactor?.requestModuleData(locationId: locationId)
    }
    
    func cahngeModulesLocation(locationId: Int, moduleId: [Int]) {
        interactor?.requestChangeModulesLocation(locationId: locationId, moduleId: moduleId)
    }
    
    
    var view: ProtocolosAdminModulesView?
    
    var interactor: ProtocolosAdminModulesInteractorInput?
    
    var router: ProtocolosAdminModulesRouter?
    
    func getData(id: Int,  locationId: Int) {
        self.interactor?.requestData(id: id, locationId: locationId)
    }
    
    func responseData() {
        
    }
    func isError(msg: String) {
        
    }
    
    func responseData(result: Modules) {
        self.view?.isSuccessData(result)
    }
    func changeModules(id: Int, locationId: Int, moduleId: [Int]) {
        interactor?.requestchangeModules(id: id, locationId: locationId, moduleId: moduleId)
    }
    
    func responseChangeModules(errores: ServerErrors, data: Modules?) {
        switch errores {
        case .ErrorInterno:
            print("Error Interno")
        case .ErrorServidor:
            print("Error Servidor")
        case .OK:
            view?.isSuccesChangeModules()
        }
    }
    
    func getAdminDetail(userID: Int, locationID: Int) {
        interactor?.requestCollaboratorDetail(locationID: locationID, userID: userID)
    }
    
    func transportResponse(data: DetailAdminEntity, response: HTTPURLResponse) {
        DispatchQueue.main.async {
            if response.statusCode == 200 {
                self.view?.succesGetDetail(data: data)
            }else{
                self.view?.failGetDetail(message: "Error")
            }
        }
        
    }
    
}
