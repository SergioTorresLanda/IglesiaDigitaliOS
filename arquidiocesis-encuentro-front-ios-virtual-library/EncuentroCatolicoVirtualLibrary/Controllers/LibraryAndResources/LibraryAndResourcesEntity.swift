//
//  LibraryAndResourcesEntity.swift
//  EncuentroCatolicoVirtualLibrary
//
//  Created by Desarrollo on 19/04/21.
//

import Foundation

// MARK: - ContentDetail
struct ContentDetail: Codable {
    let id: Int?
    let image: String?
    let title, subtitle: String?
    let contentDetailDescription: String?
    let resources: [Resource]

    enum CodingKeys: String, CodingKey {
        case id, image, title, subtitle
        case contentDetailDescription = "description"
        case resources
    }
}

// MARK: - Resource
struct Resource: Codable {
    let id: Int?
    let title: String?
    let resourceDescription: String?
    let type: String?
    let url: String?

    enum CodingKeys: String, CodingKey {
        case id, title
        case resourceDescription = "description"
        case type, url
    }
}

enum ServerErrors: Error {
    case ErrorInterno
    case ErrorServidor
    case OK
}
