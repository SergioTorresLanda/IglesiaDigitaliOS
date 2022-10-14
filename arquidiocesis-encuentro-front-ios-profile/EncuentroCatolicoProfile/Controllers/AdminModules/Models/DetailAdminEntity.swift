//
//  DetailAdminEntity.swift
//  EncuentroCatolicoProfile
//
//  Created by Pablo Luis Velazquez Zamudio on 05/11/21.
//

import Foundation

struct DetailAdminEntity: Codable {
    var id: Int?
    var name: String?
    var first_surname: String?
    var second_surname: String?
    var life_status: String?
    var email: String?
    var location: LocationComponents?
    var services: [ServicesAdmin]?
    var modules: [ModulesAdmin]?
}

struct ServicesAdmin: Codable {
    var id: Int?
    var name: String?
}

struct ModulesAdmin: Codable {
    var id: Int?
    var name: String?
    var category: String?
    var enabled: Bool?
}

struct LocationComponents: Codable {
    var id: Int?
    var name: String?
    var type: String?
}
