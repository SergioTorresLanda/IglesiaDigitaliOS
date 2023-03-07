//
//  Protocolos.swift
//  OracionesModulo
//
//  Created by Ulises Atonatiuh González Hernández on 01/03/21.
//

import Foundation


protocol ViewOracionesProtocol:AnyObject {
    var presenter: PresenterOracionesProtocol? {get set}
    func showError(message: String)
    func isSuccess(data: [DataResponse])
}

protocol RouterOracionesProtocol: AnyObject {
    static func presentModule(fromView vc: AnyObject)
}

protocol PresenterOracionesProtocol: AnyObject {
    var view: ViewOracionesProtocol? {get set}
    var interactor: InteractorInputOracionesProtocolo? {get set}
    var router: RouterOracionesProtocol? {get set}
    
    func getDataInteractor(name: String)
    func getDataInteractorSearchBar(type: String)
    
}

protocol InteractorOutputOracionesProtocolo: AnyObject {
    func isSuccessServiceInteractor(data: [DataResponse])
    func isErrorService(msg: String)
}
protocol InteractorInputOracionesProtocolo: AnyObject {
    var presenter: InteractorOutputOracionesProtocolo? {get set}
    func getOracion(name: String)
    func getOracionSearchBar(type: String)
}
