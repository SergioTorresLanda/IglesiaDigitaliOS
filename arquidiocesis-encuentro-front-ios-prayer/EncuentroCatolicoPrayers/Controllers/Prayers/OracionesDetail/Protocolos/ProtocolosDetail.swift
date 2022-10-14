//
//  ProtocolosDetail.swift
//  OracionesModulo
//
//  Created by Ulises Atonatiuh González Hernández on 02/03/21.
//

import Foundation
import UIKit

protocol ViewOracionesDetailProtocol:class {
    var presenter: PresenterOracionesDetailProtocol? {get set}
    func showError(message: String)
    func isSuccess(data: DetailViewModel)
}

protocol RouterOracionesDetailProtocol: class {
    static func getDetailView(id: Int) -> UIViewController
}

protocol PresenterOracionesDetailProtocol: class {
    var view: ViewOracionesDetailProtocol? {get set}
    var interactor: InteractorInputOracionesDetailProtocolo? {get set}
    var router: RouterOracionesDetailProtocol? {get set}
    
    func getDataInteractor(id: Int)
    func getDataInteractorDevotions(id: Int)
    
}

protocol InteractorOutputOracionesDetailProtocolo: class {
    func isSuccessServiceInteractor(data: DetailViewModel)
    func isErrorService(msg: String)
}
protocol InteractorInputOracionesDetailProtocolo: class {
    var presenter: InteractorOutputOracionesDetailProtocolo? {get set}
    func getDetailData(id: Int)
}
