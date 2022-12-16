//
//  SecurityUtils.swift
//  EncuentroCatolicoServices
//
//  Created by llavin on 07/12/22.
//

import Foundation
import CryptoSwift
import CommonCrypto

final class SecurityUtils {
    //MARK: - Static Methods
    static func createRandomIV() -> [UInt8] {
        AES.randomIV(AES.blockSize)
    }
    
    static func encryptForWebView(_ data: String) -> Data? {
        guard let certificate = SecurityInfoHandler.getInfoBy(provider: .webapp) else {
            return nil
        }
        
        let iv = Self.createRandomIV()
        let data = Data(data.utf8)
        let key = certificate.data

        do {
            let encryptedData = try AES(key: key.bytes, blockMode: CBC(iv: iv), padding: .pkcs5).encrypt(data.bytes)
            var resultBytes = iv

            resultBytes.append(contentsOf: encryptedData)
            
            return Data(resultBytes)
        } catch {
            return nil
        }
    }
    
    //MARK: - Static methods
    static func dataBase() throws -> AES {
        let auxChain: String = "69bb9cc9b9e1f0b2c49g98fif35a114big"
        let iv: Data = Data(repeating: 0, count: 16)
        
        guard let key = CryptoUtils.generateKey(auxChain) else {
            throw NSError(domain: "", code: 500, userInfo: nil)
        }
        
        return try AES(key: key.bytes, blockMode: CTR(iv: iv.bytes))
    }
}
