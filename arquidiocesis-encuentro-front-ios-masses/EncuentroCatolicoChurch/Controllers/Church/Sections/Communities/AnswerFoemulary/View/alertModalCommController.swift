//
//  alertModalCommController.swift
//  EncuentroCatolicoChurch
//
//  Created by Pablo Luis Velazquez Zamudio on 19/11/21.
//

import UIKit

class alertModalCommController: UIViewController {
    
// MARK: @IBOUTLETS -
    @IBOutlet weak var shadowBackground: UIView!
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var lblTextAlert: UILabel!
    @IBOutlet weak var btnAccept: UIButton!
    
    var textAlert = ""
    
// MARK: LIFE CYCLE VIEW FUNCTIONS -
    override func viewDidLoad() {
        super.viewDidLoad()
           setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("VC ECChurch - Communities - alertModalCommC ")
    }
    
// MARK: SETUP FUNCTIONS -
    private func setupUI() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            UIView.animate(withDuration: 0.3) {
                self.shadowBackground.alpha = 0.6
            }
        }
        lblTextAlert.text = textAlert
        btnAccept.layer.cornerRadius = 8
        alertView.layer.cornerRadius = 10
    }

// MARK: @IBACTIONS -
    @IBAction func acceptAction(_ sender: Any) {
        shadowBackground.alpha = 0
        self.dismiss(animated: true, completion: nil)
    }

//MARK: - Inicialización
    class public func showAlert(textAlert: String) -> alertModalCommController {
        let storyboard = UIStoryboard(name: "AnswerFoemularyStoryboard", bundle: Bundle(for: alertModalCommController.self))
        let view = storyboard.instantiateViewController(withIdentifier: "ALERTMODAL") as! alertModalCommController
        view.modalPresentationStyle = .overFullScreen
        view.textAlert = textAlert
        
        return view
    }
    
}
