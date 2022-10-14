//
//  DI_View.swift
//  Donaciones
//
//  Created by Alejandro Rivera Lona on 06/10/20.
//

import UIKit

class DI_View: UIView {
    var topImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "topImage", in: Bundle(for: DI_View.self), compatibleWith: nil)
        return imageView
    }()
    var gradientImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "bg", in: Bundle(for: DI_View.self), compatibleWith: nil)
        return imageView
    }()
    var titleView: DI_Title_View?
    var accountInput: DI_TextInput_View?
    var amountInput: DI_TextInput_View?
    var confirmButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .marineBlue
        button.titleLabel?.font = .buttonStyle
        button.setTitle("Confirmar", for: UIControl.State.normal)
        button.setTitleColor(UIColor.white, for: UIControl.State.normal)
        button.layer.cornerRadius = 4
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.heightAnchor.constraint(equalToConstant: 56),
        ])
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        titleView = DI_Title_View()
        accountInput = DI_TextInput_View(textLabel: "No. de tarjeta /  Cuenta bancaria")
        amountInput = DI_TextInput_View(textLabel: "¿Cuanto quieres donar?")
        
        guard let titleView = titleView else { debugPrint("Can't make title view DI_View"); return }
        guard let accountInput = accountInput else { debugPrint("Can't make account input DI_View"); return }
        guard let amountInput = amountInput else { debugPrint("Can't make amount input DI_View"); return }
        
        let container = UIStackView(arrangedSubviews: [accountInput, amountInput])
        container.axis = .vertical
        container.spacing = 16
        container.distribution = .equalSpacing
        
        addSubview(topImage)
        addSubview(gradientImage)
        addSubview(titleView)
        addSubview(container)
        addSubview(confirmButton)
        topImage.translatesAutoresizingMaskIntoConstraints = false
        gradientImage.translatesAutoresizingMaskIntoConstraints = false
        titleView.translatesAutoresizingMaskIntoConstraints = false
        container.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topImage.topAnchor.constraint(equalTo: topAnchor),
            topImage.leftAnchor.constraint(equalTo: leftAnchor),
            topImage.rightAnchor.constraint(equalTo: rightAnchor),
            
            gradientImage.bottomAnchor.constraint(equalTo: topImage.bottomAnchor),
            gradientImage.leftAnchor.constraint(equalTo: leftAnchor),
            gradientImage.rightAnchor.constraint(equalTo: rightAnchor),
            
            titleView.topAnchor.constraint(greaterThanOrEqualTo: topAnchor, constant: 60),
            titleView.leftAnchor.constraint(equalTo: leftAnchor, constant: 18),
            titleView.rightAnchor.constraint(equalTo: rightAnchor, constant: -18),
            titleView.bottomAnchor.constraint(equalTo: container.topAnchor, constant: -63),
            
            container.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 24),
            container.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -24),
//            container.heightAnchor.constraint(equalToConstant: 300),
            
            confirmButton.topAnchor.constraint(lessThanOrEqualTo: container.bottomAnchor, constant: 100),
            confirmButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -23),
            confirmButton.leftAnchor.constraint(equalTo: container.leftAnchor),
            confirmButton.rightAnchor.constraint(equalTo: container.rightAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
