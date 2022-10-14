//
//  MapDonationsView.swift
//  EncuentroCatolicoDonations
//
//  Created by Pablo Luis Velazquez Zamudio on 15/03/22.
//

import UIKit
import MapKit

struct selectMap {
    var id: Int?
    var name: String?
    var url: String?
}

class MapDonationsView: UIViewController, MapDonationsViewProtocol {
    
// MARK: PROTOCOL VAR -
    var presenter: MapDonationsPresneterProtocol?
    var currentLocationRegionRegion: MKCoordinateRegion?
    var llenado = true
    var churchDetail: Int = 0
    var idChurchFinal: Int = 0
    var searchCompleter = MKLocalSearchCompleter()
    let localRadius: CLLocationDegrees = 100_000
    var loc = ["Plaza de las Américas, Villa de Guadalupe, Gustavo A. Madero, 7050 Ciudad de México, CDMX", "Otomíes Mz 84 bis Lt 4, Ajusco, Coyoacán, 4300 Ciudad de México, CDMX", "Andador Gladiolas Mz. 9 Lt. 2, Primavera Totoltepec, Tlalpan, 14400 Ciudad de México, CDMX"]
    
// MARK: LOCAL VAR -
    var locationManager = CLLocationManager()
    
// MARK: @IBOUTELTS -
    @IBOutlet weak var customNavBar: UIView!
    @IBOutlet weak var titleNavBar: UILabel!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var myMap: MKMapView!
    @IBOutlet weak var searchIcon: UIImageView!
    
// MARK: LIFE CYCLE VIEW FUNCTION -
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.startUpdatingLocation()
        myMap.delegate = self
        if let latitude = locationManager.location?.coordinate.latitude
           ,let longitude = locationManager.location?.coordinate.longitude {
            let span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
            currentLocationRegionRegion = region
            myMap.setRegion(region, animated: true)
            myMap.showsUserLocation = true
            setCurrentLocationMap()
        }
        
        initView()
           /* self?.mapKit.addAnnotations(annotations)
            self?.setCurrentLocationMap()
            self?.removeLoader()*/
        
    }
        
// MARK: SETUP FUNCTIONS -
    private func setupUI() {
        customNavBar.layer.cornerRadius = 20
        customNavBar.ShadowNavBar()
        btnBack.setTitle("", for: .normal)
        searchField.layer.cornerRadius = 11
    }
    
    private func setCurrentLocationMap() {
        if let region = currentLocationRegionRegion {
            myMap.setRegion(region, animated: true)
        }
    }
    
    private func initView() {
        
//        addressTextField.delegate = self
//        searchCompleter.delegate = self
//        if #available(iOS 13.0, *) {
//            searchCompleter.resultTypes = [.pointOfInterest, .address]
//        }
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
       // addressResultTableView.register(AddressTableViewCell.nib,
                                       // forCellReuseIdentifier: AddressTableViewCell.reuseIdentifier)
        //addressResultTableView.delegate = self
        //addressResultTableView.dataSource = self
        
    }
    
// MARK: @IBACTIONS -
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

}

extension MapDonationsView: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        if view.isKind(of: AnnotationsDonations.self)
        {
            for subview in view.subviews {
                subview.removeFromSuperview()
            }
        }
    }
//    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
//        if view.annotation is MKUserLocation
//        {
//            return
//        }
//        let annotationView = view.annotation as? DonationsChurchMark
//        let views = Bundle.loadView(fromNib: "DonationCustomAnnotation", withType: DontaionCustomAnnotation.self)
//        views.lblChurchName.text = annotationView?.title
//        //views.lblChurchName.sizeToFit()
//        let imageURL = annotationView?.image_url
//        if imageURL == "" {
//            views.imgChurch.image = UIImage(named:"church-placeholder", in: Bundle(for: MapDonationsView.self), compatibleWith: nil)
//        }else{
//            if let imageUrl = URL(string: imageURL ?? "") {
//               // views.imgChurch.af.setImage(withURL: imageUrl)
//            }
//        }
//       // views.btnAnnotation.setTitle("", for: .normal)
//       // views.delegate = self
//        views.btnAnnotation.tag = churchDetail
//        views.addSubview(views.btnAnnotation)
//        views.center = CGPoint(x: view.bounds.size.width / 2, y: -views.bounds.size.height*0.52)
//        view.addSubview(views)
//        mapView.setCenter((view.annotation?.coordinate)!, animated: true)
//        if ((view.annotation as? DonationsChurchMark)?.id) != nil {
//            // showLoader()
//            let idChurchAnn = annotationView?.id ?? 1
//            idChurchFinal = Int(idChurchAnn)
//            let nameChurch = annotationView?.title
//            let urlChourch = annotationView?.image_url
//            let select = selectMap(id: Int(idChurchAnn), name: nameChurch, url: urlChourch)
//            print(select)
////            let singleton = ProfileMapViewController.singleton
////            singleton.nameChurch = annotationView?.title ?? "Unspecified"
////            singleton.idChurch = Int(idChurchAnn)
////            singleton.urlImgChurch = annotationView?.image_url ?? "Unspecified"
//            //  self.dismiss(animated: true, completion: nil)
//            //
//            //            self.churchDetail = Int(idChurch ?? 0)
//            //            Church.getChurch(id: id) { [weak self] church in
//            //                self?.removeLoader()
//            //                if let church = church {
//            //                    self?.goToChurch(church)
//            //                }
//            //            }
//        }
//    }
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "MapPointerCollectionViewCell"
        if annotation is MKUserLocation && llenado {
            self.llenado = false
            return nil
        }
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        if annotationView == nil {
            annotationView = AnnotationsDonations(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = false
            annotationView?.image = UIImage(named:"map-item-icon", in: Bundle(for: MapDonationsView.self), compatibleWith: nil)
        } else {
            annotationView?.annotation = annotation
        }
        return annotationView
    }
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        print("mapView(_:annotationView:calloutAccessoryControlTapped)")
    }
}

//MARK: - User location delegate
extension MapDonationsView : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let region = MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: localRadius, longitudeDelta: localRadius))
            searchCompleter.region = region
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error: \(error)")
    }
}
