//
//  API.swift
//  register_Framework
//
//  Created by Miguel Eduardo  Valdez Tellez  on 09/02/21.
//

import Foundation

struct API {
    static private var version = ""
    struct URLProvider {
        
        static let host = ""

        static let auth = "\(APIType.shared.Auth())"
        static let newHost = "\(APIType.shared.User())"

        
        
        
        struct EndPoint {
            //old
            static let clergyCatalog = "/catalogs/clergy"
            static let activitiesCatalog = "/catalog/activities"
            static let registerPost = "/user/update"
            
            //new
            static let idGlobal = UserDefaults.standard.integer(forKey: "id")
            static let congregations = "/catalog/congregations"
            static let topics = "/catalog/topics"
            static let states = "/catalog/life-states"
            static let service = "/catalog/provided-services"
            static let detail = "/user/detail/\(idGlobal)"
            static let registrer = "user/registry"
            static let churches = "https://zoh3vla2n7.execute-api.us-east-1.amazonaws.com/default/ms-church-service/churchs"
            static let locations = "/locations"
            
        }
        
        //old
        static func clergyCatalog() -> String {
            return host + version + EndPoint.clergyCatalog
        }
        
        static func appointmentsCatalog() -> String {
            return newHost + version + EndPoint.activitiesCatalog
        }
        
        //new
        static func registerPost() -> String {
            return auth + EndPoint.registerPost
        }
        
        static func getTopics() -> String {
            return newHost + version + EndPoint.topics
        }
        
        static func getStates() -> String {
            return newHost + version + EndPoint.states
        }
        
        static func getCongre() -> String {
            return newHost + version + EndPoint.congregations
        }
        
        static func getServi() -> String {
            return newHost + version + EndPoint.service
        }
        
        static func getDetail() -> String {
            return auth + EndPoint.detail
        }
        
        static func churches() -> String {
            return EndPoint.churches
        }
        
        static func locations() -> String {
            return newHost + EndPoint.locations
        }
        
        static func urlInicioDeSesion() -> String {
            return host + version + EndPoint.registrer
        }
    }
}
