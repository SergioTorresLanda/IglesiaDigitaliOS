import Foundation

public struct UserRegister: Codable {
    
    let username: String
    let email: String
    let phone_number: String
    let password: String
    let name: String
    let last_name: String
    let middle_name: String
    let role: String
    let birth_date: String
    let type_person: String
    
    init(username: String, email: String, phone_number: String, password: String, name: String, last_name: String, middle_name: String, role: String, type_person: String, birth_date: String) {
        self.username = username
        self.email = email
        self.phone_number = phone_number
        self.password = password
        self.name = name
        self.last_name = last_name
        self.middle_name = middle_name
        self.role = role
        self.type_person = type_person
        self.birth_date = birth_date
    }
    
}

struct ResponseRegister: Codable {
    
    let UserConfirmed: Bool?
    let UserSub: String?
    let CodeDeliveryDetails : CodeDeliveryDetails?
    
    init(UserConfirmed: Bool, UserSub: String, CodeDeliveryDetails : CodeDeliveryDetails) {
        self.UserConfirmed = UserConfirmed
        self.UserSub = UserSub
        self.CodeDeliveryDetails = CodeDeliveryDetails
    }

}

struct CodeDeliveryDetails: Codable {
    let Destination: String
    let DeliveryMedium: String
    let AttributeName: String
    
    init(Destination: String, DeliveryMedium: String, AttributeName: String) {
        self.Destination = Destination
        self.DeliveryMedium = DeliveryMedium
        self.AttributeName = AttributeName
    }
}


enum ErroresRegister: Error {
    case OK
    case DatosVacios
    case ContraIncorrecta
    case ContraIncorrecta2
    case CelDigitos
    case NombreMal
    case EmailIncorrecto
    case ErrorServidor
    case UsuarioExistente
    case UsuarioSinConfirmar
}

enum ErroresServidor: Error {
    case ErrorInterno
    case ErrorServidor
    case UsuarioExistente
    case ErrorContrasena
    case UsuarioSinConfirmar 
}
