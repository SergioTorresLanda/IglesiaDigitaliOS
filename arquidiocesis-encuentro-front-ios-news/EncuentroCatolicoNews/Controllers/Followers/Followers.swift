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
struct Followers2: Codable {
    var userId: Int
    var entityId: Int
    var entityType: Int
}


//{"userId":1937,"entityId":1313,"entityType":1}
