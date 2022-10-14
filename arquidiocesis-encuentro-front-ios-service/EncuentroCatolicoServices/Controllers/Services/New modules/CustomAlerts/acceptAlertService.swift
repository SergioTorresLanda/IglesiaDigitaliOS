//
//  acceptAlertService.swift
//  EncuentroCatolicoServices
//
//  Created by Pablo Luis Velazquez Zamudio on 28/07/21.
//

import UIKit

open class acceptAlertService: UIViewController {
    
    var titulo: String?
    
    // MARK: @IBOUTLETS -
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var lblTextAlert: UILabel!
    @IBOutlet weak var btnAccept: UIButton!
    @IBOutlet weak var encuentroIcon: UIImageView!
    
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
        btnAccept.layer.cornerRadius = 8
    }
    
// MARK: INICIALIZACIÓN -
    class public func showAlert(textAlert: String) -> acceptAlertService {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle(for: acceptAlertService.self))
        let view = storyboard.instantiateViewController(withIdentifier: "ALERTACCEPTS") as! acceptAlertService
        view.modalPresentationStyle = .overFullScreen
        
        view.titulo = textAlert
        
        return view
    }
    
// MARK: @IBACTIONS -
    @IBAction func acceptActions(_ sender: Any) {
        UIView.animate(withDuration: 0.1) {
            self.shadowView.alpha = 0
        }
        
        self.dismiss(animated: true, completion: nil    )
    }
    
}

