//
//  Int+Utils.swift
//  EncuentroCatolicoUtils
//
//  Created by Alejandro on 19/10/22.
//

import Foundation

public extension Int {
    //MARK: - Properties
    static let otpTimeout: Int = 179
    
    //MARK: - Methods
    func secondstoTimeString() -> String {
        let seg = self % 60
        let min = self / 60
        let segString = seg > 9 ? String(seg) : "0\(seg)"
        
        return self > 0 ? "\(min):\(segString)": "0:00"
    }
}
