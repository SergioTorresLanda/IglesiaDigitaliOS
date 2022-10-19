//
//  ECUForm.swift
//  EncuentroCatolicoUtils
//
//  Created by Alejandro on 18/10/22.
//

import Foundation

public protocol ECUForm {
    //MARK: - Properties
    var fieldList: [ECUField] { get set }
    
    //MARK: - Methods
    func validateForm() -> Bool
}

//MARK: - Default Implementations
public extension ECUForm {
    func validateForm() -> Bool {
        var isValid: Bool = true
        
        fieldList.filter({ $0.validations.count > 0 }).forEach { field in
            if !field.isValid,
               isValid {
                isValid = false
            }
        }
        
        return isValid
    }
}
