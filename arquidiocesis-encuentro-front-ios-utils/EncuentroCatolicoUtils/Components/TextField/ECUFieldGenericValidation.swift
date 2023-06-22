//
//  FHCFieldGenericValidation.swift
//  FHCommons
//
//  Created by Alejandro Orihuela on 12/03/22.
//

import Foundation

public typealias ECUValidation = (_ value: String?) -> String?

public enum ECUFieldGenericValidation {
    case required(fieldName: String)
    case greaterThan(comparation: Double)
    case greaterOrEqualThan(comparation: Double)
    case isValidEmail
    case isValidPhone
    case lowerCase(fieldName: String)
    case capitalLetters(fieldName: String)
    case number(fieldName: String)
    case isValidPwd(fieldName: String)
    case isValidRfc
    case minimunCharecters(comparation: Int)

    //MARK: - Methods
    public func getValidation() -> ECUValidation {
        switch self {
        case .required(let fieldName):
            return { $0 == "" ? String(format: "@error_msg_required".getLocalizedString(bundle: .local), String(fieldName)) : nil }
        case .greaterThan(let comparation):
            return { (Double($0 ?? "") ?? 0.0) > comparation ? nil : String(format: "@error_msg_greater_than".getLocalizedString(bundle: .local), String(comparation))}
        case .greaterOrEqualThan(let comparation):
            return { (Double($0 ?? "") ?? 0.0) >= comparation ? nil : String(format: "@error_msg_greater_than".getLocalizedString(bundle: .local), String(comparation)) }
        case .isValidEmail:
            return { value in
                guard (value?.evaluateRegEx(for: ECURegexValidation.email.rawValue) ?? false) else {
                    return "@error_msg_invalid_email".getLocalizedString(bundle: .local)
                }
                
                return validateCom(email: value) ? nil : "@error_msg_invalid_email_by_com".getLocalizedString(bundle: .local)
            }
        case .isValidPhone:
            return { ($0?.evaluateRegEx(for: ECURegexValidation.phone.rawValue) ?? false) ? nil : "@error_msg_invalid_phone".getLocalizedString(bundle: .local) }
        case .lowerCase(let fieldName):
            return { ($0?.evaluateRegEx(for: ECURegexValidation.lowerCase.rawValue) ?? false ) ? nil : String(format: "@error_msg_lowercase".getLocalizedString(bundle: .local), String(fieldName)) }
        case .capitalLetters(let fieldName):
            return { ($0?.evaluateRegEx(for: ECURegexValidation.capitalLetters.rawValue) ?? false ) ? nil : String(format: "@error_msg_capitalletters".getLocalizedString(bundle: .local), String(fieldName)) }
        case .number(let fieldName):
            return { ($0?.evaluateRegEx(for: ECURegexValidation.number.rawValue) ?? false ) ? nil : String(format: "@error_msg_number".getLocalizedString(bundle: .local), String(fieldName)) }
        case .isValidPwd(let fieldName):
            return { ($0?.evaluateRegEx(for: ECURegexValidation.pwd.rawValue) ?? false ) ? nil : String(format: "@error_msg_invalid_pwd".getLocalizedString(bundle: .local), String(fieldName)) }
        case .isValidRfc:
            return  { ($0?.evaluateRegEx(for: ECURegexValidation.rfc.rawValue) ?? false) ? nil :  "@error_msg_invalid_rfc".getLocalizedString(bundle: .local) }
        case .minimunCharecters(let comparation):
            return { $0?.count ?? 0 >= comparation ? nil : String(format: "@error_msg_minimum_characters".getLocalizedString(bundle: .local), String(comparation))}
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
