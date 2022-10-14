//
//  ArrayExtension.swift
//  RedSocialFramework
//
//  Created by Miguel Angel Vicario Flores on 17/12/20.
//  Copyright © 2020 Gabriel Briseño. All rights reserved.
//

import Foundation

public extension Array {
    var second: Element? {
        get { return self.count > 1 ? self[1] : nil }
    }
}
