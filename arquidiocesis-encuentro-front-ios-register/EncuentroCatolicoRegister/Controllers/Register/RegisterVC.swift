//
//  RegisterNewViewController.swift
//  EncuentroCatolicoRegister
//
//  Created by Alejandro on 16/10/22.
//
import EncuentroCatolicoVirtualLibrary
import Foundation
import UIKit
import EncuentroCatolicoUtils
import Firebase

class Login_Registro: BaseVC {
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
    var alertFields : AcceptAlert?
    var rolG = "Fiel"
    var typePersonG="1"
    
    //MARK: - IBOutlets
    @IBOutlet weak var loader: UIActivityIndicatorView!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var fieldStack: UIStackView!
    @IBOutlet weak var navView: UIView!
    ///Priest
    @IBOutlet weak var `switch`: UISwitch!
    
    @IBOutlet weak var priestSV: UIStackView!
    @IBOutlet weak var priestPhoneTF: UITextField!
    
    @IBOutlet weak var priestBtn: UIButton!
    @IBOutlet weak var progress: UIActivityIndicatorView!
    @IBOutlet weak var errorNumber: UILabel!
    
    @IBOutlet weak var lblChangeDataTV: UITextView!
    @IBOutlet weak var lblChangeDataTVHeight: NSLayoutConstraint!
    
    
    @IBAction func priestBtnClick(_ sender: Any) {
        let phone=priestPhoneTF.text ?? ""
        if phone.count>10 || phone.count<10 {
            errorNumber.isHidden=false
        }else{
            progress.isHidden=false
            progress.startAnimating()
            errorNumber.isHidden=true
            presenter?.requestPriestData(priest:PriestRequest(type: "priest", phone: phone))//number dummy:"5530607563"
        }
        
    }
    
    func setPrestInfo(priestInfo:ResponsePriest){
        progress.isHidden=true
        progress.stopAnimating()
        if(priestInfo.fccelular==nil || priestInfo.fccorreo==nil){
            //no hay priest
            showCanonAlert(title: "¡Ups!", msg: "No encontramos ningún registro de sacerdote asociado a este número. Verifícalo y/o ponte en contacto con el administrador en iglesiadigital@arquidiocesismexico.org")
        }else{
            UserDefaults.standard.set("PRIEST", forKey: "profile")
            //todo ok con el priest, poner datos
            priestSV.isHidden=true
            fieldStack.isHidden=false
            continueButton.isHidden=false
            nameField.textField.text=priestInfo.name
            firstLastNameField.textField.text=priestInfo.fcappaterno
            secondLastNameField.textField.text=priestInfo.fcapmaterno
            phoneField.textField.text=priestInfo.fccelular
            emailField.textField.text=priestInfo.fccorreo
            
            nameField.textField.isEnabled=false
            firstLastNameField.textField.isEnabled=false
            secondLastNameField.textField.isEnabled=false
            phoneField.textField.isEnabled=false
            emailField.textField.isEnabled=true
            lblChangeDataTV.isHidden=false
            lblChangeDataTVHeight.constant=40
            rolG = "Sacerdote"
            typePersonG="2"
        }
    }
    
    func showCanonAlert(title:String, msg:String){
        print("SHOW CANON ALERT")
        print(msg)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            self.alertFields = AcceptAlert.showAlert(titulo: title, mensaje: msg)
            self.alertFields!.view.backgroundColor = .clear
            self.present(self.alertFields!, animated: true)
         })
    }
    
    @IBAction func switchClick(_ sender: Any) {
        if `switch`.isOn{
            rolG = "Sacerdote"
            typePersonG="2"
            fieldStack.isHidden=true
            continueButton.isHidden=true
            priestSV.isHidden=false
            progress.isHidden=true
            errorNumber.isHidden=true
        }else{
            UserDefaults.standard.set("DEVOTED", forKey: "profile")
            rolG = "Fiel"
            typePersonG="1"
            priestSV.isHidden=true
            fieldStack.isHidden=false
            continueButton.isHidden=false
            nameField.textField.text=""
            firstLastNameField.textField.text=""
            secondLastNameField.textField.text=""
            phoneField.textField.text=""
            emailField.textField.text=""
            
            nameField.textField.isEnabled=true
            firstLastNameField.textField.isEnabled=true
            secondLastNameField.textField.isEnabled=true
            phoneField.textField.isEnabled=true
            emailField.textField.isEnabled=true
            lblChangeDataTV.isHidden=true
            lblChangeDataTVHeight.constant=0
        }
        
    }
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
        field.fieldDescription = "Debe tener mínimo 8 caracteres, incluyendo: 1 minúscula, 1 mayúscula, 1 número y 1 carácter especial."
        field.validations = [
            ECUFieldGenericValidation.required(fieldName: "una \(field.fieldName.lowercased()) valida").getValidation(),
            ECUFieldGenericValidation.minimunCharecters(comparation: 8).getValidation(),
            ECUFieldGenericValidation.lowerCase(fieldName: "una contraseña").getValidation(),
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
        addDoneButtonOnKeyboard()
        setupUI()
        presenter?.controlador = self
        presenter?.viewDidLoad(
            nombre: nameField.textField,
            apellido1: firstLastNameField.textField,
            apellido2: secondLastNameField.textField,
            celular: phoneField.textField,
            email: emailField.textField,
            usuario: usuario)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("VC ECRegister - RegisterVC ")
    }
    
    func addDoneButtonOnKeyboard(){
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
             doneToolbar.barStyle = .default
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Listo", style: .done, target: self, action: #selector(self.doneButtonAction))
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        priestPhoneTF.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction(){
        priestPhoneTF.resignFirstResponder()
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
            showCanonAlert(title: "Atención", msg: "Hay uno o más errores en el formulario. Verifique los campos para continuar con el registro.")
            //mostrarMSG(dtcAlerta: ["titulo": "Alerta", "cuerpo": "Verifique sus datos"])
            return
        }
        
        toggleLoading(show: true)
        presenter?.continuar(nombre: nameField.text,
                             apellido1: firstLastNameField.text,
                             apellido2: secondLastNameField.text,
                             cel: phoneField.text,
                             email: emailField.text,
                             contra1: passwordField.text,
                             contra2: confirmPasswordField.text,
                             rol: rolG,
                             typePerson:typePersonG)
    }
    
    @IBAction func onClickBack(_ sender: Any) {
        presenter?.back(controller: self)
    }
}

//MARK: - ECUForm
extension Login_Registro: ECUForm {}

//MARK: - RegisterViewProtocol
extension Login_Registro: RegisterViewProtocol {
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
extension Login_Registro {
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
