//
//  String+leadingZeros.swift
//  ZeusPayment
//
//  Created by David on 07/10/20.
//  Copyright © 2020 Gabriel Briseño. All rights reserved.
//

import Foundation

internal extension String {

    init(withInt int: Int, leadingZeros: Int = 2) {
        self.init(format: "%0\(leadingZeros)d", int)
    }
    
    func leadingZeros(_ zeros: Int) -> String {
        let padAmount = max(zeros, self.count)
        return String(repeatElement("0", count: padAmount - self.count)) + self
    }

}
