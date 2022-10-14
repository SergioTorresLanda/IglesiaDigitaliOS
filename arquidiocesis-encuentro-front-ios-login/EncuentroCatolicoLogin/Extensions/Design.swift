//
//  Design.swift
//  EncuentroCatolicoLogin
//
//  Created by Diego Martinez on 24/02/21.
//


import UIKit

extension UIView {
    func addShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 0.3, height: 0.5)
        self.layer.shadowRadius = 5
    }
    
    func setCorner(cornerRadius: CGFloat) {
        self.layer.masksToBounds = false
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
    }
    
    func makeRounded() {
        self.layer.masksToBounds = false
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
    }
    
}

extension UIButton {
    
    func underlineButtons(sizeFont: CGFloat, textColor: UIColor, text: String) {
        let yourAttributes: [NSAttributedString.Key: Any] = [
              .font: UIFont.systemFont(ofSize: sizeFont),
              .foregroundColor: textColor,
              .underlineStyle: NSUnderlineStyle.single.rawValue
          ]
        let attributedString = NSMutableAttributedString(string: text, attributes: yourAttributes)
        self.setAttributedTitle(attributedString, for: .normal)
        
    }
    
    func underlineButtonsWithFont(sizeFont: CGFloat, textColor: UIColor, text: String, font: String) {
        var yourAttributes: [NSAttributedString.Key: Any] = [:]
        
        switch font {
        case "BOLD":
            yourAttributes = [
                 // .font: UIFont.systemFont(ofSize: sizeFont),
                  .foregroundColor: textColor,
                  .underlineStyle: NSUnderlineStyle.single.rawValue,
                  .font: UIFont.boldSystemFont(ofSize: sizeFont)
                
              ]
            
        case "SEMI":
            yourAttributes = [
                 // .font: UIFont.systemFont(ofSize: sizeFont),
                  .foregroundColor: textColor,
                  .underlineStyle: NSUnderlineStyle.single.rawValue,
                  .font: UIFont.systemFont(ofSize: sizeFont, weight: .semibold)
                
              ]
            
        case "REGULAR":
            yourAttributes = [
                  //.font: UIFont.systemFont(ofSize: sizeFont),
                  .foregroundColor: textColor,
                  .underlineStyle: NSUnderlineStyle.single.rawValue,
                  .font: UIFont.systemFont(ofSize: sizeFont, weight: .regular)
                
              ]
            
        default :
            break
        }    
        
        let attributedString = NSMutableAttributedString(string: text, attributes: yourAttributes)
        self.setAttributedTitle(attributedString, for: .normal)
        
    }
    
}

private var __maxLengths = [UITextField: Int]()
extension UITextField {
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
    @objc func fix(textField: UITextField) {
        if let t = textField.text {
            textField.text = String(t.prefix(maxLength))
        }
    }
}
