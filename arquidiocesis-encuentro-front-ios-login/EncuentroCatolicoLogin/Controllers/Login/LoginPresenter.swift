import Foundation
import UIKit
import EncuentroCatolicoHome
import EncuentroCatolicoProfile

class LoginPresenter  {
    
    // MARK: Properties
    weak var view: LoginViewProtocol?
    var interactor: LoginInteractorInputProtocol?
    var wireFrame: LoginWireFrameProtocol?
    var controla: UIViewController!
    static var strError = "Error en el servidor"
}

extension LoginPresenter: LoginPresenterProtocol {
    
    func olvidoPass(controlador: UIViewController) {
        print("Forgot password")
        wireFrame?.openForgotModule(controlador: controlador)

    }
    
    func loginSuccess() {
        
    }
    
    // TODO: implement presenter methods
    func login(user: String, password: String) {
        print("presenter login")
        interactor?.login(user: user, password: password)
    }
    
    func loginInvitado(controller: UIViewController) {
        wireFrame?.loginInvitado(controller: controller)
       
    }
    
    func crearCuenta(controlador: UIViewController) {
        wireFrame?.openCreateAcount(controlador: controlador)
    }
        
}

extension LoginPresenter: LoginInteractorOutputProtocol {
    // TODO: implement interactor output methods
    
    func respuestaValidacion(error: ErroresLogin) {
        DispatchQueue.main.async {
            switch error {
            case .OK:
                self.view?.hideLoading()
                let isAutoLogin = UserDefaults.standard.bool(forKey: "autoLogin")
                if isAutoLogin{
                    UserDefaults.standard.setValue(false, forKey: "isNewUser")
                    print("YYY Login automatico, isNewUser se queda en false")
                }else{
                    print("YYY Login manual, isNewUser se va a true")
                    UserDefaults.standard.setValue(true, forKey: "isNewUser")
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.7, execute: {
                    print("presenter open home")
                    self.view?.openHome()
                })
            case .DatosVacios:
                let msg = ["titulo": "Atención", "cuerpo": "Debes llenar todos los campos."]
                self.view?.mostrarMSG(dtcAlerta: msg)
            case .CelDigitos:
                let msg = ["titulo": "Atención", "cuerpo": "El celular es a 10 dígitos."]
                self.view?.mostrarMSG(dtcAlerta: msg)
            case .EmailIncorrecto:
                let msg = ["titulo": "Atención", "cuerpo": "El usuario ingresado no existe, por favor verifíquelo."]
                self.view?.mostrarMSG(dtcAlerta: msg)
            case .usuarioPasswordIncorrecto:
                let msg = ["titulo": "Atención", "cuerpo": "La contraseña ingresada es incorrecta, por favor verifíquela."]
                self.view?.mostrarMSG(dtcAlerta: msg)
            case .ErrorServidor:
                let msg = ["titulo":"Atención", "cuerpo": "El usuario ingresado no existe, por favor verifíquelo."]//LoginPresenter.strError]
                self.view?.mostrarMSG(dtcAlerta: msg)
            case .usuarioNoExiste:
                let msg = ["titulo":"Atención", "cuerpo": "Te invitamos a terminar el registro, por favor solicita un código de acceso."]
                self.view?.retryRegister(dtcAlerta: msg)
            }
        }
    }
    
}
