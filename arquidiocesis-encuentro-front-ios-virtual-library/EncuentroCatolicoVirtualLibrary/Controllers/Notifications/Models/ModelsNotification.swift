//
//  Models.swift
//  EncuentroCatolicoVirtualLibrary
//
//  Created by Ulises Atonatiuh González Hernández on 22/03/21.
//

import Foundation


struct SosStatusModelNotification: Codable {
    let activeSOS : Bool?
}


// MARK: - WelcomeElement
struct StatusModelNotification: Codable {
    let id: Int?
    let status: String?
    let service: Service?
    let location: Location?
    let priest: PriestStatus?
    let devotee: Devotee?
}

// MARK: - Devotee
struct DevoteeNotification: Codable {
    let devoteeID: Int?
    let name, phone: String?
}

// MARK: - Location
struct LocationNotification: Codable {
    let id: Int?
    let name: String?
    let imageURL: String?
    let distance: Double?
}

// MARK: - Priest
struct PriestStatusNotification: Codable {
    let priestID, name: String?
}

// MARK: - Service
public struct ServiceNotification: Codable {
    let id: Int?
    let name: String?
}


struct ModelChangeStatusRequestNotification: Encodable {
  
    let activeSOS: String
    var todiccionary : [String: Any]? {
        return ["status": self.activeSOS]
              
          }
}


struct ModelChangeStatusSwitchRequestNotification: Encodable {
  
    let activeSOS: Bool
    var todiccionary : [String: Any]? {
        return ["activeSOS": self.activeSOS]
              
          }
}
