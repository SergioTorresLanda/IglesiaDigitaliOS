//
//  AcceptAlertLogin.swift
//  EncuentroCatolicoVirtualLibrary
//
//  Created by Sergio Torres Landa González on 25/05/23.
//

import UIKit

protocol PushViewControllerDelegate2: AnyObject {
    func pushViewController(vc: UIViewController)
}

open class AcceptAlertLogin: UIViewController {

    @IBOutlet weak var shadowCard: UIView!
    @IBOutlet weak var alertCard: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblText: UILabel!
    @IBOutlet weak var btnAccept: UIButton!
    
    @IBOutlet weak var btnNo: UIButton!
    // MARK:  COMPONENTS PICKERS DATE & TIME -
        
    var titulo: String?
    var mensaje: String?
    var type = ""
    weak var delegate: PushViewControllerDelegate?
    
    static let singleton = AcceptAlertLogin()
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        setupGestures()
        lblTitle.text = titulo
        lblText.text = mensaje
        lblText.adjustsFontSizeToFitWidth = true
        self.view.backgroundColor = .clear
        alertCard.layer.cornerRadius = 12
        btnAccept.layer.cornerRadius = 8
        btnNo.layer.cornerRadius = 8

        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { (timer) in
            UIView.animate(withDuration: 0.2) {
                self.shadowCard.alpha = 0.25
            }
        }
    }
    
    func setupGestures() {
       let tapShadowGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapShadow))
       self.shadowCard.addGestureRecognizer(tapShadowGesture)
   }
   
   @objc func handleTapShadow() {
       self.dismiss(animated: true, completion: nil)
   }
    
    @IBAction func AcceptAction(_ sender: Any) {
        shadowCard.alpha = 0
        UserDefaults.standard.setValue(true, forKey: "wantToLogin")
        self.dismiss(animated: true) {
            NotificationCenter.default.post(name: Notification.Name("poptoroot"), object: nil)
        }
    }
    
    @IBAction func noClick(_ sender: Any) {
        shadowCard.alpha = 0
        self.dismiss(animated: true) {
        }
    }
    
    //MARK: - Inicialización
    class public func showAlert(titulo: String, mensaje: String) -> AcceptAlertLogin {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle(for: AcceptAlertLogin.self))
        let view = storyboard.instantiateViewController(withIdentifier: "AcceptAlertLogin") as! AcceptAlertLogin
        view.modalPresentationStyle = .overFullScreen
        view.titulo = titulo
        view.mensaje = mensaje
        
        return view
    }

}
