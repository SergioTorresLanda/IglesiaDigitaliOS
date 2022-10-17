//
//  FHCFieldGenericValidation.swift
//  FHCommons
//
//  Created by Alejandro Orihuela on 12/03/22.
//

import Foundation

public typealias ECUValidation = (_ value: String?) -> String?

public enum ECUFieldGenericValidation {
    case required
    case greaterThan(comparation: Double)
    case greaterOrEqualThan(comparation: Double)
    case isValidEmail
    case minimunCharecters(comparation: Int)

    public func getValidation() -> ECUValidation {
        switch self {
        case .required:
            return { $0 == "" ? "@error_msg_required".getLocalizedString(bundle: .local) : nil }
        case .greaterThan(let comparation):
            return { (Double($0 ?? "") ?? 0.0) > comparation ? nil : String(format: "@error_msg_greater_than".getLocalizedString(bundle: .local), String(comparation))}
        case .greaterOrEqualThan(let comparation):
            return { (Double($0 ?? "") ?? 0.0) >= comparation ? nil : String(format: "@error_msg_greater_than".getLocalizedString(bundle: .local), String(comparation)) }
        case .isValidEmail:
            return { ($0?.evaluateRegEx(for: #"/.+@.+\..+/"#) ?? false) ? nil : "@error_msg_invalid_email".getLocalizedString(bundle: .local) }
        case .minimunCharecters(let comparation):
            return { $0?.count ?? 0 > comparation ? nil : String(format: "@error_msg_minimum_characters".getLocalizedString(bundle: .local), String(comparation))}
        }
    }
    
}
