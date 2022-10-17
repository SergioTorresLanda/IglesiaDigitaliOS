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

class RegisterNewViewController: BaseVC {
    //MARK: - Protocol Properties
    var presenter: RegisterPresenterProtocol?
    
    //MARK: - IBOutlets
    @IBOutlet weak var nameField: ECUField!
    @IBOutlet weak var firstLastNameField: ECUField!
    @IBOutlet weak var secondLastNameField: ECUField!
    @IBOutlet weak var phoneField: ECUField!
    @IBOutlet weak var birthdateField: ECUField!
    @IBOutlet weak var emailField: ECUField!
    @IBOutlet weak var passwordfield: ECUField!
    @IBOutlet weak var confirmPasswordField: ECUField!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    @IBOutlet weak var continueButton: UIButton!
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}

extension RegisterNewViewController: RegisterViewProtocol {
    
    // TODO: implement view output methods
    func resetButton() {
        toggleLoading(show: false)
    }
    
    func mostrarMSG(dtcAlerta: [String : String]) {
        toggleLoading(show: true)
        
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
extension RegisterNewViewController {
    private func toggleLoading(show: Bool) {
        continueButton.isEnabled = !show
        show ? loader.startAnimating() : loader.stopAnimating()
        loader.isHidden = !show
    }
    
    private func setupFields() {
        let validName: (_ value: String) -> Bool = { $0.evaluateRegEx(for: ".*[^A-Za-zÁÉÍÓÚáéíóúñÑ ].*") }
        
        nameField.shouldChangeCharacters = validName
        nameField.textField.textContentType = .givenName
        nameField.textField.autocapitalizationType = .words
        nameField.validations = [
            ECUFieldGenericValidation.required.getValidation()
        ]
        
        firstLastNameField.shouldChangeCharacters = validName
        firstLastNameField.textField.textContentType = .middleName
        firstLastNameField.textField.autocapitalizationType = .words
        firstLastNameField.validations = [
            ECUFieldGenericValidation.required.getValidation()
        ]
        
        secondLastNameField.shouldChangeCharacters = validName
        secondLastNameField.textField.textContentType = .familyName
        secondLastNameField.textField.autocapitalizationType = .words
        
        phoneField.shouldChangeCharacters = { $0.evaluateRegEx(for: "^(\\d+){10}$") }
        phoneField.shouldChangeCharacters = { $0.evaluateRegEx(for: "^(\\d+){10}$") }
        phoneField.textField.keyboardType = .numberPad
        phoneField.validations = [
            ECUFieldGenericValidation.required.getValidation()
        ]
        
        
    }
}
