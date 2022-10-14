//
//  Followers.swift
//  EncuentroCatolicoNews
//
//  Created by Billy on 26/01/22.
//

import Foundation
struct Followers: Codable {
    var image: String
    var name: String
    var isFollow: Bool
    var userId: Int
    var entityId: Int
    var entityType: Int
}
