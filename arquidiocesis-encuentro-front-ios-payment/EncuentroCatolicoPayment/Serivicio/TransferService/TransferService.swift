//
//  TransferService.swift
//  ZeusPayment
//
//  Created by David on 07/10/20.
//  Copyright © 2020 Gabriel Briseño. All rights reserved.
//

import Foundation
import Alamofire

class TransferService {
    
    var endpoint: String = "FrontADN/service/Captacion/traspaso/v3"
    var statusService : Request?
    
    private func getHeader(isCreditCard: Bool) -> [String: String] {
        return [
            "Content-Type":"application/json",
            "accept":"application/json",
            "token": "avC7HaqspGiLf7Adxm1cLw==",
            "key": isCreditCard ? "CndCly+znOhKThc1Dg/8CjewDKgtTWYBmZnKHKqvCgY=" : "CndCly+znOhKThc1Dg/8Ckj6zKk6FWGMtLkBaKe4MUU="
//            //"key": "CndCly+znOhKThc1Dg/8CjewDKgtTWYBmZnKHKqvCgY=" // crédito
//            "key": "CndCly+znOhKThc1Dg/8Ckj6zKk6FWGMtLkBaKe4MUU=" // débito
        ]
    }
    
    func request(isCreditCard: Bool, monto: Double, cuentaRetiro: String, cuentaDeposito: String, numeroCVV: String, fecha_vencimiento: String, completion: @escaping (Traspaso?, NetworkError?) -> Void) {
        
        let url = ZeusPayment.enviroment.getBaseURL() + endpoint
        
        let amount = String(format: "%016.2f", monto)
        let concept = "Donativo parroquial"
        var req = TransferServiceRequest(monto: amount, cuentaOperacionRetiro: cuentaRetiro, descripcionOperacionRetiro: concept, cuentaOperacionDeposito: cuentaDeposito, descripcionOperacionDeposito: concept)
        req.fechaVencimiento = fecha_vencimiento //"2105" // obligatoria en TDC
        req.numeroCVV = numeroCVV//"208" // obligatio en TDC
        
        statusService = WSManager().makePost(url: url, headers: HTTPHeaders(getHeader(isCreditCard: isCreditCard)), dataToSend: req.cipher(), expectedResponseType: TransferServiceResponse.self, completion: { (response) in
            switch response {
                case .success(let data, let httpResponse):
                    guard let transfer = data else {
                        completion(nil, .noResponse)
                        return
                    }
                    completion(transfer.traspaso, nil)
                case .failure(let error):
                    completion(nil, error)
                return
            }
        })
        
    }
    
}
