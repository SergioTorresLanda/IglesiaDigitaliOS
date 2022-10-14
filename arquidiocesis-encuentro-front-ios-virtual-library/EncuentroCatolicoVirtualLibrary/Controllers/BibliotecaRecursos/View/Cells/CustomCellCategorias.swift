//
//  CustomCellCategorias.swift
//  EncuentroCatolicoVirtualLibrary
//
//  Created by Ulises Atonatiuh González Hernández on 14/04/21.
//

import Foundation
import UIKit
class CustomCellCategorias: UICollectionViewCell {
    
    let urlOptionalImage = "https://i.ibb.co/JzQ3hnM/columnista-ruben-aguilar-2x.png"
   
    lazy var imgBack: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "AppIcon")
        img.contentMode = .scaleAspectFit
        img.translatesAutoresizingMaskIntoConstraints = false
        img.clipsToBounds = true
        return img
    }()
    
   
    lazy var title: UILabel = {
        let label = UILabel()
        label.text = "Bienvenido"
        label.textColor = .black
        label.font = UIFont(name: "Helvetica", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    lazy var texto: UILabel = {
        let label = UILabel()
        label.text = "Me da gusto tenerte por aqui."
        label.textColor = .gray
        label.font = UIFont(name: "Helvetica", size:12)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 4
        return label
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initUI()
      
    }
    
   
    
    private func initUI(){
        self.addSubview(self.imgBack)
        self.addSubview(self.title)
       
        self.imgBack.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        self.imgBack.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        self.imgBack.widthAnchor.constraint(equalToConstant:self.bounds.width - 5 ).isActive = true
        self.imgBack.heightAnchor.constraint(equalToConstant: self.bounds.height - 65).isActive = true

      
        self.title.topAnchor.constraint(equalTo: self.imgBack.bottomAnchor, constant: 5).isActive = true
        self.title.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5).isActive = true
        self.title.widthAnchor.constraint(equalToConstant: 200).isActive = true
        self.title.heightAnchor.constraint(equalToConstant: 15).isActive = true
        self.imgBack.layer.cornerRadius = 20
       
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(data: Category){
    
        self.imgBack.downloaded(from: data.image ?? self.urlOptionalImage )
        self.title.text = data.name
    }
}


