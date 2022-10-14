//
//  File.swift
//  EncuentroCatolicoMyChurch
//
//  Created by Desarrollo on 07/05/21.
//

import Foundation

// MARK: - ChurchesMass
struct ChurchesMass: Codable {
    let id: Int
    let name: String
    let imageURL: String
    let latitude, longitude: Double

    enum CodingKeys: String, CodingKey {
        case id, name
        case imageURL = "image_url"
        case latitude, longitude
    }
}

typealias ChurchesMasses = [ChurchesMass]

enum ServerErrors: Error {
    case ErrorInterno
    case ErrorServidor
    case OK
}
