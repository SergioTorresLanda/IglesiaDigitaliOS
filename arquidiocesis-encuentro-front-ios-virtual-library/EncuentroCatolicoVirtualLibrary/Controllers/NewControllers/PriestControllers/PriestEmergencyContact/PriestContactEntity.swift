//
//  PriestContactEntity.swift
//  EncuentroCatolicoVirtualLibrary
//
//  Created by Pablo Luis Velazquez Zamudio on 28/06/21.
//

import Foundation
import UIKit

struct DetailContact: Codable {
    var location: LocationDetailContact?
    var devotee: DevoteeDetContact?
    var address: AddressComponents?
    var status: String?
    var service: ServiceDetContact?
    var longitude: Double?
    var latitude: Double?
    var progress_history: [ProgessHisSac]?
}

struct AddressComponents: Codable {
    var description : String?
    var longitude: Double?
    var latitude: Double?
}

struct ServiceDetContact: Codable {
    var name: String
}

struct LocationDetailContact: Codable {
    var distance: Double?
    var name: String?
}

struct DevoteeDetContact: Codable {
    var name: String?
    var phone: String?
}

struct ProgessHisSac: Codable {
    var sub_status: String?
    var status: String?
}
