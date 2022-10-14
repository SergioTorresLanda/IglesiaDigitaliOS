//
//  PriestDetailView.swift
//  EncuentroCatolicoVirtualLibrary
//
//  Created by Pablo Luis Velazquez Zamudio on 29/06/21.
//

import UIKit
import MapKit
import Contacts
import CoreLocation

class PriestDetailView: UIViewController, PriestDetailViewProtocol {
    
    var presenter: PriestDetailPresenterPRotocol?
    let alertLoader = UIAlertController(title: "", message: "\n \n \n \n \nCargando...", preferredStyle: .alert)
    let mapsAlert = UIAlertController(title: "Encuentro", message: "Seleciona una opción", preferredStyle: .actionSheet)
    var locationManager = CLLocationManager()
    var latitude: CLLocationDegrees!
    var longitude: CLLocationDegrees!
    var addressShare = "Unspecified"
    var counter = 0
    var latitudeStr = 0.0
    var longitudeStr = 0.0
    let annotation = MKPointAnnotation()
    
// MARK: @IBOUTELTS -
    @IBOutlet weak var contentNavBar: UIView!
    @IBOutlet weak var customNavBar: UIView!
    @IBOutlet weak var navBarTitle: UILabel!
    @IBOutlet weak var backIcon: UIImageView!
    @IBOutlet weak var lblMainTitle: UILabel!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet var lblCollectionStack: [UILabel]!
    @IBOutlet weak var mainScroll: UIScrollView!
    @IBOutlet weak var mainContentView: UIView!
    @IBOutlet weak var mapCard: UIView!
    @IBOutlet weak var lblCompartir: UILabel!
    @IBOutlet weak var shareIcon: UIImageView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var pinHolder: UIImageView!
    @IBOutlet weak var placeHolderText: UILabel!
    @IBOutlet weak var star1: UIImageView!
    @IBOutlet weak var star2: UIImageView!
    @IBOutlet weak var star3: UIImageView!
    @IBOutlet weak var star4: UIImageView!
    @IBOutlet weak var star5: UIImageView!
    @IBOutlet weak var lblDaysAgo: UILabel!
    
// MARK: LIFE CYCLE APP -
    override func viewDidLoad() {
        super.viewDidLoad()
       // setupLocation()
        showLoading()
        setupUI()
        setupGestures()
        let singleton = PriestPSOSView.singleton
        print("Este es el id:", singleton.idService)
        presenter?.requestDetailService(idService: singleton.idService) //708
    
    }

    func setupUI() {
        customNavBar.ShadowNavBar()
        cardView.layer.cornerRadius = 8
        cardView.ShadowCard()
        mapCard.layer.cornerRadius = 8
        mapCard.ShadowCard()
        customNavBar.layer.cornerRadius = 20
        lblCollectionStack.forEach { (label) in
            label.adjustsFontSizeToFitWidth = true
        }
                
    }
    
    func setupGestures() {
        let tapBack = UITapGestureRecognizer(target: self, action: #selector(handleTapBack))
        backIcon.addGestureRecognizer(tapBack)
        
        let tapLbl = UITapGestureRecognizer(target: self, action: #selector(handleTapLbl))
        lblCompartir.addGestureRecognizer(tapLbl)
        
        let tapIcon = UITapGestureRecognizer(target: self, action: #selector(handleTapIcon))
        shareIcon.addGestureRecognizer(tapIcon)
        
    }
    
    private func setupMenuMaps() {
        
        let coordinates = CLLocationCoordinate2D(latitude: CLLocationDegrees(CGFloat(latitudeStr)), longitude: CLLocationDegrees(CGFloat(longitudeStr)))
        
        let appleMaps = UIAlertAction(title: "Apple Maps", style: .default) {
            _ in
            let churchMapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinates))
            churchMapItem.name = self.addressShare
            churchMapItem.openInMaps()
        }
        
        let googleMaps = UIAlertAction(title: "Google Maps", style: .default) {
            _ in
            
            let mapsUrl = URL(string:"https://www.google.com/maps/place/\(coordinates.latitude),\(coordinates.longitude)")!
            
            if (UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!)) {
                UIApplication.shared.open(mapsUrl, options: [:]) {
                    _ in
                }
            } else if (UIApplication.shared.canOpenURL(URL(string:"https://www.google.com/maps")!)) {
                UIApplication.shared.open(mapsUrl, options: [:]) {
                    _ in
                }
            }
        }
        
        let waze = UIAlertAction(title: "Waze", style: .default) {
            _ in
            
            let mapsUrl = URL(string:"https://www.waze.com/ul?ll=\(coordinates.latitude),\(coordinates.longitude)&navigate=yes&zoom=17")!
            
            if (UIApplication.shared.canOpenURL(URL(string:"waze://")!)) || (UIApplication.shared.canOpenURL(URL(string:"https://www.waze.com/")!)) {
                UIApplication.shared.open(mapsUrl, options: [:]) {
                    _ in
                }
            }
        }
        
        let socialMedia = UIAlertAction(title: "Redes sociales", style: .default) { (action) in
            self.shareLocation()
            
        }
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel)
        
        mapsAlert.addAction(socialMedia)
        mapsAlert.addAction(appleMaps)
        mapsAlert.addAction(googleMaps)
        mapsAlert.addAction(waze)
        mapsAlert.addAction(cancelAction)
        
    }
    
    private func setupLocation() {
        locationManager.delegate = self
        if CLLocationManager.locationServicesEnabled() {
            if #available(iOS 14.0, *) {
                switch locationManager.authorizationStatus {
                case .notDetermined, .restricted, .denied:
                    print("No access")
                    
                    alertLoader.dismiss(animated: true, completion: nil)
                    UIView.animate(withDuration: 0.3) {
                        self.mapView.alpha = 0
                        self.lblCompartir.alpha = 0
                        self.shareIcon.alpha = 0
                        self.placeHolderText.alpha = 1
                        self.pinHolder.alpha = 0.4
                    }
                    locationManager.requestWhenInUseAuthorization()
                    locationManager.desiredAccuracy = kCLLocationAccuracyBest
                    locationManager.startUpdatingLocation()
                    
                case .authorizedAlways, .authorizedWhenInUse:
                    print("Access")
                    locationManager.requestWhenInUseAuthorization()
                    locationManager.desiredAccuracy = kCLLocationAccuracyBest
                    locationManager.startUpdatingLocation()
                    self.placeHolderText.alpha = 0
                    self.pinHolder.alpha = 0
                    self.mapView.alpha = 1
                    self.lblCompartir.alpha = 1
                    self.shareIcon.alpha = 1
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        self.alertLoader.dismiss(animated: true, completion: nil)
                        if self.latitude != nil && self.longitude != nil {
                            print("lat & long are not nil")
                            let localizations = CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude)
                            let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                            let region = MKCoordinateRegion(center: localizations, span: span)
                            self.mapView.setRegion(region, animated: true)
                            self.mapView.showsUserLocation = true
                        }else{
                            print("lat & long are nil")
                        }
                    }
                    
                @unknown default:
                    break
                }
            } else {
                // Fallback on earlier versions
            }
        } else {
            print("Location services are not enabled")
        }
    }
    
    @objc func handleTapBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func handleTapLbl() {
        present(mapsAlert, animated: true)
       // self.present(alertPick,animated: true, completion: nil )
    }
    
    @objc func handleTapIcon() {
       // self.present(alertPick,animated: true, completion: nil )
    }
    
    func showLoading(){
        let imageView = UIImageView(frame: CGRect(x: 75, y: 25, width: 140, height: 60))
        imageView.image = UIImage(named: "logoEncuentro", in: Bundle.local, compatibleWith: nil)
        alertLoader.view.addSubview(imageView)
        self.present(alertLoader, animated: false, completion: nil)
    }
    
    func shareLocation() {
        // let items = [URL(string: url)!] este es solo para compartir url sin otro texto
        let items: [Any] = [addressShare]
        let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(ac, animated: true)
    }
    
    let regionRadio : CLLocationDistance = 1000
    
    func centerMapOnLocation (ubicacio: CLLocation) {
        
            let cordinateRegion = MKCoordinateRegion(center: ubicacio.coordinate, latitudinalMeters: regionRadio, longitudinalMeters: regionRadio)
         mapView.setRegion (cordinateRegion, animated: true)
            
        }
    
    func succesRequest(data: PriestDetail) {
        
        lblMainTitle.text = data.service?.name
        lblCollectionStack[1].text = data.devotee?.name
        if data.devotee?.name == nil {
            lblCollectionStack[1].text = "Unspecified"
        }
        
        fillStars(rating: data.review?.rating ?? 0.0)
        let isoDate = data.creation_date ?? ""
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd,yyyy"

        if let date = dateFormatterGet.date(from: isoDate) {
            print(dateFormatterPrint.string(from: date), "????")
            lblDaysAgo.text = date.timeAgoDisplay()
            
        } else {
           print("There was an error decoding the string", "????")
        }
        
        print("**** \(data.devotee?.name ?? "Unspecified") ***")
        if data.location?.distance != nil {
            let distance = (data.location?.distance!)! / 1000
            lblCollectionStack[2].text = "\(distance) km"
        }
        
        latitudeStr = data.address?.latitude ?? 0.0
        longitudeStr = data.address?.longitude ?? 0.0
        print("Esta es la long y lat", latitudeStr, longitudeStr)
        let localizacionInicial = CLLocation(latitude: latitudeStr, longitude: longitudeStr)
        
        if latitudeStr == 0.0 && longitudeStr == 0.0 {
            UIView.animate(withDuration: 0.3) {
                self.mapView.alpha = 0
                self.lblCompartir.alpha = 0
                self.shareIcon.alpha = 0
                self.placeHolderText.alpha = 1
                self.pinHolder.alpha = 0.4
            }
            print("Coordinate invalid")
        }else{
            if CLLocationCoordinate2DIsValid(CLLocationCoordinate2D(latitude: latitudeStr
                                                                    , longitude: longitudeStr)) {
                print("Coordinate valid")
                centerMapOnLocation(ubicacio: localizacionInicial)
                annotation.coordinate = CLLocationCoordinate2D(latitude: latitudeStr
                                                               , longitude: longitudeStr)
                
                mapView.addAnnotation(annotation)
                
                let location = CLLocation(latitude: self.latitudeStr, longitude: self.longitudeStr)
                location.placemark { placemark, error in
                    guard let placemark = placemark else {
                        print("Error:", error ?? "nil")
                        return
                    }
                    print(placemark.postalAddressFormatted ?? "")
                    self.addressShare = placemark.postalAddressFormatted ?? "nil"
                }
                self.setupMenuMaps()
                
            } else {
                UIView.animate(withDuration: 0.3) {
                    self.mapView.alpha = 0
                    self.lblCompartir.alpha = 0
                    self.shareIcon.alpha = 0
                    self.placeHolderText.alpha = 1
                    self.pinHolder.alpha = 0.4
                }
                print("Coordinate invalid")
                
            }
        }
        if data.review != nil {
            lblCollectionStack[10].text = "Comentario"
            lblCollectionStack[9].text = data.review?.review
        }
        
        lblCollectionStack[6].text = data.devotee?.phone
        if data.progress_history?.last?.sub_status == nil {
            switch data.progress_history?.last?.status {
            case "PENDING_CONFIRMATION":
                lblCollectionStack[8].text = "POR ACEPTAR"
                
            case "SUCCESSFULLY":
                lblCollectionStack[8].text = "CON ÉXITO"
                
            case "UNSUCCESSFULLY":
                lblCollectionStack[8].text = "SIN ÉXITO"
                
            case "ACCEPTED":
                lblCollectionStack[8].text = "ACEPTADO"
                
            case "REJECTED":
                lblCollectionStack[8].text = "RECHAZADO"
                
            case "COMPLETED":
                lblCollectionStack[8].text = "COMPLETADO"
                
            case "CANCELLED":
                lblCollectionStack[8].text = "CANCELADO"
                
            case "CALL_WAITING":
                lblCollectionStack[8].text = "ESPERANDO LLAMADA"
                
            case "CALL_FINISHED":
                lblCollectionStack[8].text = "LLAMADA TERMINADA"
                
            case "LOOKING_FOR_ASSISTANCE":
                lblCollectionStack[8].text = "BUSCANDO AYUDA"
                
            case "HELP_ON_THE_WAY":
                lblCollectionStack[8].text = "AYUDA EN CAMINO"
                
                
            default:
                print("def")
            }
            
        }else{
            switch data.progress_history?.last?.sub_status {
            case "PENDING_CONFIRMATION":
                lblCollectionStack[8].text = "POR ACEPTAR"
                
            case "SUCCESSFULLY":
                lblCollectionStack[8].text = "CON ÉXITO"
                
            case "UNSUCCESSFULLY":
                lblCollectionStack[8].text = "SIN ÉXITO"
                
            case "ACCEPTED":
                lblCollectionStack[8].text = "ACEPTADO"
                
            case "REJECTED":
                lblCollectionStack[8].text = "RECHAZADO"
                
            case "COMPLETED":
                lblCollectionStack[8].text = "COMPLETADO"
                
            case "CANCELLED":
                lblCollectionStack[8].text = "CANCELADO"
                
            case "CALL_WAITING":
                lblCollectionStack[8].text = "ESPERANDO LLAMADA"
                
            case "CALL_FINISHED":
                lblCollectionStack[8].text = "LLAMADA TERMINADA"
                
            case "LOOKING_FOR_ASSISTANCE":
                lblCollectionStack[8].text = "BUSCANDO AYUDA"
                
            case "HELP_ON_THE_WAY":
                lblCollectionStack[8].text = "AYUDA EN CAMINO"
                
                
            default:
                print("def")
            }
            
        }
        
        lblCollectionStack[4].text = data.address?.description
        
        
        alertLoader.dismiss(animated: true, completion: nil)
        
        UIView.animate(withDuration: 0.3) {
            self.cardView.alpha = 1
        }
        
    }
    
    func failRequest() {
        print("Hubo un error")
    }
    
    func fillStars(rating: Double) {
        let imgFill = UIImage(named: "FillStar", in: Bundle.local, compatibleWith: nil)
        let imgEmpty = UIImage(named: "EmptyStar", in: Bundle.local, compatibleWith: nil)
        
        if #available(iOS 13.0, *) {
           // let imgFill = UIImage(named: "Trazado 6941")
            
            if rating == 0.0 {
                print("Is zero")
                star1.image = imgEmpty
                star2.image = imgEmpty
                star3.image = imgEmpty
                star4.image = imgEmpty
                star5.image = imgEmpty
            }else if rating <= 1.0 {
                star1.image = imgFill
                star2.image = imgEmpty
                star3.image = imgEmpty
                star4.image = imgEmpty
                star5.image = imgEmpty
            }else if rating  <= 2.0 {
                star1.image = imgFill
                star2.image = imgFill
                star3.image = imgEmpty
                star4.image = imgEmpty
                star5.image = imgEmpty
            }else if rating <= 3.0 {
                star1.image = imgFill
                star2.image = imgFill
                star3.image = imgFill
                star4.image = imgEmpty
                star5.image = imgEmpty
            }else if rating <= 4.0 {
                star1.image = imgFill
                star2.image = imgFill
                star3.image = imgFill
                star4.image = imgFill
                star5.image = imgEmpty
            }else if rating <= 5.0 {
                star1.image = imgFill
                star2.image = imgFill
                star3.image = imgFill
                star4.image = imgFill
                star5.image = imgFill
            }

        }
    }
    
}

extension PriestDetailView: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        if #available(iOS 14.0, *) {
            switch manager.authorizationStatus {
            case .denied:
                print("nel")
                alertLoader.dismiss(animated: true, completion: nil)
                UIView.animate(withDuration: 0.3) {
                    self.mapView.alpha = 0
                    self.lblCompartir.alpha = 0
                    self.shareIcon.alpha = 0
                    self.placeHolderText.alpha = 1
                    self.pinHolder.alpha = 0.4
                }
            default:
                print("hola")
                self.placeHolderText.alpha = 0
                self.pinHolder.alpha = 0
                self.mapView.alpha = 1
                self.lblCompartir.alpha = 1
                self.shareIcon.alpha = 1
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.alertLoader.dismiss(animated: true, completion: nil)
                    if self.latitude != nil && self.longitude != nil {
                        print("lat & log are not nil")
                        let localizations = CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude)
                        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                        let region = MKCoordinateRegion(center: localizations, span: span)
                        self.mapView.setRegion(region, animated: true)
                        self.mapView.showsUserLocation = true
                        let location = CLLocation(latitude: self.latitude, longitude: self.longitude)
                        location.placemark { placemark, error in
                            guard let placemark = placemark else {
                                print("Error:", error ?? "nil")
                                return
                            }
                            print(placemark.postalAddressFormatted ?? "")
                            self.addressShare = placemark.postalAddressFormatted ?? "nil"
                            if self.counter == 0 {
                                print("***********Entro el setMenu")
                                self.setupMenuMaps()
                                self.counter += 1
                            }
                            
                        }
                        
                    }else{
                        print("lat & log are nil")
                    }
                }
            }
        } else {
            // Fallback on earlier versions
        }
       
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            self.latitude = location.coordinate.latitude
            self.longitude = location.coordinate.longitude
            print("Entro el delgte")
           
            
        }
    }
}
