//
//  NewDetailServiceEntity.swift
//  EncuentroCatolicoServices
//
//  Created by Pablo Luis Velazquez Zamudio on 27/07/21.
//

import Foundation
import UIKit

struct DetailService: Codable {
    var id: Int?
    var person_name: String?
    var family_name: String?
    var email: String?
    var phone: String?
    var explanation: String?
    var comments: String?
    var status: String?
    var creation_date: String?
    var modification_date: String?
    var service: ServicesContent?
    var address: AddressContent?
    var devotee: DevoteeContent?
}

struct ServicesContent: Codable {
    var id: Int?
    var name: String?
    var type: String?
}

struct AddressContent: Codable {
    var description: String?
    var zipcode: String?
    var neighborhood: String?
    var longitude: Double?
    var latitude: Double?
}

struct DevoteeContent: Codable {
    var id: Int?
    var name: String?
    var first_surname: String?
    var second_surname: String?
}

