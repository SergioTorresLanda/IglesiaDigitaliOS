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
    case isValidPhone
    case isValidPwd
    case minimunCharecters(comparation: Int)

    //MARK: - Methods
    public func getValidation() -> ECUValidation {
        switch self {
        case .required:
            return { $0 == "" ? "@error_msg_required".getLocalizedString(bundle: .local) : nil }
        case .greaterThan(let comparation):
            return { (Double($0 ?? "") ?? 0.0) > comparation ? nil : String(format: "@error_msg_greater_than".getLocalizedString(bundle: .local), String(comparation))}
        case .greaterOrEqualThan(let comparation):
            return { (Double($0 ?? "") ?? 0.0) >= comparation ? nil : String(format: "@error_msg_greater_than".getLocalizedString(bundle: .local), String(comparation)) }
        case .isValidEmail:
            return { value in
                guard (value?.evaluateRegEx(for: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}") ?? false) else {
                    return "@error_msg_invalid_email".getLocalizedString(bundle: .local)
                }
                
                return validateCom(email: value) ? nil : "@error_msg_invalid_email_by_com".getLocalizedString(bundle: .local)
            }
        case .isValidPhone:
            return { ($0?.evaluateRegEx(for: #"(\d+){10}"#) ?? false) ? nil : "@error_msg_invalid_phone".getLocalizedString(bundle: .local) }
        case .isValidPwd:
            return { ($0?.evaluateRegEx(for: .regexPwd) ?? false) ? nil : "@error_msg_invalid_pwd".getLocalizedString(bundle: .local) }
        case .minimunCharecters(let comparation):
            return { $0?.count ?? 0 > comparation ? nil : String(format: "@error_msg_minimum_characters".getLocalizedString(bundle: .local), String(comparation))}
        }
    }
    
    private func validateCom(email: String?) -> Bool {
        guard let email = email else {
            return false
        }
        
        let invalidEnds = [".con", ".comm", ".cmo"]
        let separatedBy = email.components(separatedBy: "@")
        
        guard let email = separatedBy.indices.contains(1) ? separatedBy[1] : nil else {
            return true
        }
        
        return invalidEnds.allSatisfy( { !email.contains($0) })
    }
}
