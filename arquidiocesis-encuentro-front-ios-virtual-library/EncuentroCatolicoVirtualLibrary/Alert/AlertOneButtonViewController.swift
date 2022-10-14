//
//  AlertNotificationViewController.swift
//  AlertNotificacion
//
//  Created by Miguel Eduardo  Valdez Tellez  on 23/03/21.
//

import UIKit

open class AlertOneButtonViewController: AlertaBaseViewController {

    //MARK: - IBOulets
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var textContentLabel: UILabel!
    @IBOutlet weak var textTitleLabel
        : UILabel!
    @IBOutlet weak var acceptButtonOutlet: UIButton!
    
    @IBOutlet weak var closeButton: UIButton!
    @IBAction func acceptButtonAction(_ sender: Any) {
        demo.callServiceChangeStatus()
        dismiss(animated: true)
    }
    @IBAction func closeButtonAction(_ sender: Any) {
        dismiss(animated: true)
    }
    //MARK: - Variables locales
    var titulo: String!
    var mensaje: String?
    var delegate: SubDelegateAlert?
    let demo: SOSServicesView = SOSServicesView()
    //MARK: - Ciclo de vida
    open override func viewDidLoad() {
        super.viewDidLoad()
        viewMain.layer.cornerRadius = 10
        textTitleLabel.text = titulo
        textContentLabel.text = mensaje
        acceptButtonOutlet.layer.cornerRadius = 8
        self.view.backgroundColor = .clear
    }
    
    //MARK: - Inicialización
    class public func showAlert(titulo: String, mensaje: String) -> AlertOneButtonViewController {
        let storyboard = UIStoryboard(name: "Alerts", bundle: Bundle(for: AlertOneButtonViewController.self))
        let view = storyboard.instantiateViewController(withIdentifier: "AlertOneButtonViewController") as! AlertOneButtonViewController
        view.titulo = titulo
        view.mensaje = mensaje
        return view
    }

}
