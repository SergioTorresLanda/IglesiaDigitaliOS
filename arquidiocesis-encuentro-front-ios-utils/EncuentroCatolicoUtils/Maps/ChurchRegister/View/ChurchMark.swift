//
//  ChurchMark.swift
//  encuentro
//
//  Created by Ahmed Castro on 10/4/20.
//  Copyright © 2020 Linko. All rights reserved.
//

import MapKit

class ChuckMark: NSObject, MKAnnotation {
    let title: String?
    let coordinate: CLLocationCoordinate2D
    let id: UInt
    let url: String?
    
    init(
        title: String?,
        coordinate: CLLocationCoordinate2D,
        id: UInt,
        url: String?
    ) {
        self.title = title
        self.coordinate = coordinate
        self.id = id
        self.url = url
        
        super.init()
    }
}
