//
//  RSTimeLine.swift
//  EncuentroCatolicoNews
//
//  Created by Billy on 19/11/21.
//

import Foundation
import RealmSwift

struct RSTimeLine:  Codable {
    let message : String?
    let requestId : String?
    let result : Result?

    enum CodingKeys: String, CodingKey {

        case message = "message"
        case requestId = "requestId"
        case result = "result"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        requestId = try values.decodeIfPresent(String.self, forKey: .requestId)
        result = try values.decodeIfPresent(Result.self, forKey: .result)
    }
}

struct Posts : Codable {
    let id : Int?
    let statusId : Int?
    let reactionId : Int?
    let content : String?
    let totalComments : Int?
    let totalReactions : Int?
    let createdAt : Int?
    let author : Author?
    let multimedia : [Multimedia]?
    let scope : Scope?
    let reaction: Reaction?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case statusId = "statusId"
        case reactionId = "reactionId"
        case content = "content"
        case totalComments = "totalComments"
        case totalReactions = "totalReactions"
        case createdAt = "createdAt"
        case author = "author"
        case multimedia = "multimedia"
        case scope = "scope"
        case reaction = "reaction"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        statusId = try values.decodeIfPresent(Int.self, forKey: .statusId)
        reactionId = try values.decodeIfPresent(Int.self, forKey: .reactionId)
        content = try values.decodeIfPresent(String.self, forKey: .content)
        totalComments = try values.decodeIfPresent(Int.self, forKey: .totalComments)
        totalReactions = try values.decodeIfPresent(Int.self, forKey: .totalReactions)
        createdAt = try values.decodeIfPresent(Int.self, forKey: .createdAt)
        author = try values.decodeIfPresent(Author.self, forKey: .author)
        multimedia = try values.decodeIfPresent([Multimedia].self, forKey: .multimedia)
        scope = try values.decodeIfPresent(Scope.self, forKey: .scope)
        reaction = try values.decodeIfPresent(Reaction.self, forKey: .reaction)
    }

}

struct PickerUserPost: Codable{
    let userName: String
    let asPrm: Int
    let scope: Int
    let orgId: Int
}

struct Pagination : Codable {
    let hasMore : Bool?
    let next : String?

    enum CodingKeys: String, CodingKey {

        case hasMore = "hasMore"
        case next = "next"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        hasMore = try values.decodeIfPresent(Bool.self, forKey: .hasMore)
        next = try values.decodeIfPresent(String.self, forKey: .next)
    }

}

struct Reaction : Codable {
    let id : Int?
    let type : Int?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case type = "type"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        type = try values.decodeIfPresent(Int.self, forKey: .type)
    }

}

struct Scope : Codable {
    let id : Int?
    let name : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
    }

}

struct Result : Codable {
    let pagination : Pagination?
    let posts : [Posts]?

    enum CodingKeys: String, CodingKey {

        case pagination = "pagination"
        case posts = "posts"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        pagination = try values.decodeIfPresent(Pagination.self, forKey: .pagination)
        posts = try values.decodeIfPresent([Posts].self, forKey: .posts)
    }

}

struct Author : Codable {
    let id : Int?
    let name : String?
    let image : String?
    let type : Int?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
        case image = "image"
        case type = "type"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        type = try values.decodeIfPresent(Int.self, forKey: .type)
    }

}

struct Multimedia : Codable {
    let id : Int?
    let url : String?
    let thumbnail : String?
    let format : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case url = "url"
        case thumbnail = "thumbnail"
        case format = "format"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        url = try values.decodeIfPresent(String.self, forKey: .url)
        thumbnail = try values.decodeIfPresent(String.self, forKey: .thumbnail)
        format = try values.decodeIfPresent(String.self, forKey: .format)
    }

}


