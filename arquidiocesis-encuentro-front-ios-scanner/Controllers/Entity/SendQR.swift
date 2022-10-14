//
//  SendQR.swift
//  baz-buy
//
//  Created by Monserrat Caballero on 20/11/20.
//

import Foundation

struct SendQR : Codable {
    var codigoQR        : String
    var codigoSesion    : String
    var idCanal         : String
    var idPais          : String
    var numeroTelefono  : String
}
