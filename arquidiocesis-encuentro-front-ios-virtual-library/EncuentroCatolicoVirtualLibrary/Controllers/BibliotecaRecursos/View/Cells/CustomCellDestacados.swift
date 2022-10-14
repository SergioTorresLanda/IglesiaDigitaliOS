//
//  CustomCellDestacados.swift
//  EncuentroCatolicoVirtualLibrary
//
//  Created by Ulises Atonatiuh González Hernández on 14/04/21.
//

import Foundation
import UIKit
class CustomCellDestacados: UICollectionViewCell {
    
    let urlOptionalImage = "https://i.ibb.co/JzQ3hnM/columnista-ruben-aguilar-2x.png"
    //28 117 188
    let bluecolor = UIColor(red: 25.0 / 255, green: 42.0 / 255, blue: 114.0 / 255, alpha: 1.0)
    let colorText = UIColor(red: 28/255, green: 117/255, blue: 188/255, alpha: 1.0)
    lazy var imgBack: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "AppIcon")
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleToFill
       
        img.layer.cornerRadius = 20
        img.clipsToBounds = true
        return img
    }()
    
   
    lazy var title: UILabel = {
        let label = UILabel()
        label.text = "Bienvenido"
        label.textColor = .black
        label.font = UIFont(name: "Helvetica", size: 14)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    lazy var texto: UILabel = {
        let label = UILabel()
        label.text = "Me da gusto tenerte por aqui."
        label.textColor = colorText
        label.font = UIFont(name: "Helvetica", size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 4
        return label
        
    }()
    
    lazy var btnVisto: UIButton = {
       
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = .red
        btn.setTitle("Lo màs Visto", for: .normal)
        btn.titleLabel?.font = UIFont(name: "Helvetica", size: 11)
        btn.setTitleColor(.white, for: .normal)
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initUI()
      
    }
    
   
    
    private func initUI(){
        self.addSubview(self.imgBack)
        self.addSubview(self.title)
        self.addSubview(self.texto)
        self.addSubview(self.btnVisto)
        
        self.btnVisto.layer.cornerRadius = 5
       
        self.imgBack.layer.cornerRadius = 5
        self.imgBack.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        self.imgBack.leftAnchor.constraint(equalTo: self.leftAnchor,constant: 0).isActive = true
        self.imgBack.widthAnchor.constraint(equalToConstant:self.contentView.bounds.width).isActive = true
        self.imgBack.heightAnchor.constraint(equalToConstant: 136 ).isActive = true

        
        self.btnVisto.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        self.btnVisto.centerXAnchor.constraint(equalTo: self.centerXAnchor,constant: 40).isActive = true
        self.btnVisto.widthAnchor.constraint(equalToConstant:80).isActive = true
        self.btnVisto.heightAnchor.constraint(equalToConstant: 20).isActive = true

      
        self.title.topAnchor.constraint(equalTo: self.imgBack.bottomAnchor, constant: 5).isActive = true
        self.title.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15).isActive = true
        self.title.widthAnchor.constraint(equalToConstant: self.bounds.width - 50).isActive = true
        self.title.heightAnchor.constraint(equalToConstant: 17).isActive = true
        
        
        self.texto.topAnchor.constraint(equalTo: self.title.bottomAnchor, constant: 6).isActive = true
        self.texto.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15).isActive = true
        self.texto.widthAnchor.constraint(equalToConstant: 200).isActive = true
        self.texto.heightAnchor.constraint(equalToConstant: 10).isActive = true
        
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(data: Featured){
    
        (data.views == nil) ? self.texto.text = "0 visitas" : ( self.texto.text = String(data.views ?? 0) + " visitas")
       
        
        self.imgBack.downloaded(from: data.image ?? self.urlOptionalImage )
        
        self.title.text = data.title
       
    
    }
}



