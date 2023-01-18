//
//  RegisterNewViewController.swift
//  EncuentroCatolicoRegister
//
//  Created by Alejandro on 16/10/22.
//

import Foundation
import UIKit
import EncuentroCatolicoUtils
import Firebase

class RegisterViewController: BaseVC {
    //MARK: - Protocol Properties
    var presenter: RegisterPresenterProtocol?
    lazy var fieldList: [ECUField] = [
        nameField,
        firstLastNameField,
        secondLastNameField,
        phoneField,
        emailField,
        passwordField,
        confirmPasswordField
    ]
    
    //MARK: - IBOutlets
    @IBOutlet weak var loader: UIActivityIndicatorView!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var fieldStack: UIStackView!
    @IBOutlet weak var navView: UIView!
    
    //MARK: - Properties
    var usuario: UserRegister?
    
    let nameField: ECUField = {
        let field = ECUField()
        
        field.fieldName = "Nombre (s)"
        field.textField.maxLength = 25
        field.shouldChangeCharacters = { !$0.evaluateRegEx(for: ECURegexValidation.notName.rawValue) }
        field.textField.textContentType = .givenName
        field.textField.returnKeyType = .next
        field.textField.keyboardType = .asciiCapable
        field.textField.autocapitalizationType = .words
        
        field.validations = [
            ECUFieldGenericValidation.required(fieldName: "tu nombre").getValidation()
        ]
        
        return field
    }()
    
    let firstLastNameField: ECUField = {
        let field = ECUField()
        
        field.fieldName = "Apellido paterno"
        field.textField.maxLength = 25
        field.shouldChangeCharacters = { !$0.evaluateRegEx(for: ECURegexValidation.notName.rawValue) }
        field.textField.returnKeyType = .next
        field.textField.keyboardType = .asciiCapable
        field.textField.autocapitalizationType = .none
        field.textField.autocapitalizationType = .words
        field.validations = [
            ECUFieldGenericValidation.required(fieldName: "tu \(field.fieldName.lowercased())").getValidation()
        ]
        
        return field
    }()
    
    let secondLastNameField: ECUField = {
        let field = ECUField()
        
        field.fieldName = "Apellido materno"
        field.textField.maxLength = 25
        field.shouldChangeCharacters =  { !$0.evaluateRegEx(for: ECURegexValidation.notName.rawValue) }
        field.textField.returnKeyType = .next
        field.textField.keyboardType = .asciiCapable
        field.textField.autocapitalizationType = .none
        field.textField.autocapitalizationType = .words
        
        return field
    }()
    
    let phoneField: ECUField = {
        let field = ECUField()
        
        field.fieldName = "Número celular"
        field.textField.maxLength = 10
        field.textField.returnKeyType = .next
        field.textField.keyboardType = .numberPad
        field.textField.autocapitalizationType = .none
        field.validations = [
            ECUFieldGenericValidation.required(fieldName: "tu \(field.fieldName.lowercased())").getValidation(),
            ECUFieldGenericValidation.isValidPhone.getValidation()
        ]
        
        return field
    }()
    
    let emailField: ECUField = {
        let field = ECUField()
        
        field.textField.maxLength = 64
        field.textField.returnKeyType = .next
        field.fieldName = "Correo electrónico"
        field.textField.textContentType = .emailAddress
        field.textField.autocapitalizationType = .none
        field.textField.keyboardType = .emailAddress
        field.validations = [
            ECUFieldGenericValidation.required(fieldName: "tu \(field.fieldName.lowercased())").getValidation(),
            ECUFieldGenericValidation.isValidEmail.getValidation()
        ]
        
        return field
    }()
    
    let passwordField: ECUField = {
        let field = ECUField()
        
        field.shouldChangeCharacters =  { !$0.contains(" ") }
        field.textField.maxLength = 16
        field.textField.keyboardType = .asciiCapable
        field.textField.autocorrectionType = .no
        field.textField.returnKeyType = .next
        field.textField.autocapitalizationType = .none
        field.fieldName = "Contraseña"
        field.fieldDescription = "Debe tener mínimo 8 caracteres, 1 mayúscula, 1 número y 1 carácter especial."
        field.validations = [
            ECUFieldGenericValidation.required(fieldName: "tu \(field.fieldName.lowercased())").getValidation(),
            ECUFieldGenericValidation.minimunCharecters(comparation: 8).getValidation(),
            ECUFieldGenericValidation.capitalLetters(fieldName: "una contraseña").getValidation(),
            ECUFieldGenericValidation.number(fieldName: "una contraseña").getValidation(),
            ECUFieldGenericValidation.isValidPwd(fieldName: "una contraseña").getValidation()
        ]
        
        return field
        
    }()
    
    lazy var confirmPasswordField: ECUField = {
        let field = ECUField()
        
        field.shouldChangeCharacters =  { !$0.contains(" ") }
        field.textField.maxLength = 16
        field.textField.keyboardType = .asciiCapable
        field.textField.returnKeyType = .next
        field.textField.autocapitalizationType = .none
        field.fieldName = "Confirmar tu contraseña"
        field.fieldDescription = "Ambas contraseñas deben coincidir."
        field.validations = [
            ECUFieldGenericValidation.required(fieldName: "la confirmación de la contraseña").getValidation(),
            { $0 == self.passwordField.text ? nil : "La confirmación de la contraseña debe ser igual a la contraseña" }
        ]
        
        return field
    }()
    
    let datePicker = UIDatePicker()
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        presenter?.controlador = self
        presenter?.viewDidLoad(nombre: nameField.textField, apellido1: firstLastNameField.textField, apellido2: secondLastNameField.textField, celular: phoneField.textField, email: emailField.textField, usuario: usuario)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("VC ECRegister - RegisterVC ")

    }
    
    
    //MARK: - Events
    @objc func next(_ sender: UIView) {
        guard let nextTextField = fieldList[safe: sender.tag + 1] else {
            view.endEditing(true)
            return
        }
        
        nextTextField.textField.becomeFirstResponder()
    }
    
    @IBAction func onClickLink(_ sender: UIView) {
        var url = ""
        
        switch sender.tag {
        case 1, 2, 3:
            url = "https://arquidiocesismexico.org.mx/aviso-de-privacidad/"
        default:
            return
        }
        
        guard let url = URL(string: url) else { return }
        
        UIApplication.shared.open(url)
    }
    
    @IBAction func onClickContinue(_ sender: Any) {
        guard self.validateForm() else {
            mostrarMSG(dtcAlerta: ["titulo": "Alerta", "cuerpo": "Verifique sus datos"])
            return
        }
        
        toggleLoading(show: true)
        presenter?.continuar(nombre: nameField.text,
                             apellido1: firstLastNameField.text,
                             apellido2: secondLastNameField.text,
                             cel: phoneField.text,
                             email: emailField.text,
                             contra1: passwordField.text,
                             contra2: confirmPasswordField.text)
    }
    
    @IBAction func onClickBack(_ sender: Any) {
        presenter?.back(controller: self)
    }
}

//MARK: - ECUForm
extension RegisterViewController: ECUForm {}

//MARK: - RegisterViewProtocol
extension RegisterViewController: RegisterViewProtocol {
    func resetButton() {
        toggleLoading(show: false)
    }
    
    func mostrarMSG(dtcAlerta: [String : String]) {
        toggleLoading(show: false)
        
        guard let title = dtcAlerta["titulo"],
              let desc =  dtcAlerta["cuerpo"]  else {
            return
        }
        
        let alert = UIAlertController(title: title, message: desc, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
}

//MARK: - Private functions
extension RegisterViewController {
    private func setupUI() {
        toggleLoading(show: false)
        setupFields()
        
        navView.layer.cornerRadius = 30
        navView.layer.shadowRadius = 5
        navView.layer.shadowOpacity = 0.5
        navView.layer.shadowColor = UIColor.black.cgColor
        navView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }
    
    private func toggleLoading(show: Bool) {
        continueButton.isEnabled = !show
        show ? loader.startAnimating() : loader.stopAnimating()
        loader.isHidden = !show
    }
    
    private func setupFields() {
        fieldList.enumerated().forEach { index, field in
            fieldStack.addArrangedSubview(field)
            
            field.textField.tag = index
            field.textField.addTarget(self, action: #selector(self.next(_:)), for: .editingDidEndOnExit)
        }
        
        setPasswordField(sender: passwordField)
        setPasswordField(sender: confirmPasswordField)
        
        passwordField.onClickRightAction = {
            self.setPasswordField(sender: self.passwordField)
        }
        
        confirmPasswordField.onClickRightAction = {
            self.setPasswordField(sender: self.confirmPasswordField)
        }
    }
    
    private func setPasswordField(sender: ECUField) {
        sender.textField.isSecureTextEntry = !sender.textField.isSecureTextEntry
        sender.rightIconTint = !sender.textField.isSecureTextEntry ? UIColor(red: 102/255, green: 102/255, blue: 102/255, alpha: 1) : nil
        sender.rightIcon = UIImage(named: !sender.textField.isSecureTextEntry ? "hideEye" : "showEye", in: .module, compatibleWith: nil)
    }
}
