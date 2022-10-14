//
//  ListServicesEntity.swift
//  EncuentroCatolicoServices
//
//  Created by Pablo Luis Velazquez Zamudio on 26/07/21.
//

import Foundation
import UIKit

struct ListServicesStandard: Codable {
    var id: Int?
    var status: String?
    var creation_date: String?
    var modification_date: String?
    var service: ServicesComponents?
    var devotee: DevoteeComponents?
}

struct ServicesComponents: Codable {
    var id: Int?
    var name: String?
    var type: String?
}

struct DevoteeComponents: Codable {
    var id: Int?
    var name: String?
    var fist_surname: String?
    var second_surname: String?
}
