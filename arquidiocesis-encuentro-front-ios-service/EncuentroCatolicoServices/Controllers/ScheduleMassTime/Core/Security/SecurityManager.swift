//
//  SecurityManager.swift
//  EncuentroCatolicoServices
//
//  Created by llavin on 07/12/22.
//

import Foundation

final class SecurityManager {
    //MARK: - Static Methods
    static func configure() -> Data? {
        guard let dataFile = try? Bundle.myLocal.read(for: "conf", withExtension: "data"),
              let decrypted = try? SecurityUtils.dataBase().decrypt(dataFile.bytes) else {
            return nil
        }
        
        return Data(decrypted)
    }
}

