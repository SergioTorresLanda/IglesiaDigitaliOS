//
//  PriestChurch.swift
//  MyChurches
//
//  Created by Edgar Hernandez Solis on 13/02/21.
//

import Foundation

//struct PriestChurches: Codable {
//
//    struct AssignedChurch: Codable {
//        var id: UInt
//        var tag: String
//        var image: String
//    }
//
//    struct Church: Codable {
//        var id: UInt
//        var description: String
//        var image: String
//    }
//
//    var assigned: AssignedChurch
//    var churches: Array<Church>
//
//}



struct PriestChurches: Codable {
    let assigned: Assigned?
    let locations: [Assigned]?
}

// MARK: - Assigned
struct Assigned: Codable {
    let id: Int?
    let name: String?
    let image_url: String?
    let  latitude : Double?
    let longitude: Double?
    let category: String?
    let schedules: [Schedules]?
}

struct AssignedSearch: Codable {
    let id: Int?
    let name: String?
    let image_url: String?
    let  latitude : Double?
    let longitude: Double?
}

struct Schedules: Codable {
    let start_hour: String?
    let end_hour: String?
}
