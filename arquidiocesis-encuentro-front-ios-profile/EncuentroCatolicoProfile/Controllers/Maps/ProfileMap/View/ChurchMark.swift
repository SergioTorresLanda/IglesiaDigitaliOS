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
    let image_url: String?
    let subtitle: String?
    
    init(
        title: String?,
        coordinate: CLLocationCoordinate2D,
        id: UInt,
        url: String?,
        subtitle: String?
    ) {
        self.title = title
        self.coordinate = coordinate
        self.id = id
        self.image_url = url
        self.subtitle = subtitle
        
        super.init()
    }
}
