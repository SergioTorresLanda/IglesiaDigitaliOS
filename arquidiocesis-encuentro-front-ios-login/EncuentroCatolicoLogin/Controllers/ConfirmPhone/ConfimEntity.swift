import Foundation

struct ResponseConfirm: Codable {
    let UserConfirmed: Bool
    let UserSub: String
    init(UserConfirmed: Bool, UserSub: String) {
        self.UserConfirmed = UserConfirmed
        self.UserSub = UserSub
    }
}

public struct UserConfirmarCodigo: Codable {
    let username: String
    init(username: String) {
        self.username = username
    }
}

struct BodyConfirm: Codable {
    let username: String
    let code: String
    
    init(username: String, code: String) {
        self.username = username
        self.code = code
    }
}

enum ErroresConfirm: Error {
    case OK
    case OKCodigo
    case DatosVacios
    case ContraIncorrecta
    case ErrorServidor
}

enum ErroresServidorConfirm: Error {
    case ErrorInterno
    case ErrorServidor
    case ErrorCodigo
    case Ok
    case OkReenviarCodigo
    case UsuarioExistente
    case ErrorContrasena
}
