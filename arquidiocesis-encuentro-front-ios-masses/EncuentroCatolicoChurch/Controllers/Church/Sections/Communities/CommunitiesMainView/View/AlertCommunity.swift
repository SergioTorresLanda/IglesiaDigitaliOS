//
//  AlertCommunity.swift
//  EncuentroCatolicoChurch
//
//  Created by Pablo Luis Velazquez Zamudio on 19/11/21.
//

import UIKit

open class AlertCommunity: UIViewController {

// MARK: @IBOUTLETS:
    @IBOutlet weak var shadowBackground: UIView!
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var lblFirst: UILabel!
    @IBOutlet weak var lblSecond: UILabel!
    @IBOutlet weak var btnLater: UIButton!
    @IBOutlet weak var btnContinue: UIButton!
    
    static let singleton = AlertCommunity()
    
    var isLater = false
    var communityName = ""
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            UIView.animate(withDuration: 0.3) {
                self.shadowBackground.alpha = 0.6
            }
        }
        lblFirst.text = "El registro de la Comunidad “\(communityName)” se guardó con éxito"
        alertView.layer.cornerRadius = 10
        btnContinue.layer.cornerRadius = 8
        btnLater.borderButtonColor(color: UIColor.init(red: 19/255, green: 39/255, blue: 124/255, alpha: 1))
    }
    
// MARK: @IBACTIONS -
    @IBAction func laterAction(_ sender: Any) {
        let singleton = AlertCommunity.singleton
        singleton.isLater = true
        shadowBackground.alpha = 0
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func continueAction(_ sender: Any) {
        let singleton = AlertCommunity.singleton
        singleton.isLater = false
        self.dismiss(animated: true)
    }

//MARK: - Inicialización
    class public func showAlert(communityName: String) -> AlertCommunity {
        let storyboard = UIStoryboard(name: "CommunitiesMainStoryboard", bundle: Bundle(for: AlertCommunity.self))
        let view = storyboard.instantiateViewController(withIdentifier: "COMMUNITYALERT") as! AlertCommunity
        view.communityName = communityName
        
        return view
    }

}
