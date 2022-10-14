//
//  Protocolos.swift
//  SOSLinko
//
//  Created by Ulises Atonatiuh González Hernández on 21/03/21.
//
import Foundation
import UIKit
protocol SOSViewServiciosProtocol: class {
    var presenter: SOSPresenterServiciosProtocol? { get set }
    /**
    * Add here your methods for communication PRESENTER -> VIEW
    */
    func showError(_ error: String)
    func showResult(result: [StatusModel])
    func showResponseStatus(status: Bool?)
    func successChangeServiceStatus()
    
}

protocol SOSRouterServiciosProtocol: class {
    static func presentModule() -> UIViewController 
    /**
    * Add here your methods for communication PRESENTER -> WIREFRAME
    */
    //func pushEdition(id: UInt, from controller: AnyObject)
}

protocol SOSPresenterServiciosProtocol: class {
    var view: SOSViewServiciosProtocol? { get set }
    var interactor: SOSInterctorInputServiciosProtocol? { get set }
    var router: SOSRouterServiciosProtocol? { get set }
    /**
    * Add here your methods for communication VIEW -> PRESENTER
    */
    func getData(id: UInt, status: StatusSOS)
    func isError(msg: String)
    func getStatus(id: Int)
    func changeStatus(id: Int, status: Bool)
    func changeStatusService(id: Int, status: String)
    
}

protocol SOSInterctorOutputServiciosProtocol: class {
    /**
    * Add here your methods for communication INTERACTOR -> PRESENTER
    */
    func responseInteractorData(result: [StatusModel])
    func responseInteractorStatus(status: Bool)
    func responseChangeStatus(satatus: Bool)
    func isErrorServer(msg: String)
    func responsePOst()
    func responseChangeServiceStatus()
   
    //func responseDetail(result: Result<ChurchDetail, ErrorEncuentro>)
}

protocol SOSInterctorInputServiciosProtocol: class
{
    var presenter: SOSInterctorOutputServiciosProtocol? { get set }
    /**
    * Add here your methods for communication PRESENTER -> INTERACTOR
    */
    func requestInteractorData(id: UInt, status: StatusSOS)
    func requestInteractorStatus(id: Int)
    func requestInteractorChangestatus(id: Int, status: Bool)
    func requestInteractorServiceStatus(idService: Int, status: String)
    
}
