//
//  ViewCustomNews.swift
//  EncuentroCatolicoVirtualLibrary
//
//  Created by Ulises Atonatiuh González Hernández on 20/04/21.
//

import Foundation
import UIKit


class ViewCustomNews: UIView {
    let urlOptionalImage = "https://i.ibb.co/JzQ3hnM/columnista-ruben-aguilar-2x.png"
  
    var widthView: CGFloat?
   
    lazy var imgBack: UIImageView = {
        let img = UIImageView()
//        img.image = UIImage(named: "papa", in: Bundle.local, compatibleWith: nil)
        img.contentMode = .scaleToFill
        img.translatesAutoresizingMaskIntoConstraints = false
        img.clipsToBounds = true
        return img
    }()
    
    lazy var lblTitulo: UILabel = {
        let label = UILabel()
        label.text = "Bienvenido"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        return label
        
    }()
    
    
    lazy var btnConsultar: UIButton = {
       
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = .clear
        btn.setTitle("Consultar", for: .normal)
        btn.titleLabel?.font = UIFont(name: "Helvetica", size: 15)
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 10
        btn.layer.borderWidth = 2
        btn.layer.borderColor = UIColor.white.cgColor
        return btn
    }()
    lazy var lblSubtitulo: UILabel = {
        let label = UILabel()
        label.text = "Me da gusto tenerte por aqui."
        label.textColor = .white
        label.font = UIFont(name: "Helvetica", size:16)
        label.translatesAutoresizingMaskIntoConstraints = false
    
        return label
        
    }()
    
    lazy var viewAlfa: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "#000000")?.withAlphaComponent(0.3)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    init(frame: CGRect, data: Featured) {
          super.init(frame: frame)
        
        self.widthView = frame.width
        (data.subtitle == " ") ? self.lblSubtitulo.text = "No hay subtitulos" : ( self.lblSubtitulo.text = data.subtitle)
       
        self.lblTitulo.text = data.title
        self.imgBack.downloaded(from: data.image ?? self.urlOptionalImage )
        
       
        self.setUpView()
      }
      required init?(coder: NSCoder) {
          fatalError("init(coder:) has not been implemented")
      }

    private func setUpView() {

        self.backgroundColor = .white
        self.addSubview(self.imgBack )
        self.addSubview(self.lblTitulo)
        self.addSubview(self.lblSubtitulo)
        self.addSubview(self.btnConsultar)
        
        

        self.setConstraints()

    }

    private func setConstraints() {
      
        self.imgBack.heightAnchor.constraint(equalToConstant: self.bounds.height).isActive = true
        self.imgBack.widthAnchor.constraint(equalToConstant: self.widthView!).isActive = true
        self.imgBack.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.imgBack.topAnchor.constraint(equalTo: self.topAnchor).isActive = true

        self.imgBack.addSubview(self.viewAlfa)
        
        self.viewAlfa.heightAnchor.constraint(equalToConstant: self.bounds.height).isActive = true
        self.viewAlfa.widthAnchor.constraint(equalToConstant: self.widthView!).isActive = true
        self.viewAlfa.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.viewAlfa.topAnchor.constraint(equalTo: self.topAnchor).isActive = true


        self.lblTitulo.heightAnchor.constraint(equalToConstant: 40).isActive = true
        self.lblTitulo.widthAnchor.constraint(equalToConstant: 270).isActive = true
        self.lblTitulo.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 30).isActive = true
        self.lblTitulo.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 10).isActive = true


        self.lblSubtitulo.heightAnchor.constraint(equalToConstant: 15).isActive = true
        self.lblSubtitulo.widthAnchor.constraint(equalToConstant: 180).isActive = true
        self.lblSubtitulo.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 20).isActive = true
        self.lblSubtitulo.topAnchor.constraint(equalTo: self.lblTitulo.bottomAnchor, constant: 0).isActive = true
        
        
        self.btnConsultar.heightAnchor.constraint(equalToConstant: 26).isActive = true
        self.btnConsultar.widthAnchor.constraint(equalToConstant: 107).isActive = true
        self.btnConsultar.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.btnConsultar.topAnchor.constraint(equalTo: self.lblSubtitulo.bottomAnchor, constant: 5).isActive = true
        
    }
    
    
}
