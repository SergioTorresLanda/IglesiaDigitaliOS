//
//  CrearComedor_Mapa.swift
//  EncuentroCatolicoHome
//
//  Created by Sergio Torres Landa González on 09/03/23.
//

import Foundation
import UIKit
import MapKit
import CoreLocation
import FirebaseFirestore
import EncuentroCatolicoVirtualLibrary

class CrearComedor_Mapa: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var adressLabel: UILabel!
    @IBOutlet weak var btnEnviar: UIButton!
    @IBOutlet weak var locationImg: UIImageView!
 
    //let db = Firestore.firestore()
    let ds = DispatchGroup()
    let sm = DispatchSemaphore(value: 0)
    var mapaTipo:String = ""
    let locationManager = CLLocationManager()
    let regionInMeters:Double = 500
    var adress:String="noAdressYet"
    var latitudeG:Double?
    var longitudeG:Double?
    let defaults=UserDefaults.standard
    var alertFields : AcceptAlert?
    var alcaldia:String=""
    let mapaIdZonas = ["Álvaro Obregón":10, "Azcapotzalco":2, "Benito Juárez":14, "Coyoacán":3, "Cuajimalpa de Morelos":4, "Cuauhtémoc":15, "Gustavo A. Madero":5, "Iztacalco":6, "Iztapalapa":7, "La Magdalena Contreras":8, "Miguel Hidalgo":16, "Milpa Alta":9, "Tláhuac":11, "Tlalpan":12, "Venustiano Carranza":17, "Xochimilco":13]
    var idZona=0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("mapa did load")
        let t1 = UITapGestureRecognizer(target: self, action: #selector(CrearComedor_Mapa.LocationClick))
        locationImg.isUserInteractionEnabled = true
        locationImg.addGestureRecognizer(t1)
        self.mapView.delegate = self
        /*if #available(iOS 11.0, *) {
            mapView.register(myAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        }*/
        checkLocationServices()
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    @IBAction func enviarClick(_ sender: Any) {
        //db.collection("deliverys").document(deliveryId!).updateData(["direccion": adress,"lat":latitudeG!,"long":longitudeG!])
        print("continua")
        defaults.set(adress, forKey: "lastAdress")
        defaults.set(latitudeG, forKey: "latitude")
        defaults.set(longitudeG, forKey: "longitude")
        defaults.set(idZona,forKey: "idZona")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
           print("accion")
            self.navigationController?.popViewController(animated: true)
        })
    }
    
    func openSomeUrl(s:String){
        guard let url = URL(string: s) else {return}
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
    @objc func LocationClick(sender:UITapGestureRecognizer) {
        print("click location")
        centerViewOnUserLocation()
    }
    
    override func viewDidLayoutSubviews() {
        btnEnviar.layer.cornerRadius = 25
    //    btnEnviar.layer.borderWidth = 2
    }
    
    func checkLocationServices(){
        if CLLocationManager.locationServicesEnabled(){
            setupLocationManager()
            checkLocationAuthorization()
        }else{
            showCanonAlert(title: "Atención", msg: "Habilita tus servicios de geolocalización.")
            //showToast(message: "Habilita tu ubicación", font: .systemFont(ofSize: 12.0))
        }
    }
    
    func setupLocationManager(){
        locationManager.delegate=self
        locationManager.desiredAccuracy=kCLLocationAccuracyBest
    }
    
    func checkLocationAuthorization(){
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            mapView.showsUserLocation=true
            centerViewOnUserLocation()
            //centerViewOnCDMX()
            //locationManager.startUpdatingLocation()
            break
        case .denied:
            showCanonAlert(title: "Atención", msg: "Habilita tus servicios de geolocalización.")
            //showToast(message: "Habilita tu ubicación", font: .systemFont(ofSize: 12.0))
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            showCanonAlert(title: "Atención", msg: "Habilita los permisos de ubicación de la app.")
            //showToast(message: "Habilita los permisos de ubicación", font: .systemFont(ofSize: 12.0))
            break
        case .authorizedAlways:
            break
        default:
            print("no pasa")
        }
    }
    
    func centerViewOnUserLocation(){
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            mapView.setRegion(region, animated: true)
            
            getAddressFromLatLon(lat: location.latitude, lon: location.longitude)
        }
    }
    
    func getAddressFromLatLon(lat: Double, lon: Double) {
        latitudeG=lat
        longitudeG=lon
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
        let ceo: CLGeocoder = CLGeocoder()
        center.latitude = lat
        center.longitude = lon
        
        let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
        
        ceo.reverseGeocodeLocation(loc, completionHandler:
                                    { [self](placemarks, error) in
                if (error != nil)
                {
                    print("reverse geodcode fail: \(error!.localizedDescription)")
                }
            guard let pm = placemarks else {
                //let latSub = String(self.latitude.prefix(7))
                //let longSub = String(self.longitude.prefix(8))
               self.adressLabel.text = "No pudimos obtener tu dirección. Habilita los servicios de ubicación o haz click en el botón ayuda para enviarnos tu ubicación por Whatsapp"
                return
           }
            if pm.count > 0 {
                let pm = placemarks![0]
                var addressString : String = ""
                if pm.thoroughfare != nil {
                    addressString = addressString + pm.thoroughfare! + ", "
                }
                if pm.subThoroughfare != nil {
                    addressString = addressString + pm.subThoroughfare! + ", "
                }
                if pm.locality != nil {
                    addressString = addressString + pm.locality! + ", "
                    print("la alcaldia es:")
                    print(pm.locality!)
                    alcaldia=pm.locality!
                }
                if pm.subLocality != nil {
                    addressString = addressString + pm.subLocality! + ", "
                }
                if pm.postalCode != nil {
                    addressString = addressString + pm.postalCode! + " "
                }
                self.adressLabel.text = " \(addressString)"
                self.adress=addressString
                
                idZona = mapaIdZonas[alcaldia] ?? 0
                print("LA idZONA es:;")
                print(idZona)
                /*if let cd = pm.administrativeArea {
                    print("La ubicación se encuentra en la ciudad de \(cd)")//CDMX
                } else {
                    print("No se pudo determinar la ciudad de la ubicación")
                }*/
            }
        })
    }
    
    func showCanonAlert(title:String, msg:String){
        alertFields = AcceptAlert.showAlert(titulo: title, mensaje: msg)
        alertFields!.view.backgroundColor = .clear
        self.present(alertFields!, animated: true)
    }
    
    func centerViewOnCDMX(){
        let loc = CLLocationCoordinate2D(latitude:19.3228313, longitude:-99.2040869)
            let region = MKCoordinateRegion.init(center: loc, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            mapView.setRegion(region, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
}

///////EXTENSION///////EXTENSION///////EXTENSION///////EXTENSION///////EXTENSION//////

extension CrearComedor_Mapa: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.last else {return}
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion.init(center: center, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
        mapView.setRegion(region, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
}

extension CrearComedor_Mapa:MKMapViewDelegate{
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let center = mapView.centerCoordinate
        let lat = center.latitude
        let long = center.longitude
        getAddressFromLatLon(lat: lat, lon: long)
       }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        if control == view.rightCalloutAccessoryView{
            if mapaTipo == "" {
            }else{
            }
        }
    }
}
