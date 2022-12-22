import Foundation
import UIKit
import MapKit
import IQKeyboardManagerSwift

class ChurchRegisterViewController: BaseViewController, ChurchRegisterViewProtocol {
    var presenter: ChurchRegisterPresenterProtocol?
    
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var mapSearchContainer: UIView!
    @IBOutlet weak var addressResultTableView: UITableView!
    @IBOutlet weak var addresTextField: UITextField!
    @IBOutlet weak var goToCurrentLocationButton: UIButton!
    @IBOutlet weak var starButton: UIButton!
    @IBOutlet weak var mapKit: MKMapView!
    
    var locationManager = CLLocationManager()
    var searchCompleter = MKLocalSearchCompleter()
    var peticiones = 0
    let timeToSend: TimeInterval = 0.25
    var timerAlarm: Timer?
    var addressResult: Array<MKLocalSearchCompletion> = Array()
    var subResults: Array<MKMapItem> = Array()
    var selectedPlace: MKMapItem?
    var loadSubresults = false
    let localRadius: CLLocationDegrees = 100_000
    var isForMain = true
    var currentLocationRegionRegion: MKCoordinateRegion?
    var llenado = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.startUpdatingLocation()
        
        if let latitude = locationManager.location?.coordinate.latitude
            ,let longitude = locationManager.location?.coordinate.longitude {
            let span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
            currentLocationRegionRegion = region
            mapKit.setRegion(region, animated: true)
            goToCurrentLocationButton.isHidden = false
        }
        
        initView()
        
        mapKit.showsUserLocation = true
        mapKit.delegate = self
        
        showLoader()
        Church.getMapItemChurches {
            [weak self]
            annotations in
            self?.mapKit.addAnnotations(annotations)
            self?.removeLoader()
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        print("VC ECServices - ChurchRegisterVC")

        setTitle("Localiza tu Iglesia")
        
        Church.getMyChurch() {
            [weak self]
            favourite in
            if favourite == nil {
                self?.starButton.isEnabled = false
            } else {
                self?.starButton.isEnabled = true
            }
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if #available(iOS 13.0, *) {
            return .darkContent
        } else {
            return .lightContent
        }
    }
    
    private func goToChurch(_ church: Church) {
        
    }
    
    private func changeController() {
        
    }
    
    @IBAction func regresar(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func goToCurrentLocation() {
        if let region = currentLocationRegionRegion {
            mapKit.setRegion(region, animated: true)
        }
    }
    
    @IBAction func startButton(_ sender: Any) {
        changeController()
    }
    
    @IBAction func searchAction() {
        addresTextField.becomeFirstResponder()
    }
    
}

extension ChurchRegisterViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let id = (view.annotation as? ChuckMark)?.id {
            showLoader()
            Church.getChurch(id: id) {
                [weak self]
                church in
                self?.removeLoader()
                if let church = church {
                    self?.goToChurch(church)
                }
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "MyPin"
        if annotation is MKUserLocation && llenado {
            self.llenado = false
            return nil
        }
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            annotationView?.image = UIImage(named:"map-item-icon", in: Bundle(for: ChurchRegisterViewController.self), compatibleWith: nil)
        } else {
            annotationView?.annotation = annotation
        }
        
        return annotationView
    }
    
}


extension ChurchRegisterViewController {
    
    @IBAction func changeAddress(_ sender: UITextField) {

        if timerAlarm != nil {
            timerAlarm?.invalidate()
            timerAlarm = nil
        }

        cancelAutoCompletion()

        timerAlarm = Timer.scheduledTimer(withTimeInterval: timeToSend, repeats: false) { (timer) in
            DispatchQueue.main.async(execute: {
                [weak self]
                () -> Void in
                self?.cancelAutoCompletion()
                let text = sender.text ?? ""
                if text == "" {
                    self?.clearTable()
                } else {
                    self?.searchCompleter.queryFragment = text
                }
            })
        }
    }
    
    //MARK: - View controls
    private func initView() {
        
        addressTextField.delegate = self
        searchCompleter.delegate = self
        if #available(iOS 13.0, *) {
            searchCompleter.resultTypes = [.pointOfInterest, .address]
        }
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        addressResultTableView.register(AddressTableViewCell.nib,
                                        forCellReuseIdentifier: AddressTableViewCell.reuseIdentifier)
        addressResultTableView.delegate = self
        addressResultTableView.dataSource = self
        
    }
    
    private func cancelAutoCompletion() {
        if searchCompleter.isSearching {
            searchCompleter.cancel()
        }
    }
    
    private func clearTable() {
        addressResult = Array()
        subResults = Array()
        loadSubresults = false
        addressResultTableView.reloadData()
        addressResultTableView.isHidden = true
    }
    
}

//MARK: - User location delegate
extension ChurchRegisterViewController : CLLocationManagerDelegate {
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

//MARK: - Auto completer delegates
extension ChurchRegisterViewController: MKLocalSearchCompleterDelegate {
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        completer.cancel()
        if addresTextField.isEditing {
            addressResult = completer.results
            loadSubresults = false
            subResults = Array()
            selectedPlace = nil
            addressResultTableView.reloadData()
        }
        peticiones += 1
        print("Número de peticiones: \(peticiones), resultado: \(completer.results), status: \(completer.isSearching)")
    }

    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        print("error: \(error)")
    }
    
}

//MARK: - Text field delegates
extension ChurchRegisterViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == addressTextField {
            addressResultTableView.reloadData()
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == addressTextField {
            addressResultTableView.isHidden = true
        }
    }
}

//MARK: - Table view delegates
extension ChurchRegisterViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = loadSubresults ? subResults.count : addressResult.count
        addressResultTableView.isHidden = count == 0
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AddressTableViewCell.reuseIdentifier, for: indexPath)
        
        if loadSubresults {
            (cell as? AddressTableViewCell)?.fill(with: subResults[indexPath.row])
        } else {
            (cell as? AddressTableViewCell)?.fill(with: addressResult[indexPath.row])
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        cancelAutoCompletion()
        addressTextField.resignFirstResponder()
        
        if loadSubresults {
            selectedPlace = subResults[indexPath.row]
            clearTable()
        } else {
            showLoader()
            let selection = addressResult[indexPath.row]
            let searchRequest = MKLocalSearch.Request(completion: selection)
            if #available(iOS 13.0, *) {
                searchRequest.resultTypes = [.pointOfInterest, .address]
            }
            let search = MKLocalSearch(request: searchRequest)
            search.start {
                [weak self]
                response, error in
                guard let response = response else {
                    print("Error: \(error?.localizedDescription ?? "Unknown error").")
                    return
                }
                
                self?.cancelAutoCompletion()

                if response.mapItems.isEmpty {
                    self?.showMessage("No se pudo obtener la direccion")
                } else if response.mapItems.count == 1 {
                    self?.selectedPlace = response.mapItems.first
                    self?.clearTable()
                    if let coordinates = response.mapItems.first?.placemark.location?.coordinate {
                        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                        let region = MKCoordinateRegion(center: coordinates, span: span)
                        self?.mapKit.setRegion(region, animated: true)
                    }
                } else {
                    self?.addressTextField.becomeFirstResponder()
                    self?.subResults = response.mapItems
                    self?.loadSubresults = true
                    self?.addressResultTableView.reloadData()
                    self?.addressResultTableView.isHidden = true
                }

                self?.removeLoader()
            }
        }
    }
    
}
