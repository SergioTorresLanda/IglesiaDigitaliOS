//
//  CategoriesModel.swift
//  EncuentroCatolicoVirtualLibrary
//
//  Created by 4n4rk0z on 16/04/21.
//

import Foundation

// MARK: - LibraryCategories
struct LibraryCategories: Codable {
    let id: Int?
    let title: String?
    let image: String?
    let contents: [Content]?
}

// MARK: - Content
struct Content: Codable {
    let id: Int?
    let name: String?
}
