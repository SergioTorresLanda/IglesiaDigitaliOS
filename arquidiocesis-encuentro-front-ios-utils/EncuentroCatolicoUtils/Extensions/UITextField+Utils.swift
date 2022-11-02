//
//  UITextField+Utils.swift
//  EncuentroCatolicoUtils
//
//  Created by Alejandro on 01/11/22.
//

import UIKit

private var __maxLengths = [UITextField: Int]()

public extension UITextField {
    @IBInspectable var maxLength: Int {
        get {
            guard let l = __maxLengths[self] else {
                return 150 // (global default-limit. or just, Int.max)
            }
            return l
        }
        set {
            __maxLengths[self] = newValue
            addTarget(self, action: #selector(fix), for: .editingChanged)
        }
    }
    
    @objc internal func fix(textField: UITextField) {
        if let t = textField.text {
            textField.text = String(t.prefix(maxLength))
        }
    }
}
