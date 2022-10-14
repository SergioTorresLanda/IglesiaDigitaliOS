//
//  OpenMap.swift
//  RedSocialFramework
//
//  Created by Miguel Angel Vicario Flores on 22/10/20.
//  Copyright © 2020 Gabriel Briseño. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

public class OpenMap {
     
    static public func forPlace(name: String, latitude: Double, longitude: Double) {
        let latitude: CLLocationDegrees = latitude
        let longitude: CLLocationDegrees = longitude

        let regionDistance:CLLocationDistance = 10000
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = name
        mapItem.openInMaps(launchOptions: options)
    }
}
