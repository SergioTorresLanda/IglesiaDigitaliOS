//
//  CommunityLocationListModel.swift
//  EncuentroCatolicoChurch
//
//  Created by Jorge Garcia on 01/09/21.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let communityLocationList = try? newJSONDecoder().decode(CommunityLocationList.self, from: jsonData)

import Foundation

// MARK: - CommunityLocationListElement
struct CommunityLocationListElement: Codable {
    let id: Int?
    let name, instituteOrAssociation: String?
    let imgURL: String?
    let phone: String?
    let address: String?
    let longitude, latitude, distance: Double?

    enum CodingKeys: String, CodingKey {
        case id, name
        case instituteOrAssociation = "institute_or_association"
        case imgURL = "img_url"
        case phone, address, longitude, latitude, distance
    }
}

typealias CommunityLocationList = [CommunityLocationListElement]

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public func hash(into hasher: inout Hasher) {
        // No-op
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

