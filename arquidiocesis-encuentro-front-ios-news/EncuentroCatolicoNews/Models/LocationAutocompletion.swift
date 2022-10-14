//
//  LocationAutocompletion.swift
//  RedSocialFramework
//
//  Created by Miguel Angel Vicario Flores on 18/12/20.
//  Copyright © 2020 Gabriel Briseño. All rights reserved.
//

import UIKit
import MapKit

public struct LocationAutocompletion {
    private let searchCompletion: MKLocalSearchCompletion
    private let name: String
    private let direction: String
    
    init(searchCompletion: MKLocalSearchCompletion, name: String, direction: String) {
        self.searchCompletion = searchCompletion
        self.name = name
        self.direction = direction
    }
    
    public func getSeatchCompletion() -> MKLocalSearchCompletion {
        return searchCompletion
    }
    
    public func getName() -> String {
        return name
    }
    
    public func getDirection() -> String {
        return direction
    }
}
