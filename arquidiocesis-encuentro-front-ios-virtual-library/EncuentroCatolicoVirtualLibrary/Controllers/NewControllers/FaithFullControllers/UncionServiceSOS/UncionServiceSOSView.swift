//
//  UncionServiceSOSView.swift
//  EncuentroCatolicoVirtualLibrary
//
//  Created by Pablo Luis Velazquez Zamudio on 16/06/21.
//

import UIKit

class UncionServiceSOSView: UIViewController, UncionServiceViewProtocol {
    
    var presenter: UncionServicePresenterProtocol?
    var requestTimer : Timer?
    var alert = RateAlertController.showAlertRate(serviceID: 0)
    var doradoEnc = UIColor.init(red: 189/255, green: 169/255, blue: 120/255, alpha: 1)
    var grisEnc = UIColor.init(red: 213/255, green: 212/255, blue: 204/255, alpha: 1)
    let alertLoader = UIAlertController(title: "", message: "\n \n \n \n \nCargando...", preferredStyle: .alert)
    let defaults = UserDefaults.standard
    var timesRun = 0
    var check = UIImage(named: "Trazado 6704", in: Bundle.local, compatibleWith: nil)
        
    @IBOutlet weak var contentNavBar: UIView!
    @IBOutlet weak var customNavBar: UIView!
    @IBOutlet weak var mainTitle: UILabel!
    @IBOutlet weak var backIcon: UIImageView!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var btnCancelarServ: UIButton!
    @IBOutlet var fillCircleIcons: [UIImageView]!
    @IBOutlet var lblTimeCollection: [UILabel]!
    @IBOutlet var emptyCirclesCollection: [UIImageView]!
    @IBOutlet var lineasCollection: [UIView]!
    @IBOutlet weak var lblCancelado: UILabel!
    @IBOutlet weak var lblContactName: UILabel!
    @IBOutlet weak var lblTimeCreated: UILabel!
    @IBOutlet var fiirstStackStatus: [UILabel]!
    @IBOutlet var secondStackStatus: [UILabel]!
    @IBOutlet var thirdStackStatus: [UILabel]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showLoading()
        validateActiveService()
        customNavBar.ShadowNavBar()
        mainTitle.adjustsFontSizeToFitWidth = true
        cardView.layer.cornerRadius = 10
        customNavBar.layer.cornerRadius = 20
        btnCancelarServ.layer.cornerRadius = 7
        let colorBorde = UIColor.blue
        btnCancelarServ.layer.borderWidth = 2
        btnCancelarServ.clipsToBounds = true
        btnCancelarServ.layer.borderColor = colorBorde.cgColor
        btnCancelarServ.backgroundColor = .white
        btnCancelarServ.setTitleColor(UIColor.blue, for: .normal)
        let tapBackIcon = UITapGestureRecognizer(target: self, action: #selector(handleTapBack))
        backIcon.addGestureRecognizer(tapBackIcon)
        lblTimeCollection.forEach { (lbl) in
            lbl.alpha = 0
        }
        cardView.ShadowCard()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("ECVirualLibrary - NewControllers - FaithFull - UncionServiceSOS")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.navigationController?.popToRootViewController(animated: true)
        print("bye")
    }
    
    func showLoading() {
        let imageView = UIImageView(frame: CGRect(x: 75, y: 25, width: 140, height: 60))
        imageView.image = UIImage(named: "logoEncuentro", in: Bundle.local, compatibleWith: nil)
        alertLoader.view.addSubview(imageView)
        self.present(alertLoader, animated: false, completion: nil)
    }
    
    func stopTimer() {
        print("Entro el stop timer")
        requestTimer?.invalidate()
        requestTimer = nil
    }
    
    @objc func reloadDetails() {
        timesRun += 1
        print("reload el service")
        let singleton = UncionSOSView.singleton
        presenter?.requestDetailService(serviceID: singleton.newServiceID)
    }
    
    private func bordeColorBtn(sender: UIButton) {
        let colorBorde = UIColor.white//(red: 66/255, green: 66/255, blue: 66/255, alpha: 1)
        sender.layer.borderWidth = 2
        sender.layer.borderColor = colorBorde.cgColor
        sender.backgroundColor = .lightGray
        sender.setTitleColor(.darkGray, for: .normal)
    }
    
    private func validateActiveService() {
       // let SOSId = defaults.integer(forKey: "SOSId")
        let singleton = UncionSOSView.singleton
        print(singleton.newServiceID)
        alert = RateAlertController.showAlertRate(serviceID: singleton.newServiceID)
        presenter?.requestDetailService(serviceID: singleton.newServiceID)
//        if SOSId == 0 {
//            alert = RateAlertController.showAlertRate(serviceID: singleton.newServiceID)
//            presenter?.requestDetailService(serviceID: singleton.newServiceID)
//        }else {
//            alert = RateAlertController.showAlertRate(serviceID: SOSId)
//            presenter?.requestDetailService(serviceID: SOSId)
//        }
    }
    
    @objc func handleTapBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func setChanges() {
        
        UIView.animate(withDuration: 1) {
            self.fillCircleIcons[0].tintColor = .lightGray
           
            self.bordeColorBtn(sender: self.btnCancelarServ)
            
        }
        
        btnCancelarServ.isEnabled = false
        
    }
    
// MARK: FUNCS SERVICES RETRUN -
    func loadSuccessResponse(data: ServiceDetailFaithful) {
        print(data)
        defaults.setValue(data.id, forKey: "SOSId")
        
        if timesRun == 0 {
            mainTitle.text = data.service?.name
            lblContactName.text = data.support_contact?.name
            lblTimeCreated.text = "\(data.creation_date ?? "Unspecified") hrs"
            
            if data.progress_history?.last?.sub_status == "PENDING_CONFIRMATION" {
                fiirstStackStatus[1].text = "Por aceptar"
            }
            
           
            self.alertLoader.dismiss(animated: true, completion: nil)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                UIView.animate(withDuration: 0.3) {
                    self.cardView.alpha = 1
                }
            }
            
            requestTimer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(reloadDetails), userInfo: nil, repeats: true)
            
        }else{
            
            switch data.progress_history?.last?.sub_status {
            case "PENDING_CONFIRMATION":
                fiirstStackStatus[1].text = "Por aceptar"
                
            case "CALL_WAITING":
                let date = Date()
                let calendar = Calendar.current
                let minutesComplete: String
                btnCancelarServ.isEnabled = true
                fiirstStackStatus[1].text = "Aceptado"
                let hour = calendar.component(.hour, from: date)
                let minutes = calendar.component(.minute, from: date)
                switch minutes {
                case 0,1,2,3,4,5,6,7,8,9:
                    minutesComplete = "0"+String(minutes)
                default:
                    minutesComplete = String(minutes)
                }
                //lblTimeCollection[0].text = "\(date):\(hour):\(minutesComplete)"
                lblTimeCollection[0].text = "\(hour):\(minutesComplete)"
                lblTimeCollection[0].alpha = 1
                UIView.animate(withDuration: 0.3) {
                    self.fillCircleIcons[0].tintColor = self.grisEnc
                    self.fiirstStackStatus[0].textColor = self.doradoEnc
                    
                }
                
            case "CALL_FINISHED":
                let date = Date()
                let calendar = Calendar.current
                let hour = calendar.component(.hour, from: date)
                let minutes = calendar.component(.minute, from: date)
                let minutesComplete: String
                switch minutes {
                case 0,1,2,3,4,5,6,7,8,9:
                    minutesComplete = "0"+String(minutes)
                default:
                    minutesComplete = String(minutes)
                }
                print("\(hour) \(minutesComplete)")
                lblTimeCollection[0].text = "\(hour):\(minutesComplete)"
                lblTimeCollection[0].alpha = 1
                fiirstStackStatus[2].text = "Llamada realizada"
                btnCancelarServ.alpha = 0
               // btnCancelarServ.backgroundColor = UIColor(
                
            case "LOOKING_FOR_ASSISTANCE":
                UIView.animate(withDuration: 0.3) {
                    self.emptyCirclesCollection[0].image = self.check
                    self.fillCircleIcons[1].tintColor = self.doradoEnc
                }
                
                
            case "HELP_ON_THE_WAY":
                let date = Date()
                let calendar = Calendar.current
                let hour = calendar.component(.hour, from: date)
                let minutes = calendar.component(.minute, from: date)
                let minutesComplete: String
                switch minutes {
                case 0,1,2,3,4,5,6,7,8,9:
                    minutesComplete = "0"+String(minutes)
                default:
                    minutesComplete = String(minutes)
                }
                lblTimeCollection[1].text = "\(hour):\(minutesComplete)"
                lblTimeCollection[1].alpha = 1
                UIView.animate(withDuration: 0.3) {
                    self.secondStackStatus[0].textColor = self.doradoEnc
                    self.emptyCirclesCollection[1].image = self.check
                }
                secondStackStatus[1].text = "Ayuda en camino"
                
            case "SUCCESSFULLY":
                let date = Date()
                let calendar = Calendar.current
                let hour = calendar.component(.hour, from: date)
                let minutes = calendar.component(.minute, from: date)
                let minutesComplete: String
                switch minutes {
                case 0,1,2,3,4,5,6,7,8,9:
                    minutesComplete = "0"+String(minutes)
                default:
                    minutesComplete = String(minutes)
                }
                lblTimeCollection[2].text = "\(hour):\(minutesComplete)"
                lblTimeCollection[2].alpha = 1
                UIView.animate(withDuration: 0.3) {
                    self.fillCircleIcons[2].tintColor = self.doradoEnc
                    self.thirdStackStatus[0].textColor = self.doradoEnc
                    self.btnCancelarServ.alpha = 0
                }
               
                self.thirdStackStatus[1].text = "Con éxito"
                stopTimer()
                self.present(alert, animated: true, completion: nil)
//                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
//                    self.navigationController?.popToRootViewController(animated: true)
//                }
                
            case "UNSUCCESSFULLY":
                let date = Date()
                let calendar = Calendar.current
                let hour = calendar.component(.hour, from: date)
                let minutes = calendar.component(.minute, from: date)
                let minutesComplete: String
                switch minutes {
                case 0,1,2,3,4,5,6,7,8,9:
                    minutesComplete = "0"+String(minutes)
                default:
                    minutesComplete = String(minutes)
                }
                lblTimeCollection[2].text = "\(hour):\(minutesComplete)"
                lblTimeCollection[2].alpha = 1
                UIView.animate(withDuration: 0.3) {
                    self.fillCircleIcons[2].tintColor = self.doradoEnc
                   // self.thirdStackStatus[0].alpha = 0
                    self.btnCancelarServ.alpha = 0
                }
                
                self.thirdStackStatus[1].text = "No completado"
                stopTimer()
                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                    self.navigationController?.popToRootViewController(animated: true)
                }
                
            default:
                print("fe")
                let date = Date()
                let calendar = Calendar.current
                let hour = calendar.component(.hour, from: date)
                let minutes = calendar.component(.minute, from: date)
                let minutesComplete: String
                switch minutes {
                case 0,1,2,3,4,5,6,7,8,9:
                    minutesComplete = "0"+String(minutes)
                default:
                    minutesComplete = String(minutes)
                }
                lblTimeCollection[1].text = "\(hour):\(minutesComplete)"
                lblTimeCollection[1].alpha = 1
                lblTimeCollection[2].alpha = 0
                UIView.animate(withDuration: 0.2) {
                    self.secondStackStatus.forEach { (lbl) in
                        lbl.alpha = 0
                    }
                    self.fillCircleIcons[1].tintColor = self.doradoEnc
                    self.fillCircleIcons[2].alpha = 0
                    self.emptyCirclesCollection[2].alpha = 0
                    self.lineasCollection[1].alpha = 0
                    self.lblCancelado.text = "Cancelado"
                    self.lblCancelado.alpha = 1
                    self.btnCancelarServ.alpha = 0
                    self.thirdStackStatus[0].alpha = 0
                    
                }
                stopTimer()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                    self.navigationController?.popToRootViewController(animated: true)
                }
                
            }
            
        }
            
    }
    
    func failResponse() {
        self.alertLoader.dismiss(animated: true, completion: nil)
        print("Fallo el detail")
    }
    
    func cancelPatchSuccess() {
        UIView.animate(withDuration: 0.3) {
            
            let date = Date()
            let calendar = Calendar.current
            let hour = calendar.component(.hour, from: date)
            let minutes = calendar.component(.minute, from: date)
            let minutesComplete: String
            switch minutes {
            case 0,1,2,3,4,5,6,7,8,9:
                minutesComplete = "0"+String(minutes)
            default:
                minutesComplete = String(minutes)
            }
            self.lblTimeCollection[1].text = "\(hour):\(minutesComplete)"
            self.lblTimeCollection[1].alpha = 1
            self.lblTimeCollection[2].alpha = 0
            UIView.animate(withDuration: 0.2) {
                self.secondStackStatus.forEach { (lbl) in
                    lbl.alpha = 0
                }
                self.fillCircleIcons[1].tintColor = self.doradoEnc
                self.fillCircleIcons[2].alpha = 0
                self.emptyCirclesCollection[2].alpha = 0
                self.lineasCollection[1].alpha = 0
                self.lblCancelado.text = "Cancelado"
                self.lblCancelado.alpha = 1
                self.btnCancelarServ.alpha = 0
                self.thirdStackStatus[0].alpha = 0
                
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                self.navigationController?.popToRootViewController(animated: true)
            }
        }
    }
    
    func cancelPatchFail() {
        
    }

    @IBAction func btnCancelarAction(_ sender: Any) {
        stopTimer()
        print("Entro el patch cancelar")
        defaults.removeObject(forKey: "SOSId")
        let singleton = UncionSOSView.singleton
        self.presenter?.patchUpdateCancel(status: "REJECTED", flowID: 10, idService: singleton.newServiceID)
        
    }
    
}
