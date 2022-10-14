//
//  CommunityPostImage.swift
//  EncuentroCatolicoChurch
//
//  Created by Jorge Garcia on 02/09/21.
//

import Foundation

// MARK: - CommunityPostImage
struct CommunityPostImage: Codable {
    let elementID: Int?
    let type, filename, content: String?

    enum CodingKeys: String, CodingKey {
        case elementID = "element_id"
        case type, filename, content
    }
}
