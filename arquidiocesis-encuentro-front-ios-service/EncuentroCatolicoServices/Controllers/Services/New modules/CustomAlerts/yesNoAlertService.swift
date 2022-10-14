//
//  yesNoAlertService.swift
//  EncuentroCatolicoServices
//
//  Created by Pablo Luis Velazquez Zamudio on 28/07/21.
//

import UIKit

open class yesNoAlertService: UIViewController {

// MARK: GLOBAL VAR -
    var titulo: String?
    
// MARK: @IBOUTELTS -
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var lblTextAlert: UILabel!
    @IBOutlet weak var btnNo: UIButton!
    @IBOutlet weak var btnSi: UIButton!
    @IBOutlet weak var encuentroLogo: UIImageView!

// MARK: LIFE CYCLE FUNCS -
    open override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { (timer) in
            UIView.animate(withDuration: 0.2) {
                self.shadowView.alpha = 0.25
            }
        }

    }
    
// MARK: SETUP FUNCS -
    func setupUI() {
        lblTextAlert.text = titulo
        cardView.layer.cornerRadius = 12
        btnNo.layer.cornerRadius = 8
        btnSi.layer.cornerRadius = 8
        
    }
    
// MARK: INICIALIZACIÓN -
    class public func showAlertYes(textAlert: String) -> yesNoAlertService {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle(for: yesNoAlertService.self))
        let view = storyboard.instantiateViewController(withIdentifier: "ALERTYESNOS") as! yesNoAlertService
        view.modalPresentationStyle = .overFullScreen
        
        view.titulo = textAlert
        
        return view
    }
    
// MARK: @IBACTIONS -
    @IBAction func noAction(_ sender: Any) {
        let singleton = NewDetailServiceView.singleton
        singleton.isCloseService = false
        UIView.animate(withDuration: 0.1) {
            self.shadowView.alpha = 0
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func siAction(_ sender: Any) {
        let singleton = NewDetailServiceView.singleton
        singleton.isCloseService = true
        UIView.animate(withDuration: 0.1) {
            self.shadowView.alpha = 0
        }
        self.dismiss(animated: true, completion: nil)
    }

}
