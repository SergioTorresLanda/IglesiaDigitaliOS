//
//  Bundle.swift
//  EncuentroCatolicoServices
//
//  Created by Diego Martinez on 23/02/21.
//

import Foundation

public extension Bundle {
    static let myLocal: Bundle = Bundle.init(for: ScheduleMassTimeViewController.self)
    
    func read(for identifier: String, withExtension termination: String) throws -> Data {
        guard let dataUrl = Bundle.local.url(forResource: identifier, withExtension: termination) else {
            throw NSError(domain: "", code: 404, userInfo: [
                NSLocalizedDescriptionKey: "Not found"
            ])
        }
        
        return try Data(contentsOf: dataUrl)
    }
}
