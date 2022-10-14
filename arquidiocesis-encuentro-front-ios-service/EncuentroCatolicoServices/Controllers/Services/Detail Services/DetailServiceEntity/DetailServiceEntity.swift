//
//  DetailServiceEntity.swift
//  EncuentroCatolicoServices
//
//  Created by Pablo Luis Velazquez Zamudio on 14/07/21.
//

import Foundation

struct DetailServiceEntity: Codable {
    var data: [Sububs]?
}

struct Sububs: Codable {
    var id: Int?
    var name: String?
}
