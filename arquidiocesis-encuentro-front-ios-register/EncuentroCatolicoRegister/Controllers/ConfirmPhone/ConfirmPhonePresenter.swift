import Foundation
import UIKit

class ConfirmPhonePresenter  {
    
    // MARK: Properties
    weak var view: ConfirmPhoneViewProtocol?
    var interactor: ConfirmPhoneInteractorInputProtocol?
    var wireFrame: ConfirmPhoneWireFrameProtocol?
    var codigo: String!
    var viewView: UIView!
    var controller: UIViewController!
    
}

extension ConfirmPhonePresenter: ConfirmPhonePresenterProtocol {
    
    // TODO: implement presenter methods
    func viewDidLoad(txtNumber1: UITextField, txtNumber2: UITextField, txtNumber3: UITextField, txtNumber4: UITextField, txtNumber5: UITextField, txtNumber6: UITextField) {
//        codigo = ""
//        txtNumber1.addTarget(self, action: #selector(salta(sender:)), for: .editingChanged)
//        txtNumber2.addTarget(self, action: #selector(salta(sender:)), for: .editingChanged)
//        txtNumber3.addTarget(self, action: #selector(salta(sender:)), for: .editingChanged)
//        txtNumber4.addTarget(self, action: #selector(salta(sender:)), for: .editingChanged)
//        txtNumber5.addTarget(self, action: #selector(salta(sender:)), for: .editingChanged)
//        txtNumber6.addTarget(self, action: #selector(salta(sender:)), for: .editingChanged)
//        txtNumber6.addTarget(self, action: #selector(finaliza(sender:)), for: .editingChanged)
    }
    
    @objc private func salta(sender: UITextField) {
        guard let texto = sender.text else { return }
            if texto.count > 0 {
                let nextField = sender.superview?.viewWithTag(sender.tag + 1)
                nextField?.becomeFirstResponder()
                codigo += texto
            } else {
                let nextField = sender.superview?.viewWithTag(sender.tag - 1)
                nextField?.becomeFirstResponder()
            }
       
        
    }
    
    @objc private func finaliza(sender: UITextField) {
        guard let texto = sender.text else { return }
        if texto.count > 0 {
            hideKeyBoard(view: viewView)
        }
    }
    
    func hideKeyBoard(view: UIView) {
        view.endEditing(true)
    }
    
    func reenviarCodigo(user: UserRegister) {
        interactor?.reenviarCodigo(user: user)
    }
    
    func cambiarNumero(usuario: UserRegister, controller : UIViewController) {
        wireFrame?.cambiarNumero(usuario: usuario, controller: controller)
    }
    
    func crearCuenta(user: UserRegister, newCode: String) {
        interactor?.crearCuenta(user: user, codigo: newCode)
    }
    
    func cancelar(controller: UIViewController) {
        wireFrame?.cancelar(controller: controller)
    }
    
    func politicas() {}
}

extension ConfirmPhonePresenter: ConfirmPhoneInteractorOutputProtocol {
    // TODO: implement interactor output methods
    func respuestaValidacion(error: ErroresConfirm, user: UserRegister?) {
        DispatchQueue.main.async {
            switch error {
            case .OK:
                self.wireFrame?.returnToLogin(controller: self.controller)
            case .DatosVacios:
                let msg = ["titulo": "Atención", "cuerpo": "Faltan campos por llenar"]
                self.view?.mostrarMSG(dtcAlerta: msg)
            case .ContraIncorrecta:
                let msg = ["titulo": "Atención", "cuerpo": "El código de verificación ingresado no es válido."]
                self.view?.mostrarMSG(dtcAlerta: msg)
            case .ErrorServidor:
                let msg = ["titulo":"Error", "cuerpo": "El código es incorrecto"]
                self.view?.mostrarMSG(dtcAlerta: msg)
            case .OKCodigo:
                let msg = ["titulo":"Correcto", "cuerpo": "Se envio un nuevo código a tu celular"]
                self.view?.mostrarMSG(dtcAlerta: msg)
            }
        }
    }
}
