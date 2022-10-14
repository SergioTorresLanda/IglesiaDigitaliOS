//
//  Models.swift
//  OracionesModulo
//
//  Created by Ulises Atonatiuh González Hernández on 01/03/21.
//

import Foundation

struct DataResponse: Codable {
    let name: String?
    let id: Int?
    let icon_url: String?
    let devotions: [Devotion]?
}

// MARK: - Devotion
struct Devotion: Codable {
    let name: String?
    let id: Int?
}
