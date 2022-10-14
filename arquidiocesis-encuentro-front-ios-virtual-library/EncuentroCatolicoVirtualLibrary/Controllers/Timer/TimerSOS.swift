//
//  TimerSOS.swift
//  EncuentroCatolicoVirtualLibrary
//
//  Created by Ulises Atonatiuh González Hernández on 20/04/21.
//

import Foundation
import UIKit

class TimerSOS: UIViewController {
    
    let loadingAlert = UIAlertController(title: "", message: "\n \n \n \n \nCargando...", preferredStyle: .alert)
    
    lazy var  navImageBackground : UIImageView = {
        let img = UIImageView()
        img.backgroundColor = UIColor(red: 10/255, green: 40/255, blue: 129/255, alpha: 1.0)
        img.clipsToBounds = true
        img.contentMode = .scaleToFill
        return img
        
    }()
    
    lazy var btnBack: UIButton =  {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "close", in: Bundle.local, compatibleWith: nil), for: .normal)
        button.addTarget(self, action: #selector(popViewCounter), for: .touchUpInside)
        return button
    }()
    
    lazy var lblNav : UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "Emergencia"
        label.font = .boldSystemFont(ofSize: 18.0)
        label.textColor = .white
        return label
    }()
    
    var nameCapilla: String?
    var name: String?
    var serviceId: Int?
    
    private let networkingService: NetworkingService = NetworkingApi()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showLoading()
        self.initUI()
        guard let id = serviceId else {return}
        let status = networkingService.statusNotification(serviceId: id) { status in
            if status.status != ""{
                self.initTimer(status: status.status, fecha: status.creation_date)
            }else{
                let dialogMessage = UIAlertController(title: "SOS", message: "EL RECURSO SOLICITADO NO FUE ENCONTRADO", preferredStyle: .alert)
                self.present(dialogMessage, animated: true, completion: nil)
            }
            
        }
        print(status)
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    private func initUI() {
        hideLoading()
        self.view.addSubview(self.navImageBackground)
        self.view.addSubview(self.btnBack)
        self.view.addSubview(self.lblNav)
        
        self.navImageBackground.topAnchor(equalTo: view.topAnchor, constant: -10)
        self.navImageBackground.widthAnchor(equalTo: view.frame.width + 20)
        self.navImageBackground.heightAnchor(equalTo: 118)
        self.navImageBackground.centerXAnchor(equalTo: view.centerXAnchor)
        
        
        self.btnBack.centerYAnchor(equalTo: navImageBackground.centerYAnchor, constant: 30)
        self.btnBack.leadingAnchor(equalTo: view.leadingAnchor, constant: 15)
        self.btnBack.widthAnchor(equalTo: 35)
        self.btnBack.heightAnchor(equalTo: 35)
        
        self.lblNav.centerXAnchor(equalTo: navImageBackground.centerXAnchor)
        self.lblNav.centerYAnchor(equalTo: navImageBackground.centerYAnchor, constant: 30)
        
    }
    
    func showLoading(){
        let imageView = UIImageView(frame: CGRect(x: 75, y: 25, width: 140, height: 60))
        imageView.image = UIImage(named: "logoEncuentro", in: Bundle.local, compatibleWith: nil)
        loadingAlert.view.addSubview(imageView)
        self.present(loadingAlert, animated: true, completion: nil)
    }
    
    func hideLoading(){
        loadingAlert.dismiss(animated: true, completion: nil)
    }
    
    private func initTimer(status: String, fecha: String) {
        
        let data = DataCounter(number: 20, number2: 20, number3: 30)
        self.view.backgroundColor = .white
        let view = ViewTimer(frame: CGRect(x: 22, y: 160, width: 369, height: 300), data: data)
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.lightGray.cgColor
        view.layer.shadowOffset = CGSize(width: 2.5, height: 1.5)
        view.layer.shadowRadius = 2.5
        view.layer.shadowOpacity = 1.0
        view.lblSubtitulo.text = name
        view.lblTitulo.text = nameCapilla
        
        view.lblSolicitud.text = "Solicitada: \(fecha)"
        
        switch status {
        case "ACCEPTED":
            view.imageStatus2.image = UIImage(named:"confirmado", in: Bundle.local, compatibleWith: nil)
            view.lblTImeStatus2.text = Date.init(timeIntervalSince1970: TimeInterval(view.time)).formatRelativeString()
        case "IN_PROGRESS":
            view.imageStatus2.image = UIImage(named:"confirmado", in: Bundle.local, compatibleWith: nil)
            view.lblTImeStatus2.text = Date.init(timeIntervalSince1970: TimeInterval(view.time)).formatRelativeString()
        case "COMPLETED":
            view.imageStatus2.image = UIImage(named:"confirmado", in: Bundle.local, compatibleWith: nil)
            view.lblTImeStatus2.text = Date.init(timeIntervalSince1970: TimeInterval(view.time)).formatRelativeString()
        default:
            print("")
        }
        view.delegateCounter = self
        self.view.addSubview(view)
    }
    
    @objc func popViewCounter() {
        NotificationCenter.default.post(name: Notification.Name("SOSCreated"), object: nil)
        self.navigationController?.popToRootViewController(animated: false)
    }
    
}

extension TimerSOS: DelegateViewCounter {
    func callAction() {
        //Actions to poptoRoot
    }
}
