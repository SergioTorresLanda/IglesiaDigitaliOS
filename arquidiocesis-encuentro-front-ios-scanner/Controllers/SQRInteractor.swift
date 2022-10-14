//
//  SInteractor.swift
//  baz-buy
//
//  Created by Monserrat Caballero on 28/10/20.
//

import Foundation

protocol SQRPresenterToInteractorProtocol: class {
    var _presenter: SQRInteractorToPresenterProtocol? { set get }
    func cancelAnyRequest()
    func requestData(qrCode: SendQR)
}

class SQRInteractor: SQRPresenterToInteractorProtocol {
    
    var _presenter: SQRInteractorToPresenterProtocol?
    
   // var service     =   InteractorBase.shared
    
    func requestData(qrCode: SendQR) {
//        service.callService(
//            route   : Route.GET_QR,
//            params  : qrCode,
//            entity  : ReturnQR.self,
//            success: { [weak self] (data, msg) in
//                /* Regresa la peticion en forma de estructura ReturnMovement */
//                let result  =   data as? ReturnQR
//
//                guard let structReference = result else { debugPrint("Can't create structMovement"); return }
//
//                self?._presenter?.returnRequest(data: [structReference.concepto, structReference.monto])
//            }, failure: { [weak self] (code, msg) in
////                debugPrint("Code --> :\(code), Message --> \(msg)")
//                self?._presenter?.returnRequestFailure(code: code, msg: msg)
//        })
    }
    
    func cancelAnyRequest() {
        
    }
}
