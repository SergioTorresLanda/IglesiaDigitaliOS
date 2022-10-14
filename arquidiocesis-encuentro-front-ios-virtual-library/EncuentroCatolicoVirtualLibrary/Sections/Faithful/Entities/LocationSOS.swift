//
//  LocationSOS.swift
//  FielSOS
//
//  Created by René Sandoval on 20/03/21.
//

import Foundation

struct LocationSOS: Decodable {
    let id: Int
    let name: String
    let image_url: String
    let distance: Double
    let priests: [Priest]
}
