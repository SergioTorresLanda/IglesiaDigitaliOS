//
//  CommunityTupeCatalog.swift
//  EncuentroCatolicoChurch
//
//  Created by Jorge Garcia on 27/08/21.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let communityTypeCatalog = try? newJSONDecoder().decode(CommunityTypeCatalog.self, from: jsonData)

import Foundation

// MARK: - CommunityTypeCatalog
struct CommunityTypeCatalog: Codable {
    var data: [Datum]?
}

// MARK: - Datum
struct Datum: Codable {
    var id: Int?
    var datumDescription: String?

    enum CodingKeys: String, CodingKey {
        case id
        case datumDescription = "description"
    }
}

