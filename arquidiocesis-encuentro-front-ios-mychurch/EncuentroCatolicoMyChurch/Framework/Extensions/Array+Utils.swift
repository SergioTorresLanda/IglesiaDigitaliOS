//
//  Array+Utils.swift
//  Nomad
//
//  Created by Diego Luna on 14/08/20.
//

import Foundation

extension Array {
    subscript(safe index: Index) -> Element? {
        let isValidIndex = index >= 0 && index < count
        return isValidIndex ? self[index] : nil
    }
    
    func canBeUpdated(safe index: Index) -> Bool {
        let isValidIndex = index >= 0 && index < count
        return isValidIndex ? true : false
    }
}
  
