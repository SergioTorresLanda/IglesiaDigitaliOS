//
//  AcceptAlertDonations.swift
//  EncuentroCatolicoServices
//
//  Created by llavin on 14/12/22.
//

import UIKit

protocol accpetAlertActionDelegate: AnyObject {
    func didPressAcccept()
}

open class AcceptAlertDonations: UIViewController {
    
// MARK: LOCAL VAR -
    var title1 = ""
    var message = ""
    var btnTitleStr = ""
    var delegate: accpetAlertActionDelegate?
    
// MARK: @IBOUTLET -
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var btnAccept: UIButton!
    
// MARK: LIFE CYCLE VIEW FUNCTIONS -
    open override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

    }
    
// MARK: SETUP FUNCTIONS -
    private func setupUI() {
        lblTitle.text = title1
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
    class public func showAlert(title: String, message: String, btnTitle: String) -> AcceptAlertDonations {
        let storyboard = UIStoryboard(name: "ScheduleMassTimeViewController", bundle: Bundle(for: AcceptAlertDonations.self))
        let view = storyboard.instantiateViewController(withIdentifier: "AcceptAlert") as! AcceptAlertDonations
        view.modalPresentationStyle = .overFullScreen
        view.title1 = title
        view.message = message
        view.btnTitleStr = btnTitle
        
        return view
    }

}
