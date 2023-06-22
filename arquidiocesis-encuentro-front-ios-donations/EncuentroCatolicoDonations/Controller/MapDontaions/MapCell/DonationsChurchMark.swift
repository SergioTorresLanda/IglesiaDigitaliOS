//
//  DonationsChurchMark.swift
//  EncuentroCatolicoDonations
//
//  Created by Sergio Torres Landa on 15/03/22.
//

import Foundation
import MapKit

class DonationsChurchMark: NSObject, MKAnnotation {
    let title: String?
    let coordinate: CLLocationCoordinate2D
    let id: UInt
    let image_url: String?
    
    init(
        title: String?,
        coordinate: CLLocationCoordinate2D,
        id: UInt,
        url: String?
    ) {
        self.title = title
        self.coordinate = coordinate
        self.id = id
        self.image_url = url
        
        super.init()
    }
}
