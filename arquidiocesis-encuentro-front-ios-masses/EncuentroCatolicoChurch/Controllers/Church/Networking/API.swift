//
//  API.swift
//  Encuentro
//
//  Created by Edgar Hernandez on 4/2/21.
//  Copyright © 2021 Linko. All rights reserved.
//

import Foundation

struct API {
    
    static private var version = ""
    
    struct URLProvider {
        
        #if PROD
        static let host = ""
        #elseif QA
        static let host = ""
        #else
        static let host = "\(APIType.shared.User())"
        static let testHost = "\(APIType.shared.User())"
        #endif
        
        struct EndPoint {
            static let churches = "/priest/%@/churches"
            static let churchDetail = "/locations/"
            static let registrer = "user/registry"
            static let locations = "/locations?type_location=CHURCH"
        }
        
        static func priestChurches(id: Int) -> String {
            return host  + String(format: EndPoint.churches, id.description)
        }
        
        static func churchDetail(id: Int) -> String {
            return host + String(format: EndPoint.churchDetail + String(id))
        }
        static func urlInicioDeSesion() -> String {
            return host  + EndPoint.registrer
        }
        
        static func churches() -> String {
            return EndPoint.churches
        }
        
        static func locations() -> String {
            return testHost + EndPoint.locations
        }
        
        
    }

}
