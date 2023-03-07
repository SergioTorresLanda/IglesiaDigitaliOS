import Foundation
import UIKit

class RegisterInteractor: RegisterInteractorInputProtocol {

    // MARK: Properties
    weak var presenter: RegisterInteractorOutputProtocol?
    var localDatamanager: RegisterLocalDataManagerInputProtocol?
    var remoteDatamanager: RegisterRemoteDataManagerInputProtocol?
    
    func viewDidLoad(nombre: UITextField, apellido1: UITextField, apellido2: UITextField, celular: UITextField, email: UITextField, usuario: UserRegister?) {
        if usuario != nil {
            nombre.text = usuario?.name
            apellido1.text = usuario?.last_name
            apellido2.text = usuario?.middle_name
            email.text = usuario?.email
            celular.text = usuario?.phone_number.replacingOccurrences(of: "+52", with: "")
        }
    }
    
    func requestPriestData(priest:PriestRequest){
        remoteDatamanager?.requestPriestData(priest:priest)
    }
    
    func realizaValidaciones(nombre: String, apellido1: String, apellido2: String, cel: String, email: String, contra1: String, contra2: String, rol:String, typePerson:String) {
        let cel = cel.trimmingCharacters(in: .whitespaces)
        let email = email.trimmingCharacters(in: .whitespaces)
        let contra1 = contra1.trimmingCharacters(in: .whitespaces)
        let defaults = UserDefaults.standard
        
        defaults.setValue(contra1, forKey: "password")
        remoteDatamanager?.saveData(register: UserRegister(username: email, email: email, phone_number: cel, password: contra1, name: nombre, last_name: apellido1, middle_name: apellido2, role: rol, type_person: typePerson))
    }
    
    func isValidEmailAddress(emailAddressString: String) -> Bool {
        var returnValue = true
        let emailRegEx = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:.[a-zA-Z0-9-]+)*$"
        
        do {
            let regex = try NSRegularExpression(pattern: emailRegEx)
            let nsString = emailAddressString as NSString
            let results = regex.matches(in: emailAddressString, range: NSRange(location: 0, length: nsString.length))
            
            if results.count == 0 {
                returnValue = false
            }
        } catch {
            returnValue = false
        }
        
        return  returnValue
    }
    
    func isValidPassword(pass: String) -> Bool {
        var returnValue = true
        let emailRegEx = "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[\\.=+^\\$*.&{}()?\\[\\]!\\-\\?\\@#%&/\",><':;|_~`]).{8,}$"
        
        do {
            let regex = try NSRegularExpression(pattern: emailRegEx)
            let nsString = pass as NSString
            let results = regex.matches(in: pass, range: NSRange(location: 0, length: nsString.length))
            
            if results.count == 0 {
                returnValue = false
            }
        } catch {
            returnValue = false
        }
        
        return  returnValue
    }


}

extension RegisterInteractor: RegisterRemoteDataManagerOutputProtocol {
    // TODO: Implement use case methods
    func callbackResponsePriest(respuesta: ResponsePriest?, error: ErroresServidor?, user: PriestRequest){
        if error != nil {
            switch error! {
            case .ErrorInterno:
                presenter?.respuestaValidacionPriest(error: ErroresRegister.ErrorServidor, user: nil)
            case .ErrorServidor:
                presenter?.respuestaValidacionPriest(error: ErroresRegister.ErrorServidor, user: nil)
            case .UsuarioExistente:
                presenter?.respuestaValidacionPriest(error: ErroresRegister.UsuarioExistente, user: nil)
            case .ErrorContrasena:
                presenter?.respuestaValidacionPriest(error: ErroresRegister.ContraIncorrecta2, user: nil)
            case .UsuarioSinConfirmar:
                presenter?.respuestaValidacionPriest(error: ErroresRegister.UsuarioSinConfirmar, user: nil)
            }
        } else {
            presenter?.respuestaValidacionPriest(error: ErroresRegister.OK, user: respuesta)
        }
    }
    
    
    func callbackResponse(respuesta: ResponseRegister?, error: ErroresServidor?, user: UserRegister) {
        if error != nil {
            switch error! {
            case .ErrorInterno:
                presenter?.respuestaValidacion(error: ErroresRegister.ErrorServidor, user: user)
            case .ErrorServidor:
                presenter?.respuestaValidacion(error: ErroresRegister.ErrorServidor, user: user)
            case .UsuarioExistente:
                presenter?.respuestaValidacion(error: ErroresRegister.UsuarioExistente, user: user)
            case .ErrorContrasena:
                presenter?.respuestaValidacion(error: ErroresRegister.ContraIncorrecta2, user: user)
            case .UsuarioSinConfirmar:
                presenter?.respuestaValidacion(error: ErroresRegister.UsuarioSinConfirmar, user: user)
            }
        } else {
            presenter?.respuestaValidacion(error: ErroresRegister.OK, user: user)
        }
    }
    
}
