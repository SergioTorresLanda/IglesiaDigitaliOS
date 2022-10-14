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
    let locationName: String?
    let coordinate: CLLocationCoordinate2D
    let id: UInt

  init(
    title: String?,
    locationName: String?,
    coordinate: CLLocationCoordinate2D,
    id: UInt
  ) {
    self.title = title
    self.locationName = locationName
    self.coordinate = coordinate
    self.id = id

    super.init()
  }

  var subtitle: String? {
    return locationName
  }
}
