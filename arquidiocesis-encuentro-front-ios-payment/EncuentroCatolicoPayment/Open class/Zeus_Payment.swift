//
//  Zeus_Payment.swift
//  zeus-ios-sdk-payment
//
//  Created by Gabriel Briseño on 06/10/20.
//  Copyright © 2020 Gabriel Briseño. All rights reserved.
//

import UIKit

enum ZeusPaymentEnvironment {
    case Development
    case Qa
    case Release
    
    func getBaseURL() -> String {
        switch self {
            case .Development: return ""
            case .Qa: return ""
            case .Release: return ""
        }
    }
}

class Zeus_Payment {
    static func makeTransfer(environment: ZeusPaymentEnvironment) {
        
    }
}
