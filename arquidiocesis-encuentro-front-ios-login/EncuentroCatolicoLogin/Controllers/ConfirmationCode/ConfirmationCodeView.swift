//
//  ConfirmationCodeView.swift
//  EncuentroCatolicoLogin
//
//  Created by Pablo Luis Velazquez Zamudio on 21/06/21.
//

import UIKit
import EncuentroCatolicoVirtualLibrary
import EncuentroCatolicoUtils

class ConfirmationCodeView: UIViewController, ConfirmationCodeViewProtocol {
    
    var presenter: ConfirmationCodePresenterProtocol?
    lazy var fieldList: [ECUField] = [
        passwordField,
        confirmPasswordField
    ]
    let underlineColor = UIColor.init(red: 28/255, green: 117/255, blue: 188/255, alpha: 1)
    var canContinue = false
    var canResend = false
    var isPaste = false
    var pos = 0
    var codeStr : [String] = []
    var emailUser = "Unspecified"

    var mensaje = ""
    var alertFields : AcceptAlert? //= AcceptAlert.showAlert(titulo: "Atención", mensaje: "")
    let alertSuccess = UIAlertController(title: "", message: "Tu contraseña se cambio con éxito", preferredStyle: .alert)
    
    let alertSuccessResend = UIAlertController(title: "", message: "Se envío un código a tu número de telefono, por favor verifica tu bandeja de mensajes", preferredStyle: .alert)
    let alertLoader = UIAlertController(title: "", message: "\n \n \n \n \nCargando...", preferredStyle: .alert)
    
    @IBOutlet weak var backIcon: UIImageView!
    @IBOutlet weak var navBarImg: UIImageView!
    @IBOutlet weak var lblMainTitle: UILabel!
    @IBOutlet weak var lblSubtitle: UILabel!
    @IBOutlet weak var btnResend: UIButton!
    @IBOutlet weak var btnCorregirUser: UIButton!
    @IBOutlet weak var firtsLbl: UILabel!
    @IBOutlet weak var fisrtSublbl: UILabel!
    @IBOutlet weak var lineaViewEmail: UIView!
    @IBOutlet weak var secondlbl: UILabel!
    @IBOutlet weak var secondSublbl: UILabel!
    @IBOutlet weak var confirmField: UITextField!
    @IBOutlet weak var inputField: UITextField!
    @IBOutlet weak var lineaViewConfirm: UIView!
    @IBOutlet weak var btnAccpet: UIButton!
    @IBOutlet weak var lblAcceptTerms: UILabel!
    @IBOutlet weak var btnTerms: UIButton!
    @IBOutlet weak var lblUs: UILabel!
    @IBOutlet weak var btnPrivacity: UIButton!
    @IBOutlet weak var btnEtica: UIButton!
    @IBOutlet weak var lblConoce: UILabel!
    @IBOutlet var numberFieldsCollection: [UITextField]!
    @IBOutlet var eyeCollectionIcons: [UIImageView]!
    @IBOutlet weak var lblDescTimer: UILabel!
    @IBOutlet weak var lblTimer: UILabel!
    @IBOutlet weak var lblPhone: UILabel!
    @IBOutlet weak var fieldStack: UIStackView!
    
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
            ECUFieldGenericValidation.required(fieldName: "tu \(field.fieldName.lowercased())").getValidation(),
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
    
    private lazy var timer: ECUTimer = {
        let timer = ECUTimerNative()
       
        timer.delegate = self
        
        return timer
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        btnAccpet.isEnabled = true
        
        self.lblDescTimer.text = "No podrás solicitar otro código \n hasta pasando tres minutos"
//        eyeCollectionIcons[0].tintColor = .gray
//        eyeCollectionIcons[1].tintColor = .gray
        if emailUser.contains("@") == true {
            presenter?.requestUserInfo(email: emailUser)
        }else{
            lblPhone.text = emailUser
        }
        
        timer.start(to: .otpTimeout)
        
        numberFieldsCollection.forEach { (field) in
            field.delegate = self
            field.textContentType = .oneTimeCode
        }
//        inputField.delegate = self
//        confirmField.delegate = self
        btnTerms.underlineButtons(sizeFont: 11, textColor: underlineColor, text: "Términos y condiciones")
        btnPrivacity.underlineButtons(sizeFont: 11, textColor: underlineColor, text: "Política de privacidad")
        btnEtica.underlineButtons(sizeFont: 11, textColor: underlineColor, text: "Código de ética")
        btnResend.underlineButtons(sizeFont: 15, textColor: underlineColor, text: "Reenviar código")
        btnCorregirUser.underlineButtons(sizeFont: 15, textColor: underlineColor, text: "Corregir usuario")
//        inputField.delegate = self
//        confirmField.delegate = self
//        inputField.returnKeyType = .next
//        confirmField.returnKeyType = .done
        lblMainTitle.adjustsFontSizeToFitWidth = true
        lblSubtitle.adjustsFontSizeToFitWidth = true
        lblAcceptTerms.adjustsFontSizeToFitWidth = true
        btnTerms.titleLabel?.adjustsFontSizeToFitWidth = true
        lblUs.adjustsFontSizeToFitWidth = true
        btnPrivacity.titleLabel?.adjustsFontSizeToFitWidth = true
        btnEtica.titleLabel?.adjustsFontSizeToFitWidth = true
        btnAccpet.layer.cornerRadius = 8
        let tapSuperview = UITapGestureRecognizer(target: self, action: #selector(TapSuperview))
        self.view.addGestureRecognizer(tapSuperview)
        
//        let tapEyeI = UITapGestureRecognizer(target: self, action: #selector(TapEyeI))
//        eyeCollectionIcons[0].addGestureRecognizer(tapEyeI)
        
//        let tapEyeII = UITapGestureRecognizer(target: self, action: #selector(TapEyeII))
//        eyeCollectionIcons[1].addGestureRecognizer(tapEyeII)
        
        
        let defaults = UserDefaults.standard
        let phone = defaults.string(forKey: "telefono") ?? "0"
        if phone != "" {
            lblPhone.text = phone
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("VC ECLogin - ConfirmationVC")
    }
    
    //MARK: - Events
    @objc func next(_ sender: UIView) {
        guard let nextTextField = fieldList[safe: sender.tag + 1] else {
            view.endEditing(true)
            return
        }
        
        nextTextField.textField.becomeFirstResponder()
    }
    
    func showLoading() {
        let imageView = UIImageView(frame: CGRect(x: 75, y: 25, width: 140, height: 60))
        imageView.image = UIImage(named: "logoEncuentro", in: Bundle.local, compatibleWith: nil)
        alertLoader.view.addSubview(imageView)
        self.present(alertLoader, animated: false, completion: nil)
    }
    
    @objc func handleTapBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func TapEyeI() {
        print("TapEyeI")
//        if inputField.isSecureTextEntry == false {
//            inputField.isSecureTextEntry = true
//        }else{
//            inputField.isSecureTextEntry = false
//        }
    }
    
    @objc func TapEyeII() {
//        if confirmField.isSecureTextEntry == false {
//            confirmField.isSecureTextEntry = true
//        }else{
//            confirmField.isSecureTextEntry = false
//        }
    }
    
    func checkTextSufficientComplexity(text : String) -> Bool{

        var state = false
        let capitalLetterRegEx  = ".*[A-Z]+.*"
        let texttest = NSPredicate(format:"SELF MATCHES %@", capitalLetterRegEx)
        let capitalresult = texttest.evaluate(with: text)
        print("\(capitalresult)")


        let numberRegEx  = ".*[0-9]+.*"
        let texttest1 = NSPredicate(format:"SELF MATCHES %@", numberRegEx)
        let numberresult = texttest1.evaluate(with: text)
        print("\(numberresult)")


        let specialCharacterRegEx  = ".*[()/-_´ç¨Ç·'`´:,;{}!¡¿?@#$%^&]+.*"
        let texttest2 = NSPredicate(format:"SELF MATCHES %@", specialCharacterRegEx)

        let specialresult = texttest2.evaluate(with: text)
        print("\(specialresult)")

        if capitalresult && numberresult && specialresult == true && text.count >= 8 {
            state = true
        }else{
            state = false
        }
        
        return state

    }
    
    @objc func TapSuperview() {
        self.view.endEditing(true)
    }
    
    func succesChange() {
        alertLoader.dismiss(animated: true, completion: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.present(self.alertSuccess, animated: true, completion: nil)
            self.btnAccpet.isEnabled = true
        }
        
        Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { (timer) in
            self.alertSuccess.dismiss(animated: true, completion: nil)
            Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { (tim) in
                self.navigationController?.popToRootViewController(animated: true)
            }
        }
    }
    
    func errorChange() {
        alertLoader.dismiss(animated: true, completion: nil)
        btnAccpet.isEnabled = true
        alertFields = AcceptAlert.showAlert(titulo: "Atención", mensaje: "Datos incorrectos, intenta de nuevo")
        alertFields!.view.backgroundColor = .clear
        present(alertFields!, animated: true)
    }
    
    func statusResponse2() {
       // alertLoader.dismiss(animated: true, completion: nil)
        self.canResend = false
        btnResend.isEnabled = true
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { (timer) in
            self.present(self.alertSuccessResend, animated: true, completion: nil)
            Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { (tim) in
                self.alertSuccessResend.dismiss(animated: true, completion: nil)
                self.numberFieldsCollection.forEach { (fielf) in
                    fielf.text = ""
                }
                UIView.animate(withDuration: 0.3) {
                    self.btnResend.alpha = 0
                    self.lblDescTimer.alpha = 1
                    self.lblTimer.alpha = 1
                }
            }
        }
        print("Todo cool bro, puedes seguir")
    }
    
    func succesUserInfo(data: UserInfo) {
        print(data)
        lblPhone.text = data.UserAttributes?.phone_number
    }
    
    func failUserInfo() {
        print("Error bro")
    }
    
    @IBAction func acceptAction(_ sender: Any) {
        print("acceptAction")
        print(passwordField.text)
        print(confirmPasswordField.text)
        if passwordField.text != "" && confirmPasswordField.text != "" {
            if passwordField.text != confirmPasswordField.text{
                mensaje = "Las contraseñas deben de coincidir"
                alertFields = AcceptAlert.showAlert(titulo: "Atención", mensaje: mensaje)
                alertFields!.view.backgroundColor = .clear
                present(alertFields!, animated: true)
            } else {
                self.showLoading()
                let singleton = ForgotPViewController.singleton
                let completeCode = "\(numberFieldsCollection[0].text ?? "0")\(numberFieldsCollection[1].text ?? "0")\(numberFieldsCollection[2].text ?? "0")\(numberFieldsCollection[3].text ?? "0")\(numberFieldsCollection[4].text ?? "0")\(numberFieldsCollection[5].text ?? "0")"
                presenter?.postParamsChange(email: singleton.emailParam, code: completeCode, input: passwordField.text)
                btnAccpet.isEnabled = false
            }
        }else{
            mensaje = "Faltan campos por llenar"
            alertFields = AcceptAlert.showAlert(titulo: "Atención", mensaje: mensaje)
            alertFields!.view.backgroundColor = .clear
            present(alertFields!, animated: true)
        }
        
        
    }
    @IBAction func btDismiss(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func resendAction(_ sender: Any) {
        
        if self.canResend == false{
            let alert = AcceptAlert.showAlert(titulo: "", mensaje: "No podrás solicitar otro código hasta pasando tres minutos")
            alert.view.backgroundColor = .clear
            present(alert, animated: true)
        }else{
            let singleton = ForgotPViewController.singleton
            timer.start(to: .otpTimeout)
            presenter?.postData2(dataEmail: singleton.emailParam)
            btnResend.isEnabled = false
        }
        
    }
    
    @IBAction func corregirUserAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
       
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

extension ConfirmationCodeView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
        print("ConfirmationCodeView")
        switch passwordField {
        case passwordField:
            confirmField.becomeFirstResponder()
        default:
            self.view.endEditing(true)
        }

        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField.tag {
        case 7, 8:
            btnAccpet.isEnabled = false
        default:
            print("Default")
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
       
        switch textField.tag {
        case 7:
            
            btnAccpet.isEnabled = true
            print("Case 7")
                if passwordField.text == confirmPasswordField.text {
                    if checkTextSufficientComplexity(text: passwordField.text) == true {
                        canContinue = true
                        print("sigue")
                    }else{
                        print("CAS 7")
                        canContinue = false
                        mensaje = "La contraseña debe tener 8 caracteres y al menos una letra mayúscula, un número y carácter especial"
                        alertFields = AcceptAlert.showAlert(titulo: "Atención", mensaje: mensaje)
                    }

                }else{
                    print("CAS 7 AFUERA")
                    canContinue = false
                    mensaje = "Las contraseñas deben coincidir"
                    alertFields = AcceptAlert.showAlert(titulo: "Atención", mensaje: mensaje)

                }
            
        case 8:
           
            btnAccpet.isEnabled = true
            print("Case 8")
            if confirmPasswordField.text == passwordField.text {
                if checkTextSufficientComplexity(text: confirmPasswordField.text) == true {
                    print("sigue")
                    canContinue = true
                }else{
                    print("CAS 8 AFUERA")
                    canContinue = false
                    mensaje = "La contraseña debe tener 8 caracteres y al menos una letra mayúscula, un número y carácter especial"
                    alertFields = AcceptAlert.showAlert(titulo: "Atención", mensaje: mensaje)
                }

            }else{
                print("CAS 8 AFUERA")
                canContinue = false
                mensaje = "Las contraseñas deben coincidir"
                alertFields = AcceptAlert.showAlert(titulo: "Atención", mensaje: mensaje)

            }
            
        default:
            print("deafult")
        }
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        var count = 8
        switch textField.tag {
        case 7, 8:
            print("filed pass")
            return true
            
        default:
            print("fields number")
            //This lines allows the user to delete the number in the textfield.
            if string.isEmpty{
                
              //  if numberFieldsCollection[0].text != "" {
                    print("Ve pa atrás")
                    
                    switch textField.tag {
                    case 1:
                        DispatchQueue.main.async {
                            self.view.endEditing(true)
                        }
                        
                    case 2:
                        DispatchQueue.main.async {
                            self.numberFieldsCollection[0].becomeFirstResponder()
                        }
                       
                        
                    case 3:
                        DispatchQueue.main.async {
                            self.numberFieldsCollection[1].becomeFirstResponder()
                        }
                       
                        
                    case 4:
                        DispatchQueue.main.async {
                            self.numberFieldsCollection[2].becomeFirstResponder()
                        }
                       
                        
                    case 5:
                        DispatchQueue.main.async {
                            self.numberFieldsCollection[3].becomeFirstResponder()
                        }
                       
                        
                    case 6:
                        DispatchQueue.main.async {
                            self.numberFieldsCollection[4].becomeFirstResponder()
                        }
//                        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { (timer) in
//
//                        }
                        
                    default:
                        print("Deafult")
                    }
                    
                
                return true
            }
            //----------------------------------------------------------------
            
            //This lines prevents the users from entering any type of text.
            if Int(string) == nil {
                return false
            }
            //----------------------------------------------------------------
            
            //This lines lets the user copy and paste the One Time Code.
            //For this code to work you need to enable subscript in Strings https://gist.github.com/JCTec/6f6bafba57373f7385619380046822a0
            
            codeStr.append(string)
            
            if codeStr.count >= 6 {
                numberFieldsCollection[0].text = codeStr[0]
                numberFieldsCollection[1].text = codeStr[1]
                numberFieldsCollection[2].text = codeStr[2]
                numberFieldsCollection[3].text = codeStr[3]
                numberFieldsCollection[4].text = codeStr[4]
                numberFieldsCollection[5].text = codeStr[5]
                
                DispatchQueue.main.async {
                    self.view.endEditing(true)
                }
                codeStr.removeAll()
                
            }
            
            //----------------------------------------------------------------
            
            //This is where the magic happens. The OS will try to insert manually the code number by number, this lines will insert all the numbers one by one in each TextField as it goes In. (The first one will go in normally and the next to follow will be inserted manually)
            if string.count == 1 {
                if (textField.text?.count ?? 0) == 1 && textField.tag == 0{
                    if (numberFieldsCollection[1].text?.count ?? 0) == 1{
                        if (numberFieldsCollection[2].text?.count ?? 0) == 1{
                            if (numberFieldsCollection[3].text?.count ?? 0) == 1{
                                if (numberFieldsCollection[4].text?.count ?? 0) == 1{
                                    numberFieldsCollection[5].text = string
                                    DispatchQueue.main.async {
                                        self.dismissKeyboard()
                                        // self.validCode()
                                    }
                                    return false
                                }else{
                                    numberFieldsCollection[5].text = string
                                    return false
                                }
                            }else{
                                numberFieldsCollection[4].text = string
                                return false
                            }
                        }else{
                            numberFieldsCollection[3].text = string
                            return false
                        }
                    }else{
                        numberFieldsCollection[2].text = string
                        return false
                    }
                }
            }
            //----------------------------------------------------------------
            
            
            //This lines of code will ensure you can only insert one number in each UITextField and change the user to next UITextField when function ends.
            guard let textFieldText = textField.text,
                  let rangeOfTextToReplace = Range(range, in: textFieldText) else {
                return false
            }
            let substringToReplace = textFieldText[rangeOfTextToReplace]
            count = textFieldText.count - substringToReplace.count + string.count
            
            
            if count == 1{
                if textField.tag == 1{
                    DispatchQueue.main.async {
                        self.numberFieldsCollection[1].becomeFirstResponder()
                    }
                    
                }else if textField.tag == 2{
                    DispatchQueue.main.async {
                        self.numberFieldsCollection[2].becomeFirstResponder()
                    }
                    
                }else if textField.tag == 3{
                    DispatchQueue.main.async {
                        self.numberFieldsCollection[3].becomeFirstResponder()
                    }
                    
                }else if textField.tag == 4{
                    DispatchQueue.main.async {
                        self.numberFieldsCollection[4].becomeFirstResponder()
                    }
                    
                }else if textField.tag == 5{
                    DispatchQueue.main.async {
                        self.numberFieldsCollection[5].becomeFirstResponder()
                    }
                    
                }else {
                    DispatchQueue.main.async {
                        self.dismissKeyboard()
                        // self.validCode()
                    }
                }
            }
            
            if count == 0 {
                print("Es cero")
            }
            
            pos += 1
            
            return count <= 1
        }
        
    }
    
    func shouldChangeCustomOtp(textField:UITextField) ->Bool {

        
        switch textField.tag {
        case 1:
            let str = self.numberFieldsCollection[0].text ?? "000000"
            
            str.forEach { (char) in
                codeStr.append("\(char)")
            }
            
            print(codeStr)
        case 2:
            Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { (timer) in
                self.numberFieldsCollection[2].becomeFirstResponder()
            }
            
        case 3:
            Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { (timer) in
                self.numberFieldsCollection[3].becomeFirstResponder()
            }
            
        case 4:
            Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { (timer) in
                self.numberFieldsCollection[4].becomeFirstResponder()
            }
            
        case 5:
            Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { (timer) in
                self.numberFieldsCollection[5].becomeFirstResponder()
            }
            
        case 6:
            Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { (timer) in
                self.view.endEditing(true)
            }
            
        default:
            print("default")
        }
        
        return true

    }
    
    func textFieldDidChange(_ textField: UITextField) {
        
        switch textField.tag {
        case 1:
            if textField.text?.count == 1 {
                print("Salta de field2")
            }
            
        case 2:
            if textField.text?.count == 1 {
                print("Salta de field3")
            }
            
        case 3:
            if textField.text?.count == 1 {
                print("Salta de field4")
            }
            
        case 4:
            if textField.text?.count == 1 {
                print("Salta de field5")
            }
            
        case 5:
            if textField.text?.count == 1 {
                print("Salta de field6")
            }
            
        case 6:
            if textField.text?.count == 1 {
                print("quita el teclado")
            }
        default:
            print("default")
        }
        
    }
}

extension StringProtocol {
    subscript(offset: Int) -> Element {
        return self[index(startIndex, offsetBy: offset)]
    }
    subscript(_ range: Range<Int>) -> SubSequence {
        return prefix(range.lowerBound + range.count)
            .suffix(range.count)
    }
    subscript(range: ClosedRange<Int>) -> SubSequence {
        return prefix(range.lowerBound + range.count)
            .suffix(range.count)
    }
    subscript(range: PartialRangeThrough<Int>) -> SubSequence {
        return prefix(range.upperBound.advanced(by: 1))
    }
    subscript(range: PartialRangeUpTo<Int>) -> SubSequence {
        return prefix(range.upperBound)
    }
    subscript(range: PartialRangeFrom<Int>) -> SubSequence {
        return suffix(Swift.max(0, count - range.lowerBound))
    }
}

extension LosslessStringConvertible {
    var string: String { return .init(self) }
}

extension BidirectionalCollection {
    subscript(safe offset: Int) -> Element? {
        guard !isEmpty, let i = index(startIndex, offsetBy: offset, limitedBy: index(before: endIndex)) else { return nil }
        return self[i]
    }
}

//MARK: - ECUTimerDelegate
extension ConfirmationCodeView: ECUTimerDelegate {
    func timerOnStop() {
        self.lblDescTimer.alpha = 0
        self.lblTimer.alpha = 0
        self.btnResend.alpha = 1
        self.canResend = true
    }
    
    func timer(onUpdate countdown: Int) {
        self.lblTimer.text = countdown.secondstoTimeString()
    }
}


//MARK: - Private functions
extension ConfirmationCodeView {
    private func setupUI() {
        setupFields()
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
