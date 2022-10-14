//
//  TransferServiceRequest.swift
//  ZeusPayment
//
//  Created by David on 07/10/20.
//  Copyright © 2020 Gabriel Briseño. All rights reserved.
//

import Foundation

struct TransferServiceRequest: Codable {    
    var monto: String = ""
    var cuentaOperacionRetiro: String = ""
    var codigoDivisa: String = "MXP"
    var codigoOperacionDeposito: String = "160"
    var descripcionOperacionRetiro: String = ""
    var cuentaOperacionDeposito: String = ""
    var descripcionOperacionDeposito: String
    var codigoOperacionRetiro: String = "169"
    var campoLibre: String = ""
    var numeroCVV: String = ""
    var fechaVencimiento = "2103"
    var nombreTitular = "Francisco Javier"
    func cipher() -> String {
        guard let jsonData = try? JSONEncoder().encode(self),
            let jsonString = String(data: jsonData, encoding: .utf8),
            let strCrypted = CipherUtil.encryptJSON(text: jsonString) else {
                return ""
        }
        
        return strCrypted
    }

}
