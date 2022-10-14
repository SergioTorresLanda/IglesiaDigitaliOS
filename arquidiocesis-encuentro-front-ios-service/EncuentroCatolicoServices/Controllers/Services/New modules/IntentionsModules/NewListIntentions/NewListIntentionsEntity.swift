//
//  NewListIntentionsEntity.swift
//  EncuentroCatolicoServices
//
//  Created by Pablo Luis Velazquez Zamudio on 27/07/21.
//

import Foundation
import UIKit

struct ListIntentions: Codable {
    var date: String?
    var start_time: String?
    var end_time: String?
    var priest: PriestData?
}

struct PriestData: Codable {
    var id: String?
    var name: String?
    var first_surname: String?
    var second_surname: String?
}


