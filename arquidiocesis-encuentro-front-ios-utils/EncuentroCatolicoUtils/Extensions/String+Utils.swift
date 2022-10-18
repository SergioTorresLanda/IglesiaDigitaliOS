//
//  String+Localizable.swift
//  EncuentroCatolicoUtils
//
//  Created by Alejandro on 16/10/22.
//

import Foundation

public extension String {
    //MARK: - Static Properties
    static let regexName = ".*[^A-Za-zÁÉÍÓÚáéíóúñÑ ].*"
    static let regexPwd = "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[\\.=+^\\$*.&{}()?\\[\\]!\\-\\?\\@#%&/,><':;|_~`]).{8,}$"
    //MARK: - Methods
    func getLocalizedString(bundle: Bundle) -> String {
        NSLocalizedString(self, tableName: nil, bundle: bundle, value: self, comment: "")
    }
    
    /// Evaluate a String with a regEx with range 0
    func evaluateRegEx(for regEx: String, with options: NSRegularExpression.Options = []) -> Bool {
        let range = NSRange(location: 0, length: self.count)
        
        guard let nsRegEx = try? NSRegularExpression(pattern: regEx, options: options) else { return false }
        
        return nsRegEx.firstMatch(in: self, options: [], range: range) != nil
    }
}
