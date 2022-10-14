//
//  AssignedChurchModel.swift
//  EncuentroCatolicoProfile
//
//  Created by Jorge Garcia on 02/07/21.
//

import Foundation


struct AssignedChurches: Codable {
    let assigned: Assigned?
    let locations: [Assigned]?
}

// MARK: - Assigned
struct Assigned: Codable {
    let id: Int?
    let name: String?
    let image_url: String?
    let  latitude : Double?
    let longitude: Double?
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

