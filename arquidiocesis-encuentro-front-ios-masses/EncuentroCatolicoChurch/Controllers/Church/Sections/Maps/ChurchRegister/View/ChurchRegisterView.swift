import Foundation
import UIKit
import MapKit
import AlamofireImage


class MiIglesia_MapaIglesias: BaseViewController, ChurchRegisterViewProtocol, UtilsDetailsChurchButtonDelegate {
    
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var mapSearchContainer: UIView!
    @IBOutlet weak var addressResultTableView: UITableView!
    @IBOutlet weak var addresTextField: UITextField!
    @IBOutlet weak var goToCurrentLocationButton: UIButton!
    @IBOutlet weak var starButton: UIButton!
    @IBOutlet weak var mapKit: MKMapView!
    
    var isPrincipal: Int?
    var isPrincpalBool: Bool?
    var presenter: ChurchRegisterPresenterProtocol?
    weak var delegate: UtilsDetailsChurchButtonDelegate?
    var wireFrame: ChurchRegisterWireFrameProtocol?
    var locationManager = CLLocationManager()
    var searchCompleter = MKLocalSearchCompleter()
    var peticiones = 0
    let timeToSend: TimeInterval = 0.25
    let regionRadius: Double = 100
    var timerAlarm: Timer?
    var addressResult: Array<MKLocalSearchCompletion> = Array()
    var subResults: Array<MKMapItem> = Array()
    var selectedPlace: MKMapItem?
    var loadSubresults = false
    let localRadius: CLLocationDegrees = 100_000
    var isForMain = true
    var currentLocationRegionRegion: MKCoordinateRegion?
    var llenado = true
    var churchSelectId = selectMap()
    var churchDetail: Int = 0
    struct selectMap {
        var id: UInt?
        var name: String?
        var url: String?
    }
    var communityDetail: CommunityLocationList?
    var fillCommunityDetail: CommunityLocationList?
    var churchDetailLocation: [LocationResponse]?
    var fillChurchDetailLocation: [LocationResponse]?
    weak var annotation: MKAnnotation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: true)
        //        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.startUpdatingLocation()
        mapKit.delegate = self
        if let latitude = locationManager.location?.coordinate.latitude
           ,let longitude = locationManager.location?.coordinate.longitude {
            let span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: span)
            currentLocationRegionRegion = region
            mapKit.setRegion(region, animated: true)
            mapKit.showsUserLocation = true
            setCurrentLocationMap()
        }
        if isPrincipal == 3 {
            if let latitude = locationManager.location?.coordinate.latitude
               ,let longitude = locationManager.location?.coordinate.longitude {
                presenter?.getCommunityDetailMap(lat: latitude, lon: longitude)
            }
        }else {
            presenter?.getLocations()
            initView()
            showLoader()
            Church.getMapItemChurches {
                [weak self]
                annotations in
                self?.mapKit.addAnnotations(annotations)
                self?.setCurrentLocationMap()
                self?.removeLoader()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("VC ECChurch - Maps - ChurchRegisterView ")
        setTitle("Localiza tu Iglesia")
        addressResultTableView.isHidden = true
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
    
    private func goToChurch(_ church: LocationResponse) {
        
    }
    
    private func changeController() {
        
    }
    
    private func setCurrentLocationMap() {
        if let region = currentLocationRegionRegion {
            mapKit.setRegion(region, animated: true)
        }
    }
    
    @IBAction func regresar(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
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
    
    func showLocation(location: Array<LocationResponse>) {
        churchDetailLocation = location
        fillChurchDetailLocation = location
    }
    
    func showError(error: String) {
    }
    
    @objc func calloutTapped(sender:UITapGestureRecognizer) {
        
    }
    func didPressUtilsDetalButton(_ tag: Int) {
        if isPrincipal == 3 {
           // self.dismiss(animated: true, completion: nil)
            self.presenter?.goToCommunityDetail(id: churchDetail, myChourch: false, isPricipalBool: isPrincpalBool ?? false)
        }else {
            self.presenter?.goToChurchDetailMap(id: churchDetail, selector: isPrincipal ?? 1)
        }
    }
    func communityLocationSuccess(response: CommunityLocationList) {
        self.communityDetail = response
        self.fillCommunityDetail = response
        DispatchQueue.main.async { [self] in
            if response.isEmpty {
                let alert = UIAlertController(title: "", message: "No hay comunidades cernaca a tu ubicaión", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertAction.Style.default, handler: nil))
                present(alert, animated: true, completion: nil)
            }else {
                initView()
                showLoader()
                getMapItemCommunities() {
                    [weak self]
                    annotations in
                    self?.mapKit.addAnnotations(annotations)
                    self?.setCurrentLocationMap()
                    self?.removeLoader()
                }
            }
        }
    }
    func communityLocationError(msg: String) {
        DispatchQueue.main.async { [self] in
            removeLoader()
        }
    }
    
    func getMapItemCommunities(completion: @escaping (Array<ChuckMark>) -> Void) {
        guard let communities = communityDetail else {return}
        for communities in communities {
            let markItems = [ChuckMark(title: communities.name,
                                       coordinate: CLLocationCoordinate2D(latitude: communities.latitude ?? 0.0,
                                                                          longitude: communities.longitude ?? 0.0), id: UInt(communities.id ?? 1), url: communities.imgURL, subtitle: String(communities.id ?? 0))]
            completion(markItems)
        }
    }
}

extension MiIglesia_MapaIglesias: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        if view.isKind(of: AnnotationView.self)
        {
            for subview in view.subviews {
                subview.removeFromSuperview()
            }
        }
    }
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if view.annotation is MKUserLocation {
            return
        }
            let annotationView = view.annotation as? ChuckMark
            let views = Bundle.loadView(fromNib: "ChurchCustomeAnotation", withType: ChurchCustomeAnotation.self)
            views.churchLabel.text = annotationView?.title
            views.churchLabel.sizeToFit()
            let imageURL = annotationView?.image_url
            if imageURL == "" {
                views.churchImage.image = UIImage(named:"church-placeholder", in: Bundle(for: MiIglesia_MapaIglesias.self), compatibleWith: nil)
            }else{
                if let imageUrl = URL(string: imageURL ?? "") {
                    views.churchImage.af.setImage(withURL: imageUrl)
                }
            }
            views.churchButton.setTitle("", for: .normal)
            views.delegate = self
            views.churchButton.tag = churchDetail
            views.addSubview(views.churchButton)
            views.center = CGPoint(x: view.bounds.size.width / 2, y: -views.bounds.size.height*0.52)
            view.addSubview(views)
            mapView.setCenter((view.annotation?.coordinate)!, animated: true)
            //if let id = (view.annotation as? ChuckMark)?.id {
                //showLoader()
                let idChurch = annotationView?.id
                let nameChurch = annotationView?.title
                let urlChourch = annotationView?.image_url
                let select = selectMap(id: idChurch, name: nameChurch, url: urlChourch)
                print(select)
                self.churchDetail = Int(idChurch ?? 0)
//                Church.getChurch(id: id) { [weak self] church in
//                    self?.removeLoader()
//                    if let church = church {
//                        self?.goToChurch(church)
//                    }
//                }
           // }
        
    }
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "MapPointerCollectionViewCell"
        if annotation is MKUserLocation && llenado {
            self.llenado = false
            return nil
        }
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        if annotationView == nil {
            annotationView = AnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = false
            annotationView?.image = UIImage(named:"map-item-icon", in: Bundle(for: MiIglesia_MapaIglesias.self), compatibleWith: nil)
        } else {
            annotationView?.annotation = annotation
        }
        return annotationView
    }
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        print("mapView(_:annotationView:calloutAccessoryControlTapped)")
    }
}


extension MiIglesia_MapaIglesias {
    
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
extension MiIglesia_MapaIglesias : CLLocationManagerDelegate {
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
extension MiIglesia_MapaIglesias: MKLocalSearchCompleterDelegate {
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        completer.cancel()
        if isPrincipal == 3 {
            communityDetail = fillCommunityDetail
            communityDetail = communityDetail?.filter { data in
                var result: Bool {
                    let addresText = addresTextField.text ?? ""
                    let name = data.name?.forSorting
                    print(name!, addresText.forSorting)
                    if name!.contains(addresText.forSorting){
                        return name!.contains(addresText.forSorting)
                    }else {
                        let dataAddress = data.address?.forSorting
                        return dataAddress!.contains(addresTextField.text ?? "")
                    }
                }
                return  result
             }
            addressResultTableView.reloadData()
        }else {
            churchDetailLocation = fillChurchDetailLocation
            churchDetailLocation = churchDetailLocation?.filter { data in
                let addresText = addresTextField.text
                let name = data.name!
                print(name.forSorting, addresText?.forSorting)
                var result: Bool {
                    let addresText = addresTextField.text ?? ""
                    let name = data.name?.forSorting
                    print(name!, addresText.forSorting)
                    if name!.contains(addresText.forSorting){
                        return name!.contains(addresText.forSorting)
                    }else {
                        let dataAddress = data.address?.forSorting
                        return dataAddress!.contains(addresTextField.text ?? "")
                    }
                }
                return  result
             }
            addressResultTableView.reloadData()
        }
//        if addresTextField.isEditing {
//            addressResult = completer.results
//            loadSubresults = false
//            subResults = Array()
//            selectedPlace = nil
//            addressResultTableView.reloadData()
//        }
//        peticiones += 1
        //        print("Número de peticiones: \(peticiones), resultado: \(completer.results), status: \(completer.isSearching)")
    }
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        print("error: \(error)")
    }
    
}

//MARK: - Text field delegates
extension MiIglesia_MapaIglesias: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == addressTextField {
            addressResultTableView.reloadData()
            addressResultTableView.alpha = 1
            addressResultTableView.isHidden = false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == addressTextField {
            addressResultTableView.alpha = 0
            addressResultTableView.isHidden = true
           
        }
    }
}

//MARK: - Table view delegates
extension MiIglesia_MapaIglesias: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count: Int {
            if isPrincipal == 3 {
                let datacount  = communityDetail?.count
                addressResultTableView.isHidden = datacount == 0
                return datacount ?? 0
            }else {
                let datacount  = churchDetailLocation?.count
                addressResultTableView.isHidden = datacount == 0
                return datacount ?? 0
            }
        }
//        let count = loadSubresults ? subResults.count : addressResult.count
//        addressResultTableView.isHidden = count == 0
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AddressTableViewCell.reuseIdentifier, for: indexPath) as! AddressTableViewCell
        
        if isPrincipal == 3 {
            cell.titleLabel.text = communityDetail?[indexPath.row].name
            cell.subtitleLabel.text = communityDetail?[indexPath.row].address
        }else {
            cell.titleLabel.text = churchDetailLocation?[indexPath.row].name
            cell.subtitleLabel.text = churchDetailLocation?[indexPath.row].address
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        cancelAutoCompletion()
        addressTextField.resignFirstResponder()
        addressResultTableView.isHidden = true
        if isPrincipal == 3 {
            let dortmundLocation = CLLocation(latitude: communityDetail?[indexPath.row].latitude ?? 0.0, longitude: communityDetail?[indexPath.row].longitude ?? 0.0)
            let dortmunRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: dortmundLocation.coordinate.latitude, longitude: dortmundLocation.coordinate.longitude), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            self.mapKit.setRegion(dortmunRegion, animated: true)
        }else {
            let dortmundLocation = CLLocation(latitude: churchDetailLocation?[indexPath.row].latitude ?? 0.0, longitude: churchDetailLocation?[indexPath.row].longitude ?? 0.0)
            let dortmunRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: dortmundLocation.coordinate.latitude, longitude: dortmundLocation.coordinate.longitude), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            self.mapKit.setRegion(dortmunRegion, animated: true)
        }
//        if loadSubresults {
//            selectedPlace = subResults[indexPath.row]
//            clearTable()
//        } else {
//            showLoader()
//            let selection = addressResult[indexPath.row]
//            let searchRequest = MKLocalSearch.Request(completion: selection)
//            if #available(iOS 13.0, *) {
//                searchRequest.resultTypes = [.pointOfInterest, .address]
//            }
//            let search = MKLocalSearch(request: searchRequest)
//            search.start {
//                [weak self]
//                response, error in
//                guard let response = response else {
//                    print("Error: \(error?.localizedDescription ?? "Unknown error").")
//                    return
//                }
//
//                self?.cancelAutoCompletion()
//
//                if response.mapItems.isEmpty {
//                    self?.showMessage("No se pudo obtener la direccion")
//                } else if response.mapItems.count == 1 {
//                    self?.selectedPlace = response.mapItems.first
//                    self?.clearTable()
//                    if let coordinates = response.mapItems.first?.placemark.location?.coordinate {
//                        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
//                        let region = MKCoordinateRegion(center: coordinates, span: span)
//                        self?.mapKit.setRegion(region, animated: true)
//                    }
//                } else {
//                    self?.addressTextField.becomeFirstResponder()
//                    self?.subResults = response.mapItems
//                    self?.loadSubresults = true
//                    self?.addressResultTableView.reloadData()
//                    self?.addressResultTableView.isHidden = true
//                }
//
//                self?.removeLoader()
//            }
//        }
    }
    
}

extension String {
    var forSorting: String {
        let simple = folding(options: [.diacriticInsensitive, .widthInsensitive, .caseInsensitive], locale: nil)
        let nonAlphaNumeric = CharacterSet.alphanumerics.inverted
        return simple.components(separatedBy: nonAlphaNumeric).joined(separator: "")
    }
}

