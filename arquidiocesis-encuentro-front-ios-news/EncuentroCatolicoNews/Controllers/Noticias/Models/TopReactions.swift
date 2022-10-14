//
//  TopReactions.swift
//  zeus-ios-sdk-new-social-network
//
//  Created by Miguel Angel Vicario Flores on 02/10/20.
//  Copyright © 2020 Gabriel Briseño. All rights reserved.
//

import UIKit

// MARK: - TopReactions
public struct TopReactions: Codable {
    let topReactions: [TopReaction]
}

// MARK: - TopReaction
public struct TopReaction: Codable {
    let id: Int
    let img: String
    let color, type: String
    let total: Int
}
