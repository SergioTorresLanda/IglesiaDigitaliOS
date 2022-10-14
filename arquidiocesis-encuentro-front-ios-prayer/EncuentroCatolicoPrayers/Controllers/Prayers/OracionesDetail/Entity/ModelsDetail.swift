//
//  ModelsDetail.swift
//  OracionesModulo
//
//  Created by Ulises Atonatiuh González Hernández on 02/03/21.
//

import Foundation
import UIKit
struct DetailResponse: Codable {
    let id: Int?
    let name: String?
    let icon: String?
    let type: Int?
    let description: String?
    let image_url: String?
    let similars: [SimilarResponse]?
}

struct SimilarResponse: Codable {
    let id: Int?
    let name: String?
    let icon: String?
    let type: Int?
}


struct DetailViewModel {
    let id: Int?
    let name: String?
    let icon: String?
    let type: Int?
    let description: String?
    let image_url: String?
    let similars: [SimilarResponse]?
}
