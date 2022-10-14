//
//  AcceptAlertDonations.swift
//  EncuentroCatolicoDonations
//
//  Created by Pablo Luis Velazquez Zamudio on 16/03/22.
//

import UIKit

protocol accpetAlertActionDelegate: AnyObject {
    func didPressAcccept()
}

open class AcceptAlertDonations: UIViewController {
    
// MARK: LOCAL VAR -
    var message = ""
    var btnTitleStr = ""
    var delegate: accpetAlertActionDelegate?
    
// MARK: @IBOUTLET -
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var btnAccept: UIButton!
    
// MARK: LIFE CYCLE VIEW FUNCTIONS -
    open override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

    }
    
// MARK: SETUP FUNCTIONS -
    private func setupUI() {
        lblMessage.text = message
        btnAccept.setTitle(btnTitleStr, for: .normal)
        alertView.layer.cornerRadius = 12
        btnAccept.layer.cornerRadius = 8
        Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { timer in
            UIView.animate(withDuration: 0.3) {
                self.shadowView.alpha = 0.6
            }
        }
       
    }
    
// MARK: @IBACCTIONS -
    @IBAction func acceptAction(_ sender: Any) {
        self.shadowView.alpha = 0
        delegate?.didPressAcccept()
        self.dismiss(animated: true, completion: nil)
    }
    
//MARK: - Inicialización
    class public func showAlert(message: String, btnTitle: String) -> AcceptAlertDonations {
        let storyboard = UIStoryboard(name: "NewDonations", bundle: Bundle(for: AcceptAlertDonations.self))
        let view = storyboard.instantiateViewController(withIdentifier: "AcceptAlert") as! AcceptAlertDonations
        view.modalPresentationStyle = .overFullScreen
        view.message = message
        view.btnTitleStr = btnTitle
        
        return view
    }

}
