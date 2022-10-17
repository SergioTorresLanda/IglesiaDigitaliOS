//
//  ConfirmPhoneViewController.swift
//  EncuentroCatolicoRegister
//
//  Created by Jorge Cruz on 01/05/21.
//

import UIKit

class ConfirmPhoneViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet var modifyNumber: UIButton!
    @IBOutlet var refreshCode: UIButton!
    @IBOutlet var refreshPhoneNumber: UIButton!
    @IBOutlet weak var txtNumber1: UITextField!
    @IBOutlet weak var txtNumber2: UITextField!
    @IBOutlet weak var txtNumber3: UITextField!
    @IBOutlet weak var txtNumber4: UITextField!
    @IBOutlet weak var txtNumber5: UITextField!
    @IBOutlet weak var txtNumber6: UITextField!
    @IBOutlet weak var txtTelefono: UILabel!
    @IBOutlet weak var btnCrear: UIButton!
    @IBOutlet weak var btnReenviar: UIButton!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    @IBOutlet var codeButton: UIButton!
    @IBOutlet var privacyButton: UIButton!
    @IBOutlet var termConditionsButton: UIButton!
    @IBOutlet var lblArriba: UIView!
    // MARK: Properties
    var presenter: ConfirmPhonePresenterProtocol?
    var usuario: UserRegister?
    var codeStr : [String] = []
    var pos = 0

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegates()
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        presenter?.viewView = view
        presenter?.viewDidLoad(txtNumber1: txtNumber1, txtNumber2: txtNumber2, txtNumber3: txtNumber3, txtNumber4: txtNumber4, txtNumber5: txtNumber5, txtNumber6: txtNumber6)
        lblArriba.layer.cornerRadius = 30
        lblArriba.layer.shadowRadius = 5
        lblArriba.layer.shadowOpacity = 0.5
        lblArriba.layer.shadowColor = UIColor.black.cgColor
        lblArriba.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        txtTelefono.text = usuario?.phone_number.replacingOccurrences(of: "+52", with: "")
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyBoard))
        
        let modifyNumberText = "Modificar número".underlineDecorative(font: UIFont.systemFont(ofSize: 14))
        let refreshPhoneNumberText = "Corregir número celular".underlineDecorative(font: UIFont.systemFont(ofSize: 14,weight: .bold))
        let refreshCodeText = "Reenviar código".underlineDecorative(font: UIFont.systemFont(ofSize: 14, weight: .bold))
        modifyNumber.setAttributedTitle(modifyNumberText, for: .normal)
        refreshCode.setAttributedTitle(refreshCodeText, for: .normal)
        refreshPhoneNumber.setAttributedTitle(refreshPhoneNumberText, for: .normal)
        
        
        let codeButtonText = "Código de ética".underlineDecorative(font: UIFont.systemFont(ofSize: 11))
        let privacyButtonText = "Política de Privacidad.".underlineDecorative(font: UIFont.systemFont(ofSize: 11))
        let termButtonText = "Términos y condiciones".underlineDecorative(font: UIFont.systemFont(ofSize: 11))
        codeButton.setAttributedTitle(codeButtonText, for: .normal)
        privacyButton.setAttributedTitle(privacyButtonText, for: .normal)
        termConditionsButton.setAttributedTitle(termButtonText, for: .normal)
        
        btnReenviar.layer.cornerRadius = 10
        btnReenviar.layer.borderWidth = 1
        btnReenviar.layer.borderColor = UIColor(red: 25/255, green: 42/255, blue: 115/255, alpha: 1).cgColor
        view.addGestureRecognizer(tap)
        loader.isHidden = true
    }
    
    private func setupDelegates() {
        txtNumber1.delegate = self
        txtNumber2.delegate = self
        txtNumber3.delegate = self
        txtNumber4.delegate = self
        txtNumber5.delegate = self
        txtNumber6.delegate = self
    }
    
    @objc private func hideKeyBoard() {
        presenter?.hideKeyBoard(view: view)
    }
    
    // MARK: Actions
    @IBAction func reenvioAction(_ sender: Any) {
        //print("-> 🚧 usuario: ",usuario!)
        txtNumber1.text = ""
        txtNumber2.text = ""
        txtNumber3.text = ""
        txtNumber4.text = ""
        txtNumber5.text = ""
        txtNumber6.text = ""
        presenter?.reenviarCodigo(user: usuario!)
       
    }
    
    @IBAction func cambiaNumero(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func crearAction(_ sender: Any) {
        btnCrear.isEnabled = false
        loader.isHidden = false
        loader.startAnimating()
        presenter?.controller = self
        let code = "\(txtNumber1.text ?? "")\(txtNumber2.text ?? "")\(txtNumber3.text ?? "")\(txtNumber4.text ?? "")\(txtNumber5.text ?? "")\(txtNumber6.text ?? "")"
        presenter?.crearCuenta(user: usuario!, newCode: code)
    }
    
    @IBAction func cancelarAction(_ sender: Any) {
        presenter?.cancelar(controller: self)
    }
    
    @IBAction func politicasAction(_ sender: Any) {
        presenter?.politicas()
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension ConfirmPhoneViewController: ConfirmPhoneViewProtocol {
    // TODO: implement view output methods
    
    func mostrarMSG(dtcAlerta: [String : String]) {
        self.btnCrear.isEnabled = true
        self.loader.stopAnimating()
        self.loader.isHidden = true
        let alerta = UIAlertController(title: dtcAlerta["titulo"], message: dtcAlerta["cuerpo"], preferredStyle: .alert)
        alerta.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: nil))
        self.present(alerta, animated: true, completion: nil)
    }
    
}

extension ConfirmPhoneViewController: UITextFieldDelegate {
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
                            self.txtNumber1.becomeFirstResponder()
                        }
                       
                        
                    case 3:
                        DispatchQueue.main.async {
                            self.txtNumber2.becomeFirstResponder()
                        }
                       
                        
                    case 4:
                        DispatchQueue.main.async {
                            self.txtNumber3.becomeFirstResponder()
                        }
                       
                        
                    case 5:
                        DispatchQueue.main.async {
                            self.txtNumber4.becomeFirstResponder()
                        }
                       
                        
                    case 6:
                        DispatchQueue.main.async {
                            self.txtNumber5.becomeFirstResponder()
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
                txtNumber1.text = codeStr[0]
                txtNumber2.text = codeStr[1]
                txtNumber3.text = codeStr[2]
                txtNumber4.text = codeStr[3]
                txtNumber5.text = codeStr[4]
                txtNumber6.text = codeStr[5]
                
                DispatchQueue.main.async {
                    self.view.endEditing(true)
                }
                codeStr.removeAll()
                
            }
            
            //----------------------------------------------------------------
            
            //This is where the magic happens. The OS will try to insert manually the code number by number, this lines will insert all the numbers one by one in each TextField as it goes In. (The first one will go in normally and the next to follow will be inserted manually)
            if string.count == 1 {
                if (textField.text?.count ?? 0) == 1 && textField.tag == 0{
                    if (txtNumber2.text?.count ?? 0) == 1{
                        if (txtNumber3.text?.count ?? 0) == 1{
                            if (txtNumber4.text?.count ?? 0) == 1{
                                if (txtNumber5.text?.count ?? 0) == 1{
                                    txtNumber6.text = string
                                    DispatchQueue.main.async {
                                        // self.validCode()
                                    }
                                    return false
                                }else{
                                    txtNumber6.text = string
                                    return false
                                }
                            }else{
                                txtNumber5.text = string
                                return false
                            }
                        }else{
                            txtNumber4.text = string
                            return false
                        }
                    }else{
                        txtNumber3.text = string
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
                        self.txtNumber2.becomeFirstResponder()
                    }
                    
                }else if textField.tag == 2{
                    DispatchQueue.main.async {
                        self.txtNumber3.becomeFirstResponder()
                    }
                    
                }else if textField.tag == 3{
                    DispatchQueue.main.async {
                        self.txtNumber4.becomeFirstResponder()
                    }
                    
                }else if textField.tag == 4{
                    DispatchQueue.main.async {
                        self.txtNumber5.becomeFirstResponder()
                    }
                    
                }else if textField.tag == 5{
                    DispatchQueue.main.async {
                        self.txtNumber6.becomeFirstResponder()
                    }
                    
                }else {
                    DispatchQueue.main.async {
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
}

