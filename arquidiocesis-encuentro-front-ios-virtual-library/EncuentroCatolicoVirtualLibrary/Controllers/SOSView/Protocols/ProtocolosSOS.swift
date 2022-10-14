//
//  ProtocolosSOS.swift
//  SOSLinko
//
//  Created by Ulises Atonatiuh González Hernández on 21/03/21.
//

import Foundation

import UIKit
protocol SOSViewProtocol: class {
    var presenter: SOSPresenterProtocol? { get set }
    /**
    * Add here your methods for communication PRESENTER -> VIEW
    */
    func showError(_ error: String)
    func showResult(result: [SOSFielModel])
}

protocol SOSRouterProtocol: class {
    static func presentModule() -> UIViewController
    /**
    * Add here your methods for communication PRESENTER -> WIREFRAME
    */
    //func pushEdition(id: UInt, from controller: AnyObject)
}

protocol SOSPresenterProtocol: class {
    var view: SOSViewProtocol? { get set }
    var interactor: SOSInterctorInputProtocol? { get set }
    var router: SOSRouterProtocol? { get set }
    /**
    * Add here your methods for communication VIEW -> PRESENTER
    */
    func getData(id: UInt)
    func isError(msg: String)
    
}

protocol SOSInterctorOutputProtocol: class {
    /**
    * Add here your methods for communication INTERACTOR -> PRESENTER
    */
    func responseInteractor(result: [SOSFielModel])
    func responseError(msg: String)
    //func responseDetail(result: Result<ChurchDetail, ErrorEncuentro>)
}

protocol SOSInterctorInputProtocol: class
{
    var presenter: SOSInterctorOutputProtocol? { get set }
    /**
    * Add here your methods for communication PRESENTER -> INTERACTOR
    */
    func requestInteractor(id: UInt)
    
}
