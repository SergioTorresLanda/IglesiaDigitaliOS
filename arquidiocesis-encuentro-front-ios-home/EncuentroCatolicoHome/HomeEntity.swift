import Foundation

public struct UserHome: Codable {
    
    let username: String
    
    init(username: String) {
        self.username = username
    }
    
}

public struct UserRespHome: Codable {
    
    let UserAttributes: UserAttributes
    
    public init(UserAttributes: UserAttributes) throws {
        self.UserAttributes = UserAttributes
    }
    
}

public struct UserAttributes: Codable {
  //  let id: Int
    let email: String
    let phone_number: String
    let name: String
    let last_name: String
    let middle_name: String?
    let role: String
    let profile: String
    
    init(username: String, email: String, phone_number: String, name: String, last_name: String, middle_name: String, role: String, profile: String) {
       // self.id = id
        self.email = email
        self.phone_number = phone_number
        self.name = name
        self.last_name = last_name
        self.middle_name = middle_name
        self.role = role
        self.profile = profile
    }
    
    var userRole: String{
        switch role {
        case UserRoleEnum.fiel.rawValue:
            return UserRoleEnum.fiel.rawValue
        case UserRoleEnum.fieladministrador.rawValue:
            return UserRoleEnum.fieladministrador.rawValue
        case UserRoleEnum.sacerdote.rawValue:
            return UserRoleEnum.sacerdote.rawValue
        case UserRoleEnum.Sacerdoteadministrador.rawValue:
            return UserRoleEnum.Sacerdoteadministrador.rawValue
        case UserRoleEnum.Sacerdotedecano.rawValue:
            return UserRoleEnum.Sacerdotedecano.rawValue
        default:
            return ""
        }
    }
}
 enum UserRoleEnum: String {
    case fiel = "Fiel"
    case fieladministrador = "Fiel administrador"
    case sacerdote = "Sacerdote"
    case Sacerdoteadministrador = "Sacerdote administrador"
    case Sacerdotedecano = "Sacerdote decano"
}

enum UserProfileEnum: String {
    case fiel = "DEVOTED"
    case fieladministrador = "DEVOTED_ADMIN"
    case sacerdote = "PRIEST"
    case Sacerdoteadministrador = "PRIEST_ADMIN"
    case Sacerdotedecano = "DEAN_PRIEST"
    case ResponsableComunidad = "COMMUNITY_RESPONSIBLE"
    case AdministradorComunidad = "COMMUNITY_ADMIN"
    case MiembroComunidad = "COMMUNITY_MEMBER"
}

enum UserCommunityStatus: String {
    case pendingApproval = "PENDING_VICARAGE_APPROVAL"
    case complete = "COMPLETED"
    case pendindCompletion = "PENDING_COMPLETION"
}

enum ErroresHome: Error {
    case OK
    case ErrorServidor
}

enum ErroresServidorHome: Error {
    case ErrorInterno
    case ErrorServidor
    case Ok
}


struct ProfileDetailImgH: Codable {
    var data: USerH?
}

struct USerH: Codable {
    var User: ProfileComponentsH?
}

struct ProfileComponentsH: Codable {
    var name: String
    var first_surname: String
    var image: String?
    var community: Community?
    var location_id: Int?
    var location_modules: [LocationComponents]?
   
}
struct Community: Codable {
    var id: Int?
    var name, status: String?
}

struct HomeSaintOfDay: Codable {
    var id: Int?
    var title: String?
    var starting_date: String?
    var ending_date: String?
    var image_url: String?
    var publish_url: String?
}

struct HomeSuggestions: Codable {
    var id: Int?
    var title: String?
    var publish_date: String?
    var image_url: String?
    var article_url: String?
    var category: String?
    var type: String?
}

struct LocationComponents: Codable {
    var id: Int?
    var name: String?
    var type: String?
    var modules: [String]?
}

struct LiveModel: Codable {
    var name: String?
    var author: String?
    var type: String?
    var streaming_url: String?
    
}
