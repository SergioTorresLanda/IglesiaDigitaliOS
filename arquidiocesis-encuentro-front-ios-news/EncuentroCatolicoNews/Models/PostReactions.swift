//
//  PostReactions.swift
//  zeus-ios-sdk-new-social-network
//
//  Created by Miguel Angel Vicario Flores on 17/09/20.
//  Copyright © 2020 Gabriel Briseño. All rights reserved.
//

import Foundation

// MARK: - PostReactions
public struct PostReactions: Codable {
    var data: DataClass
}

// MARK: - DataClass
public struct DataClass: Codable {
    var resp: [Resp]
    let pages, total: Int
    let header: [Header]
}

// MARK: - Header
public struct Header: Codable {
    let id: Int
    let img: String
    let color, type: String
    let total: Int    
}

// MARK: - Resp
public struct Resp: Codable {
    let autor: Autor
    let reaction: Header
}

public typealias Headers = [Header]
