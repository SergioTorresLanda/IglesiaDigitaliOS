import Foundation

class LoginInteractor: LoginInteractorInputProtocol {

    // MARK: Properties
    weak var presenter: LoginInteractorOutputProtocol?
    var localDatamanager: LoginLocalDataManagerInputProtocol?
    var remoteDatamanager: LoginRemoteDataManagerInputProtocol?
    
    func login(user: String, password: String) {
        if user.trimmingCharacters(in: .whitespaces) == "" || password.trimmingCharacters(in: .whitespaces) == "" {
            presenter?.respuestaValidacion(error: ErroresLogin.DatosVacios)
        } else {
            remoteDatamanager?.login(user: UserLogin(username: user, password: password))
        }
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

}

extension LoginInteractor: LoginRemoteDataManagerOutputProtocol {
    // TODO: Implement use case methods
    
    func callbackResponse(respuesta: ResponseLogin?, error: ErroresServidorLogin?, user: UserLogin) {
        if error != nil {
            switch error! {
            case .ErrorInterno:
                presenter?.respuestaValidacion(error: ErroresLogin.ErrorServidor)
            case .ErrorServidor:
                presenter?.respuestaValidacion(error: ErroresLogin.ErrorServidor)
            case .usuarioPasswordIncorrecto:
                presenter?.respuestaValidacion(error: ErroresLogin.usuarioPasswordIncorrecto)
            case .usuarioNoExiste:
                presenter?.respuestaValidacion(error: ErroresLogin.usuarioNoExiste)
            }
        } else {
            presenter?.respuestaValidacion(error: ErroresLogin.OK)
        }
    }
    
}
