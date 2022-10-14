//
//  SocialNetworkErrors.swift
//  zeus-ios-sdk-new-social-network
//
//  Created by Miguel Angel Vicario Flores on 24/09/20.
//  Copyright © 2020 Gabriel Briseño. All rights reserved.
//

import Foundation

public enum SocialNetworkErrors: Error {
    case NetworkConnection
    case ResponseError

    public var message: String {
        switch self {
        case .NetworkConnection:
            return "Servidor No Disponible"
        case .ResponseError:
            return "Error Con El Servicio"
        }
    }
}
