//
//  Search_TextField.swift
//  EncuentroCatolicoNewFormation
//
//  Created by Daniel Isaac Mora Osorio on 03/05/21.
//

import UIKit
import EncuentroCatolicoUtils

class Search_TextField: UITextField {

    var closeButton: UIButton?
    
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
        
        let imageView_ = UIImageView()
        let image_ = UIImage(named: "iconoBuscar", in: Bundle().getBundle(), compatibleWith: nil)
        
        imageView_.image = image_
        imageView_.contentMode = .scaleAspectFit
       
        let imageButtonClose = UIButton()
        let imageClose = UIImage(named: "close", in: Bundle(for: ECUField.self), compatibleWith: nil)?.withRenderingMode(.alwaysTemplate)
        
        imageButtonClose.setImage(imageClose, for: .normal)
        imageButtonClose.tintColor = .gray
        imageButtonClose.isHidden = true
        imageButtonClose.contentMode = .scaleAspectFit
        imageButtonClose.addTarget(self, action: #selector(onClickClean(_:)), for: .touchUpInside)
        
        let stackH = UIStackView()
        
        stackH.axis = .horizontal
        stackH.distribution = .fillEqually
        stackH.alignment = .center
        stackH.spacing = 4
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 40))
        view.addSubview(stackH)
        
        stackH.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackH.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            stackH.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            stackH.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            stackH.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
        
        stackH.addArrangedSubview(imageButtonClose)
        stackH.addArrangedSubview(imageView_)
        
        self.closeButton = imageButtonClose
        
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
    
    //MARK: - Events
    @objc func onClickClean(_ sender: UIView) {
        self.text = nil
        self.sendActions(for: .editingChanged)
    }
}
