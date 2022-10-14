//
//  RSComments.swift
//  EncuentroCatolicoNews
//
//  Created by Gibran Galicia on 25/11/21.
//

import Foundation

struct RSComments: Codable {
    let message : String?
    let requestId : String?
    let result : CmResult?

    enum CodingKeys: String, CodingKey {

        case message = "message"
        case requestId = "requestId"
        case result = "result"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        requestId = try values.decodeIfPresent(String.self, forKey: .requestId)
        result = try values.decodeIfPresent(CmResult.self, forKey: .result)
    }

}

struct CmResult : Codable {
    let pagination : CmPagination?
    let comments : [CmComments]?

    enum CodingKeys: String, CodingKey {

        case pagination = "Pagination"
        case comments = "Comments"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        pagination = try values.decodeIfPresent(CmPagination.self, forKey: .pagination)
        comments = try values.decodeIfPresent([CmComments].self, forKey: .comments)
    }
}

struct CmPagination : Codable {
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


struct CmComments : Codable {
    let id : Int?
    let countComment : Int?
    let countReact : Int?
    let content : String?
    let status : Int?
    let createdAt : Int?
    let author : CmAuthor?
    let scope : CmScope?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case countComment = "countComment"
        case countReact = "countReact"
        case content = "content"
        case status = "status"
        case createdAt = "createdAt"
        case author = "author"
        case scope = "scope"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        countComment = try values.decodeIfPresent(Int.self, forKey: .countComment)
        countReact = try values.decodeIfPresent(Int.self, forKey: .countReact)
        content = try values.decodeIfPresent(String.self, forKey: .content)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        createdAt = try values.decodeIfPresent(Int.self, forKey: .createdAt)
        author = try values.decodeIfPresent(CmAuthor.self, forKey: .author)
        scope = try values.decodeIfPresent(CmScope.self, forKey: .scope)
    }

}

struct CmAuthor : Codable {
    let name : String?
    let image : String?
    let type : Int?

    enum CodingKeys: String, CodingKey {

        case name = "name"
        case image = "image"
        case type = "type"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        type = try values.decodeIfPresent(Int.self, forKey: .type)
    }

}

struct CmScope : Codable {
    let id: Int?
    let name : String?
    let image : String?
    let typeId : Int?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
        case image = "image"
        case typeId = "type"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        typeId = try values.decodeIfPresent(Int.self, forKey: .typeId)
    }

}
