//
//  ECNFFormationType.swift
//  EncuentroCatolicoNewFormation
//
//  Created by Alejandro on 20/10/22.
//

import Foundation

enum ECNFFormationType: String, CaseIterable {
    case pdf = "FILE"
    case video = "VIDEO"
    case audio = "AUDIO"
    case text = "TEXT"
    case link = "LINK"
    case newest = "NEW"
    case featured = "FEATURED"
    
    //MARK: - Static Methods
    static func getTypesByCatalog(by code: String) -> [ECNFFormationType] {
        code == "OUTSTANDING" ? [.newest, .featured] : [.pdf, .video, .audio, .text, .link]
    }
    
    //MARK: - Methods
    func getLocatizedString() -> String {
        switch self {
        case .pdf:
            return "PDF"
        case .video:
            return "Videos"
        case .audio:
            return "Audio"
        case .text:
            return "Texto"
        case .link:
            return "Enlaces"
        case .newest:
            return "Lo Nuevo"
        case .featured:
            return "Lo más visto"
        }
    }
}
