//
//  ChurchDetail.swift
//  PriestMyChurches
//
//  Created by Miguel Eduardo Valdez Tellez on 13/02/21.
//

import Foundation
import MapKit


//
//// MARK: - Day
//struct Day: Codable {
//    let id: Int?
//    let name: String?
//    let checked: Bool?
//}
//
//// MARK: - Parson
//struct Parson: Codable {
//    let priest_id: Int?
//    let name: String?
//}




//
//// MARK: - ChurchDetail
struct ChurchDetail: Codable {
    // MARK: - Attention
    struct Attention: Codable {
        let days: [Day]?
        let hour_start, hour_end: String?
    }

    // MARK: - Attention
    struct Masses: Codable {
        let days: [Day]?
        let hour_start, hour_end: String?
    }

    // MARK: - Day
    struct Day: Codable {
        let id: Int?
        let name: String?
        let checked: Bool?
    }

    struct Parson: Codable {
        let id: Int?
        let name: String?
    }

    struct Service: Codable {
        let type: TypeClass?
        let schedules: [Horary]?
        let geared_toward, description: String?
    }
    
    struct TypeClass: Codable {
        let id: Int?
        let name: String?
        let image_url: String?
    }
    
    struct Horary: Codable {
        let days: [Day]?
        let hour_start, hour_end: String?
    }

    let id: Int?
    let name: String?
    let image_url: String?
    let description, address: String?
    let latitude, longitude, distance, rating: Double?
    let email, phone, stream, bank_account, website, facebook, twitter, instagram: String?
    let parson, principal: Parson?
    var priests: [Parson]?
    var horary, attention, masses: [Attention]?
    var services: [Service]?
    //var clerics: [String:Any]?
    
    enum CodingKeys: String, CodingKey {
        case horary = "schedules"
        case latitude, longitude, distance, rating
        case email, phone, stream, bank_account, website, facebook, twitter, instagram
        case attention, masses, services, parson, principal, image_url, name, id, priests, description, address
      //  case clerics
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
    case clergyVicarage = "CLERGY_VICARAGE"
}
