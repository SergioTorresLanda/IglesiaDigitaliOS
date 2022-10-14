//
//  DI_Title_View.swift
//  Donaciones
//
//  Created by Alejandro Rivera Lona on 06/10/20.
//

import UIKit

class DI_Title_View: UIView {
    var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .titleStyle
        label.textColor = .marineBlue
        label.numberOfLines = 2
        label.textAlignment = .center
        label.text = "Parroquia del Señor de la \nResurrección"
        return label
    }()
    var subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .subtitleStyle
        label.textColor = .marineBlue
        label.numberOfLines = 2
        label.textAlignment = .center
        label.text = "Para realizar un donativo \ningresa los siguientes campos"
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        layer.masksToBounds = false
        layer.cornerRadius = 10
        layer.shadowColor = UIColor(white: 0, alpha: 1).cgColor
        layer.shadowOpacity = 0.1
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = 6
        
        
        [titleLabel, subtitleLabel].forEach( { addSubview($0); $0.translatesAutoresizingMaskIntoConstraints = false } )
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 35),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 60),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -60),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            subtitleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 63),
            subtitleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -63),
            
            self.heightAnchor.constraint(equalToConstant: 161),
            self.widthAnchor.constraint(equalToConstant: 340),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
