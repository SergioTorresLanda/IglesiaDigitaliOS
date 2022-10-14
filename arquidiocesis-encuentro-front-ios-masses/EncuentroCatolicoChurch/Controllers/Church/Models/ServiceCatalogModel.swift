//
//  ServiceCatalogModel.swift
//  EncuentroCatolicoChurch
//
//  Created by Jorge Garcia on 06/10/21.
//

import Foundation

/// MARK: - ServiceCatalogModelElement
struct ServiceCatalogModelElement: Codable {
    let id: Int
    let name: String
    let iconUrl: String
}

typealias ServiceCatalogModel = [ServiceCatalogModelElement]
