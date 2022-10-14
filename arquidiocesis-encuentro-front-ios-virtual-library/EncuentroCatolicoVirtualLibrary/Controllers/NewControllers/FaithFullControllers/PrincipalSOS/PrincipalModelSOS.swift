//
//  PrincipalModelSOS.swift
//  EncuentroCatolicoVirtualLibrary
//
//  Created by Pablo Luis Velazquez Zamudio on 16/06/21.
//

import Foundation
import UIKit

struct PModelSOS: Codable {
    var description : String?
    var name : String?
    var id: Int?
}

struct LastSosModel: Codable {
    var service_id: Int?
    var status: String?
}
