//
//  DI_TextField_View.swift
//  Donaciones
//
//  Created by Alejandro Rivera Lona on 06/10/20.
//

import UIKit

class DI_TextInput_View: UIView {
    var textField: PaddedTextField = {
        let textfield = PaddedTextField()
        textfield.textInsets = UIEdgeInsets(top: 19, left: 16, bottom: 19, right: 16)
        textfield.backgroundColor = .white
        textfield.text = "3409 - 2290 - 8567"
        textfield.font = .textFieldStyle
        textfield.textColor = UIColor(white: 0, alpha: 0.60)
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.heightAnchor.constraint(equalToConstant: 56).isActive = true
        textfield.layer.masksToBounds = true
        textfield.layer.cornerRadius = 4
        textfield.layer.borderColor = UIColor(white: 172/255, alpha: 1).cgColor
        textfield.layer.borderWidth = 1
        return textfield
    }()
    var label: UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        label = UILabel()
        
        guard let label = label else { debugPrint("No label DI_TextInput_View"); return }
        
        let container = UIStackView(arrangedSubviews: [textField, label])
        container.axis = .vertical
        container.spacing = 3
        container.distribution = .equalSpacing
        
        addSubview(container)
        
        container.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: self.topAnchor),
            container.leftAnchor.constraint(equalTo: self.leftAnchor),
            container.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            container.rightAnchor.constraint(equalTo: self.rightAnchor),
        ])
    }
    
    convenience init(textLabel text: String, colorText: UIColor = .marineBlue) {
        self.init()
        label?.textColor = colorText
        label?.text = text
        label?.font = .labelStyle
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UIColor {
    @nonobjc class var marineBlue: UIColor {
        return UIColor(red: 1.0 / 255.0, green: 32.0 / 255.0, blue: 104.0 / 255.0, alpha: 1.0)
    }
}

extension UIFont {
    
    class var titleStyle: UIFont {
        return UIFont(name: "Montserrat-Bold", size: 16.0) ?? UIFont.systemFont(ofSize: 16, weight: .bold)
    }
    
    class var subtitleStyle: UIFont {
        return UIFont(name: "Montserrat-Regular", size: 16.0) ?? UIFont.systemFont(ofSize: 16, weight: .regular)
    }
    
    class var textFieldStyle: UIFont {
        return UIFont(name: "Montserrat-Regular", size: 14.0) ?? UIFont.systemFont(ofSize: 14, weight: .regular)
    }
    
    class var labelStyle: UIFont {
        return UIFont(name: "Montserrat-Bold", size: 12.0) ?? UIFont.systemFont(ofSize: 12, weight: .bold)
    }
    
    class var buttonStyle: UIFont {
        return UIFont(name: "Montserrat-Bold", size: 14.0) ?? UIFont.systemFont(ofSize: 14, weight: .bold)
    }
    
    
}

open class PaddedTextField: UITextField {
    public var textInsets = UIEdgeInsets.zero {
        didSet {
            setNeedsDisplay()
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init() {
        self.init(frame: .zero)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    open override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textInsets)
    }
    
    open override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textInsets)
    }
    
    open override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textInsets)
    }
    
    open override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: textInsets))
    }
}
