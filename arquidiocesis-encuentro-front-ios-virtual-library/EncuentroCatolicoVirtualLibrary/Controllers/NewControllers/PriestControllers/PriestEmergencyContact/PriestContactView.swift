//
//  PriestContactView.swift
//  EncuentroCatolicoVirtualLibrary
//
//  Created by Pablo Luis Velazquez Zamudio on 28/06/21.
//

import UIKit
import MapKit
import Contacts

class PriestContactView: UIViewController, PriestContactViewProtocol, UIViewControllerTransitioningDelegate {
    var presenter: PriestContactPresenterProtocol?
    let transition = SlideTransition()
    let alertLoader = UIAlertController(title: "", message: "\n \n \n \n \nCargando...", preferredStyle: .alert)
    var doradoEnc = UIColor.init(red: 189/255, green: 169/255, blue: 120/255, alpha: 1)
    var check = UIImage(named: "Trazado 6704", in: Bundle.local, compatibleWith: nil)
    var grisEnc = UIColor.init(red: 213/255, green: 212/255, blue: 204/255, alpha: 1)

// MARK: @IBOUTLETS -
    @IBOutlet weak var contentNavBar: UIView!
    @IBOutlet weak var customNavBar: UIView!
    @IBOutlet weak var backIconNav: UIImageView!
    @IBOutlet weak var lblNavBarTitle: UILabel!
    @IBOutlet weak var lblMainTitle: UILabel!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet var fistStackLbl: [UILabel]!
    @IBOutlet weak var lineaCardView: UIView!
    @IBOutlet weak var phoneImg: UIImageView!
    @IBOutlet var enviadoStackLbl: [UILabel]!
    @IBOutlet var progresoStackLbl: [UILabel]!
    @IBOutlet var finalizadoStackLbl: [UILabel]!
    @IBOutlet var circleFillCollection: [UIImageView]!
    @IBOutlet var circleEmptyCollection: [UIImageView]!
    @IBOutlet var blueLinesCollection: [UIView]!
    @IBOutlet var timeStackLbl: [UILabel]!
    @IBOutlet weak var btnAccept: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var lblcancelado: UILabel!
    
// MARK: LIFE CYCLE -
    override func viewDidLoad() {
        super.viewDidLoad()
        showLoading()
        setupUI()
        setupGestures()
        let singleton = Home_SOSPriest.singleton
        print("%", singleton.idService)
        presenter?.requestContactDetail(idService: singleton.idService)
                
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("EC virtualLibrary - NewControllers - Priest Controllers - PriestemergencyContact")

    }
    
// MARK: SETUP FUNCS -

    func setupUI() {
        cardView.layer.cornerRadius = 10
        customNavBar.layer.cornerRadius = 20
        cardView.ShadowCard()
        customNavBar.ShadowNavBar()
        btnAccept.layer.cornerRadius = 8
        btnCancel.layer.cornerRadius = 8
        btnCancel.roundedNborder(borderColor: UIColor.init(red: 25/255, green: 42/255, blue: 115/255, alpha: 1))
        lblMainTitle.adjustsFontSizeToFitWidth = true
        fistStackLbl.forEach { (label) in
            label.adjustsFontSizeToFitWidth = true
        }
        timeStackLbl.forEach { (lbl) in
            lbl.alpha = 0
        }
        
    }
    
    func setupGestures() {
        let tapBack = UITapGestureRecognizer(target: self, action: #selector(handleTapBack))
        backIconNav.addGestureRecognizer(tapBack)
        
        phoneImg.isUserInteractionEnabled = true
        let tapPhone = UITapGestureRecognizer(target: self, action: #selector(handleTapPhone))
        phoneImg.addGestureRecognizer(tapPhone)
        
    }
    
    func showLoading(){
        let imageView = UIImageView(frame: CGRect(x: 75, y: 25, width: 140, height: 60))
        imageView.image = UIImage(named: "logoEncuentro", in: Bundle.local, compatibleWith: nil)
        alertLoader.view.addSubview(imageView)
        self.present(alertLoader, animated: false, completion: nil)
    }
    
    func setupStatusData(status: String) {
        
        switch status {
        case "PENDING_CONFIRMATION":
            enviadoStackLbl[1].text = "Por aceptar"
            
        case "CALL_WAITING":
            
            self.btnCancel.alpha = 0
            self.btnAccept.alpha = 0
            let date = Date()
            let calendar = Calendar.current
            enviadoStackLbl[1].text = "Aceptado"
            let hour = calendar.component(.hour, from: date)
            let minutes = calendar.component(.minute, from: date)
            let minutesComplete: String
            switch minutes {
            case 0,1,2,3,4,5,6,7,8,9:
                minutesComplete = "0"+String(minutes)
            default:
                minutesComplete = String(minutes)
            }
            timeStackLbl[0].text = "\(hour):\(minutesComplete)"
            
            timeStackLbl[0].alpha = 1
            UIView.animate(withDuration: 0.3) {
                self.circleFillCollection[0].tintColor = self.grisEnc
                self.enviadoStackLbl[0].textColor = self.doradoEnc
               
                
            }
            let alertYesNo = AlertYesNo.showAlertYesNo(titulo: "Realizar llamada", mensaje: "Comunicate con el solicitante \n ¿Se realizó la llamada con éxito?", type: "CALL")
            alertYesNo.transitioningDelegate = self
            present(alertYesNo, animated: true, completion: nil)
            
        case "CALL_FINISHED":
            self.btnCancel.alpha = 0
            self.btnAccept.alpha = 0
            let date = Date()
            let calendar = Calendar.current
            enviadoStackLbl[1].text = "Aceptado"
            let hour1 = calendar.component(.hour, from: date)
            let minutes1 = calendar.component(.minute, from: date)
            let minutesComplete: String
            switch minutes1 {
            case 0,1,2,3,4,5,6,7,8,9:
                minutesComplete = "0"+String(minutes1)
            default:
                minutesComplete = String(minutes1)
            }
            timeStackLbl[0].text = "\(hour1):\(minutesComplete)"
            timeStackLbl[0].alpha = 1
            UIView.animate(withDuration: 0.3) {
                self.circleFillCollection[0].tintColor = self.grisEnc
                self.enviadoStackLbl[0].textColor = self.doradoEnc
                self.circleEmptyCollection[0].image = self.check
                
            }
            
            let hour = calendar.component(.hour, from: date)
            let minutes = calendar.component(.minute, from: date)
            timeStackLbl[0].text = "\(hour):\(minutes)"
            timeStackLbl[0].alpha = 1
            enviadoStackLbl[2].text = "Llamada realizada"
            enviadoStackLbl[2].alpha = 1
            
            let alertyes = AlertYesNo.showAlertYesNo(titulo: "Confirmar", mensaje: "Se realizará el servicio", type: "SERVICE")
            alertyes.transitioningDelegate = self
            present(alertyes, animated: true, completion: nil)
            
        case "LOOKING_FOR_ASSISTANCE":
            
            self.btnCancel.alpha = 0
            self.btnAccept.alpha = 0
            let date = Date()
            let calendar = Calendar.current
            enviadoStackLbl[1].text = "Aceptado"
            let hour1 = calendar.component(.hour, from: date)
            let minutes1 = calendar.component(.minute, from: date)
            let minutesComplete: String
            switch minutes1 {
            case 0,1,2,3,4,5,6,7,8,9:
                minutesComplete = "0"+String(minutes1)
            default:
                minutesComplete = String(minutes1)
            }
            timeStackLbl[0].text = "\(hour1):\(minutesComplete)"
            timeStackLbl[0].alpha = 1
            UIView.animate(withDuration: 0.3) {
                self.circleFillCollection[0].tintColor = self.grisEnc
                self.enviadoStackLbl[0].textColor = self.doradoEnc
                self.circleEmptyCollection[0].image = self.check
            }
            
            let hour = calendar.component(.hour, from: date)
            let minutes = calendar.component(.minute, from: date)
            timeStackLbl[0].text = "\(hour):\(minutes)"
            timeStackLbl[0].alpha = 1
            enviadoStackLbl[2].text = "Llamada realizada"
            enviadoStackLbl[2].alpha = 1
            
            UIView.animate(withDuration: 0.3) {
                self.circleEmptyCollection[0].image = self.check
                self.circleFillCollection[1].tintColor = self.doradoEnc
            }
            let alert = AlertDatosPriest.showAlertPriest(titulo: "Ingresar datos")
            alert.transitioningDelegate = self
            present(alert, animated: true, completion: nil)
            
        case "HELP_ON_THE_WAY":
            
            self.btnCancel.alpha = 0
            self.btnAccept.alpha = 0
            let date = Date()
            let calendar = Calendar.current
            enviadoStackLbl[1].text = "Aceptado"
            let hour1 = calendar.component(.hour, from: date)
            let minutes1 = calendar.component(.minute, from: date)
            let minutesComplete: String
            switch minutes1 {
            case 0,1,2,3,4,5,6,7,8,9:
                minutesComplete = "0"+String(minutes1)
            default:
                minutesComplete = String(minutes1)
            }
            timeStackLbl[0].text = "\(hour1):\(minutesComplete)"
            timeStackLbl[0].alpha = 1
            UIView.animate(withDuration: 0.3) {
                self.circleFillCollection[0].tintColor = self.grisEnc
                self.enviadoStackLbl[0].textColor = self.doradoEnc
                self.circleEmptyCollection[0].image = self.check
            }
            
            let hour2 = calendar.component(.hour, from: date)
            let minutes2 = calendar.component(.minute, from: date)
            timeStackLbl[0].text = "\(hour2):\(minutes2)"
            timeStackLbl[0].alpha = 1
            enviadoStackLbl[2].text = "Llamada realizada"
            enviadoStackLbl[2].alpha = 1
            
            
            let hour = calendar.component(.hour, from: date)
            let minutes = calendar.component(.minute, from: date)
            
            timeStackLbl[1].text = "\(hour):\(minutes)"
            timeStackLbl[1].alpha = 1
            UIView.animate(withDuration: 0.3) {
                self.progresoStackLbl[0].textColor = self.doradoEnc
                self.circleEmptyCollection[1].image = self.check
                self.progresoStackLbl[1].alpha = 1
            }
            progresoStackLbl[1].text = "Ayuda en camino"
            let alertFinish = AlertYesNo.showAlertYesNo(titulo: "Confirmar", mensaje: "Se realizó con éxito el servicio", type: "SERVICEFINISH")
            alertFinish.transitioningDelegate = self
            present(alertFinish, animated: true, completion: nil)
            
        default:
                        
            let date = Date()
            let calendar = Calendar.current
            enviadoStackLbl[1].text = "Aceptado"
            let hour1 = calendar.component(.hour, from: date)
            let minutes1 = calendar.component(.minute, from: date)
            let minutesComplete: String
            switch minutes1 {
            case 0,1,2,3,4,5,6,7,8,9:
                minutesComplete = "0"+String(minutes1)
            default:
                minutesComplete = String(minutes1)
            }
            timeStackLbl[0].text = "\(hour1):\(minutesComplete)"
            timeStackLbl[0].alpha = 1
            UIView.animate(withDuration: 0.3) {
                self.circleFillCollection[0].tintColor = self.grisEnc
                self.enviadoStackLbl[0].textColor = self.doradoEnc
                
            }
            
            let hour2 = calendar.component(.hour, from: date)
            let minutes2 = calendar.component(.minute, from: date)
            timeStackLbl[0].text = "\(hour2):\(minutes2)"
            timeStackLbl[0].alpha = 1
            enviadoStackLbl[2].text = "Llamada realizada"
            
            
            let hour = calendar.component(.hour, from: date)
            let minutes = calendar.component(.minute, from: date)
            timeStackLbl[1].text = "\(hour):\(minutes)"
            timeStackLbl[1].alpha = 1
            UIView.animate(withDuration: 0.3) {
                self.progresoStackLbl[0].textColor = self.doradoEnc
                self.circleEmptyCollection[1].image = self.check
            }
            progresoStackLbl[1].text = "Ayuda en camino"
            
            print("fe")
           
            let hour3 = calendar.component(.hour, from: date)
            let minutes3 = calendar.component(.minute, from: date)
            timeStackLbl[1].text = "\(hour3):\(minutes3)"
            timeStackLbl[1].alpha = 1
            timeStackLbl[2].alpha = 0
            UIView.animate(withDuration: 0.2) {
                self.progresoStackLbl.forEach { (lbl) in
                    lbl.alpha = 0
                }
                self.circleFillCollection[1].tintColor = self.doradoEnc
                self.circleFillCollection[2].alpha = 0
                self.circleEmptyCollection[2].alpha = 0
                self.blueLinesCollection[1].alpha = 0
                self.lblcancelado.text = "Cancelado"
                self.lblcancelado.alpha = 1
              //  self.btnCancelarServ.alpha = 0
                self.finalizadoStackLbl[0].alpha = 0
                
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                self.navigationController?.popToRootViewController(animated: true)
            }
            
        }
    }
    
// MARK: SERVICES GET DATA-
    func loadSuccessRequest(data: DetailContact) {
        
        print("CACHA EL STATUS:", data.status)
        fistStackLbl[1].text = data.devotee?.name
        if data.location?.distance != nil {
            let distance = (data.location?.distance!)! / 1000
            fistStackLbl[2].text = "\(distance) km"
        }
        
        print("Esta es la direccion: \(data.address?.description ?? "Unspecified")")
        fistStackLbl[4].text = data.address?.description
        fistStackLbl[6].text = data.devotee?.phone
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            self.alertLoader.dismiss(animated: true, completion: nil)
            self.lblMainTitle.text = data.service?.name
            self.setupStatusData(status: data.progress_history?.last?.sub_status ?? "nil")
            UIView.animate(withDuration: 0.2) {
                self.cardView.alpha = 1
            }
        })

    }
    
    func failRequest() {
        
    }
    
// MARK: - PATCH SERVICES RESPONSES
        
    func succesUpdateStatusPatch(status: String, flowID: Int) {
        
        switch  flowID {
        case 0:
            print("hola")
            if status == "REJECTED" {
                UIView.animate(withDuration: 0.3) {
                    self.circleFillCollection[0].tintColor = UIColor.init(red: 213/244, green: 214/255, blue: 204/255, alpha: 1)
                    self.circleFillCollection[1].tintColor = self.doradoEnc
                    self.progresoStackLbl[0].alpha = 0
                    self.finalizadoStackLbl[0].alpha = 0
                    self.blueLinesCollection[1].alpha = 0
                    self.circleEmptyCollection[2].alpha = 0
                    self.circleFillCollection[2].alpha = 0
                    self.timeStackLbl[2].alpha = 0
                    self.lblcancelado.alpha = 1
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                    self.navigationController?.popViewController(animated: true)
                })
            }else{
                
                let date = Date()
                let calendar = Calendar.current
                let hour = calendar.component(.hour, from: date)
                let minutes = calendar.component(.minute, from: date)
                
                enviadoStackLbl[1].text = "Aceptado"
                timeStackLbl[0].text = "\(hour):\(minutes)"
                timeStackLbl[0].alpha = 1
                let alertYesNo = AlertYesNo.showAlertYesNo(titulo: "Realizar llamada", mensaje: "Comunicate con el solicitante \n ¿Se realizó la llamada con éxito?", type: "CALL")
                alertYesNo.transitioningDelegate = self
                present(alertYesNo, animated: true, completion: nil)
            }
            
        case 1:
            enviadoStackLbl[2].text = "Llamada realizada"
            let date = Date()
            let calendar = Calendar.current
            let hour = calendar.component(.hour, from: date)
            let minutes = calendar.component(.minute, from: date)
            
            timeStackLbl[0].text = "\(hour):\(minutes)"
            timeStackLbl[0].alpha = 1
            enviadoStackLbl[2].alpha = 1
            let alertyes = AlertYesNo.showAlertYesNo(titulo: "Confirmar", mensaje: "Se realizará el servicio", type: "SERVICE")
            alertyes.transitioningDelegate = self
            present(alertyes, animated: true, completion: nil)
            
        case 2:
            enviadoStackLbl[3].text = "Buscando ayuda"
            enviadoStackLbl[3].alpha = 1
            UIView.animate(withDuration: 0.5) {
                self.enviadoStackLbl[0].textColor = self.doradoEnc
                self.circleEmptyCollection[0].image = self.check
                self.circleFillCollection[1].tintColor = self.doradoEnc
            }
            let alert = AlertDatosPriest.showAlertPriest(titulo: "Ingresar datos")
            alert.transitioningDelegate = self
            present(alert, animated: true, completion: nil)
            
        case 3:
            progresoStackLbl[1].text = "Ayuda en camino"
            let date = Date()
            let calendar = Calendar.current
            let hour = calendar.component(.hour, from: date)
            let minutes = calendar.component(.minute, from: date)
            
            timeStackLbl[1].text = "\(hour):\(minutes)"
            timeStackLbl[1].alpha = 1
            progresoStackLbl[1].alpha = 1
            UIView.animate(withDuration: 0.5) {
                self.progresoStackLbl[0].textColor = self.doradoEnc
                self.circleEmptyCollection[1].image = self.check
            }
            let alertFinish = AlertYesNo.showAlertYesNo(titulo: "Confirmar", mensaje: "Se realizó con éxito el servicio", type: "SERVICEFINISH")
            alertFinish.transitioningDelegate = self
            present(alertFinish, animated: true, completion: nil)
            
        case 4:
            UIView.animate(withDuration: 0.5) {
                self.circleFillCollection[2].tintColor = self.doradoEnc
            }
            finalizadoStackLbl[1].text = "Con éxito"
            let date = Date()
            let calendar = Calendar.current
            let hour = calendar.component(.hour, from: date)
            let minutes = calendar.component(.minute, from: date)
            
            timeStackLbl[2].text = "\(hour):\(minutes)"
            timeStackLbl[2].alpha = 1
            finalizadoStackLbl[1].alpha = 1
                    
        default:
            print("default el flujo cancelado")
            let date = Date()
            let calendar = Calendar.current
            let hour = calendar.component(.hour, from: date)
            let minutes = calendar.component(.minute, from: date)
            
            timeStackLbl[1].text = "\(hour):\(minutes)"
            timeStackLbl[1].alpha = 1
            UIView.animate(withDuration: 0.3) {
                self.circleFillCollection[0].tintColor = UIColor.init(red: 213/244, green: 214/255, blue: 204/255, alpha: 1)
                self.circleFillCollection[1].tintColor = self.doradoEnc
                self.progresoStackLbl[0].alpha = 0
                self.progresoStackLbl[1].alpha = 0
                self.blueLinesCollection[1].alpha = 0
                self.circleEmptyCollection[2].alpha = 0
                self.circleFillCollection[2].alpha = 0
                self.finalizadoStackLbl[0].alpha = 0
                self.finalizadoStackLbl[1].alpha = 0
                self.timeStackLbl[2].alpha = 0
                
                self.lblcancelado.alpha = 1
            }
        }
    }
    
    func failUpdateStatusPatch() {
        print("Error en el patch")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            let alertAceptar = AcceptAlert.showAlert(titulo: "Aviso", mensaje: "Por el momento no es posible realizar esta operación, intentelo más tarde")
            self.present(alertAceptar, animated: true, completion: nil)
        }
    }
    
    func succesUpdateHour() {
       // presenter?.updateStatusService(status: "HELP_ON_THE_WAY", flowID: 3)
        progresoStackLbl[1].text = "Ayuda en camino"
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        
        timeStackLbl[1].text = "\(hour):\(minutes)"
        timeStackLbl[1].alpha = 1
        progresoStackLbl[1].alpha = 1
        UIView.animate(withDuration: 0.5) {
            self.progresoStackLbl[0].textColor = self.doradoEnc
            self.circleEmptyCollection[1].image = self.check
        }
        let alertFinish = AlertYesNo.showAlertYesNo(titulo: "Confirmar", mensaje: "Se realizó con éxito el servicio", type: "SERVICEFINISH")
        alertFinish.transitioningDelegate = self
        present(alertFinish, animated: true, completion: nil)
    }
    
    func failUpdateHour() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            let alert = AlertDatosPriest.showAlertPriest(titulo: "Ingresar datos")
            alert.transitioningDelegate = self
            self.present(alert, animated: true, completion: nil)
        })
    }
    
// MARK: GENERAL FUNCS -
    func dialNumber(number : String) {

     if let url = URL(string: "tel://\(number)"),
       UIApplication.shared.canOpenURL(url) {
          if #available(iOS 10, *) {
            UIApplication.shared.open(url, options: [:], completionHandler:nil)
           } else {
               UIApplication.shared.openURL(url)
           }
       } else {
                // add error message here
       }
    }
    
// MARK: @OBJC FUNCS -
    @objc func handleTapBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func handleTapPhone() {
        print("Tap en el phone img")
        dialNumber(number: fistStackLbl[6].text ?? "0")
    }
    
// MARK: @IBATCIONS -
    @IBAction func accpetAction(_ sender: Any) {
        presenter?.updateStatusService(status: "ACCEPTED", flowID: 0)
        UIView.animate(withDuration: 0.4) {
            self.btnAccept.alpha = 0
            self.btnCancel.alpha = 0
        }
 
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        presenter?.updateStatusService(status: "REJECTED", flowID: 0)
        UIView.animate(withDuration: 0.4) {
            self.btnAccept.alpha = 0
            self.btnCancel.alpha = 0
        }
    }
    
    
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = true
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = false
        print("Hola")
        
        let singleton = AlertYesNo.singleton
        switch singleton.typeAlert {
        case "CALL":
            print("CALL")
            presenter?.updateStatusService(status: "CALL_FINISHED", flowID: 1)
            
        case "SERVICE":
            print("SERVICE SOS")
            presenter?.updateStatusService(status: "LOOKING_FOR_ASSISTANCE", flowID: 2)
            
        case "NO":
            print("EL USER DIJO QUE NO EN EL ALERT")
            presenter?.updateStatusService(status: "CANCELLED", flowID: 5)
            
        case "PRIEST":
            print("PRIEST")
            let singleton = AlertDatosPriest.singleton
            print(singleton.completeDateSent)
            presenter?.updateHour(dateStr: singleton.completeDateSent, nameID: singleton.sendIdPriest)
            
        case "SERVICEFINISH":
            print("FINISH")
            presenter?.updateStatusService(status: "SUCCESSFULLY", flowID: 4)
            
        case "NOFINISHSERVICE":
            print("NO FINISH")
            presenter?.updateStatusService(status: "UNSUCCESSFULLY", flowID: 5)
            
        default:
            print("Deafult")
        }
      
        return transition
    }
    
}
