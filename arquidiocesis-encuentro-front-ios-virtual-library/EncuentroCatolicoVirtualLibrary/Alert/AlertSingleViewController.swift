//
//  AlertNotificationViewController.swift
//  AlertNotificacion
//
//  Created by Miguel Eduardo  Valdez Tellez  on 23/03/21.
//

import UIKit

class AlertSingleViewController: AlertaBaseViewController  {

    //MARK: - IBOulets
    @IBOutlet weak var viewMain: UIView!
    @IBOutlet weak var textContentLabel: UILabel!
    @IBOutlet weak var textTitleLabel
        : UILabel!
    
    @IBAction func closeAlert(_ sender: Any) {
        dismiss(animated: true)
    }
    //MARK: - Variables locales
    var titulo: String!
    var mensaje: String?
    var mensajeConAtributos: NSAttributedString?
    var delegate: SubDelegateAlert?
    
    //MARK: - Ciclo de vida
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewMain.layer.cornerRadius = 10
        textTitleLabel.text = titulo
        textContentLabel.text = mensaje
    }
    
    //MARK: - Inicialización
    class func showAlert(titulo: String, mensaje: String) -> AlertSingleViewController {
        let storyboard = UIStoryboard(name: "Alerts", bundle: Bundle(for: AlertSingleViewController.self))
        let view = storyboard.instantiateViewController(withIdentifier: "AlertSingleViewController") as! AlertSingleViewController
        view.titulo = titulo
        view.mensaje = mensaje
        return view
    }

}
