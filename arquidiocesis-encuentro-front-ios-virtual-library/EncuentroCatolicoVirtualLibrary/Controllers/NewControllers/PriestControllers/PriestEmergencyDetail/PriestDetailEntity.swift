//
//  PriestDetailEntity.swift
//  EncuentroCatolicoVirtualLibrary
//
//  Created by Pablo Luis Velazquez Zamudio on 29/06/21.
//

import Foundation
import UIKit

struct PriestDetail: Codable {
    var location: LocationDetail?
    var creation_date: String?
    var devotee: DevoteeDet?
    var status: String?
    var address: AddressComponentsPriest?
    var service: ServiceDet?
    var longitude: Double?
    var latitude: Double?
    var id: Int?
    var progress_history: [ProgessHis]?
    var review: Review?
}

struct AddressComponentsPriest: Codable {
    var description : String?
    var longitude: Double?
    var latitude: Double?
}

struct ServiceDet: Codable {
    var name: String
}

struct LocationDetail: Codable {
    var distance: Double?
    var name: String?
}

struct DevoteeDet: Codable {
    var name: String?
    var phone: String?
}

struct ProgessHis: Codable {
    var status: String?
    var sub_status: String?
}

struct Review: Codable {
    var rating: Double?
    var review: String?
}
