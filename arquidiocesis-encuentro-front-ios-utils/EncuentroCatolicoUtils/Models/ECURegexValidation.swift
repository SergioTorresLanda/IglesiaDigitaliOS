//
//  ECURegexValidations.swift
//  EncuentroCatolicoUtils
//
//  Created by Alejandro on 01/11/22.
//

import Foundation

public enum ECURegexValidation: String {
    case notName = ".*[^A-Za-zÁÉÍÓÚáéíóúñÑ ].*"
    case pwd = "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[\\.=+^\\$*.&{}()?\\[\\]!\\-\\?\\@#%&/\",><':;|_~`]).{8,}$"
    case phone = #"(\d+){10}"#
    case email = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    case zipCode = #"(\d+){5}"#
    case rfc = #"^[A-Z,Ñ,&]{3,4}([0-9]{2})(0[1-9]|1[0-2])(0[1-9]|1[0-9]|2[0-9]|3[0-1])[A-Z|\d]{3}$"#
    case capitalLetters = "[A-Z]"
    case number = "[0-9]"
}
