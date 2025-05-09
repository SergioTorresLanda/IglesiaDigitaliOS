//
//  ProfileUserInfoViewController.swift
//  EncuentroCatolicoProfile
//
//  Created Desarrollo on 07/04/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

protocol ProtocolProfileUserInfoX: NSObjectProtocol {
    func closeAction()
}
class ProfileUserInfoViewController: UIViewController, ProfileUserInfoViewProtocol {
    var presenter: ProfileUserInfoPresenterProtocol?

    weak var delegteClose: ProtocolProfileUserInfoX?
    @IBOutlet var btnClose: UIButton!
    @IBOutlet var imgView: UIImageView!
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var txtService: UITextField!
    @IBOutlet var txtDescription: UITextField!
    @IBOutlet var bottomStack: UIView!

    
    var viewStyle: viewMode?
    var options: [ProvidedService] = []

    override func viewDidLoad() {
        super.viewDidLoad()
       
        setViewMode(mode: viewStyle)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("VC ECProfile - ProfileServices - ProfileUserInfoVC ")

    }

    func setViewMode(mode: viewMode?) {
        if mode == .diacono {
            bottomStack.isHidden = true
        } else {
            txtService.delegate = self
            presenter?.getProvidedServices()
            bottomStack.isHidden = false
        }
    }

//    func loadCatalog(data: ProvidedServices) {
//        for element in data.data {
//            options.append(element)
//        }
//    }

    func showCatalogActionSheet() {
        let actionSheet = UIAlertController(title: "Servicios", message: "¿Qué servicio prestas a la iglesia?", preferredStyle: .actionSheet)
        for element in options {
            actionSheet.addAction(UIAlertAction(title: element.name, style: .default, handler: { [self] _ in
                txtService.tag = element.id
                txtService.text = element.name
            }))
        }
        actionSheet.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
        present(actionSheet, animated: true, completion: nil)
    }

    @IBAction func close(_ sender: Any) {
        self.view.isHidden = true
        delegteClose?.closeAction()
//        self.dismiss(animated: false, completion: nil)
    }

    
   
    func mostrarMSG(dtcAlerta: [String: String]) {
        let alerta = UIAlertController(title: dtcAlerta["titulo"], message: dtcAlerta["cuerpo"], preferredStyle: .alert)
        alerta.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: nil))
        present(alerta, animated: true, completion: nil)
    }
}

extension ProfileUserInfoViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        view.endEditing(true)
        showCatalogActionSheet()
    }
}
