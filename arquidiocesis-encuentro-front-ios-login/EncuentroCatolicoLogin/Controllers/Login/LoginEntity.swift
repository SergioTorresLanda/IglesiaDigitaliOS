import Foundation

struct UserLogin: Codable {
    let username: String
    let password: String
    
    init(username: String, password: String) {
        self.username = username
        self.password = password
    }
}

struct ResponseLogin: Codable {
    let msg       : String?
    let error_code: Int?
    
    init(msg: String?, error_code: Int?) {
        self.msg        = msg
        self.error_code = error_code
    }
}

struct RespuestaServidor: Codable {
    let UserAttributes: UserAttributes
    let AuthenticationResult: AuthenticationResult
    init(UserAttributes: UserAttributes, AuthenticationResult: AuthenticationResult)  {
        self.UserAttributes = UserAttributes
        self.AuthenticationResult = AuthenticationResult
    }
}

struct AuthenticationResult: Codable {
    let AccessToken: String
    let RefreshToken: String
    let IdToken: String
    init(accessToken: String, refreshToken: String, idToken: String) {
        self.AccessToken = accessToken
        self.RefreshToken = refreshToken
        self.IdToken = idToken
    }
}

struct ServerErrors: Codable{
    let code: Int
    let error: String
}

struct UserAttributes: Codable {
    let name: String
    let last_name: String
    let middle_name: String?
    let phone_number: String
    let email: String
    let id: Int
    let role: String
    let profile: String
    
    init(id: Int, name: String, last_name: String, middle_name: String, phone_number: String, email: String, role: String, profile: String) {
        self.id = id
        self.name = name
        self.last_name = last_name
        self.middle_name = middle_name
        self.phone_number = phone_number
        self.email = email
        self.role = role
        self.profile = profile
    }
    
}

enum ErroresLogin: Error {
    case OK
    case DatosVacios
    case CelDigitos
    case EmailIncorrecto
    case usuarioPasswordIncorrecto
    case usuarioNoExiste
    case ErrorServidor
}

enum ErroresServidorLogin: Error {
    case ErrorInterno
    case ErrorServidor
    case usuarioNoExiste
    case usuarioPasswordIncorrecto
}


struct ProfileDetailImgH: Codable {
    var data: USerH?
}

struct USerH: Codable {
    var User: ProfileComponentsH?
}

struct ProfileComponentsH: Codable {
    var image: String?
    var community: CommunityComponents?
    var location_id: Int?
    var location_modules: [LocationComponents]?
    var profile: String?
    var life_status: LifeStatusComponents?
   
}

struct CommunityComponents: Codable {
    var id: Int?
    var name: String?
    var status: String?
}

struct LocationComponents: Codable {
    var id: Int?
    var name: String?
    var modules: [String]?
}

struct LifeStatusComponents: Codable {
    var id: Int?
    var name: String?
}
