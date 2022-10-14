//
//  ServicesDefinitions.swift
//  Nomad
//
//  Created by Diego Luna on 30/07/20.
//

import Foundation

class ServiceDefinitions: NSObject {

    // MARK: - Churches Services

    static func urlGetChurchesList(input: String? = nil) -> String {
        guard let searchPlace = input else {
            return String(format: "%@/locations", getBaseURL())
        }
        return String(format: "%@/locations?name=%@", getBaseURL(), searchPlace)
    }
    
    private static func getBaseURL() -> String {
        #if DEBUG
        return "https://rc1hfd6cjd.execute-api.us-east-1.amazonaws.com/dev"
        #else
        return "https://rc1hfd6cjd.execute-api.us-east-1.amazonaws.com/dev"
        #endif
    }
}
