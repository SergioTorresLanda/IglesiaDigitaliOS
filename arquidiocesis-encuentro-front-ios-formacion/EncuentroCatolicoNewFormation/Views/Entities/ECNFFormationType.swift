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
        }
    }
}
