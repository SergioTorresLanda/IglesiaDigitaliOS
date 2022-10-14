//
//  AlertNotificacionVIewController.swift
//  EncuentroCatolicoVirtualLibrary
//
//  Created by Miguel Eduardo  Valdez Tellez  on 22/03/21.
//

import UIKit

class AlertNotificacionVIew: UIView {
    static let shared = AlertNotificacionVIew()
    
    //MARK: - IBOutlets
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var textBlueMain: UILabel!
    @IBOutlet weak var textGrayMain: UILabel!
    @IBOutlet weak var textContentSOS: UILabel!
    @IBOutlet weak var aceptServiceButtonOutlet: UIButton!
    @IBOutlet weak var closeButtonOutlet: UIButton!
    @IBOutlet weak var stackViewButtonSOSOutlet: UIStackView!
    
    //MARK: - IBActions
    @IBAction func aceptServiceButtonAction(_ sender: Any) {
        print("Exito!!")
    }
    
    @IBAction func closeButtonAction(_ sender: Any) {
        
    }
    @IBAction func scheduleButtonAction(_ sender: Any) {
        print("Exito!!")
    }
    
    @IBAction func refuseButtonAction(_ sender: Any) {
        print("Exito!!")
    }
    
    //MARK: - Local variables
    var alertStyle: AlertStyle = .single
    static let reuseIdentifier: String = "AlertNotificacionVIew"
    
    enum AlertStyle {
        case single
        case oneButton
        case doubleButton
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        Bundle.local.loadNibNamed(AlertNotificacionVIew.reuseIdentifier, owner: self, options: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("View not been implemented")
    }
    
    func showAlert(alertStyletype: AlertStyle, title: String, content: String) {
        switch alertStyle {
        case .single:
            textBlueMain.isHidden = false
            textBlueMain.text = title
            textGrayMain.isHidden = false
            textGrayMain.text = content
            closeButtonOutlet.isHidden = false
            aceptServiceButtonOutlet.isHidden = true
            textContentSOS.isHidden = true
            stackViewButtonSOSOutlet.isHidden = true
        case .oneButton:
            textBlueMain.isHidden = false
            textBlueMain.text = title
            textGrayMain.isHidden = false
            textGrayMain.text = content
            closeButtonOutlet.isHidden = true
            aceptServiceButtonOutlet.isHidden = false
            textContentSOS.isHidden = true
            stackViewButtonSOSOutlet.isHidden = true
        case .doubleButton:
            textBlueMain.isHidden = false
            textBlueMain.text = title
            textGrayMain.isHidden = false
            textGrayMain.text = content
            closeButtonOutlet.isHidden = true
            aceptServiceButtonOutlet.isHidden = true
            textContentSOS.isHidden = false
            stackViewButtonSOSOutlet.isHidden = false
        default:
            break
        }
    }
}

