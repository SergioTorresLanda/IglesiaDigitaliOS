//
//  Search_TextField.swift
//  EncuentroCatolicoNewFormation
//
//  Created by Daniel Isaac Mora Osorio on 03/05/21.
//

import UIKit

class Search_TextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 20
        layer.masksToBounds = true
        layer.borderWidth = 2
        layer.borderColor = UIColor(white: 245.0 / 255.0, alpha: 1.0).cgColor
        backgroundColor = UIColor(white: 245.0 / 255.0, alpha: 1.0)
        keyboardType = .alphabet
        autocorrectionType = .no
        autocapitalizationType = .none
        
        let imageView_ = UIImageView(frame: CGRect(x: 8.0, y: 8.0, width: 25.0, height: 25.0))
        let image_ = UIImage(named: "iconoBuscar", in: Bundle().getBundle(), compatibleWith: nil)
        imageView_.image = image_
        imageView_.contentMode = .scaleAspectFit
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        view.addSubview(imageView_)
        rightViewMode = UITextField.ViewMode.always
        rightView = view
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var textPadding = UIEdgeInsets(
        top: 10,
        left: 20,
        bottom: 10,
        right: 20
    )
    
    /// Función para alinear texto con paddings
    /// - Parameter bounds: layer bounds del view
    /// - Returns: vector de vuelta
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.editingRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }
    
}
