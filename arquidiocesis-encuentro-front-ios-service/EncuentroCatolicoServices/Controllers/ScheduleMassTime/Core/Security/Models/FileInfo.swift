//
//  FileInfo.swift
//  EncuentroCatolicoServices
//
//  Created by llavin on 07/12/22.
//

import Foundation

/// Struct to parser the  JSON from data base
struct FileInfo: Decodable {
    var data: [SecurityInfo]
    
    enum CodingKeys: String, CodingKey {
        case data
    }
}

/// Struct to parser the  JSON from data base
struct SecurityInfo: Decodable {
    /// Key identifiare
    var keyId: Int
    /// Provider name
    var provider: String
    /// Initialization vector
    var iv: String?
    /// Key
    var certificate: String
    
    enum CodingKeys: String, CodingKey {
        case keyId = "KeyId"
        case provider = "Provider"
        case iv = "IVHash"
        case certificate = "Certificate"
    }
}
