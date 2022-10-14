//
//  ZeusPayment.swift
//  ZeusPayment
//
//  Created by David on 07/10/20.
//  Copyright © 2020 Gabriel Briseño. All rights reserved.
//

import UIKit

public enum ZeusPaymentEnvironments {
    case Development
    case Qa
    case Release
    
    func getBaseURL() -> String {
        switch self {
            case .Development: return "http://10.51.82.132:8080/"
            case .Qa: return "http://10.51.82.132:8080/"
            case .Release: return "http://200.38.122.30:8080/"
        }
    }
}

public protocol ZeusPaymentDelegate {
    func didFinishSuccess()
    func didFinishWith(error: String)
}

public class ZeusPayment {
    static var enviroment: ZeusPaymentEnvironments = .Release
    var delegate: ZeusPaymentDelegate?
    var isCreditCard = false
    
    public init(delegate: ZeusPaymentDelegate) {
        self.delegate = delegate
    }
    
    public func makeTransferWith(isCreditCard: Bool, monto: Double, cta_retiro: String, cta_deposito: String, validity_date: String = "", cvv: String = "") {
        self.isCreditCard = isCreditCard
        doTransferWith(isCreditCard: isCreditCard, monto: monto, cta_retiro: cta_retiro, cta_deposito: cta_deposito, validity_date: validity_date, cvv: cvv)
    }
    
    func doTransferWith(isCreditCard: Bool, monto: Double, cta_retiro: String, cta_deposito: String, validity_date: String = "", cvv: String = "") {
        let default_credit_data = getDefaultDataForCreditCard()
        let default_visa_data = getDefaultDataForVISACard()
        
        let _cta_deposito = cta_deposito == "" ? (isCreditCard ? default_credit_data.cta_deposito : default_visa_data.cta_deposito) : cta_deposito
        let _cta_retiro = cta_retiro == "" ? (isCreditCard ? default_credit_data.cta_retiro : default_visa_data.cta_retiro) : cta_retiro
        let _cvv = cvv == "" ? default_credit_data.cvv : cvv
        let _validity_date = validity_date == "" ? default_credit_data.date : validity_date
        
        TransferService().request(isCreditCard: isCreditCard, monto: monto, cuentaRetiro: _cta_retiro, cuentaDeposito: _cta_deposito, numeroCVV: _cvv, fecha_vencimiento: _validity_date) { [weak self] (response, error) in

            debugPrint("============== RESPUESTA CONSUMO DE SERVICIO ===============")
            debugPrint(response ?? "Sin response")
            debugPrint(error ?? "sin error")
            debugPrint("============== RESPUESTA CONSUMO DE SERVICIO ===============")

            let isCreditFlow = self?.isCreditCard ?? false
            
            if isCreditFlow {
                if let _ = response {
                    self?.delegate?.didFinishSuccess()
                }
                
                if let _error = error {
                    self?.delegate?.didFinishWith(error: "\(String(describing: _error.getError()))")
                }
            } else {
                if error == nil {
                    if let _response = response {
                        if _response.DescriptionCode.hasPrefix("B520") {
                            self?.delegate?.didFinishWith(error: "B520")
                        } else {
                            self?.delegate?.didFinishSuccess()
                        }
                    } else {
                        self?.delegate?.didFinishWith(error: "nil response")
                    }
                } else {
                    debugPrint(error!)
                    self?.delegate?.didFinishWith(error: error!.localizedDescription)
                }
            }
        }
    }
    
    func getDefaultDataForCreditCard() -> (cta_deposito: String, cvv: String, date: String, cta_retiro: String) {
        return ("28701355392040", "208", "2105", "4053069033992234")
    }
    
    func getDefaultDataForVISACard() -> (cta_deposito: String, cta_retiro: String) {
        return ("28701355392040", "4027665003158004")
    }
}
