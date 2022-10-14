//
//  Traceable.swift
//  EncuentroCatolico
//
//  Created by Juan Martell on 13/10/22.
//

import Foundation
public protocol Traceable {
    /// Event name
    var name: String { get }
    /// Tracking parameters
    var parameters: [String: String] { get }
}
