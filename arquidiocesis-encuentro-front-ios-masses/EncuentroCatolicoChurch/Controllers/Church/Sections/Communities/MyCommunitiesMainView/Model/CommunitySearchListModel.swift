//
//  CommunitySearchListModel.swift
//  EncuentroCatolicoChurch
//
//  Created by Jorge Garcia on 31/08/21.
//

import Foundation

// MARK: - CommunitySearchListElement
struct CommunitySearchListElement: Codable {
    let id: Int?
    let name: String?
    let instituteOrAssociation: String?
    let imgURL: String?
    let phone, address: String?
    let longitude, latitude: Double?

    enum CodingKeys: String, CodingKey {
        case id, name
        case instituteOrAssociation = "institute_or_association"
        case imgURL = "img_url"
        case phone, address, longitude, latitude
    }
}

typealias CommunitySearchList = [CommunitySearchListElement]
