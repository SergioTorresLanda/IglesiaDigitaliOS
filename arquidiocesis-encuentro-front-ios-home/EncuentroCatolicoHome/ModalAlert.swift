//
//  ModalAlert.swift
//  EncuentroCatolicoHome
//
//  Created by Pablo Luis Velazquez Zamudio on 19/10/21.
//

import UIKit

open class ModalAlert: UIViewController {
    
    var titleAlert = ""
    var message = ""
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var btnCancelar: UIButton!
    @IBOutlet weak var btnAccept: UIButton!
    

    open override func viewDidLoad() {
        super.viewDidLoad()
        lblTitle.text = titleAlert
        lblMessage.text = message

    }

//MARK: - Inicialización
    class public func showModalAlert(title: String, message: String) -> ModalAlert {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle(for: ModalPrayController.self))
        let view = storyboard.instantiateViewController(withIdentifier: "MODALALERT") as! ModalAlert
        view.modalPresentationStyle = .overFullScreen
        view.titleAlert = title
        view.message = message
        
        return view
    }
    
    @IBAction func cancelAction(_ sender: Any) {
    }
    
    @IBAction func acceptAction(_ sender: Any) {
    }
    
}
