//
//  CommunityMainListModel.swift
//  EncuentroCatolicoChurch
//
//  Created by Jorge Garcia on 31/08/21.
//

import Foundation

// MARK: - CommunityMainList
struct CommunityMainList: Codable {
    var assigned: AssignedMainList?
    var locations: [AssignedMainList]?
}

// MARK: - Assigned
struct AssignedMainList: Codable {
    var id: Int?
    var name: String?
    var imageURL: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case imageURL = "image_url"
    }
}

