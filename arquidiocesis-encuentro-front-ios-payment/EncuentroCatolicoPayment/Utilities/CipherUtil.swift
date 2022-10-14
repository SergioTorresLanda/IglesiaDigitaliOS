//
//  CipherUtil.swift
//  zeus-ios-sdk-payment
//
//  Created by David on 07/10/20.
//  Copyright © 2020 Gabriel Briseño. All rights reserved.
//

import Foundation
import CryptoSwift
enum CipherUtil {
    
    static var iTosk = "702681"
    static var SxTICKET = "1Vh-tU51wgA+yhJw"

    static func encryptJSON(text: String) -> String? {
        let iv = generateIV(employee: iTosk)
        let key = SxTICKET
        guard let bytesIV = iv.data(using: .utf8)?.bytes,
            let encrypt = try? AES(key: key.bytes, blockMode: CBC(iv: bytesIV), padding: .pkcs5).encrypt(text.bytes) else {
            return nil
        }
        return encrypt.toBase64()
    }
    
    static func generateIV(employee: String) -> String {
        var strEmployee: String = ""
        var i = 0
        var j = 0
        
        while i < 16 {
            if i > 0 {
                j += 1
            }
            j %= employee.count
            strEmployee = strEmployee + String(employee.charAt(at: j))
            i += 1
        }
                
        return strEmployee
    }
    
}

fileprivate extension String {
    // charAt(at:) returns a character at an integer (zero-based) position.
    // example:
    // let str = "hello"
    // var second = str.charAt(at: 1)
    //  -> "e"
    func charAt(at: Int) -> Character {
        let charIndex = self.index(self.startIndex, offsetBy: at)
        return self[charIndex]
    }
}
