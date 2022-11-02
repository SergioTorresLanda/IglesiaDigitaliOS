//
//  String+Localizable.swift
//  EncuentroCatolicoUtils
//
//  Created by Alejandro on 16/10/22.
//

import UIKit

public extension String {
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
    
    func underlineDecorative(font:UIFont)->NSMutableAttributedString{
        let attibute = NSMutableParagraphStyle()
        
        attibute.alignment = .left
        attibute.lineBreakMode = .byWordWrapping
        
        let attributes: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.foregroundColor: UIColor.getColorFromHex(hex: "1C75BC"),
            NSAttributedString.Key.underlineStyle : NSUnderlineStyle.single.rawValue,
            NSAttributedString.Key.font : font ,
            NSAttributedString.Key.paragraphStyle : attibute
        ]
        let stringAttribute = NSMutableAttributedString(string: self, attributes: attributes)
        return stringAttribute
    }
}
