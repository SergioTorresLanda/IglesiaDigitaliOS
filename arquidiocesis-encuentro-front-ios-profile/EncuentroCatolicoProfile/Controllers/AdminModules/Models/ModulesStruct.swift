//
//  ModulesStruct.swift
//  EncuentroCatolicoProfile
//
//  Created by Jorge Garcia on 24/06/21.
//

import Foundation

struct Modules: Codable {
   let id: Int?
    let name: String?
    let first_surname: String?
    let second_surname: String?
    let life_status: String?
    let email: String?
   // let location: String?
    var services: [Services]?
    var modules: [ModulesList]?
}

struct Services: Codable {
    let id: Int?
    let name: String?
}

struct ModulesList: Codable {
    let id: Int?
    let name: String?
    let category: String?
    let enabled: Bool?
}


