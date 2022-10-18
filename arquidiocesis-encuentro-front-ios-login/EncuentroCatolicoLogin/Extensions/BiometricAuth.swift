//
//  BiometricAuth.swift
//  EncuentroCatolicoLogin
//
//  Created by For Linko on 17/10/22.
//

import Foundation
import LocalAuthentication
import Security
import UIKit

class BiometricAuth {
    enum BiometricType {
        case none
        case touchID
        case faceID
        case unknown
    }
    
    enum BiometricError: LocalizedError {
        case authenticationFailed
        case userCancel
        case userFallback
        case biometryNotAvailable
        case biometryNotEnrolled
        case biometryLockout
        case unknown
        
        var errorDescription: String? {
            switch self {
            case .authenticationFailed: return "There was a problem verifying your identity."
            case .userCancel: return "You pressed cancel."
            case .userFallback: return "You pressed password."
            case .biometryNotAvailable: return "Face ID/Touch ID is not available."
            case .biometryNotEnrolled: return "Face ID/Touch ID is not set up."
            case .biometryLockout: return "Face ID/Touch ID is locked."
            case .unknown: return "Face ID/Touch ID may not be configured"
            }
        }
    }
    
    private let context = LAContext()
    private let policy: LAPolicy
    private let localizedReason: String
    
    private var error: NSError?
    
    init(policy: LAPolicy = .deviceOwnerAuthenticationWithBiometrics,
         localizedReason: String = "Verify your Identity",
         localizedFallbackTitle: String = "Enter App Password") {
        self.policy = policy
        self.localizedReason = localizedReason
        context.localizedFallbackTitle = localizedFallbackTitle
        context.localizedCancelTitle = "Touch me not"
    }
    
    func canEvaluate(completion: (Bool, BiometricType, BiometricError?) -> Void) {
        // Asks Context if it can evaluate a Policy
        // Passes an Error pointer to get error code in case of failure
        guard context.canEvaluatePolicy(policy, error: &error) else {
            // Extracts the LABiometryType from Context
            // Maps it to our BiometryType
            let type = biometricType(for: context.biometryType)
            
            // Unwraps Error
            // If not available, sends false for Success & nil in BiometricError
            guard let error = error else {
                return completion(false, type, nil)
            }
            
            // Maps error to our BiometricError
            return completion(false, type, biometricError(from: error))
        }
        
        // Context can evaluate the Policy
        completion(true, biometricType(for: context.biometryType), nil)
    }
    
    func evaluate(completion: @escaping (Bool, BiometricError?) -> Void) {
        // Asks Context to evaluate a Policy with a LocalizedReason
        context.evaluatePolicy(policy, localizedReason: localizedReason) { [weak self] success, error in
            // Moves to the main thread because completion triggers UI changes
            DispatchQueue.main.async {
                if success {
                    // Context successfully evaluated the Policy
                    completion(true, nil)
                } else {
                    // Unwraps Error
                    // If not available, sends false for Success & nil for BiometricError
                    guard let error = error else { return completion(false, nil) }
                    
                    // Maps error to our BiometricError
                    completion(false, self?.biometricError(from: error as NSError))
                }
            }
        }
    }
    
    private func biometricType(for type: LABiometryType) -> BiometricType {
        switch type {
        case .none:
            return .none
        case .touchID:
            return .touchID
        case .faceID:
            return .faceID
        @unknown default:
            return .unknown
        }
    }
    
    private func biometricError(from nsError: NSError) -> BiometricError {
        let error: BiometricError
        
        switch nsError {
        case LAError.authenticationFailed:
            error = .authenticationFailed
        case LAError.userCancel:
            error = .userCancel
        case LAError.userFallback:
            error = .userFallback
        case LAError.biometryNotAvailable:
            error = .biometryNotAvailable
        case LAError.biometryNotEnrolled:
            error = .biometryNotEnrolled
        case LAError.biometryLockout:
            error = .biometryLockout
        default:
            error = .unknown
        }
        
        return error
    }
}

open class DAKeychain {
    
    open var loggingEnabled = false
    
    private init() {}
    public static let shared = DAKeychain()
    
    open subscript(key: String) -> String? {
        get {
            return load(withKey: key)
        } set {
            DispatchQueue.global().sync(flags: .barrier) {
                self.save(newValue, forKey: key)
            }
        }
    }
    
    private func save(_ string: String?, forKey key: String) {
        let query = keychainQuery(withKey: key)
        let objectData: Data? = string?.data(using: .utf8, allowLossyConversion: false)

        if SecItemCopyMatching(query, nil) == noErr {
            if let dictData = objectData {
                let status = SecItemUpdate(query, NSDictionary(dictionary: [kSecValueData: dictData]))
                logPrint("Update status: ", status)
            } else {
                let status = SecItemDelete(query)
                logPrint("Delete status: ", status)
            }
        } else {
            if let dictData = objectData {
                query.setValue(dictData, forKey: kSecValueData as String)
                let status = SecItemAdd(query, nil)
                logPrint("Update status: ", status)
            }
        }
    }
    
    private func load(withKey key: String) -> String? {
        let query = keychainQuery(withKey: key)
        query.setValue(kCFBooleanTrue, forKey: kSecReturnData as String)
        query.setValue(kCFBooleanTrue, forKey: kSecReturnAttributes as String)
        
        var result: CFTypeRef?
        let status = SecItemCopyMatching(query, &result)
        
        guard
            let resultsDict = result as? NSDictionary,
            let resultsData = resultsDict.value(forKey: kSecValueData as String) as? Data,
            status == noErr
            else {
                logPrint("Load status: ", status)
                return nil
        }
        return String(data: resultsData, encoding: .utf8)
    }
    
    private func keychainQuery(withKey key: String) -> NSMutableDictionary {
        let result = NSMutableDictionary()
        result.setValue(kSecClassGenericPassword, forKey: kSecClass as String)
        result.setValue(key, forKey: kSecAttrService as String)
        result.setValue(kSecAttrAccessibleAlwaysThisDeviceOnly, forKey: kSecAttrAccessible as String)
        return result
    }
    
    private func logPrint(_ items: Any...) {
        if loggingEnabled {
            print(items)
        }
    }
}
