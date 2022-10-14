//
//  OtherServicesEntity.swift
//  EncuentroCatolicoServices
//
//  Created by Desarrollo on 26/04/21.
//

import Foundation

struct otherServicesOptions: Equatable{
    var title: String
    var type: String
    var id: String?
    var description: String?
    var action: String?
    var parent: cases? 
}

// MARK: - OtherServicesOption
struct servicesSubOption: Codable {
    let id: Int
    let name, otherServicesOptionDescription, action: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case otherServicesOptionDescription = "description"
        case action
    }
}


enum cases{
//    case Celebraciones
    case Bendiciones
    case OtrosServicios
}

enum ServerErrors: Error {
    case ErrorInterno
    case ErrorServidor
    case OK
}
