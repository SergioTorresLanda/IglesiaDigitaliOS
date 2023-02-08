//
//  Bundle.swift
//  EncuentroCatolicoPrayers
//
//  Created by Diego Martinez on 23/02/21.
//

import Foundation

@available(iOS 13.0, *)
public extension Bundle {
    static let local: Bundle = Bundle.init(for: Home_Oraciones.self)
}
