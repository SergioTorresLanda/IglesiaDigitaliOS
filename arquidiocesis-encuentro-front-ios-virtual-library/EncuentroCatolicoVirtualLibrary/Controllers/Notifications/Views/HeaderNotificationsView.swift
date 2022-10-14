//
//  HeaderNotificationsView.swift
//  EncuentroCatolicoVirtualLibrary
//
//  Created by Ulises Atonatiuh González Hernández on 27/04/21.
//

import Foundation
import UIKit


struct DataHeaderNotification {
    let title: String
    let horarios: String
    let img : String
    let km: Double
}

class HeaderNotificationView: UIView {
    
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
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        return label
        
    }()
    
    lazy var lblHorarios: UILabel = {
        let label = UILabel()
        label.text = "Me da gusto tenerte por aqui."
        label.textColor = .black
        label.font = UIFont(name: "Helvetica", size: 11)
        label.translatesAutoresizingMaskIntoConstraints = false
    
        return label
        
    }()
    
    lazy var lblKM: UILabel = {
        let label = UILabel()
        label.text = "KM"
        label.textColor = .black
        label.font = UIFont(name: "Helvetica", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
    
        return label
        
    }()
    
    init(frame: CGRect, data: DataHeaderNotification) {
          super.init(frame: frame)
        
       
        self.lblKM.text = String(data.km) + "km"
        self.lblTitulo.text = data.title
        self.lblHorarios.text = data.horarios
        
        self.imgBack.downloaded(from: data.img)
        
       
        self.setUpView()
      }
      required init?(coder: NSCoder) {
          fatalError("init(coder:) has not been implemented")
      }

    private func setUpView() {

        self.backgroundColor = .white
        self.addSubview(self.imgBack )
        self.addSubview(self.lblTitulo)
        self.addSubview(self.lblHorarios)
        self.addSubview(self.lblKM)
        
        

        self.setConstraints()

    }

    private func setConstraints() {
        
//        kkkk
      
        self.imgBack.heightAnchor.constraint(equalToConstant: 81).isActive = true
        self.imgBack.widthAnchor.constraint(equalToConstant: 104).isActive = true
        self.imgBack.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5).isActive = true
        self.imgBack.topAnchor.constraint(equalTo: self.topAnchor).isActive = true


        self.lblTitulo.heightAnchor.constraint(equalToConstant: 40).isActive = true
        self.lblTitulo.widthAnchor.constraint(equalToConstant: 200).isActive = true
        self.lblTitulo.leftAnchor.constraint(equalTo: self.imgBack.rightAnchor, constant: 10).isActive = true
        self.lblTitulo.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true


        self.lblHorarios.heightAnchor.constraint(equalToConstant: 15).isActive = true
        self.lblHorarios.widthAnchor.constraint(equalToConstant: 100).isActive = true
        self.lblHorarios.leftAnchor.constraint(equalTo: self.imgBack.rightAnchor, constant: 10).isActive = true
        self.lblHorarios.topAnchor.constraint(equalTo: self.lblTitulo.bottomAnchor, constant: 0).isActive = true
        
        
        self.lblKM.heightAnchor.constraint(equalToConstant: 20).isActive = true
        self.lblKM.widthAnchor.constraint(equalToConstant: 107).isActive = true
        self.lblKM.topAnchor.constraint(equalTo: self.topAnchor, constant: 50).isActive = true
        self.lblKM.leftAnchor.constraint(equalTo: self.lblHorarios.rightAnchor, constant: 15).isActive = true
        
    }
    
    
    
}
