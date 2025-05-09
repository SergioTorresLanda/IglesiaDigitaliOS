import Foundation
import UIKit
import EncuentroCatolicoHome
import EncuentroCatolicoProfile
import AuthenticationServices
import EncuentroCatolicoVirtualLibrary
import EncuentroCatolicoUtils
import Network
import FirebaseFirestore

class Login_Login: UIViewController {
    
    // MARK: Properties
    var presenter: LoginPresenterProtocol?
    
    //MARK: Outlets
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var txtUser: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnPassword: UIButton!
    @IBOutlet weak var viewArriba: UIView!
    @IBOutlet weak var btnRegistar: UIButton!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var btnTerms: UIButton!
    @IBOutlet weak var btnPolicity: UIButton!
    @IBOutlet weak var btnForgot: UIButton!
    @IBOutlet weak var btnEtich: UIButton!
    @IBOutlet weak var btnBiometric: UIButton!
    
    @IBOutlet weak var contentViewTerminos: UIView!
    @IBOutlet weak var btnLogIn: UIButton!
    @IBOutlet weak var contentViewIniSes: UIView!
    
    @IBOutlet weak var btnBack: UIButton!
    
    @IBOutlet weak var btnAutoLogin: UIButton!
    
    let db = Firestore.firestore()
    var colorBlue = UIColor(red: 28/255, green: 117/255, blue: 188/255, alpha: 1)
    var forceUpdate: Bool = false
    private var biometric = BiometricAuth()
    var version: Double = 0.0
    var biometricButton: Bool = UserDefaults.standard.bool(forKey: "biometricEnable")
    let loadingAlert = UIAlertController(title: "", message: "\n \n \n \n \nCargando...", preferredStyle: .alert)
    var alertFields : AcceptAlert?
    let monitor = NWPathMonitor()
    var isInternet=false
    //    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        spinner.isHidden = true
        setupView()
//        validateButtonBiometric()
        self.hideKeyboardWhenTappedAround()
        print("RemoteConfig: didLoad \(forceUpdate)")
        forceUpdateF()
        setupInternetObserver()
    }
    
    func setupInternetObserver(){
        monitor.pathUpdateHandler = { pathUpdateHandler in
                   if pathUpdateHandler.status == .satisfied {
                       print("Internet connection is on.")
                       self.isInternet=true
                   } else {
                       print("There's no internet connection.")
                       self.isInternet=false
                   }
               }
               let queue = DispatchQueue(label: "Network")
               monitor.start(queue: queue)
    }
    
    func forceUpdateF(){
        if forceUpdate {
            if version > Double(getInstalledVersion() ?? "") ?? 0.0 {
                let alert = UIAlertController(title: "Aviso", message: "Es Necesario Actualizar", preferredStyle: .alert)
                if let url = URL(string: "https://apps.apple.com/mx/app/iglesia-digital/id1559605584") {
                    alert.addAction(UIAlertAction(title: "Ir A Tienda", style: .cancel, handler: { action in
                        UIApplication.shared.open(url, options: [:]) { _ in
                            
                            exit(EXIT_SUCCESS)
                        }
                        
                    }))
                }
                
                self.present(alert, animated: true, completion: nil)
            }
        }
        monitor.pathUpdateHandler = { pathUpdateHandler in
            if pathUpdateHandler.status == .satisfied {
                print("Internet connection is on.")
                self.isInternet=true
            } else {
                print("There's no internet connection.")
                self.isInternet=false
            }
        }
        let queue = DispatchQueue(label: "Network")
        monitor.start(queue: queue)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //biometricCanValidate()
        btnRegistar.isEnabled = true
        spinner.stopAnimating()
        spinner.isHidden = true
        
        txtUser.addTarget(self, action: #selector(salta(sender:)), for: .editingDidEndOnExit)
        txtPassword.addTarget(self, action: #selector(finaliza(sender:)), for: .editingDidEndOnExit)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("VC ECLogin - LoginView")
        //configureKeyboardObservables()
        let defaults = UserDefaults.standard
        let newUser = defaults.bool(forKey: "isNewUser")
        let wantToLogin = defaults.bool(forKey: "wantToLogin")
        let stage = defaults.string(forKey: "stage")
        print("NEw USER?")
        print(newUser)
        print("Want login?")
        print(wantToLogin)
        if newUser { //ya es usuario, avanza
            print("SE SALTO EL LOGIN/REGISTRO PQ Ya esta logueado")
            NotificationCenter.default.addObserver(self, selector: #selector(popViews), name: NSNotification.Name(rawValue: "newLogOut"), object: nil)
            openHome()
        }else if !wantToLogin{ //no es usuario, se loguea con dummy
            print("SE SALTO EL LOGIN/REGISTRO 2")
            if stage == "Prod"{
                lookForAutomaticCredentials(collection: "CredencialesDummyApp")
                //autoLogin(user:"priest1@gmail.com", psw:"Priest1*")
            }else{
                lookForAutomaticCredentials(collection: "CredencialesDummyAppQA")
                //autoLogin(user:"5584008568", psw:"I1992i15#")
            }
        }else{
            biometricCanValidate()
            print("ni una ni otra, aqui se queda para login/ registro")
        }
        //else, se queda para hacer registro/login
    }
    
    func lookForAutomaticCredentials(collection:String){
        db.collection(collection).whereField("activo", isEqualTo: true)
            .getDocuments() { (qS, err) in
                if let err = err {
                    self.showCanonAlert(titulo: "Atención", mensaje: "Por el momento no se puede acceder a la app sin registro previo.")
                    print("Error getting documents: \(err)")
                } else {
                    for doc in qS!.documents {
                        print("LAS AUTO CREDENCIALES SON::") //QA bien
                        print("\(doc.documentID) => \(doc.data())")
                        let user = doc.get("usuario") as? String ?? ""
                        let psw = doc.get("contrasena") as? String ?? ""
                        self.autoLogin(user: user, psw: psw)
                    }
                }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        hideLoading()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        txtUser.text = ""
        txtPassword.text = ""
    }
    
    @objc private func salta(sender: UITextField) {
        let nextField = sender.superview?.viewWithTag(sender.tag + 1)
        nextField?.becomeFirstResponder()
    }
    
    @objc private func finaliza(sender: UITextField) {
        self.dismissKeyboard()
    }
    
    deinit {
        biometricValidations()
    }
    
    @IBAction func autoLoginClick(_ sender: Any) {
        print("SE SALTO EL LOGIN/REGISTRO 2")
        let stage = UserDefaults.standard.string(forKey: "stage")
            //autoLogin(user:"5584008568", psw:"I1992i15#")
        if stage == "Prod"{
            lookForAutomaticCredentials(collection: "CredencialesDummyApp")
            //autoLogin(user:"priest1@gmail.com", psw:"Priest1*")
        }else{
            lookForAutomaticCredentials(collection: "CredencialesDummyAppQA")
            //autoLogin(user:"9545407746", psw:"Sergio1*")
        }
    }
    
    func autoLogin(user:String, psw:String){
        let vD = validatePhoneMail(toValidate: user)
        print("Auto login: "+vD + " " + psw)
        UserDefaults.standard.set("true", forKey: "NewOnboarding")
        UserDefaults.standard.setValue(true, forKey: "autoLogin")
        spinner.isHidden = false
        spinner.startAnimating()
        showLoading()
        presenter?.controla = self
        presenter?.login(user: vD, password: psw)
    }
    
    func openHome(){
        let instance = FirebaseManager.shared.getSNFirebaseInstance()
        let view = SocialNetwork.openSocialNetowrk(firebaseApp: instance)
        view.modalPresentationStyle = .fullScreen
        self.present(view, animated: true)
        //antes desde el loginPresenter
        /*
        let view = SocialNetworkController(nibName: "SocialNetworkController", bundle: Bundle(for: SocialNetworkController.self))
        view.modalPresentationStyle = .overFullScreen
        self.navigationController?.pushViewController(view, animated: true)*/
    }

    private func getInstalledVersion() -> String? {
        if let info = Bundle.main.infoDictionary,
           let currentVersion = info["CFBundleShortVersionString"] as? String {
            return currentVersion
        }
        return nil
    }
    
    @objc func popViews(){
        for controller in self.navigationController!.viewControllers as Array {
            if controller.isKind(of: Login_Login.self) {
                self.navigationController!.popToViewController(controller, animated: true)
                break
            }
        }
    }
    
    private func setupView(){
        contentViewTerminos.isHidden = false
        contentViewIniSes.isHidden = true
        btnBack.isHidden = true
        btnLogin.layer.masksToBounds = true
        btnLogin.setCorner(cornerRadius: 10)
        viewArriba.layer.cornerRadius = 30
        viewArriba.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        btnRegistar.layer.borderWidth = 1
        btnRegistar.layer.borderColor = UIColor(red: 25/255, green: 42/255, blue: 115/255, alpha: 1).cgColor
        btnAutoLogin.layer.borderWidth = 1
        btnAutoLogin.layer.borderColor = UIColor(red: 25/255, green: 42/255, blue: 115/255, alpha: 1).cgColor
        btnForgot.underlineButtonsWithFont(sizeFont: 13, textColor: colorBlue, text: "Olvidé contraseña", font: "SEMI")
        btnBiometric.underlineButtonsWithFont(sizeFont: 13, textColor: colorBlue, text: "Inicio de sesión biométrico", font: "SEMI")
        btnTerms.underlineButtons(sizeFont: 11, textColor: colorBlue, text: "Términos y condiciones")
        btnPolicity.underlineButtons(sizeFont: 11, textColor: colorBlue, text: "Política de privacidad")
        btnEtich.underlineButtons(sizeFont: 11, textColor: colorBlue, text: "Código de ética")
    }
    
    func showLoading(){
        let imageView = UIImageView(frame: CGRect(x: 100, y: 15, width: 80, height: 80))//mitad es en 145dp
        imageView.image = UIImage(named: "iconoIglesia3", in: Bundle(identifier: "mx.arquidiocesis.EncuentroCatolicoLogin"), compatibleWith: nil)
        loadingAlert.view.addSubview(imageView)
        loadingAlert.view.backgroundColor = .white
        loadingAlert.view.layer.cornerRadius = 20
        loadingAlert.view.ShadowNavBar()
        self.present(loadingAlert, animated: true, completion: nil)
    }
    
    private func validatePhoneMail(toValidate: String)->String {
        if isValidPhone(phone: toValidate) {
            return "+52\(toValidate)"
        }else if isValidEmail(email: toValidate){
            return toValidate
        }
        return toValidate
    }
    
    private func biometricValidations() {
        
        biometric.evaluate { [weak self] (success, error) in
            guard self != nil else {return}
            switch success {
            case true:
                let userValue = UserDefaults.standard.string(forKey: "email")
                let drws = DAKeychain.shared["miIglesia"]
                    self?.btnRegistar.isEnabled = false
                    self?.spinner.isHidden = false
                    self?.spinner.startAnimating()
                    self?.showLoading()
                    self?.presenter?.controla = self
                    self?.presenter?.login(user: userValue ?? "", password: drws ?? "")
            case false:
                break
            }
        }
    }
    
    private func biometricCanValidate() {
        let userValue = UserDefaults.standard.string(forKey: "emailForBiometric") ?? ""
        let drws = DAKeychain.shared["miIglesia"] ?? ""
    
        guard userValue != "",
              drws != "" else {
            print("CONDICION 1 ELSE")
            btnBiometric.isHidden = true
            btnRegistar.backgroundColor = UIColor.init(red: 17/255, green: 33/255, blue: 129/255, alpha: 1)
            btnRegistar.setTitleColor(UIColor.white, for: UIControl.State())
            //btnAutoLogin.backgroundColor = UIColor.init(red: 17/255, green: 33/255, blue: 129/255, alpha: 1)
            //btnAutoLogin.setTitleColor(UIColor.white, for: UIControl.State())
            btnLogIn.backgroundColor = UIColor.clear
            btnLogIn.setTitleColor(UIColor.init(red: 17/255, green: 33/255, blue: 129/255, alpha: 1), for: UIControl.State())
            btnLogIn.layer.borderWidth = 1
            btnLogIn.layer.borderColor = UIColor(red: 25/255, green: 42/255, blue: 115/255, alpha: 1).cgColor
            return
        }
        
        biometric.canEvaluate { (canEvaluate, typeBio, canEvaluateError) in
            print("CONDICION 2 ELSE")
            switch typeBio {
            case .none, .unknown:
                btnBiometric.isHidden = true
                btnRegistar.backgroundColor = UIColor.init(red: 17/255, green: 33/255, blue: 129/255, alpha: 1)
                btnRegistar.setTitleColor(UIColor.white, for: UIControl.State())
                btnLogIn.backgroundColor = UIColor.clear
                btnLogIn.setTitleColor(UIColor.init(red: 17/255, green: 33/255, blue: 129/255, alpha: 1), for: UIControl.State())
                btnLogIn.layer.borderWidth = 1
                btnLogIn.layer.borderColor = UIColor(red: 25/255, green: 42/255, blue: 115/255, alpha: 1).cgColor
                print("CONDICION 2.1 ELSE")
                return
            case .touchID, .faceID:
                break
            }
            
            if canEvaluate {
                btnBiometric.isHidden = false
            }else {
                print("CONDICION 2 ELSE x")
                btnBiometric.isHidden = true
            }
        
            //pinta botones login
            btnLogIn.backgroundColor = UIColor.init(red: 17/255, green: 33/255, blue: 129/255, alpha: 1)
            btnLogIn.setTitleColor(UIColor.white, for: UIControl.State())
           
            btnRegistar.backgroundColor = UIColor.clear
            btnRegistar.setTitleColor(UIColor.init(red: 17/255, green: 33/255, blue: 129/255, alpha: 1), for: UIControl.State())
            btnRegistar.layer.borderWidth = 1
            btnRegistar.layer.borderColor = UIColor(red: 25/255, green: 42/255, blue: 115/255, alpha: 1).cgColor
            btnAutoLogin.backgroundColor = UIColor.clear
            btnAutoLogin.setTitleColor(UIColor.init(red: 17/255, green: 33/255, blue: 129/255, alpha: 1), for: UIControl.State())
            btnAutoLogin.layer.borderWidth = 1
            btnAutoLogin.layer.borderColor = UIColor(red: 25/255, green: 42/255, blue: 115/255, alpha: 1).cgColor
        }
    }
    
    
    @IBAction func btnActionLogin(_ sender: Any) {
        self.contentViewIniSes.isHidden = false
        self.btnBack.isHidden = false
        self.contentViewTerminos.isHidden = true
    }
    
    @IBAction func btnActionBackToTop(_ sender: Any) {
        self.contentViewIniSes.isHidden = true
        self.btnBack.isHidden = true
        self.contentViewTerminos.isHidden = false
        self.txtUser.text = ""
        self.txtPassword.text = ""
        // presenter?.back(controller: self)
    }
    
    //MARK: - Actions
    @IBAction func olvidoPass(_ sender: Any) {
        presenter?.olvidoPass(controlador: self)
    }
    
    @IBAction func login(_ sender: Any) {
        UserDefaults.standard.setValue(false, forKey: "autoLogin")
        let validatedData = validatePhoneMail(toValidate: txtUser.text ?? "")
        btnRegistar.isEnabled = false
        if isInternet {
            spinner.isHidden = false
            spinner.startAnimating()
            showLoading()
            presenter?.controla = self
            presenter?.login(user: validatedData, password: txtPassword.text ?? "")
        } else {
            showCanonAlert(titulo: "Atención", mensaje: "No tienes conexión a internet.")
        }
    }
    
    func showCanonAlert(titulo:String, mensaje:String){
        alertFields = AcceptAlert.showAlert(titulo: titulo, mensaje: mensaje)
        alertFields!.view.backgroundColor = .clear
        present(alertFields!, animated: true)
    }
    
    @IBAction func loginInvitado(_ sender: Any) {
        presenter?.loginInvitado(controller: self)
    }
    
    @IBAction func crearCuenta(_ sender: Any) {
        presenter?.crearCuenta(controlador: self)
    }
    
    @IBAction func showPassword(_ sender: Any) {
        let module = Bundle(for: Login_Login.self)
        txtPassword.isSecureTextEntry = !txtPassword.isSecureTextEntry
        
        btnPassword.setImage(UIImage(named: !txtPassword.isSecureTextEntry ? "hideEye" : "showEye", in: module, compatibleWith: nil), for: .normal)
        btnPassword.tintColor = .gray
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
    
    @IBAction func eticButton(_ sender: Any) {
        guard let url = URL(string: "https://arquidiocesismexico.org.mx/aviso-de-privacidad/") else { return }
        UIApplication.shared.open(url)
    }
    
    
    @IBAction func biometricLogin(_ sender: Any) {
        if isInternet{
            biometricValidations()
        } else {
            self.alertFields = AcceptAlert.showAlert(titulo: "Atención", mensaje: "No tienes conexión a internet.")
            self.alertFields!.view.backgroundColor = .clear
            self.present(self.alertFields!, animated: true)
        }
        
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        scrollView.contentOffset.y = 185
    }
    
    @objc private func keyboardDidHide(notification: NSNotification) {
        scrollView.contentOffset.y = 0
    }
}


extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}


extension Login_Login: LoginViewProtocol {
    // TODO: implement view output methods
    func mostrarMSG(dtcAlerta: [String : String]) {
        loadingAlert.dismiss(animated: true, completion: {
            self.btnRegistar.isEnabled = true
            self.spinner.stopAnimating()
            self.spinner.isHidden = true
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            self.alertFields = AcceptAlert.showAlert(titulo: dtcAlerta["titulo"]!, mensaje: dtcAlerta["cuerpo"]!)
            self.alertFields!.view.backgroundColor = .clear
            self.present(self.alertFields!, animated: true)
            
        })
    }
    
    func retryRegister(dtcAlerta: [String : String]) {
        loadingAlert.dismiss(animated: true, completion: {
            self.btnRegistar.isEnabled = true
            self.spinner.stopAnimating()
            self.spinner.isHidden = true
            let alerta = UIAlertController(title: dtcAlerta["titulo"], message: dtcAlerta["cuerpo"], preferredStyle: .alert)
            alerta.addAction(UIAlertAction(title: "Solicitar código", style: .default, handler: {_ in
                var dato = self.txtUser.text ?? ""
                if  !dato.isValidEmailSP(){
                    dato = "+52" + dato
                }
                let model = UserRegister(username: dato, email: "", phone_number: dato, password: "", name: "", last_name: "", middle_name: "", role: "", type_person: "", birth_date: "")
                let view  = ConfirmPhoneWireFrame.createConfirmPhoneModule(usuario: model)
                self.navigationController?.pushViewController(view, animated: true)
            }))
            self.present(alerta, animated: true, completion: nil)
        })
    }
    
    func hideLoading(){
        loadingAlert.dismiss(animated: true, completion: nil)
    }
    
    
    
}

extension Login_Login {

    func isValidPhone(phone: String) -> Bool {
        let phoneRegex = "^[0-9+]{0,1}+[0-9]{5,16}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phoneTest.evaluate(with: phone)
    }
    
    func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    func alert(title: String, message: String, okActionTitle: String) {
        let alertView = UIAlertController(title: title,
                                          message: message,
                                          preferredStyle: .alert)
        let okAction = UIAlertAction(title: okActionTitle, style: .default)
        alertView.addAction(okAction)
        present(alertView, animated: true)
    }
    
}

extension UIView {
    
    func ShadowNavBar() {
        clipsToBounds = true
        layer.shadowRadius = 5
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        layer.shadowOpacity = 0.5
        layer.masksToBounds = false
    }
    
    func ShadowCard() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 4.0
    }
}
