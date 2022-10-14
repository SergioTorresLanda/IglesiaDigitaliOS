//
//  Bundle.swift
//  EncuentroCatolicoDonations
//
//  Created by Diego Martinez on 03/03/21.
//

import Foundation

public extension Bundle {
    static let local: Bundle = Bundle.init(for: DonationsRouter.self)
    
    func read(for identifier: String, withExtension termination: String) throws -> Data {
        guard let dataUrl = Bundle.local.url(forResource: identifier, withExtension: termination) else {
            throw NSError(domain: "", code: 404, userInfo: [
                NSLocalizedDescriptionKey: "Not found"
            ])
        }
        
        return try Data(contentsOf: dataUrl)
    }
}


