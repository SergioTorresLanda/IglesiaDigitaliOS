//
//  CryptoUtils.swift
//  EncuentroCatolicoServices
//
//  Created by llavin on 08/12/22.
//

import Foundation
import CommonCrypto

struct CryptoUtils {
    public static func generateIV(with hashKey: String) -> Data? {
        guard let keyData: Data = hashKey.data(using: .utf8) else { return nil }
        guard let dataToProcess: Data = self.generateHMAC(with: keyData, and: keyData) else { return nil }
        return self.generateHMAC(with: keyData, and: dataToProcess)?.prefix(16)
    }
    
    public static func generateSalt(phrase: String) -> Data? {
        guard let result: DataHandler = self.generate(phrase: phrase,
                                                      rounds: 2920) else { return nil }
        return self.generateHMAC(with: result.derivedKey, and: result.HMACData)
    }
    
    public static func generateSalt(certificate: String) -> Data? {
        guard let result: DataHandler = self.generate(phrase: certificate,
                                                      rounds: 3670) else { return nil }
        return self.generateHMAC(with: result.derivedKey, and: result.HMACData)
    }
    
    public static func generateSalt(token: String) -> Data? {
        return self.makeSalt(phrase: token)
    }
    
    public static func generateSalt(token: Data) -> Data? {
        guard let text = String(data: token, encoding: .ascii) else { return nil }
        return self.makeSalt(phrase: text)
    }
    
    public static func generateKey(_ key: String) -> Data? {
        guard let salt = self.generateSalt(phrase: key) else { return nil }
        var derivedKey: [UInt8] = Array(repeating: 0, count: Int(kCCKeySizeAES256))
        let status = self.derivationPBKDF(phrase: key,
                                          salt: salt,
                                          derivedKey: &derivedKey,
                                          rounds: 65536)
        guard status == 0 else { return nil }
        return Data(bytes: &derivedKey, count: derivedKey.count)
    }
    
    public static func getTextFromSHA512(text: String) -> String? {
        guard let data = text.data(using: .utf8),
            let digest = self.generateSHA512(data: data) else { return nil }
        var result: String = ""
        digest.forEach {
            result += String(format: "%02x", $0)
        }
        return result
    }
    
    public static func generateSHA512(text: String) -> Data? {
        guard let data = text.data(using: .utf8) else { return nil }
        return self.generateSHA512(data: data)
    }
    
    public static func generateMD5(text: String) -> Data? {
        guard let data = text.data(using: .utf8) else { return nil }
        return self.generateMD5(data: data)
    }
    
    public static func generateMD5(data: Data) -> Data? {
        var digest: [UInt8] = Array(repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
        return data.withUnsafeBytes {
            CC_MD5($0.baseAddress, UInt32(data.count), &digest)
            return Data(bytes: &digest, count: Int(CC_MD5_DIGEST_LENGTH))
        }
    }
    
    public static func generateSHA512(data: Data) -> Data? {
        var digest: [UInt8] = Array(repeating: 0, count: Int(CC_SHA512_DIGEST_LENGTH))
        return data.withUnsafeBytes {
            CC_SHA512($0.baseAddress, UInt32(data.count), &digest)
            return Data(bytes: &digest, count: Int(CC_SHA512_DIGEST_LENGTH))
        }
    }
    
    public static func cleanDescription(from hash: Data) -> String? {
        return String(data: hash, encoding: .ascii)?.trimmingCharacters(in: .controlCharacters)
    }
    
    public static func cleanPadding(from data: Data) -> Data? {
        guard let text = String(data: data, encoding: .ascii) else { return nil }
        let cleanText = text.trimmingCharacters(in: .controlCharacters)
                            .trimmingCharacters(in: .whitespaces)
        return cleanText.data(using: .ascii)
    }
    
    public static func zeroPadding(for data: Data) -> Data {
        var cleanString: Data = data
        repeat {
            cleanString.append(00)
        } while (cleanString.count % 32) != 0
        return cleanString
    }
    
    private static func makeSalt(phrase: String) -> Data? {
        guard let result: DataHandler = self.generate(phrase: phrase,
                                                      rounds: 8769) else { return nil }
        return self.generateHMAC(with: result.derivedKey, and: result.HMACData)
    }
    
    private static func generateHMAC(with key: Data, and data: Data) -> Data? {
        var context = CCHmacContext()
        var result: [UInt8] = Array(repeating: 0, count: Int(CC_SHA256_DIGEST_LENGTH))
        return key.withUnsafeBytes { keyBytes in
            data.withUnsafeBytes { dataBytes in
                CCHmacInit(&context,
                           CCHmacAlgorithm(kCCHmacAlgSHA256),
                           keyBytes.baseAddress,
                           key.count)
                CCHmacUpdate(&context,
                             dataBytes.baseAddress,
                             data.count)
                CCHmacFinal(&context,
                            &result)
                return Data(bytes: &result, count: Int(CC_SHA256_DIGEST_LENGTH))
            }
        }
    }
    
    private static func generate(phrase: String, rounds: UInt32) -> DataHandler? {
        guard let digest: Data = self.generateSHA512(text: phrase) else { return nil }
        var derivedKey: [UInt8] = Array(repeating: 0, count: Int(kCCKeySizeAES256))
        let sizeDigest: Int = digest.count / 2
        let saltData: Data = digest.prefix(sizeDigest)
        let hmacData: Data = digest.suffix(sizeDigest)
        let status = self.derivationPBKDF(phrase: phrase,
                                          salt: saltData,
                                          derivedKey: &derivedKey,
                                          rounds: rounds)
        guard status == 0 else { return nil }
        return DataHandler(Data(bytes: &derivedKey, count: derivedKey.count),
                           hmacData)
    }
    
    private static func derivationPBKDF(phrase: String, salt: Data, derivedKey: inout [UInt8], rounds: UInt32) -> Int32 {
        guard let phraseData: Data = phrase.data(using: .utf8) else { return -1 }
        return derivedKey.withUnsafeMutableBytes { derivedKeyBytes in
            salt.withUnsafeBytes { saltBytes in
                CCKeyDerivationPBKDF(CCPBKDFAlgorithm(kCCPBKDF2),
                                     phrase,
                                     phraseData.count,
                                     saltBytes.baseAddress?.assumingMemoryBound(to: UInt8.self),
                                     salt.count,
                                     CCPseudoRandomAlgorithm(kCCPRFHmacAlgSHA1),
                                     rounds,
                                     derivedKeyBytes.baseAddress?.assumingMemoryBound(to: UInt8.self),
                                     kCCKeySizeAES256)
            }
        }
    }
}

extension CryptoUtils {
    private struct DataHandler {
        let derivedKey: Data
        let HMACData: Data
        
        public init(_ derivedKey: Data, _ HMACData: Data) {
            self.derivedKey = derivedKey
            self.HMACData = HMACData
        }
    }
}
