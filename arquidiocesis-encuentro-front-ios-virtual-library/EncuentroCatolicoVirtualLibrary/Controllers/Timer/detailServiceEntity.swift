//
//  detailServiceEntity.swift
//  EncuentroCatolicoVirtualLibrary
//
//  Created by MacBookPro on 11/05/21.
//

import Foundation

struct statusNotificationSOS: Codable {
    let id: Int
    let status: String
    let creation_date: String
    let longitude: Double
    let latitude: Double
    let service: ServiceN
    let location: LocationN
    let priest: PriestN
    let devotee: DevoteeN
    let complaints_box: ComplaintsBox
}

struct ComplaintsBox: Codable {
}

struct ServiceN: Codable {
    let id: Int
    let name: String
}

// MARK: - Devotee
struct DevoteeN: Codable {
    let devotee_id: Int
    let name: String
    let phone: String
}

// MARK: - Location
struct LocationN: Codable {
    let id: Int
    let name: String
    let image_url: String
    let distance: Double
}

// MARK: - Priest
struct PriestN: Codable {
    let priest_id: Int
    let name: String
}
