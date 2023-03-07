//
//  ForgotPViewController.swift
//  EncuentroCatolicoLogin
//
//  Created by Pablo Luis Velazquez Zamudio on 21/06/21.
//

import UIKit
import EncuentroCatolicoVirtualLibrary
import EncuentroCatolicoUtils

class ForgotPViewController: UIViewController, ForgotViewProtocol {

    var presenter: ForgotPresenterProtocol?
    let underlineColor = UIColor.init(red: 28/255, green: 117/255, blue: 188/255, alpha: 1)
    var     alertFields : AcceptAlert?
    var alertFailRequest : AcceptAlert?
    var canContiue = false
    var alertLoader = UIAlertController(title: "", message: "\n \n \n \n \nCargando...", preferredStyle: .alert)
    var emailParam = ""
    static let singleton = ForgotPViewController()
    
    
    @IBOutlet weak var backIcon: UIImageView!
    @IBOutlet weak var navBarImg: UIImageView!
    @IBOutlet weak var lblMainTitle: UILabel!
    @IBOutlet weak var lblSubtitle: UILabel!
    @IBOutlet weak var lblCorreo: UILabel!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var lineaView: UIView!
    @IBOutlet weak var btnAccept: UIButton!
    @IBOutlet weak var fisrtlblTerms: UILabel!
    @IBOutlet weak var btnTerms: UIButton!
    @IBOutlet weak var lblUs: UILabel!
    @IBOutlet weak var btnPrivacity: UIButton!
    @IBOutlet weak var lblConoce: UILabel!
    @IBOutlet weak var btnEtica: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnTerms.underlineButtons(sizeFont: 11, textColor: underlineColor, text: "Términos y condiciones")
        btnPrivacity.underlineButtons(sizeFont: 11, textColor: underlineColor, text: "Política de privacidad")
        btnEtica.underlineButtons(sizeFont: 11, textColor: underlineColor, text: "Código de ética")
        emailField.returnKeyType = .done
        lblMainTitle.adjustsFontSizeToFitWidth = true
        btnAccept.layer.cornerRadius = 8
        lblSubtitle.adjustsFontSizeToFitWidth = true
        fisrtlblTerms.adjustsFontSizeToFitWidth = true
        btnTerms.titleLabel?.adjustsFontSizeToFitWidth = true
        lblUs.adjustsFontSizeToFitWidth = true
        btnPrivacity.titleLabel?.adjustsFontSizeToFitWidth = true
        lblConoce.adjustsFontSizeToFitWidth = true
        btnEtica.titleLabel?.adjustsFontSizeToFitWidth = true
        emailField.delegate = self
        
        let tapSuperview = UITapGestureRecognizer(target: self, action: #selector(TapSuperview))
        self.view.addGestureRecognizer(tapSuperview)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("VC ECLogin - ForgotPVC")
    }
    
    @objc func TapSuperview() {
        self.view.endEditing(true)
    }
    
    @objc func handleTapBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func showLoader(){
        alertLoader = UIAlertController(title: "", message: "\n \n \n \n \nCargando...", preferredStyle: .alert)
        let imageView = UIImageView(frame: CGRect(x: 100, y: 15, width: 80, height: 80))//mitad es en 145dp
        imageView.image = UIImage(named: "iconoIglesia3", in: Bundle.local, compatibleWith: nil)
        alertLoader.view.addSubview(imageView)
        self.present(alertLoader, animated: false, completion: nil)
    }

    func statusResponse() {
        let singleton = ForgotPViewController.singleton
        singleton.emailParam = validatePhoneMail(toValidate: emailField.text ?? "") ?? (emailField.text ?? "")
        alertLoader.dismiss(animated: true, completion: nil)
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { (timer) in
            let view  = ConfirmationCodeRouter.createModule(userEmail: self.emailField.text ?? "")
            self.navigationController?.pushViewController(view, animated: true)
        }
        print("Todo cool bro, puedes seguir")
    }
    
    func failRequest() {
        alertLoader.dismiss(animated: true, completion: nil)
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { (timer) in
            self.alertFields = AcceptAlert.showAlert(titulo: "Algo salio mal", mensaje: "Por favor intenta de nuevo más tarde")
            self.alertFields!.view.backgroundColor = .clear
            self.present(self.alertFields!, animated: true)
        }
    }
    
    private func validatePhoneMail(toValidate: String) -> String? {
        
        if isValidPhone(phone: toValidate) {
            return "+52\(toValidate)"
        }
        
        if isValidEmail(email: toValidate) {
            return toValidate
        }
        
        return nil
    }
    @IBAction func backDismiss(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func acceptAction(_ sender: Any) {
        
        print(emailField.text ?? "un")
//        let view  = ConfirmationCodeRouter.createModule(userEmail: emailField.text ?? "")
//        self.navigationController?.pushViewController(view, animated: true)
        
        if (emailField.text ?? "") != "" {
            if canContiue == true {
                guard let textValidate = validatePhoneMail(toValidate: (emailField.text ?? "")) else {
                    alertFields = AcceptAlert.showAlert(titulo: "Atención", mensaje: "Debes ingresar un correo electrónico válido o un número celular válido")
                    alertFields!.view.backgroundColor = .clear
                    present(alertFields!, animated: true)
                    return
                }
                
                showLoader()
                presenter?.postData(dataEmail: textValidate)
//                let view  = ConfirmationCodeRouter.createModule()
//        self.navigationController?.pushViewController(view, animated: true)

            }else{
//                alertFields!.view.backgroundColor = .clear
//                present(alertFields!, animated: true)
            }
        }else{

            alertFields = AcceptAlert.showAlert(titulo: "Atención", mensaje: "Faltan campos por llenar")
            alertFields!.view.backgroundColor = .clear
            present(alertFields!, animated: true)
        }
    }
    
    @IBAction func termsAction(_ sender: Any) {
        guard let url = URL(string: "https://arquidiocesismexico.org.mx/aviso-de-privacidad/") else { return }
        UIApplication.shared.open(url)
        print("tap terms")
    }
    
    @IBAction func privacyPoliciesAction(_ sender: Any) {
        guard let url = URL(string: "https://arquidiocesismexico.org.mx/aviso-de-privacidad/") else { return }
        UIApplication.shared.open(url)
        print("tap privacy policies")
    }
    
    @IBAction func ethicCodeAction(_ sender: Any) {
        guard let url = URL(string: "https://arquidiocesismexico.org.mx/aviso-de-privacidad/") else { return }
        UIApplication.shared.open(url)
        print("tap ethic code")
    }
    
}

extension ForgotPViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        canContiue = true
//        if checkTextSufficientComplexity(text: emailField.text ?? "nil") == true {
//            canContiue = true
//        }else{
//            canContiue = false
//            alertFields = AcceptAlert.showAlert(titulo: "Atención", mensaje: "Por favor introduce un correo valido")
//        }
        
    }
    
    func checkTextSufficientComplexity(text : String) -> Bool{
        
        var state = false
        
        let specialCharacterRegEx  = ".*[@]+.*"
        let texttest2 = NSPredicate(format:"SELF MATCHES %@", specialCharacterRegEx)
        
        let specialresult = texttest2.evaluate(with: text)
        print("\(specialresult)")
        
        let specialDotCharacterRegEx  = ".*[.]+.*"
        let texttest3 = NSPredicate(format:"SELF MATCHES %@", specialDotCharacterRegEx)
        
        let numberRegEx  = ".*[0-9]+.*"
        let texttest1 = NSPredicate(format:"SELF MATCHES %@", numberRegEx)
        let numberresult = texttest1.evaluate(with: text)
        print("\(numberresult)")
        
        let specialDotresult = texttest3.evaluate(with: text)
        print("\(specialDotresult)")
        
        if specialresult && specialDotresult == true || numberresult == true {
            state = true
        }else{
            state = false
        }
        
        return state
        
    }
    
}

extension ForgotPViewController {

    func isValidPhone(phone: String) -> Bool {
        phone.evaluateRegEx(for: ECURegexValidation.phone.rawValue)
    }

    func isValidEmail(email: String) -> Bool {
        email.evaluateRegEx(for: ECURegexValidation.email.rawValue)
    }

}
