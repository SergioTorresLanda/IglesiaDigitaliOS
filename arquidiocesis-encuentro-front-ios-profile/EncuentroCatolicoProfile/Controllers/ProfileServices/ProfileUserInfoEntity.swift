//
//  ProfileUserInfoEntity.swift
//  EncuentroCatolicoProfile
//
//  Created by Desarrollo on 12/04/21.
//

import Foundation

enum viewMode {
    case diacono //vista reducida
    case soltero
    case viudo
    case casado
}

//// MARK: - ProvidedServices
//struct ProvidedServices: Codable {
//    let data: [ProvidedService]
//}

// MARK: - Datum
struct ProvidedService {
    let id: Int
    let name: String
}
