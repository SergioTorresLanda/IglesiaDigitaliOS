//
//  LocationsInteractor.swift
//  zeus-ios-sdk-new-social-network
//
//  Created Miguel Angel Vicario Flores on 06/09/20.
//  Copyright ©️ 2020 Gabriel Briseño. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit
import MapKit

public class LocationsInteractor: LocationsInteractorProtocol {
    
    weak var presenter: LocationsPresenterProtocol?
    
    //MARK: - GetMapImage
    func getMapImage(coordinates: CLLocationCoordinate2D) {
        let snapOptions = MKMapSnapshotter.Options()
        let region = MKCoordinateRegion(center: coordinates, latitudinalMeters: 500, longitudinalMeters: 500)
        snapOptions.region = region
        snapOptions.size = CGSize(width: 400, height: 250)
        snapOptions.scale = UIScreen.main.scale
        let snapShotter = MKMapSnapshotter(options: snapOptions)
        snapShotter.start { (snap, error) in
            if error != nil {
                self.presenter?.didFinishGettingMapWithErrors(error: SocialNetworkErrors.ResponseError)
                return
            }
            
            if let snapShot = snap?.image {
                let image = UIGraphicsImageRenderer(size: snapShot.size).image { _ in
                    snapShot.draw(at: .zero)
                    
                    let pinView = MKPinAnnotationView(annotation: nil, reuseIdentifier: nil)
                    let pinImage = pinView.image
                    
                    var point = CGPoint(x: snapShot.size.width / 2, y: snapShot.size.height / 2)
                    let pinSize = pinView.image?.size
                    point.x = point.x-(pinSize!.width/2)
                    point.y = point.y-(pinSize!.height/2)
                    
                    pinImage?.draw(at: point)
                }
                
                DispatchQueue.main.async {
                    self.presenter?.didFinishGettingMap(image: image)
                }
            } else {
                self.presenter?.didFinishGettingMapWithErrors(error: SocialNetworkErrors.ResponseError)
            }
        }
    }
    
}
