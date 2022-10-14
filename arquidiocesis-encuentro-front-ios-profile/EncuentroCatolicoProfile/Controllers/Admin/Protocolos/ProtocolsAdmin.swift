//
//  PorotocolsColaboradores.swift
//  EncuentroCatolicoProfile
//
//  Created by Ulises Atonatiuh González Hernández on 05/05/21.
//

import Foundation
import UIKit

protocol ProtocolosAdminView: class {
    var presenter: ProtocolosAdminPresenter? { get set }
    
    func isSuccessDataColaboradores(churches: AssignedChurches)
    func isSuccesDelete(result: Bool)
    func showError(_ error: String)
    
}


protocol ProtocolosAdminRouter: class {
    static func getController(from contoller: AnyObject)
    func pushToAdminList(locationId: Int, from contoller: AnyObject)
    func pushToModules(id: Int?, name: String, comesFromList: Int, locationId: Int, isAdmin: Bool?, isSuperAdmin: Bool?, from contoller: AnyObject)
}


protocol ProtocolosAdminPresenter: class {
    var view: ProtocolosAdminView? { get set }
    var interactor: ProtocolosAdminInteractorInput? { get set }
    var router: ProtocolosAdminRouter? { get set }
    
    func getData(id: Int)
    func deleteColaboradorData(id: Int, email: String?, phone: String?)
    func goToAdmin(locationId: Int)
    func goToModules(id: Int?, name: String, comesFromList: Int, locationId: Int, isAdmin: Bool?, isSuperAdmin: Bool?)
}


protocol ProtocolosAdminInteractorOutput: class {
    func responseColaboradores(_ churches: AssignedChurches)
    func responseDeleteColaborador(status: Bool)
    func isError(error: String)
}


protocol ProtocolosAdminInteractorInput: class {
    var presenter: ProtocolosAdminInteractorOutput? { get set }
    func requestData(id: Int)
    func requestDeleteColaborador(id: Int?, email: String?, phone: String?)
}
