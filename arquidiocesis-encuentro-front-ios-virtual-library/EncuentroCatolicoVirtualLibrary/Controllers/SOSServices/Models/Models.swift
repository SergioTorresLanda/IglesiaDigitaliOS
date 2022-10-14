//
//  Models.swift
//  EncuentroCatolicoVirtualLibrary
//
//  Created by Ulises Atonatiuh González Hernández on 22/03/21.
//

import Foundation


struct SosStatusModel: Codable {
    let activeSOS : Bool?
}


// MARK: - WelcomeElement
struct StatusModel: Codable {
    let id: Int?
    let status: String?
    let service: Service?
    let location: Location?
    let priest: PriestStatus?
    let devotee: Devotee?
}

// MARK: - Devotee
struct Devotee: Codable {
    let devoteeID: Int?
    let name, phone: String?
}

// MARK: - Location
struct Location: Codable {
    let id: Int?
    let name: String?
    let imageURL: String?
    let distance: Double?
}

// MARK: - Priest
struct PriestStatus: Codable {
    let priestID, name: String?
}

// MARK: - Service
public struct Service: Codable {
    let id: Int?
    let name: String?
}


struct ModelChangeStatusRequest: Encodable {
  
    let activeSOS: String
    var todiccionary : [String: Any]? {
        return ["status": self.activeSOS]
              
          }
}


struct ModelChangeStatusSwitchRequest: Encodable {
  
    let activeSOS: Bool
    var todiccionary : [String: Any]? {
        return ["activeSOS": self.activeSOS]
              
          }
}
