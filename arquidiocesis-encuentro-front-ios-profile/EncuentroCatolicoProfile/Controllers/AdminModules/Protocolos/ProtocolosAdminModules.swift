//
//  ProtocolosAdminModules.swift
//  EncuentroCatolicoProfile
//
//  Created by Ulises Atonatiuh González Hernández on 06/05/21.
//

import Foundation
import UIKit

protocol ProtocolosAdminModulesView: class {
    var presenter: ProtocolosAdminModulesPresenter? { get set }
    
    func isSuccessData(_ modules: Modules)
   
    func showError(_ error: String)
    
    func isSuccessModulesData(_ modules: [ModulesLocation])
    
    func isSuccesChangeModules()
    func succesGetDetail(data: DetailAdminEntity)
    func failGetDetail(message: String) 
}


protocol ProtocolosAdminModulesRouter: class {
    static func getController(id: Int?, name: String, comesFromList: Int, locationId: Int, isAdmin: Bool?, isSuperAdmin: Bool?, from contoller: AnyObject)
}


protocol ProtocolosAdminModulesPresenter: class {
    var view: ProtocolosAdminModulesView? { get set }
    var interactor: ProtocolosAdminModulesInteractorInput? { get set }
    var router: ProtocolosAdminModulesRouter? { get set }
    
    func getData(id: Int, locationId: Int)
    func changeModules(id: Int, locationId: Int, moduleId: [Int])
    func getModulesData(locationId: Int)
    func cahngeModulesLocation(locationId: Int, moduleId: [Int])
    func getAdminDetail(userID: Int, locationID: Int)
    
}


protocol ProtocolosAdminModulesInteractorOutput: class {
    func responseData(result: Modules)
    func responseModulesData(result: [ModulesLocation])
    func isError(msg: String)
    func responseChangeModules(errores: ServerErrors, data: Modules?)
    func transportResponse(data: DetailAdminEntity, response: HTTPURLResponse)
   
}


protocol ProtocolosAdminModulesInteractorInput: class {
    var presenter: ProtocolosAdminModulesInteractorOutput? { get set }
    func requestData(id: Int, locationId: Int)
    func requestchangeModules(id: Int, locationId: Int, moduleId: [Int])
    func requestModuleData(locationId: Int)
    func requestChangeModulesLocation(locationId: Int, moduleId: [Int])
    func requestCollaboratorDetail(locationID: Int, userID: Int)
   
}
