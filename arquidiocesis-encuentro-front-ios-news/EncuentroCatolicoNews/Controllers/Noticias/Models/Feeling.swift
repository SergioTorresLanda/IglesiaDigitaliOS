//
//  Feeling.swift
//  zeus-ios-sdk-new-social-network
//
//  Created by Miguel Angel Vicario Flores on 16/12/20.
//  Copyright © 2020 Gabriel Briseño. All rights reserved.
//

import Foundation

//MARK: - Feeling
public struct Feeling: Codable {
    let type: String
    let feeling_id: Int
    let img: String
}

public typealias Feelings = [Feeling]
