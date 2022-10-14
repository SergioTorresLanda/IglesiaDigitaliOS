//
//  ResponseBase.swift
//  ZeusPayment
//
//  Created by David on 07/10/20.
//  Copyright © 2020 Gabriel Briseño. All rights reserved.
//

import Foundation

struct ResponseBase<T>: Codable where T: Codable {
    let mensaje: String
    let folio: String
    let resultado: T?
    let codigo: String?
    let info: String?
    let detalles: [String]?
}
