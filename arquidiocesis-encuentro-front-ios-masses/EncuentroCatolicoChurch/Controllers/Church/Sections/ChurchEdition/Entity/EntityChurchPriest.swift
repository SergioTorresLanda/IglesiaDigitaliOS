//
//  EntityChurchPriest.swift
//  ChurchPriest
//
//  Created by Ulises Atonatiuh González Hernández on 11/02/21.
//

import Foundation


struct ModelViewData {
    let name, email, church, number: String?
    let welcomeDescription, address , image, account: String?
    let servicesHours: [String]?
    let serviceHoursOficina: [String]?
    let serviceDates: [String]?
    let serviceDatesOficina: [String]?
}

//struct ModelPriestResponse: Codable {

struct ModelPriestResponse: Codable {
    let name, fatherSurname, motherSurname, description: String?
    let birthDate, ordinationDate, email: String?
    let clergy: Clergy?
    let activity: [Activity2]?
}

// MARK: - Activity
struct Activity2: Codable {
    let id: Int?
    let name: String?
}

// MARK: - Clergy
struct Clergy: Codable {
    let id: Int?
    let tag, description: String?
}


struct ModelDetailChurchResponse: Codable {
    let welcomeDescription, address, email, image: String?
    let services: [Service]?
    let masses: [Attention]?
    let attention: Attention?
    let phone: String?
    let parson: Int?
    let stream: Stream?
    let priest: [Int]?
    let bankAccount: String?
    let confessions: [Attention]?
    let activities: [Activity]?
}

// MARK: - Activity
struct Activity: Codable {
    let id: Int?
    let days, hours: String?
}

// MARK: - Attention
struct Attention: Codable {
    let days, hours: String?
}

// MARK: - Service
struct Service: Codable {
    let id: Int?
    let day, hours: String?
}

// MARK: - Stream
struct Stream: Codable {
    let url, hours: String?
}

//MARK: - Catalogs
struct ServiceCatalogItem: Codable {
    var id: UInt
    var icon: String
    var name: String
    var description: String
}

struct MassesCatalogItem: Codable {
    var id: UInt
    var name: String
    var description: String
}

//MARK: - Update service
struct ChurchEditionRequest: Codable {
    
}

struct ChurchEditionResponse: Codable {
    
}
