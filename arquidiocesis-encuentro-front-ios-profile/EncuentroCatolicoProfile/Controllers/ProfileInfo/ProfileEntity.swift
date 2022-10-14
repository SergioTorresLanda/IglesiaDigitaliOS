import Foundation


struct ResponseProfile: Codable {
    
    let msg       : String?
    let error_code: Int?
    
    init(msg: String?, error_code: Int?) throws {
        self.msg        = msg
        self.error_code = error_code
    }

}

public struct UserProfile: Codable {
    
    let username: String
    
    init(username: String) {
        self.username = username
    }
    
}


public struct UserRespProfile: Codable {
    
    let UserAttributes: UserAttributes
    
    public init(UserAttributes: UserAttributes) throws {
        self.UserAttributes = UserAttributes
    }
    
}

public struct UserAttributes: Codable {
    
    let email: String
    let phone_number: String
    let name: String
    let last_name: String
    let middle_name: String?
    
    init(username: String, email: String, phone_number: String, name: String, last_name: String, middle_name: String) {
        self.email = email
        self.phone_number = phone_number
        self.name = name
        self.last_name = last_name
        self.middle_name = middle_name
    }
    
}

enum ErroresProfile: Error {
    case OK
    case DatosVacios
    case CelDigitos
    case NombreMal
    case EmailIncorrecto
    case ErrorServidor
}

enum ErroresServidorProfile: Error {
    case ErrorInterno
    case ErrorServidor
    case OK
}

struct UploadImageData: Codable {
    var url : String?
    
}

struct ProfileDetailImg: Codable {
    var data: USer?
}

struct USer: Codable {
    var User: ProfileComponents?
}

struct ProfileComponents: Codable {
    var image: String?
    var life_status: LifeComponents?
    var services_provided: [ServiceProvided]?
   
}

struct LifeComponents: Codable {
    var id: Int?
    var name: String?
}

struct ServiceProvided: Codable {
    var location_name: String?
}

struct PrefixResponse: Codable {
    var data: [Prefixes]?
}

struct Prefixes: Codable {
    var id: Int?
    var description: String?
}
