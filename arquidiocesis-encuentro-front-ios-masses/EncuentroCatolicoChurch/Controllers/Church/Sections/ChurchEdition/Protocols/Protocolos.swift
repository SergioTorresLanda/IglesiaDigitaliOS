//
//  Protocolos.swift
//  ChurchPriest
//
//  Created by Ulises Atonatiuh González Hernández on 11/02/21.
//

import Foundation
import UIKit

protocol ChurchPriestViewProtocol: AnyObject {
    var presenter: ChurchPriestPresenterProtocol? { get set }
    
    func showError(message: String)
    func isSuccess(churchDetail: ChurchDetail?, servicesCatalog: Array<ServiceCatalogItem>?, massesCatalog: Array<MassesCatalogItem>?)
    func succesUpdate(response: ChurchEditionResponse?)
}

protocol ChurchPriestWireFrameProtocol: AnyObject {
    static func presentModule(with churchId: Int, fromView vc: AnyObject, churchDetail: ChurchDetail) 
}

protocol ChurchPriestPresenterProtocol: AnyObject {
    var view: ChurchPriestViewProtocol? { get set }
    var interactor: ChurchPriestInteractorInputProtocol? { get set }
    var wireFrame: ChurchPriestWireFrameProtocol? { get set }
  
    func getDataInteractor(id: String, idChurch: String)
    func updateChurchData(id: Int, _ data: ChurchEditionRequest)
}

protocol ChurchPriestInteractorOutputProtocol: AnyObject {
    //Add here your methods for communication INTERACTOR -> PRESENTER
    
    func updateChurchResponse(response: ChurchEditionResponse?)
    func isSuccessServiceInteractor(churchDetail: ChurchDetail?, servicesCatalog: Array<ServiceCatalogItem>?, massesCatalog: Array<MassesCatalogItem>?)
    func isErrorService(msg: String)
}


protocol ChurchPriestInteractorInputProtocol: AnyObject {
    var presenter: ChurchPriestInteractorOutputProtocol? { get set }
   
    //* Add here your methods for communication PRESENTER -> INTERACTOR
    func getPriestDetail(idPriest: String, idChurch: String)
    func requestChurchDataUpdate(id: Int, _ data: ChurchEditionRequest)
}

