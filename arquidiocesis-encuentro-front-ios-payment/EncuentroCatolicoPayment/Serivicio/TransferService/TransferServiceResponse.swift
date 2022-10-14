//
//  TransferServiceResponse.swift
//  ZeusPayment
//
//  Created by David on 07/10/20.
//  Copyright © 2020 Gabriel Briseño. All rights reserved.
//

import Foundation

struct TransferServiceResponse: Codable {
    let traspaso: Traspaso
}

struct Traspaso: Codable {
    let descripcionDivisa: String
    let contratoCtaAbono: String
    let oficinaCuentaAbono: String
    let hora: String
    let FechaValor: String
    let literalTraspaso: String
    let literalDivisaTransferencia: String
    let divisaOrigen: String
    let plazaOficina: String
    let moneda: String
    let contratoCtaCargo: String
    let oficinaCuentaCargo: String
    let telefono: String
    let divisaCuentaAbono: String
    let fechaOperacion: String
    let DescriptionCode: String
    let divisa: String
    let importeCargo: String
    let origenOperación: String
    let codigoTransaccion: String
    let descripcionSucursal: String
    let secuencia: String
    let terminal: String
    let codigoDivisa: String
    let MontoITF: String
    let titularCuentaCargo: String
    let monto: String
    let indicadorDebe: String
    let conceptoOperacion: String
    let importeEquivalente: String
    let nombreTitular1: String
    let divisaCuentaCargo: String
    let fechaPoblacion: String
    let literalSolicitud2: String
    let entidadOrigen: String
    let literalSolicitud1: String
    let statusCode: String
}
