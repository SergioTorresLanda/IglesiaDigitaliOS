//
//  SecurityManager.swift
//  EncuentroCatolicoDonations
//
//  Created by Alejandro on 14/10/22.
//

import Foundation

final class SecurityManager {
    //MARK: - Static Methods
    static func configure() -> Data? {
        guard let dataFile = try? Bundle.local.read(for: "conf", withExtension: "data"),
              let decrypted = try? SecurityUtils.dataBase().decrypt(dataFile.bytes) else {
            return nil
        }
        
        return Data(decrypted)
    }
}
