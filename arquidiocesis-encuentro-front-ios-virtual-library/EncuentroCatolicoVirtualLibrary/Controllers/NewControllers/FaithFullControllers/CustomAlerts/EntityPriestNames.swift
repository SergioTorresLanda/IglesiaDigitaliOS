//
//  EntityPriestNames.swift
//  EncuentroCatolicoVirtualLibrary
//
//  Created by Pablo Luis Velazquez Zamudio on 15/07/21.
//

import Foundation

struct EntityPriestNames: Codable {
    var data: [Priests2]?
}

struct Priests2: Codable {
    var id: Int?
    var name: String?
}
