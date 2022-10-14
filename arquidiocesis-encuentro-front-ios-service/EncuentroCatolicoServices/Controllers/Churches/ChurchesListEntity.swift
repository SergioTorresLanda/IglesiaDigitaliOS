//
//  ChurchesListEntity.swift
//  EncuentroCatolicoServices
//
//  Created by Desarrollo on 30/04/21.
//

import Foundation

// MARK: - ChurchLocation
struct ChurchLocation: Codable {
    let id: Int
    let name: String
    let imageURL: String?
    let distance: Int
    let address: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case imageURL = "image_url"
        case distance, address
    }
}

typealias ChurchLocations = [ChurchLocation]
