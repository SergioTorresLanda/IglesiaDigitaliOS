import Foundation
import UIKit

class RegisterPresenter  {
    
    // MARK: Properties
    weak var view: RegisterViewProtocol?
    var interactor: RegisterInteractorInputProtocol?
    var wireFrame: RegisterWireFrameProtocol?
    var controlador: UIViewController?
    
}

extension RegisterPresenter: RegisterPresenterProtocol {
    func back(controller: UIViewController) {
        wireFrame?.back(controller: controller)
    }
    
    
    // TODO: implement presenter methods
    func viewDidLoad(nombre: UITextField, apellido1: UITextField, apellido2: UITextField, celular: UITextField, email: UITextField, usuario: UserRegister?) {
        interactor?.viewDidLoad(nombre: nombre, apellido1: apellido1, apellido2: apellido2, celular: celular, email: email, usuario: usuario)
    }
    
    func requestPriestData(priest:PriestRequest){
        interactor?.requestPriestData(priest:priest)
    }
    
    func hideKeyBoard(view: UIView) {
        view.endEditing(true)
    }
    
    func continuar(nombre: String, apellido1: String, apellido2: String, cel: String, email: String, contra1: String, contra2: String, rol:String, typePerson:String) {
        interactor?.realizaValidaciones(nombre: nombre, apellido1: apellido1, apellido2: apellido2, cel: "+52" + cel, email: email, contra1: contra1, contra2: contra2, rol: rol, typePerson: typePerson)
    }
    
    func cancelar(controller: UIViewController) {
        wireFrame?.cancelar(controller: controller)
    }
    
    func politicas() {
        
    }
    
}

extension RegisterPresenter: RegisterInteractorOutputProtocol {
    func respuestaValidacionPriest(error: ErroresRegister, user: ResponsePriest?) {
        DispatchQueue.main.async {
            switch error {
            case .OK:
                self.view?.setPrestInfo(priestInfo:user!)
            case .ErrorServidor:
                self.view?.setPrestInfo(priestInfo:ResponsePriest(name: nil, fcappaterno: nil, fcapmaterno: nil, fccelular: nil, fccorreo: nil))
            default:
            print("default case no pasa")
            }
        }
    }
    
    // TODO: implement interactor output methods
    func respuestaValidacion(error: ErroresRegister, user: UserRegister?) {
        DispatchQueue.main.async {
            switch error {
            case .OK:
                self.view?.resetButton()
                self.wireFrame?.confirmarPhone(controlador: self.controlador ?? UIViewController(), user: user!)
            case .DatosVacios:
                let msg = ["titulo": "Atención", "cuerpo": "Faltan campos por llenar"]
                self.view?.mostrarMSG(dtcAlerta: msg)
            case .ContraIncorrecta:
                let msg = ["titulo": "Atención", "cuerpo": "Las contraseñas deben coincidir"]
                self.view?.mostrarMSG(dtcAlerta: msg)
            case .CelDigitos:
                let msg = ["titulo": "Atención", "cuerpo": "El celular es a 10 digitos"]
                self.view?.mostrarMSG(dtcAlerta: msg)
            case .NombreMal:
                let msg = ["titulo": "Atención", "cuerpo": "Favor de escribir un nombre correcto"]
                self.view?.mostrarMSG(dtcAlerta: msg)
            case .EmailIncorrecto:
                let msg = ["titulo": "Atención", "cuerpo": "Favor de validar el email"]
                self.view?.mostrarMSG(dtcAlerta: msg)
            case .ErrorServidor:
                let msg = ["titulo":"Error", "cuerpo": "Error en el servidor"]
                self.view?.mostrarMSG(dtcAlerta: msg)
            case .ContraIncorrecta2:
                let msg = ["titulo": "Atención", "cuerpo": "La contraseña debe incluir al menos una letra mayúscula, una minúscula y un carácter especial"]
                self.view?.mostrarMSG(dtcAlerta: msg)
            case .UsuarioExistente:
                let msg = ["titulo": "Atención", "cuerpo": "El usuario que intentas ingresar ya existe"]
                self.view?.mostrarMSG(dtcAlerta: msg)
            case .UsuarioSinConfirmar:
//                let msg = ["titulo": "Atención", "cuerpo": "El usuario no está confirmado"]
//                self.view?.mostrarMSG(dtcAlerta: msg)
                self.view?.resetButton()
                self.wireFrame?.confirmarPhone(controlador: self.controlador ?? UIViewController(), user: user!)
            }
        }
    }
}
