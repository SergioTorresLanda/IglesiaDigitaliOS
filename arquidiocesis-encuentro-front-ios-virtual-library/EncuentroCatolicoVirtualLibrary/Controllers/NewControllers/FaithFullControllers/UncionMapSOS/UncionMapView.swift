//
//  UncionMapView.swift
//  EncuentroCatolicoVirtualLibrary
//
//  Created by Pablo Luis Velazquez Zamudio on 20/07/21.
//

import UIKit
import MapKit
import CoreLocation
import Contacts

class UncionMapView: UIViewController, UncionMapViewProtocol {
    var presenter: UncionMapPresenterProtocol?
    
// MARK: GLOBAL VAR -
    var locationManager = CLLocationManager()
    var latitude: CLLocationDegrees!
    var longitude: CLLocationDegrees!
    var sendLat: CLLocationDegrees!
    var sendLong: CLLocationDegrees!
    let alertLoader = UIAlertController(title: "", message: "\n \n \n \n \nCargando...", preferredStyle: .alert)
    
// MARK: @IBOUTLETS -
    @IBOutlet weak var contentNavBar: UIView!
    @IBOutlet weak var customNavBar: UIView!
    @IBOutlet weak var navBarTitle: UILabel!
    @IBOutlet weak var backIcon: UIImageView!
    @IBOutlet weak var mainScroll: UIScrollView!
    @IBOutlet weak var mainContentView: UIView!
    @IBOutlet weak var lblMainTitle: UILabel!
    @IBOutlet weak var cardLocations: UIView!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var nameLineView: UIView!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var addressField: UITextField!
    @IBOutlet weak var addressLineView: UIView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var btnSend: UIButton!
    @IBOutlet weak var constraintTopAddress: NSLayoutConstraint!
    @IBOutlet weak var contraintTopSerach: NSLayoutConstraint!
    @IBOutlet weak var heightCard: NSLayoutConstraint!
    @IBOutlet weak var placeHolderText: UILabel!
    @IBOutlet weak var pinHolder: UIImageView!
    
// MARK: LIFE CYCLE APP -
    override func viewDidLoad() {
        super.viewDidLoad()
        showLoading()
        setupLocation()
        setupUI()
        setupLogicService()
        setupGestures()
        setupDelegates()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("ECVirualLibrary - NewControllers - UncionMapSOS - UncionMapView")

    }
    
// MARK: PRIVATE SETUP FUNCS -
    private func setupUI() {
        cardLocations.layer.cornerRadius = 12
        customNavBar.ShadowNavBar()
        cardLocations.ShadowCard()
        customNavBar.layer.cornerRadius = 20
        btnSend.layer.cornerRadius = 8
    }
    
    func showLoading(){
        let imageView = UIImageView(frame: CGRect(x: 100, y: 15, width: 80, height: 80))//mitad es en 145dp
        imageView.image = UIImage(named: "iconoIglesia3", in: Bundle.local, compatibleWith: nil)
        alertLoader.view.addSubview(imageView)
        self.present(alertLoader, animated: false, completion: nil)
    }
    
    private func setupDelegates() {
        nameField.delegate = self
        addressField.delegate = self
        nameField.returnKeyType = .next
        addressField.returnKeyType = .done
    }
    
    private func setupLogicService() {
        let singleton = Home_SOSPrincipal.singleton
        
        if singleton.globalIndex == 0 {
//            lblMainTitle.text = "Proporciona el nombre y la dirección de tu servicio/funeraria"
            
        }else{
            
            lblAddress.alpha = 1
            addressField.alpha = 1
            addressLineView.alpha = 1
            lblName.alpha = 0
            nameField.alpha = 0
            nameLineView.alpha = 0
//            lblMainTitle.text = "Proporciona la dirección de tu servicio"
            UIView.animate(withDuration: 0.5) {
                self.constraintTopAddress.constant = 13
                self.contraintTopSerach.constant = 29
                self.heightCard.constant = 78
            }
            
        }
        
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
    
    private func setupGestures() {
        let tapBack = UITapGestureRecognizer(target: self, action: #selector(handleTapBack))
        backIcon.addGestureRecognizer(tapBack)
        
        let superTap = UITapGestureRecognizer(target: self, action: #selector(handleTapSuperview))
        self.view.addGestureRecognizer(superTap)
    }
    
    private func searchAddress() {
        let geodecoder = CLGeocoder()
        geodecoder.geocodeAddressString(addressField.text!) { (places: [CLPlacemark]?, error: Error?) in
            if error == nil {
                let place = places?.first
                let anotacion = MKPointAnnotation()
                anotacion.coordinate = (place?.location?.coordinate)!
                anotacion.title = self.addressField.text
                
                let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                let region = MKCoordinateRegion(center: anotacion.coordinate, span: span)
                self.mapView.setRegion(region, animated: true)
                self.mapView.addAnnotation(anotacion)
                self.mapView.selectAnnotation(anotacion, animated: true)
                self.sendLat = place?.location?.coordinate.latitude
                self.sendLong = place?.location?.coordinate.longitude
            }else{
                print("Error al encontrar dirección")
            }
        }
    }
    
// MARK: @OBJC FUNCS -
    @objc func handleTapBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func handleTapSuperview() {
        self.view.endEditing(true)
    }
    
// MARK: @IBACTIONS -
    @IBAction func sendActions(_ sender: Any) {
        self.view.endEditing(true)
        searchAddress()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let singleton = Home_SOSPrincipal.singleton
            switch singleton.globalIndex {
            case 0:
                
                if self.nameField.text != "" && self.addressField.text != "" {
                    singleton.direction = self.addressField.text  ?? ""
                    if self.sendLat != nil && self.sendLong != nil {
                        let  module = UncionSOSRouter.createModule(globalLatitude: "\(self.sendLat!)", globalLongitude: "\(self.sendLong!)")
                        self.navigationController?.pushViewController(module, animated: true)
                    }
                    
                }else{
                    let alert = AcceptAlert.showAlert(titulo: "Aviso", mensaje: "Faltan campos por llenar")
                    alert.view.backgroundColor = .clear
                    self.present(alert, animated: true)
                }
                
            case 1:
                
                if self.addressField.text != "" {
                    singleton.direction = self.addressField.text ?? "nil"
                    if self.sendLat != nil && self.sendLong != nil {
                        let  module = UncionSOSRouter.createModule(globalLatitude: "\(self.sendLat!)", globalLongitude: "\(self.sendLong!)")
                        self.navigationController?.pushViewController(module, animated: true)
                    }
                    
                }else{
                    let alert = AcceptAlert.showAlert(titulo: "Aviso", mensaje: "Faltan campos por llenar")
                    alert.view.backgroundColor = .clear
                    self.present(alert, animated: true)
                }
                
            default:
                print("deafult")
            }
        }
               
    }
    
}

extension UncionMapView: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        if #available(iOS 14.0, *) {
            switch manager.authorizationStatus {
            case .denied:
                print("nel")
                alertLoader.dismiss(animated: true, completion: nil)
                UIView.animate(withDuration: 0.3) {
                    self.mapView.alpha = 0
                    self.placeHolderText.alpha = 1
                    self.pinHolder.alpha = 0.4
                }
            default:
                print("hola")
                self.placeHolderText.alpha = 0
                self.pinHolder.alpha = 0
                self.mapView.alpha = 1
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
                        //self.latitude, self.longitude
                        location.placemark { placemark, error in
                            guard let placemark = placemark else {
                                print("Error:", error ?? "nil")
                                return
                            }
                            self.addressField.text = placemark.postalAddressFormatted ?? "Unspecified"
                            print(placemark.postalAddressFormatted ?? "")
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
            self.sendLat = location.coordinate.latitude
            self.sendLong = location.coordinate.longitude

        }
    }
}

extension UncionMapView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameField {
            addressField.becomeFirstResponder()
        }else{
            searchAddress()
            self.view.endEditing(true)
        }
        
        return true
        
    }
    
}
