//
//  AlertNotificationViewController.swift
//  AlertNotificacion
//
//  Created by Miguel Eduardo  Valdez Tellez  on 23/03/21.
//

import UIKit

class AlertTwoButtonsViewController: AlertaBaseViewController {

    //MARK: - IBOulets
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var textContentLabel: UILabel!
    @IBOutlet weak var textTitleLabel : UILabel!
    @IBOutlet weak var agendarButtonOutlet: UIButton!
    @IBOutlet weak var rechazarButtonOutlet: UIButton!
    @IBOutlet weak var otherTextLabel: UILabel!
    @IBAction func rechazarButtonAction(_ sender: Any) {
        self.delegate?.refuseButton(action: self)
    }
    @IBAction func agendarButtonAction(_ sender: Any) {
        self.delegate?.scheduleButton(action: self)
    }
    //MARK: - Variables locales
    var titulo: String!
    var mensaje: String?
    var otroText: String?
    var delegate: SubDelegateAlert?
    
    //MARK: - Ciclo de vida
    override func viewDidLoad() {
        super.viewDidLoad()
        agendarButtonOutlet.layer.cornerRadius = 8
        rechazarButtonOutlet.layer.cornerRadius = 8
        viewMain.layer.cornerRadius = 10
        textTitleLabel.text = titulo
        textContentLabel.text = mensaje
        otherTextLabel.text = otroText
    }
    
    //MARK: - Inicialización
    class func showAlert(titulo: String, mensaje: String, otro: String) -> AlertTwoButtonsViewController {
        let storyboard = UIStoryboard(name: "Alerts", bundle: Bundle(for: AlertTwoButtonsViewController.self))
        let view = storyboard.instantiateViewController(withIdentifier: "AlertTwoButtonsViewController") as! AlertTwoButtonsViewController
        view.titulo = titulo
        view.mensaje = mensaje
        view.otroText = otro
        return view
    }

}
