//
//  CommentsEntity.swift
//  EncuentroCatolicoChurch
//
//  Created by Pablo Luis Velazquez Zamudio on 31/08/21.
//

import Foundation
import UIKit


struct Comments: Codable {
    var my_review: ElementsReview?
    var other_reviews: [CommentsList]?
}

struct ElementsReview: Codable{
    var id: Int?
    var review: String?
    var creation_date: String?
    var rating: Double?
    var devotee: DevoteeCommentsComponents?
}

struct CommentsList: Codable {
    var id: Int?
    var review: String?
    var creation_date: String?
    var rating: Double?
    var devotee: DevoteeCommentsComponents?
}

struct DevoteeCommentsComponents: Codable {
    var id: Int?
    var name: String?
    var first_surname: String?
    var second_surname: String?
    var image_url: String?
}


