//
//  ProtocolosAdminFormulario.swift
//  EncuentroCatolicoProfile
//
//  Created by Ulises Atonatiuh González Hernández on 06/05/21.
//

import Foundation
import UIKit

protocol ProtocolosAdminFormularioView: class {
    var presenter: ProtocolosAdminFormularioPresenter? { get set }
    
    func isSuccessData(_ modules: Modules)
   
    func showError(_ error: String)
    
}


protocol ProtocolosAdminFormularioRouter: class {
    static func getController(id: Int, name: String, locationId: Int, isAdmin: Bool, isSuperAdmin: Bool, from contoller: AnyObject)
    func pushToModules(id: Int?, name: String, comesFromList: Int, locationId: Int, isAdmin: Bool?, isSuperAdmin: Bool?, from contoller: AnyObject)
}


protocol ProtocolosAdminFormularioPresenter: class {
    var view: ProtocolosAdminFormularioView? { get set }
    var interactor: ProtocolosAdminFormularioInteractorInput? { get set }
    var router: ProtocolosAdminFormularioRouter? { get set }
    
    func getData(id: Int, locationId: Int)
    
    func goToModules(id: Int?, name: String, comesFromList: Int, locationId: Int, isAdmin: Bool?, isSuperAdmin: Bool?)

}


protocol ProtocolosAdminFormularioInteractorOutput: class {
    func responseData(result: Modules)
    func isError(msg: String)
   
}


protocol ProtocolosAdminFormularioInteractorInput: class {
    var presenter: ProtocolosAdminFormularioInteractorOutput? { get set }
    func requestData(id: Int, locationId: Int)
   
}
