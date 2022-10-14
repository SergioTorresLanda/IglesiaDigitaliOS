//
//  CongregationsEntity.swift
//  EncuentroCatolicoProfile
//
//  Created by Pablo Luis Velazquez Zamudio on 11/09/21.
//

import Foundation

struct CongregationsList: Codable {
    var data: [Elements]?
}

struct Elements: Codable {
    var id: Int?
    var descripcion: String?
}
