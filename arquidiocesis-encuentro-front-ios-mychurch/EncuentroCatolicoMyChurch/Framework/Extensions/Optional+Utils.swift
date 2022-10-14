//
//  Optional+Utils.swift
//  Nomad
//
//  Created by Diego Luna on 14/08/20.
//

import Foundation

public extension Optional where Wrapped: Any {
    
    var isNull: Bool {
        return self == nil || self is NSNull
    }
    
    func value(or defaultValue: Wrapped) -> Wrapped {
        if let wrappedItem = self {
            return wrappedItem
        }
        
        return defaultValue
    }
}
