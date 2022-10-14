//
//  IntentionsEntity.swift
//  EncuentroCatolicoServices
//
//  Created by Ricardo Ramirez on 10/05/21.
//

import Foundation

struct PriestChurches: Codable {
    let assigned: Assigned?
    let locations: [Assigned]?
}

// MARK: - Assigned
public struct Assigned: Codable {
    let id: Int?
    let name: String?
    let image_url: String?
//    let latitude : Double?
//    let longitude: Double?
}
