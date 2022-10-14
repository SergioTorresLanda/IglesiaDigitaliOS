//
//  ModelsBibliotecaRecursos.swift
//  EncuentroCatolicoVirtualLibrary
//
//
//  Created by Ulises Atonatiuh González Hernández on 15/04/21.
//

import Foundation
import UIKit
struct ModelCellDestacados {
    let title: String
    let lblConsultas: String
    let img: UIImage
}

struct ModelCellCategorias {
    let title: String
    let img: UIImage
}



// MARK: - Welcome
struct LibraryResourcesResponse: Codable {
    let news, featured: [Featured]?
    let categories: [Category]?
}

// MARK: - Category
struct Category: Codable {
    let code: String?
    let image: String?
    let name: String?
}

// MARK: - Featured
struct Featured: Codable {
    let id: Int?
    let title, subtitle: String?
    let views: Int?
    let image: String?
}

struct LibrarySearchResponse: Codable {
   let  id: Int
    let name: String
}
