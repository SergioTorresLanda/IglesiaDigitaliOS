//
//  Collection+Utils.swift
//  EncuentroCatolicoUtils
//
//  Created by Alejandro on 18/10/22.
//

import Foundation

public extension Collection {

    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
