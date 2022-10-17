//
//  RegisterViewController.swift
//  EncuentroCatolicoRegister
//
//  Created by Jorge Cruz on 25/03/21.
//

import Foundation
import UIKit
import EncuentroCatolicoUtils
import Firebase

public extension String{
    
    func underlineDecorative(font:UIFont)->NSMutableAttributedString{
        let attibute = NSMutableParagraphStyle()
        attibute.alignment = .left
        attibute.lineBreakMode = .byWordWrapping
        
        let attributes: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.foregroundColor: UIColor.init(hex: "1C75BC")!,
            NSAttributedString.Key.underlineStyle : NSUnderlineStyle.single.rawValue,
            NSAttributedString.Key.font : font ,
            NSAttributedString.Key.paragraphStyle : attibute
        ]
        let stringAttribute = NSMutableAttributedString(string: self, attributes: attributes)
        return stringAttribute
    }
    
}
class RegisterViewController: BaseVC, UITextFieldDelegate {
    
    @IBOutlet weak var birthdayText: UITextField!
    @IBOutlet weak var txtNombre: UITextField!
    @IBOutlet weak var txtApellido1: UITextField!
    @IBOutlet weak var txtApellido2: UITextField!
    @IBOutlet weak var txtCelular: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtContra1: UITextField!
    @IBOutlet weak var txtContra2: UITextField!
    @IBOutlet weak var lblArriba: UIView!
    @IBOutlet weak var scroll: UIScrollView!
    @IBOutlet weak var brnContinuar: UIButton!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    @IBOutlet weak var correcto1: UIImageView!
    @IBOutlet weak var correcto2: UIImageView!
    @IBOutlet var codeButton: UIButton!
    @IBOutlet var privacyButton: UIButton!
    @IBOutlet weak var confirmPasswordImageView: UIImageView!
    @IBOutlet var termConditionsButton: UIButton!
    @IBOutlet weak var passwordImageView: UIImageView!
    // MARK: Properties
    var presenter: RegisterPresenterProtocol?
    var usuario: UserRegister?
    var celNumber: String = ""
    var evaluationStatus = false
    let datePicker = UIDatePicker()
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        showDatePicker()
        setupDelegates()
        let codeButtonText = "Código de ética".underlineDecorative(font: UIFont.systemFont(ofSize: 11))
        let privacyButtonText = "Política de Privacidad.".underlineDecorative(font: UIFont.systemFont(ofSize: 11))
        let termButtonText = "Términos y condiciones".underlineDecorative(font: UIFont.systemFont(ofSize: 11))
        codeButton.setAttributedTitle(codeButtonText, for: .normal)
        privacyButton.setAttributedTitle(privacyButtonText, for: .normal)
        termConditionsButton.setAttributedTitle(termButtonText, for: .normal)
        
        presenter?.controlador = self
        presenter?.viewDidLoad(nombre: txtNombre, apellido1: txtApellido1, apellido2: txtApellido2, celular: txtCelular, email: txtEmail, usuario: usuario)
        
        lblArriba.layer.cornerRadius = 30
        lblArriba.layer.shadowRadius = 5
        lblArriba.layer.shadowOpacity = 0.5
        lblArriba.layer.shadowColor = UIColor.black.cgColor
        lblArriba.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyBoard))
        view.addGestureRecognizer(tap)
        loader.isHidden = true
        txtContra1.addTarget(self, action: #selector(textFieldDidChangeContra(textField:)), for: .editingChanged)
        txtContra2.addTarget(self, action: #selector(textFieldDidChangeContra2(textField:)), for: .editingChanged)
        txtNombre.addTarget(self, action: #selector(salta(sender:)), for: .editingDidEndOnExit)
        txtApellido1.addTarget(self, action: #selector(salta(sender:)), for: .editingDidEndOnExit)
        txtApellido2.addTarget(self, action: #selector(salta(sender:)), for: .editingDidEndOnExit)
        txtCelular.addTarget(self, action: #selector(saltaNumero(sender:)), for: .editingChanged)
        txtEmail.addTarget(self, action: #selector(salta(sender:)), for: .editingDidEndOnExit)
        txtEmail.addTarget(self, action: #selector(evalute(sender:)), for: .editingChanged)
        txtContra1.addTarget(self, action: #selector(salta(sender:)), for: .editingDidEndOnExit)
        txtContra1.delegate = self
        txtContra2.addTarget(self, action: #selector(finaliza(sender:)), for: .editingDidEndOnExit)
        txtContra2.delegate = self
        txtCelular.delegate = self
        
        setPasswordImage(isValid: false, view: correcto1)
        setPasswordImage(isValid: false, view: correcto2)
    }
    
    private func setupDelegates() {
        txtNombre.delegate = self
        txtApellido1.delegate = self
        txtApellido2.delegate = self
    }
    
    func isValidEmail(email: String) -> Bool {
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            return emailTest.evaluate(with: email)
        }
    func isValidDate(date: Date) -> Bool {
            guard let minimum = Calendar.current.date(byAdding: .year, value: -8, to: Date()) else {
                return false
            }
            
            return date <= minimum
        }
    
    func isValidPassword(pass: String) -> Bool {
        var returnValue = true
        let emailRegEx = "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[\\.=+^\\$*.&{}()?\\[\\]!\\-?@#%&/,><':;|_~`]).{8,}$"
        
        do {
            let regex = try NSRegularExpression(pattern: emailRegEx)
            let nsString = pass as NSString
            let results = regex.matches(in: pass, range: NSRange(location: 0, length: nsString.length))
            
            if results.count == 0 {
                returnValue = false
            }
        } catch {
            returnValue = false
        }
        
        return  returnValue
    }
    
    @objc private func salta(sender: UITextField) {
        let nextField = sender.superview?.viewWithTag(sender.tag + 1)
        nextField?.becomeFirstResponder()
    }
    
    private func validateCom(email: String) -> Bool {
            let invalidEnds = [".con", ".comm", ".cmo"]
            let separatedBy = email.components(separatedBy: "@")
            
            guard let email = separatedBy.indices.contains(1) ? separatedBy[1] : nil else {
                return true
            }
            
            return invalidEnds.allSatisfy( { !email.contains($0) })
        }
    
    @objc private func evalute(sender: UITextField) {
            if let email = txtEmail.text {
                evaluationStatus = validateCom(email: email)
            }
        }

    
    @objc private func saltaNumero(sender: UITextField) {
        guard let texto = sender.text else { return }
        if texto.count == 10 {
            if texto.prefix(2) == "52" {
                let alert = UIAlertController(title: "Alerta", message: "Formato de número celular incorrecto", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                celNumber = ""
            } else {
                celNumber = texto
            }
        }
    }
    
    @objc private func finaliza(sender: UITextField) {
        view.endEditing(true)
    }
    
    @objc private func textFieldDidChangeContra(textField: UITextField) {
        correcto1.isHidden = textField.text ?? "" == ""
        setPasswordImage(isValid: isValidPassword(pass: textField.text ?? ""), view: correcto1)
        setPasswordImage(isValid: txtContra1.text == txtContra2.text, view: correcto2)
    }
    
    @objc private func textFieldDidChangeContra2(textField: UITextField) {
        correcto2.isHidden = textField.text ?? "" == ""
        setPasswordImage(isValid: isValidPassword(pass: textField.text ?? "") && txtContra1.text == txtContra2.text, view: correcto2)
    }
    
    @objc private func hideKeyBoard() {
        presenter?.hideKeyBoard(view: view)
    }
    
    private func setPasswordImage(isValid: Bool, view: UIImageView) {
        view.image = UIImage(named: isValid ? "correcto" : "close", in: .module, compatibleWith: nil)
        view.tintColor = isValid ? nil : .red
    }
    
    // MARK: Actions
    @IBAction func crearAction(_ sender: Any) {
        brnContinuar.isEnabled = false
        loader.isHidden = false
        loader.startAnimating()
        
        if isValidPassword(pass: txtContra1.text ?? "") && isValidPassword(pass: txtContra2.text ?? "") && isValidEmail(email: txtEmail.text ?? "") && txtCelular.text?.count == 10{
            if evaluationStatus == true {
                presenter?.continuar(nombre: txtNombre.text ?? "", apellido1: txtApellido1.text ?? "", apellido2: txtApellido2.text ?? "", cel: txtCelular.text ?? "", email: txtEmail.text ?? "", contra1: txtContra1.text ?? "", contra2: txtContra2.text ?? "", birthDate: birthdayText.text ?? "")
            }else {
                let alert = UIAlertController(title: "Alerta", message: "Verifica tu correo, formato de correo incorrecto", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                brnContinuar.isEnabled = true
                loader.isHidden = true
                loader.stopAnimating()
            }
        }else {
            let alert = UIAlertController(title: "Alerta", message: "Verifica que tus datos están correctos", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            brnContinuar.isEnabled = true
            loader.isHidden = true
            loader.stopAnimating()
        }
    
    }
    func showDatePicker(){
        datePicker.datePickerMode = .date
        datePicker.maximumDate = Calendar.current.date(byAdding: .year, value: -8, to: Date())
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
            print("Version anterior")
        }
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "OK", style: .plain, target: self, action: #selector(donedatePicker));
        toolbar.setItems([ UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil), doneButton], animated: false)
        
        birthdayText.inputAccessoryView = toolbar
        birthdayText.inputView = datePicker
    }
    @objc func donedatePicker(){
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy" //"yyyy/MM/dd"
        let fecha = formatter.string(from: datePicker.date)
        birthdayText.text = fecha //vFecha
        
        self.view.endEditing(true)
    }
    @IBAction func termButton(_ sender: Any) {
        guard let url = URL(string: "https://arquidiocesismexico.org.mx/aviso-de-privacidad/") else { return }
        UIApplication.shared.open(url)
    }
    @IBAction func privButton(_ sender: Any) {
        guard let url = URL(string: "https://arquidiocesismexico.org.mx/aviso-de-privacidad/") else { return }
        UIApplication.shared.open(url)
    }
    @IBAction func eticButton(_ sender: Any) {
        guard let url = URL(string: "https://arquidiocesismexico.org.mx/aviso-de-privacidad/") else { return }
        UIApplication.shared.open(url)
    }
    
    //    @IBAction func cancelarAction(_ sender: Any) {
    //        presenter?.cancelar(controller: self)
    //    }
    
    @IBAction func showPassword1(_ sender: UIButton) {
        setPasswordField(sender: passwordImageView, passField: txtContra1)
    }
    
    @IBAction func showPassword2(_ sender: UIButton) {
        setPasswordField(sender: confirmPasswordImageView, passField: txtContra2)
    }
    
    private func setPasswordField(sender: UIImageView, passField: UITextField) {
        passField.isSecureTextEntry = !passField.isSecureTextEntry
        sender.image = UIImage(named: !passField.isSecureTextEntry ? "hideEye" : "showEye", in: .module, compatibleWith: nil)
        sender.tintColor = !passField.isSecureTextEntry ? UIColor(red: 102/255, green: 102/255, blue: 102/255, alpha: 1) : nil
    }
    
    //    @IBAction func politicasAction(_ sender: Any) {
    //        presenter?.politicas()
    //    }
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func focusBirddayAction(_ sender: Any) {
        birthdayText.becomeFirstResponder()
    }
    
    @IBAction func termsAction(_ sender: Any) {
        guard let url = URL(string: "https://arquidiocesismexico.org.mx/aviso-de-privacidad/") else { return }
        UIApplication.shared.open(url)
        print("tap terms")
    }
    
    @IBAction func policityActions(_ sender: Any) {
        guard let url = URL(string: "https://arquidiocesismexico.org.mx/aviso-de-privacidad/") else { return }
        UIApplication.shared.open(url)
        print("tap policity")
    }
    
    @IBAction func ethicCodeAction(_ sender: Any) {
        guard let url = URL(string: "https://arquidiocesismexico.org.mx/aviso-de-privacidad/") else { return }
        UIApplication.shared.open(url)
        print("tap ethic code")
    }
    
}

extension RegisterViewController: RegisterViewProtocol {
    // TODO: implement view output methods
    func resetButton() {
        self.brnContinuar.isEnabled = true
        self.loader.stopAnimating()
        self.loader.isHidden = true
    }
    
    func mostrarMSG(dtcAlerta: [String : String]) {
        self.brnContinuar.isEnabled = true
        self.loader.stopAnimating()
        self.loader.isHidden = true
        let alert = UIAlertController(title: dtcAlerta["titulo"]!, message: dtcAlerta["cuerpo"]!, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension RegisterViewController {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        switch textField {
        case txtNombre:
            do {
                let regex = try NSRegularExpression(pattern: ".*[^A-Za-zÁÉÍÓÚáéíóúñÑ ].*", options: [])
                if regex.firstMatch(in: string, options: [], range: NSMakeRange(0, string.count)) != nil {
                    return false
                }
            }
            catch {
                print("ERROR")
            }
        return true
        case txtApellido1:
            do {
                let regex = try NSRegularExpression(pattern: ".*[^A-Za-zÁÉÍÓÚáéíóúñÑ ].*", options: [])
                if regex.firstMatch(in: string, options: [], range: NSMakeRange(0, string.count)) != nil {
                    return false
                }
            }
            catch {
                print("ERROR")
            }
        return true
        case txtApellido2:
            do {
                let regex = try NSRegularExpression(pattern: ".*[^A-Za-zÁÉÍÓÚáéíóúñÑ ].*", options: [])
                if regex.firstMatch(in: string, options: [], range: NSMakeRange(0, string.count)) != nil {
                    return false
                }
            }
            catch {
                print("ERROR")
            }
            return true
        case txtContra2, txtContra1:
            return !string.contains(" ")
        default:
            return true
        }
               
    }
    
}

extension String {
    /// stringToFind must be at least 1 character.
    func countInstances(of stringToFind: String) -> Int {
        assert(!stringToFind.isEmpty)
        var count = 0
        var searchRange: Range<String.Index>?
        while let foundRange = range(of: stringToFind, options: [], range: searchRange) {
            count += 1
            searchRange = Range(uncheckedBounds: (lower: foundRange.upperBound, upper: endIndex))
        }
        return count
    }
}
