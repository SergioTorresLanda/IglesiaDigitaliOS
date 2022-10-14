//
//  EnumsNetworking.swift
//  DeFatAFit
//
//  Created by Ulises Atonatiuh González Hernández on 27/04/20.
//  Copyright © 2020 Ulisao. All rights reserved.
//

import Foundation


public enum ErrorManager: Swift.Error {
    case errorInvalidUrl
    case errorNoParameters
    case errorHeaders
    case errorSereliziation
    case errorServicio
    case noInternet
}
public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}
