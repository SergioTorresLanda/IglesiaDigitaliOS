//
//  ViewTimer.swift
//  EncuentroCatolicoVirtualLibrary
//
//  Created by Ulises Atonatiuh González Hernández on 20/04/21.
//


import Foundation
import UIKit



protocol DelegateViewCounter {
    func callAction()
}
struct DataCounter {
    let number: Float
    let number2: Float
    let number3: Float
}

class ViewTimer: UIView {
   
     var delegateCounter: DelegateViewCounter?
    var counter = 300
    var counterSeg = 60
    var widthView: CGFloat?
    let blueColor = UIColor(red: 25.0 / 255, green: 42.0 / 255, blue: 114.0 / 255, alpha: 1.0)
   
    lazy var lblTitulo: UILabel = {
        let label = UILabel()
        label.text = "Unión de los enfermos"
        label.textColor = blueColor
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var lblSubtitulo: UILabel = {
        let label = UILabel()
        label.text = "Parroco Jesus Silva"
        label.textColor = .black
        label.font = UIFont(name: "Helvetica", size:16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var lblSolicitud: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica", size: 11)
        label.textColor = .gray
        label.text = "Solicitada: 11/05/2021"
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var lblKM: AnimatedLabel = {
        let label = AnimatedLabel()
        label.text = "0.0"
        label.textColor = .gray
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var lblServicio: UILabel = {
        let label = UILabel()
        label.text = "Servicio por confirmar"
        label.textColor = .lightGray
        label.font = UIFont(name: "Helvetica", size:14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var view1: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = false
        view.backgroundColor = .white
        view.layer.shadowColor = UIColor.lightGray.cgColor
        view.layer.shadowOffset = CGSize(width: 1.5, height: 1.5)
        view.layer.shadowRadius = 1.5
        view.layer.shadowOpacity = 1.0
        return view
    }()
    
    
    lazy var view2: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = false
        view.backgroundColor = .white
        view.layer.shadowColor = UIColor.lightGray.cgColor
        view.layer.shadowOffset = CGSize(width: 1.5, height: 1.5)
        view.layer.shadowRadius = 1.5
        view.layer.shadowOpacity = 1.0
        return view
    }()
    
    lazy var view3: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.lightGray.cgColor
        view.layer.shadowOffset = CGSize(width: 1.5, height: 1.5)
        view.layer.shadowRadius = 1.5
        view.layer.shadowOpacity = 1.0
        return view
    }()
    
    
//    lazy var btnCircular: UIButton = {
//
//        let btn = UIButton()
//        btn.translatesAutoresizingMaskIntoConstraints = false
//        btn.backgroundColor = .yellow
//        btn.layer.cornerRadius = 10
//        return btn
//    }()
    
    
    lazy var lblNumber1: AnimatedLabel = {
        let label = AnimatedLabel()
        label.text = "0.0"
        label.textColor = .gray
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var lblNumber2: UILabel = {
        let label = UILabel()
        label.text = "0.0"
        label.textColor = .gray
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var lblNumber3: AnimatedLabel = {
        let label = AnimatedLabel()
        label.text = "0.0"
        label.textColor = .gray
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var dosPuntos: UILabel = {
        let label = UILabel()
        label.text = ":"
        label.textColor =  blueColor
        label.font = UIFont.boldSystemFont(ofSize: 35)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var dosPuntos2: UILabel = {
        let label = UILabel()
        label.text = ":"
        label.textColor =  blueColor
        label.font = UIFont.boldSystemFont(ofSize: 35)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var imageStatus: UIImageView = {
       let image = UIImageView()
        image.image = UIImage(named:"confirmado", in: Bundle.local, compatibleWith: nil)
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var lblStatus: UILabel = {
        let label = UILabel()
        label.text = "Confirmada"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var lblSubStatus: UILabel = {
        let label = UILabel()
        label.text = "Llamada realizada"
        label.textColor = .gray
        label.font = UIFont.boldSystemFont(ofSize: 11)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var lblTImeStatus: UILabel = {
        let label = UILabel()
        label.text = "10:00 am"
        label.textColor = .gray
        label.font = UIFont.boldSystemFont(ofSize: 11)
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var lineStatus: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 10/255, green: 40/255, blue: 129/255, alpha: 1.0)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var imageStatus2: UIImageView = {
       let image = UIImageView()
        image.image = UIImage(named:"pendiente", in: Bundle.local, compatibleWith: nil)
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var lblStatus2: UILabel = {
        let label = UILabel()
        label.text = "En progreso"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var lblSubStatus2: UILabel = {
        let label = UILabel()
        label.text = "Sacerdote en camino"
        label.textColor = .gray
        label.font = UIFont.boldSystemFont(ofSize: 11)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var lblTImeStatus2: UILabel = {
        let label = UILabel()
        label.text = "00:00"
        label.textColor = .gray
        label.font = UIFont.boldSystemFont(ofSize: 11)
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var lineStatus2: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 10/255, green: 40/255, blue: 129/255, alpha: 1.0)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var imageStatus3: UIImageView = {
       let image = UIImageView()
        image.image = UIImage(named:"border", in: Bundle.local, compatibleWith: nil)
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var lblStatus3: UILabel = {
        let label = UILabel()
        label.text = "Completada"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var lblSubStatus3: UILabel = {
        let label = UILabel()
        label.text = "En espera"
        label.textColor = .gray
        label.font = UIFont.boldSystemFont(ofSize: 11)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var lblTImeStatus3: UILabel = {
        let label = UILabel()
        label.text = "00:00"
        label.textColor = .gray
        label.font = UIFont.boldSystemFont(ofSize: 11)
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var number1: Float = 0.0
    private var number2: Float = 0.0
    private var number3: Float = 0.0
    
    var time: Double = Date.asNumber()
    var status: String?
    var fecha: String?
    
     init(frame: CGRect, data: DataCounter) {
        super.init(frame: frame)
        self.number1 = data.number
        self.number2 = data.number2
        self.number3 = data.number3
        self.setUpView()
      }
      required init?(coder: NSCoder) {
          fatalError("init(coder:) has not been implemented")
      }

    private func setUpView() {
        
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
       
        self.backgroundColor = .white
        
//        self.view1.addSubview(self.lblNumber1)
//        self.view2.addSubview(self.lblNumber2)
//        self.view3.addSubview(self.lblNumber3)
        self.addSubview(self.lblTitulo)
        self.addSubview(self.lblSubtitulo)
        self.addSubview(self.lblSolicitud)
//        self.addSubview(self.btnCircular)
        self.addSubview(self.lblKM)
//        self.addSubview(self.lblServicio)
//        self.addSubview(self.view1)
//        self.addSubview(self.view2)
//        self.addSubview(self.view3)
//        self.addSubview(self.dosPuntos)
//        self.addSubview(self.dosPuntos2)
        self.addSubview(self.imageStatus)
        self.addSubview(self.lblStatus)
        self.addSubview(self.lblSubStatus)
        self.addSubview(self.lblTImeStatus)
        self.addSubview(self.lineStatus)
        self.addSubview(self.imageStatus2)
        self.addSubview(self.lblStatus2)
        self.addSubview(self.lblSubStatus2)
        self.addSubview(self.lblTImeStatus2)
        self.addSubview(self.lineStatus2)
        self.addSubview(self.imageStatus3)
        self.addSubview(self.lblStatus3)
        self.addSubview(self.lblSubStatus3)
        self.addSubview(self.lblTImeStatus3)

        self.setConstraints()

    }

    private func setConstraints() {
        
        self.lblTitulo.heightAnchor.constraint(equalToConstant: 40).isActive = true
        self.lblTitulo.widthAnchor.constraint(equalToConstant: 270).isActive = true
        self.lblTitulo.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5).isActive = true
        self.lblTitulo.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        
//
//        self.view1.heightAnchor.constraint(equalToConstant: 36).isActive = true
//        self.view1.widthAnchor.constraint(equalToConstant: 24).isActive = true
//        self.view1.rightAnchor.constraint(equalTo: self.dosPuntos.leftAnchor, constant: -5).isActive = true
//        self.view1.topAnchor.constraint(equalTo: self.topAnchor, constant: 2).isActive = true
//
//        self.lblNumber1.centerYAnchor.constraint(equalTo: self.view1.centerYAnchor).isActive = true
//        self.lblNumber1.centerXAnchor.constraint(equalTo: self.view1.centerXAnchor).isActive = true
//
//
//
//        self.dosPuntos.heightAnchor.constraint(equalToConstant: 26).isActive = true
//        self.dosPuntos.widthAnchor.constraint(equalToConstant: 4).isActive = true
//        self.dosPuntos.rightAnchor.constraint(equalTo: self.view2.leftAnchor, constant: -8).isActive = true
//        self.dosPuntos.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
//
//
//        self.view2.heightAnchor.constraint(equalToConstant: 36).isActive = true
//        self.view2.widthAnchor.constraint(equalToConstant: 24).isActive = true
//        self.view2.rightAnchor.constraint(equalTo: self.dosPuntos2.leftAnchor, constant: -5).isActive = true
//        self.view2.topAnchor.constraint(equalTo: self.topAnchor, constant: 2).isActive = true
//
//        self.lblNumber2.centerYAnchor.constraint(equalTo: self.view2.centerYAnchor).isActive = true
//        self.lblNumber2.centerXAnchor.constraint(equalTo: self.view2.centerXAnchor).isActive = true
//
//
//
//        self.dosPuntos2.heightAnchor.constraint(equalToConstant: 26).isActive = true
//        self.dosPuntos2.widthAnchor.constraint(equalToConstant: 4).isActive = true
//        self.dosPuntos2.rightAnchor.constraint(equalTo: self.view3.leftAnchor, constant: 12).isActive = true
//        self.dosPuntos2.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
//
//
//        self.view3.heightAnchor.constraint(equalToConstant: 36).isActive = true
//        self.view3.widthAnchor.constraint(equalToConstant: 24).isActive = true
//        self.view3.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5).isActive = true
//        self.view3.topAnchor.constraint(equalTo: self.topAnchor, constant: 2).isActive = true
//
//        self.lblNumber3.centerYAnchor.constraint(equalTo: self.view3.centerYAnchor).isActive = true
//        self.lblNumber3.centerXAnchor.constraint(equalTo: self.view3.centerXAnchor).isActive = true


        self.lblSubtitulo.heightAnchor.constraint(equalToConstant: 15).isActive = true
        self.lblSubtitulo.widthAnchor.constraint(equalToConstant: 180).isActive = true
        self.lblSubtitulo.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5).isActive = true
        self.lblSubtitulo.topAnchor.constraint(equalTo: self.lblTitulo.bottomAnchor, constant: 0).isActive = true
        
        
        self.lblSolicitud.heightAnchor.constraint(equalToConstant: 15).isActive = true
        self.lblSolicitud.widthAnchor.constraint(equalToConstant: 180).isActive = true
        self.lblSolicitud.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5).isActive = true
        self.lblSolicitud.topAnchor.constraint(equalTo: self.lblSubtitulo.bottomAnchor, constant:5).isActive = true
        
        self.lblKM.heightAnchor.constraint(equalToConstant: 15).isActive = true
        self.lblKM.widthAnchor.constraint(equalToConstant: 100).isActive = true
        self.lblKM.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5).isActive = true
        self.lblKM.topAnchor.constraint(equalTo: self.lblSubtitulo.bottomAnchor, constant: 5).isActive = true
       
        
//        self.lblServicio.heightAnchor.constraint(equalToConstant: 15).isActive = true
//        self.lblServicio.widthAnchor.constraint(equalToConstant: 150).isActive = true
//        self.lblServicio.leftAnchor.constraint(equalTo: self.lblKM.rightAnchor, constant: 20).isActive = true
//        self.lblServicio.topAnchor.constraint(equalTo: self.view3.bottomAnchor, constant: 15).isActive = true
       
        
//        self.btnCircular.heightAnchor.constraint(equalToConstant: 20).isActive = true
//        self.btnCircular.widthAnchor.constraint(equalToConstant: 20).isActive = true
//        self.btnCircular.leftAnchor.constraint(equalTo: self.lblServicio.rightAnchor, constant: 0).isActive = true
//        self.btnCircular.topAnchor.constraint(equalTo: self.view3.bottomAnchor, constant: 10).isActive = true
       
        lblNumber1.count(from: 0, to: 0)
        
        self.imageStatus.heightAnchor.constraint(equalToConstant: 25).isActive = true
        self.imageStatus.widthAnchor.constraint(equalToConstant: 25).isActive = true
        self.imageStatus.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        self.imageStatus.topAnchor.constraint(equalTo: self.lblSolicitud.bottomAnchor, constant: 15).isActive = true
        
        self.lblStatus.heightAnchor.constraint(equalToConstant: 15).isActive = true
        self.lblStatus.widthAnchor.constraint(equalToConstant: 150).isActive = true
        self.lblStatus.leftAnchor.constraint(equalTo: self.imageStatus.rightAnchor, constant: 5).isActive = true
        self.lblStatus.topAnchor.constraint(equalTo: self.lblSolicitud.bottomAnchor, constant: 15).isActive = true
        
        self.lblSubStatus.heightAnchor.constraint(equalToConstant: 15).isActive = true
        self.lblSubStatus.widthAnchor.constraint(equalToConstant: 150).isActive = true
        self.lblSubStatus.leftAnchor.constraint(equalTo: self.imageStatus.rightAnchor, constant: 5).isActive = true
        self.lblSubStatus.topAnchor.constraint(equalTo: self.lblStatus.bottomAnchor, constant: 0).isActive = true
        
        self.lblTImeStatus.heightAnchor.constraint(equalToConstant: 15).isActive = true
        self.lblTImeStatus.widthAnchor.constraint(equalToConstant: 150).isActive = true
        self.lblTImeStatus.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5).isActive = true
        self.lblTImeStatus.topAnchor.constraint(equalTo: self.lblSolicitud.bottomAnchor, constant: 15).isActive = true
        
        self.lineStatus.heightAnchor.constraint(equalToConstant: 25).isActive = true
        self.lineStatus.widthAnchor.constraint(equalToConstant: 3).isActive = true
        self.lineStatus.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        self.lineStatus.topAnchor.constraint(equalTo: self.imageStatus.bottomAnchor, constant: 15).isActive = true
        
        self.imageStatus2.heightAnchor.constraint(equalToConstant: 25).isActive = true
        self.imageStatus2.widthAnchor.constraint(equalToConstant: 25).isActive = true
        self.imageStatus2.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        self.imageStatus2.topAnchor.constraint(equalTo: self.lineStatus.bottomAnchor, constant: 15).isActive = true
        
        self.lblStatus2.heightAnchor.constraint(equalToConstant: 15).isActive = true
        self.lblStatus2.widthAnchor.constraint(equalToConstant: 150).isActive = true
        self.lblStatus2.leftAnchor.constraint(equalTo: self.imageStatus2.rightAnchor, constant: 5).isActive = true
        self.lblStatus2.topAnchor.constraint(equalTo: self.lineStatus.bottomAnchor, constant: 15).isActive = true
        
        self.lblSubStatus2.heightAnchor.constraint(equalToConstant: 15).isActive = true
        self.lblSubStatus2.widthAnchor.constraint(equalToConstant: 150).isActive = true
        self.lblSubStatus2.leftAnchor.constraint(equalTo: self.imageStatus2.rightAnchor, constant: 5).isActive = true
        self.lblSubStatus2.topAnchor.constraint(equalTo: self.lblStatus2.bottomAnchor, constant: 0).isActive = true
        
        self.lblTImeStatus2.heightAnchor.constraint(equalToConstant: 15).isActive = true
        self.lblTImeStatus2.widthAnchor.constraint(equalToConstant: 150).isActive = true
        self.lblTImeStatus2.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5).isActive = true
        self.lblTImeStatus2.topAnchor.constraint(equalTo: self.lineStatus.bottomAnchor, constant: 15).isActive = true
        
        self.lineStatus2.heightAnchor.constraint(equalToConstant: 25).isActive = true
        self.lineStatus2.widthAnchor.constraint(equalToConstant: 3).isActive = true
        self.lineStatus2.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        self.lineStatus2.topAnchor.constraint(equalTo: self.imageStatus2.bottomAnchor, constant: 15).isActive = true
        
        self.imageStatus3.heightAnchor.constraint(equalToConstant: 25).isActive = true
        self.imageStatus3.widthAnchor.constraint(equalToConstant: 25).isActive = true
        self.imageStatus3.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        self.imageStatus3.topAnchor.constraint(equalTo: self.lineStatus2.bottomAnchor, constant: 15).isActive = true
        
        self.lblStatus3.heightAnchor.constraint(equalToConstant: 15).isActive = true
        self.lblStatus3.widthAnchor.constraint(equalToConstant: 150).isActive = true
        self.lblStatus3.leftAnchor.constraint(equalTo: self.imageStatus3.rightAnchor, constant: 5).isActive = true
        self.lblStatus3.topAnchor.constraint(equalTo: self.lineStatus2.bottomAnchor, constant: 15).isActive = true
        
        self.lblSubStatus3.heightAnchor.constraint(equalToConstant: 15).isActive = true
        self.lblSubStatus3.widthAnchor.constraint(equalToConstant: 150).isActive = true
        self.lblSubStatus3.leftAnchor.constraint(equalTo: self.imageStatus3.rightAnchor, constant: 5).isActive = true
        self.lblSubStatus3.topAnchor.constraint(equalTo: self.lblStatus3.bottomAnchor, constant: 0).isActive = true
        
        self.lblTImeStatus3.heightAnchor.constraint(equalToConstant: 15).isActive = true
        self.lblTImeStatus3.widthAnchor.constraint(equalToConstant: 150).isActive = true
        self.lblTImeStatus3.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5).isActive = true
        self.lblTImeStatus3.topAnchor.constraint(equalTo: self.lineStatus2.bottomAnchor, constant: 15).isActive = true

    }
    
    
    @objc func updateCounter() {
        
        if counter > 0 {
            let minutes = counter / 60
            
            let seconds = counter % 60
            
            counter = counter - 1
            
          
            self.lblNumber2.text = "0\(minutes)"
            if seconds < 10 {
                self.lblNumber3.text = "0\(seconds)"
            } else {
                self.lblNumber3.text = "\(seconds)"
                if seconds == 0 {
                    self.delegateCounter?.callAction()
                    #warning("Set alert generica")
                }
            }
            
            self.lblKM.text = "\(lblNumber1.text ?? "0") : \(lblNumber2.text ?? "0") : \(lblNumber3.text ?? "0")"
            
        }
    }
    
    
    
}
