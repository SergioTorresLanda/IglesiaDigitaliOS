//
//  Comments.swift
//  RedSocialFramework
//
//  Created by Miguel Angel Vicario Flores on 16/12/20.
//  Copyright © 2020 Gabriel Briseño. All rights reserved.
//

import Foundation

// MARK: - Comments
public struct Comments: Codable {
    var comments: [Comment]
    let pages, total: Int
}

// MARK: - Comment
public class Comment: Codable {
    var id: Int
    var active: Bool
    var countComment: Int
    var content: String
    var countReact: Int
    var autor: Autor
    var created: Int
    var myReaction: MyReaction?
    var comments: Comment?
    var isSon: Bool = false
    var fatherId: Int = 0

    init(id: Int, active: Bool, countComment: Int, content: String, countReact: Int, autor: Autor, created: Int, myReaction: MyReaction?, comments: Comment?) {
        self.id = id
        self.active = active
        self.countComment = countComment
        self.content = content
        self.countReact = countReact
        self.autor = autor
        self.created = created
        self.myReaction = myReaction
        self.comments = comments
    }
    
    convenience init () {
        self.init(id: 0, active: false, countComment: 0, content: "", countReact: 0,
                  autor: Autor(FIIDEMPLEADO: 0, nombre: "", imagen: nil), created: 0, myReaction: nil, comments: nil)
    }
    
    enum CodingKeys: String, CodingKey {
        case id, active, countComment, content, countReact, autor, created, myReaction, comments
    }
}

// MARK: - Autor
public struct Autor: Codable {
    let FIIDEMPLEADO: Int
    let nombre: String
    let imagen: String?
}

// MARK: - MyReaction
public struct MyReaction: Codable {
    var id: Int
    var img: String
    var color: String
    var type: String
}

typealias CommentsArray = [Comment]
