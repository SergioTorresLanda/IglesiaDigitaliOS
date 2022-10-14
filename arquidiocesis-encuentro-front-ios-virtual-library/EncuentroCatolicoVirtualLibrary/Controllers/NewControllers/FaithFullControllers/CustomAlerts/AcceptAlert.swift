//
//  AcceptAlert.swift
//  EncuentroCatolicoVirtualLibrary
//
//  Created by Pablo Luis Velazquez Zamudio on 17/06/21.
//

import UIKit

protocol PushViewControllerDelegate: class {
    func pushViewController(vc: UIViewController)
}

open class AcceptAlert: UIViewController {

    @IBOutlet weak var shadowCard: UIView!
    @IBOutlet weak var alertCard: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblText: UILabel!
    @IBOutlet weak var btnAccept: UIButton!
    
// MARK:  COMPONENTS PICKERS DATE & TIME -
        
    var titulo: String?
    var mensaje: String?
    var type = ""
    weak var delegate: PushViewControllerDelegate?
    
    static let singleton = AcceptAlert()
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        setupGestures()
        lblTitle.text = titulo
        lblText.text = mensaje
        lblText.adjustsFontSizeToFitWidth = true
        self.view.backgroundColor = .clear
        alertCard.layer.cornerRadius = 12
        btnAccept.layer.cornerRadius = 8
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
        self.dismiss(animated: true) {
        }
                
    }
    
    //MARK: - Inicialización
    class public func showAlert(titulo: String, mensaje: String) -> AcceptAlert {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle(for: AcceptAlert.self))
        let view = storyboard.instantiateViewController(withIdentifier: "AcceptAlert") as! AcceptAlert
        view.modalPresentationStyle = .overFullScreen
        view.titulo = titulo
        view.mensaje = mensaje
        
        return view
    }

}

  

