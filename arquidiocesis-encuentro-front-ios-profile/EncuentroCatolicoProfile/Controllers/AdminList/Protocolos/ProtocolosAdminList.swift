//
//  ProtocolosAdminList.swift
//  EncuentroCatolicoProfile
//
//  Created by Ulises Atonatiuh González Hernández on 06/05/21.
//

import Foundation
import UIKit
protocol ProtocolosAdminListView: class {
    var presenter: ProtocolosAdminListPresenter? { get set }
    
    func isSuccessData(_ modules: [UserList])
    func showError(_ error: String)
    
}


protocol ProtocolosAdminListRouter: class {
    static func getController(locationId: Int, from contoller: AnyObject)
    func pushFormularyController(id: Int, name: String, locationId: Int, isAdmin: Bool, isSuperAdmin: Bool, from contoller: AnyObject)
}


protocol ProtocolosAdminListPresenter: class {
    var view: ProtocolosAdminListView? { get set }
    var interactor: ProtocolosAdminListInteractorInput? { get set }
    var router: ProtocolosAdminListRouter? { get set }
    func searchBarPerson(id: Int, name: String)
    func getData(id: Int)
    func goToFormullary(id: Int, name: String, locationId: Int, isAdmin: Bool, isSuperAdmin: Bool)
  
}


protocol ProtocolosAdminListInteractorOutput: class {
    func responseData(result: [UserList])
    func isError(msg: String)
    
}


protocol ProtocolosAdminListInteractorInput: class {
    var presenter: ProtocolosAdminListInteractorOutput? { get set }
    func requestData(id: Int)
    func getsearchBarPerson(id: Int, name: String)
   
}
