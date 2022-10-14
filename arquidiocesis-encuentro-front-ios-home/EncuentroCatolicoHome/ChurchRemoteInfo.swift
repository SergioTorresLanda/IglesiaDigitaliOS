//
//  ChurchRemoteInfo.swift
//  BASAMyPayments
//
//  Created by Alejandro on 14/10/22.
//

import Foundation

struct ChurchRemoteInfo: Decodable {
    //MARK: - Properties
    let forceUpdateIOS: Bool
    let versionIOS: Double
    
    //MARK: - CodingKeys
    enum CodingKeys: String, CodingKey {
        case forceUpdateIOS = "force_update_ios"
        case versionIOS = "version_ios"
    }
}
