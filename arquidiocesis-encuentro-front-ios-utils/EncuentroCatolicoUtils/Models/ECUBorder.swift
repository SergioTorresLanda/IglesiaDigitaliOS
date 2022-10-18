//
//  ECUBorder.swift
//  EncuentroCatolicoUtils
//
//  Created by Alejandro on 18/10/22.
//

import UIKit

public struct ECUBorder {
    //MARK: - Properties
    public let side: ECUViewSide
    public let color: CGColor
    public let thickenss: CGFloat
    
    //MARK: - Life Cycle
    public init(side: ECUViewSide,color: CGColor, thickness: CGFloat) {
        self.side = side
        self.color = color
        self.thickenss = thickness
    }
    
}
