import Foundation
import UIKit
import EncuentroCatolicoHome
import EncuentroCatolicoProfile

class LoginPresenter  {
    
    // MARK: Properties
    weak var view: LoginViewProtocol?
    var interactor: LoginInteractorInputProtocol?
    var wireFrame: LoginWireFrameProtocol?
    let onboarding = UserDefaults.standard.bool(forKey: "onboarding")
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
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                    if !self.onboarding {
                       // let view = Vista1WireFrame.createModule()
                        //let view = OnBoardingCCWireFrame.createModule()
                       // let view = NewOnboardingRouter.createModule(typeOnboarding: "FirstOnboarding")
                       // view.modalPresentationStyle = .overFullScreen
                        UserDefaults.standard.set("true", forKey: "NewOnboarding")
                        let view = SocialNetworkController(nibName: "SocialNetworkController", bundle: Bundle(for: SocialNetworkController.self))
                        self.controla.navigationController?.pushViewController(view, animated: true)
                       // self.controla?.navigationController?.pushViewController(view, animated: true)
                           }
                           else {
                           // let view = Vista1WireFrame.createModule()
                            //let view = OnBoardingCCWireFrame.createModule()
                           // let view = NewOnboardingRouter.createModule(typeOnboarding: "FirstOnboarding")
                            UserDefaults.standard.set("true", forKey: "NewOnboarding")
                            let view = SocialNetworkController(nibName: "SocialNetworkController", bundle: Bundle(for: SocialNetworkController.self))
                            view.modalPresentationStyle = .overFullScreen
                            self.controla.navigationController?.pushViewController(view, animated: true)
                            //self.controla?.navigationController?.pushViewController(view, animated: true)
                           }
                  //  self.wireFrame?.loginInvitado(controller: self.controla)
                    
                })
            case .DatosVacios:
                let msg = ["titulo": "Atención", "cuerpo": "Debes llenar todos los campos"]
                self.view?.mostrarMSG(dtcAlerta: msg)
            case .CelDigitos:
                let msg = ["titulo": "Atención", "cuerpo": "El celular es a 10 digitos"]
                self.view?.mostrarMSG(dtcAlerta: msg)
            case .EmailIncorrecto:
                let msg = ["titulo": "Atención", "cuerpo": "Favor de validar el email"]
                self.view?.mostrarMSG(dtcAlerta: msg)
            case .usuarioPasswordIncorrecto:
                let msg = ["titulo": "Atención", "cuerpo": "El usuario y/o contraseña son incorrectos"]
                self.view?.mostrarMSG(dtcAlerta: msg)
            case .ErrorServidor:
                let msg = ["titulo":"Error", "cuerpo": LoginPresenter.strError]
                self.view?.mostrarMSG(dtcAlerta: msg)
            case .usuarioNoExiste:
                let msg = ["titulo":"Aviso", "cuerpo": "Te invitamos a terminar el registro, por favor solicita un código de acceso"]
                self.view?.retryRegister(dtcAlerta: msg)
            }
        }
    }
    
}
