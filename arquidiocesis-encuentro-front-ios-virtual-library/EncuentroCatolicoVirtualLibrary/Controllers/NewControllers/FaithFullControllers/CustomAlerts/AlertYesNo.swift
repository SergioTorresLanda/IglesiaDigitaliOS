//
//  AlertYesNo.swift
//  EncuentroCatolicoVirtualLibrary
//
//  Created by Pablo Luis Velazquez Zamudio on 30/06/21.
//

import UIKit

open class AlertYesNo: UIViewController {    
    var titulo: String?
    var mensaje: String?
    var typeAlert = ""
    static let singleton = AlertYesNo()
    
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var lblTitleAlert: UILabel!
    @IBOutlet weak var lblTextAlert: UILabel!
    @IBOutlet weak var btnYes: UIButton!
    @IBOutlet weak var btnNo: UIButton!
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        alertView.layer.cornerRadius = 12
        btnYes.layer.cornerRadius = 8
        btnNo.roundedNborder(borderColor: UIColor.init(red: 25/255, green: 42/255, blue: 115/255, alpha: 1))
        btnNo.layer.cornerRadius = 8
        lblTitleAlert.text = titulo
        lblTextAlert.text = mensaje
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { (timer) in
            UIView.animate(withDuration: 0.2) {
                self.shadowView.alpha = 0.25
            }
        }

    }

    class public func showAlertYesNo(titulo: String, mensaje: String, type: String) -> AlertYesNo {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle(for: AlertYesNo.self))
        let view = storyboard.instantiateViewController(withIdentifier: "AlertYesNo") as! AlertYesNo
        view.modalPresentationStyle = .overFullScreen
        view.titulo = titulo
        view.mensaje = mensaje
        view.typeAlert = type
        
        return view
    }

    @IBAction func yesAction(_ sender: Any) {
        
        let singleton = AlertYesNo.singleton
        singleton.typeAlert = typeAlert
        
        UIView.animate(withDuration: 0.1) {
            self.shadowView.alpha = 0
        }
        self.dismiss(animated: true, completion: nil)
        
        
        
    }
    
    @IBAction func noAction(_ sender: Any) {
        
        switch typeAlert {
            
        case "SERVICEFINISH":
            print(typeAlert)
            let singleton = AlertYesNo.singleton
            singleton.typeAlert = "NOFINISHSERVICE"
            
        default:
            print("default")
            print(typeAlert)
            let singleton = AlertYesNo.singleton
            singleton.typeAlert = "NO"
        }
       
        
        UIView.animate(withDuration: 0.1) {
            self.shadowView.alpha = 0
        }
        self.dismiss(animated: true, completion: nil)
    }
    
}
