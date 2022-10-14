//
//  SacramentsEntity.swift
//  EncuentroCatolicoServices
//
//  Created by Desarrollo on 30/04/21.
//

import Foundation

struct Sacrament: Codable {
    let id: Int
    let name, sacramentDescription: String
    let file: String
    let action: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case sacramentDescription = "description"
        case file, action
    }
}

typealias Sacraments = [Sacrament]
