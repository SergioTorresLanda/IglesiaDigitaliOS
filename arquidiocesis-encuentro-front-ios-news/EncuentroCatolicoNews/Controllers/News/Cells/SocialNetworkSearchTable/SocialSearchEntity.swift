//
//  SocialSearchEntity.swift
//  EncuentroCatolicoPrayers
//
//  Created by Pablo Luis Velazquez Zamudio on 25/01/22.
//

import Foundation

struct SerachResponse: Codable {
    var message: String?
    var requestId: String?
    var result: ResultSearch?
}

struct ResultSearch: Codable {
    var pagination: PaginationSearch?
    var results: [ResultsSearch]?
}

struct PaginationSearch: Codable {
    var hasMore: Bool?
    var next: String?
}

struct ResultsSearch: Codable {
    var id: Int?
    var name: String?
    var type: String?
    var relationship: RelationShip?
    var metadata: MetaDataSearch?
}

struct MetaDataSearch: Codable {
    var communityId: Int?
    var personId: Int?
    var address: String?
    var email: String?
    var username: String?
    var role: String?
    var type: Int?
    var phoneNumber: String?
}

struct RelationShip: Codable {
    var id: Int?
    var statusId: Int?
}

struct FollowResponse: Codable {
    var message: String?
    var requestId: String?
    var result: ResultFollow?
}

struct ResultFollow: Codable {
    var id: Int?
    var status: Int?
}
