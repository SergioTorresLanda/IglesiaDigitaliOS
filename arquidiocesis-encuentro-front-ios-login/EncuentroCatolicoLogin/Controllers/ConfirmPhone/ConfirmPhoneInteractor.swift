import Foundation

class ConfirmPhoneInteractor: ConfirmPhoneInteractorInputProtocol {

    // MARK: Properties
    weak var presenter: ConfirmPhoneInteractorOutputProtocol?
    var localDatamanager: ConfirmPhoneLocalDataManagerInputProtocol?
    var remoteDatamanager: ConfirmPhoneRemoteDataManagerInputProtocol?
    
    func reenviarCodigo(user: UserRegister) {
        remoteDatamanager?.reenviarCodigo(user: UserConfirmarCodigo(username: user.email))
    }
    
    func crearCuenta(user: UserRegister, codigo: String) {
        if codigo.count != 6 {
            presenter?.respuestaValidacion(error: ErroresConfirm.DatosVacios, user: user)
        } else {
            remoteDatamanager?.validaCodigo(user: user, codigo: codigo)
        }
    }

}

extension ConfirmPhoneInteractor: ConfirmPhoneRemoteDataManagerOutputProtocol {
    // TODO: Implement use case methods
    
    func callbackResponse(respuesta: ResponseConfirm?, error: ErroresServidorConfirm?, user: UserRegister?) {
        if error != nil {
            switch error! {
            case .ErrorInterno:
                presenter?.respuestaValidacion(error: ErroresConfirm.ErrorServidor, user: user)
            case .ErrorServidor:
                presenter?.respuestaValidacion(error: ErroresConfirm.ErrorServidor, user: user)
            case .ErrorCodigo:
                presenter?.respuestaValidacion(error: ErroresConfirm.ContraIncorrecta, user: user)
            case .Ok:
                presenter?.respuestaValidacion(error: ErroresConfirm.OK, user: user)
            case .OkReenviarCodigo:
                presenter?.respuestaValidacion(error: ErroresConfirm.OKCodigo, user: user)
            case .UsuarioExistente:
                presenter?.respuestaValidacion(error: ErroresConfirm.ErrorServidor, user: user)
            case .ErrorContrasena:
                presenter?.respuestaValidacion(error: ErroresConfirm.ErrorServidor, user: user)
            }
        } else {
            presenter?.respuestaValidacion(error: ErroresConfirm.OK, user: user)
        }
    }
}
