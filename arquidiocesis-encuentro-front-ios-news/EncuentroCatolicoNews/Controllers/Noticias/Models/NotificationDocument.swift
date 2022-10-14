//
//  NotificationDocument.swift
//  RedSocialFramework
//
//  Created by Miguel Angel Vicario Flores on 10/11/20.
//  Copyright © 2020 Gabriel Briseño. All rights reserved.
//

import Foundation

//MARK: - NotificationDocument
public struct NotificationDocument: Codable {
    let documentID: String
    let autor: AutorDocument
    let date: Int
    let group: GroupDocument
    let message: String
    let viewed: Bool
}

public struct GroupDocument: Codable {
    let id: Int
    let name: String
}

public struct ItemDocument: Codable {
    let comment_id: Int
    let reaction: ReactionDocument
}

public struct ReactionDocument: Codable {
    let active: Bool
    let color: String
    let id: Int
    let img: String
    let type: String
}

public struct AutorDocument: Codable {
    let FIIDEMPLEADO: Int?
    let name: String?
}
