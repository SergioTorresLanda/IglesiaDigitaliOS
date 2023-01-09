import Foundation
import UIKit
import MapKit
import AlamofireImage
import EncuentroCatolicoVirtualLibrary
//import DropDown

class ProfileMapViewController: BaseViewController, ProfileMapViewProtocol, UtilsDetailsChurchButtonDelegate {
    
    var isPrincipal: Int?
    var presenter: ProfileMapPresenterProtocol?
    weak var delegate: UtilsDetailsChurchButtonDelegate?
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var mapSearchContainer: UIView!
    @IBOutlet weak var addressResultTableView: UITableView!
    @IBOutlet weak var addresTextField: UITextField!
    @IBOutlet weak var goToCurrentLocationButton: UIButton!
    @IBOutlet weak var starButton: UIButton!
    @IBOutlet weak var mapKit: MKMapView!
    @IBOutlet weak var btnNoCommunity: UIButton!
    @IBOutlet weak var navImg: UIImageView!
    @IBOutlet weak var lblNavTitle: UILabel!
    @IBOutlet weak var btnBack: UIButton!
    
    static let singleton = ProfileMapViewController()
    var locationsData: [LocationResponse] = []
    var fillLocationData = [LocationResponse]()
    var idChurch: Int?
    var wireFrame: ProfileMapWireFrameProtocol?
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
    var selecrtedChurch = selectMap()
    var nameChurch = ""
    var idChurchFinal: Int = 0
    var urlImgChurch = ""
    var mapType = ""
    let transition = SlideTransition()
    var isFormNotCommunity = false
    struct selectMap {
        var id: Int?
        var name: String?
        var url: String?
    }
    weak var annotation: MKAnnotation?
    var annotationsG : [UInt:Int] = [:]
    /*if staged == "Qa" {
        API = "https://api.qa-iglesia-digital.com/arquidiocesis/encuentro/v1"
    }else if staged == "Prod" {
        API = "https://api.iglesia-digital.com.mx/arquidiocesis/encuentro/v1"*/
    // /locations?type_location=CHURCH  (IGLESIAS)
    // /locations  (comunidades + iglesias)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //validateTypeView(type: mapType)
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
        
        initView()
        showLoader()
        /*Church.getMapItemChurches {
            [weak self]
            annotations in
            self?.mapKit.addAnnotations(annotations)
            self?.setCurrentLocationMap()
            self?.removeLoader()
        }*/
        //let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyBoard))
        //view.addGestureRecognizer(tap)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("VC ECProfile - ProfileMapView ")
        validateTypeView(type: mapType)
        lookFor()
        //presenter?.getLocations()
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
    
    private func validateTypeView(type: String) {
        switch type {
        case "Religioso", "Laico":
            print("Validate LAICO")
            btnNoCommunity.isHidden = true
            btnNoCommunity.setTitle("No encuentro mi iglesia", for: .normal)
            lblNavTitle.text="Localiza tu iglesia"
            Church.getMapItemChurches {
                [weak self]
                annotations in
                self?.mapKit.addAnnotations(annotations)
                self?.setCurrentLocationMap()
                self?.removeLoader()
            }
        case "LaicoCom":
            print("Validate LAICOCOM")
            btnNoCommunity.isHidden = true
            btnNoCommunity.setTitle("No encuentro mi comunidad", for: .normal)
            lblNavTitle.text="Localiza tu comunidad"
            Church.getMapItemComs {
                [weak self]
                annotations in
                self?.mapKit.addAnnotations(annotations)
                self?.setCurrentLocationMap()
                self?.removeLoader()
            }
        case "Donations":
            print("Validate DONS")
            btnNoCommunity.isHidden = true
            lblNavTitle.text = "Mi ofrenda"
            self.view.backgroundColor = UIColor.init(red: 25/255, green: 42/255, blue: 115/255, alpha: 1)
            Church.getMapItemChurches {
                [weak self]
                annotations in
                self?.mapKit.addAnnotations(annotations)
                self?.setCurrentLocationMap()
                self?.removeLoader()
            }
        default:
            print("Validate "+mapType)
            btnNoCommunity.isHidden = true
        }
    }
    
    private func lookFor() {
        switch mapType {
        case "Religioso", "Laico":
            print("LOOKFOR LAIcO")
            presenter?.getLocations()
        case "LaicoCom":
            print("LOOKFOR LAICOCOM")
            presenter?.getLocationsCom()
        case "Donations":
            presenter?.getLocations()
            print("LOOKFOR DONS")
        default:
            presenter?.getLocations()
            print("LOOKFOR " + mapType)
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
        if isPrincipal == 4 {
            navigationController?.popViewController(animated: true)
        }else {
            let singleton = ProfileMapViewController()
            singleton.nameChurch = "Unspecified"
            self.dismiss(animated: false, completion: nil)
        }
    }
    
    @IBAction func goToCurrentLocation() {
        print("Here do dismis with data")
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
    
    @IBAction func noCommunityAction(_ sender: Any) {
       let alert = AcceptAlert.showAlert(titulo: "", mensaje: "Por lo visto tu comunidad no está en nuestra base de datos. En cuanto guardes tu perfil, te aparecerá un formulario donde podrás registrar tu comunidad.")
        alert.transitioningDelegate = self
        self.present(alert, animated: false, completion: nil)
    }
    
//    func showLocation(location: Array<LocationResponse>) {
//        locationsData = location
//    }
    
    func showLocation(location: [LocationResponse]) {
        locationsData = location
        fillLocationData = location
    }
    
    func showError(error: String) {
    }
    
    @objc func calloutTapped(sender:UITapGestureRecognizer) {
        
    }
    
    @objc private func hideKeyBoard() {
        view.endEditing(true)
    }
    
    func didPressUtilsDetalButton(_ tag: Int) {
        if isPrincipal == 4 {
            let locationId: [String: Int] = ["locationId": idChurchFinal]
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "getMapData"), object: nil, userInfo: locationId)
            navigationController?.popViewController(animated: true)
            NotificationCenter.default.removeObserver(self, name: Notification.Name(rawValue: "getMapData"), object: nil)
        }else {
            presenter?.dismissMapModule(id: 0, name: "", url: "", from: self)
        }
    }
 }

extension ProfileMapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        if view.isKind(of: AnnotationView.self)
        {
            for subview in view.subviews {
                subview.removeFromSuperview()
            }
        }
    }
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if view.annotation is MKUserLocation {return}
        let annotationView = view.annotation as? ChuckMark
        let views = Bundle.loadView(fromNib: "ChurchCustomeAnotation", withType: ChurchCustomeAnotation.self)
        views.churchLabel.text = annotationView?.title
        views.churchLabel.sizeToFit()
        let imageURL = annotationView?.image_url
        if imageURL == "" {
            views.churchImage.image = UIImage(named:"church-placeholder", in: Bundle(for: ProfileMapViewController.self), compatibleWith: nil)
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
        if ((view.annotation as? ChuckMark)?.id) != nil {
            // showLoader()
            let idChurchAnn = annotationView?.id ?? 1
            idChurchFinal = Int(idChurchAnn)
            let nameChurch = annotationView?.title
            let urlChourch = annotationView?.image_url
            let select = selectMap(id: Int(idChurchAnn), name: nameChurch, url: urlChourch)
            print("::SELECT::")
            print(select)
            let singleton = ProfileMapViewController.singleton
            singleton.nameChurch = annotationView?.title ?? "Unspecified"
            singleton.idChurch = Int(idChurchAnn)
            singleton.urlImgChurch = annotationView?.image_url ?? "Unspecified"
            UserDefaults.standard.set(annotationView?.title ?? "", forKey: "nameChurchDon")
            UserDefaults.standard.set(annotationView?.image_url ?? "", forKey: "imgChurchDon")
            UserDefaults.standard.set(annotationView?.id, forKey: "idChurchDon")
        }
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
            annotationView?.image = UIImage(named:"map-item-icon", in: Bundle(for: ProfileMapViewController.self), compatibleWith: nil)
        } else {
            annotationView?.annotation = annotation
        }
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        print("mapView(_:annotationView:calloutAccessoryControlTapped)")
    }
}


extension ProfileMapViewController {
    
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
extension ProfileMapViewController : CLLocationManagerDelegate {
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
extension ProfileMapViewController: MKLocalSearchCompleterDelegate {
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        completer.cancel()
//        if addresTextField.isEditing {
//            addressResult = completer.results
//            loadSubresults = false
//            subResults = Array()
//            selectedPlace = nil
//            addressResultTableView.reloadData()
//        }
//        peticiones += 1
//        print("Número de peticiones: \(peticiones), resultado: \(completer.results), status: \(completer.isSearching)")
        if addresTextField.isEditing {
            locationsData = fillLocationData
            locationsData = locationsData.filter { data in
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
    }
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        print("error: \(error)")
    }
    
}

//MARK: - Text field delegates
extension ProfileMapViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == addressTextField {
            addressResultTableView.reloadData()
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == addressTextField {
            if addressTextField.text == "" {
                addressResultTableView.isHidden = true
            }else {
                addressResultTableView.isHidden = false
            }
        }
    }
}

//MARK: - Table view delegates
extension ProfileMapViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = locationsData.count
        addressResultTableView.isHidden = count == 0
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AddressTableViewCell.reuseIdentifier, for: indexPath) as! AddressTableViewCell
        
        if locationsData[indexPath.row].name != nil {
            cell.titleLabel.text =  locationsData[indexPath.row].name
            cell.subtitleLabel.text =  locationsData[indexPath.row].address
        } else {
            cell.subtitleLabel.text =  locationsData[indexPath.row].name
            cell.titleLabel.text =  locationsData[indexPath.row].address
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        cancelAutoCompletion()
        addressTextField.resignFirstResponder()
        addressResultTableView.isHidden = true
        //Ir al lugar
        let dortmundLocation = CLLocation(latitude: locationsData[indexPath.row].latitude ?? 0.0, longitude: locationsData[indexPath.row].longitude ?? 0.0)
        let dortmunRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: dortmundLocation.coordinate.latitude, longitude: dortmundLocation.coordinate.longitude), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        self.mapKit.setRegion(dortmunRegion, animated: true)
        //Liberar tarjeta.
      
        let idChurchAnn = locationsData[indexPath.row].id ?? 1
        let nameX = locationsData[indexPath.row].name ?? "No Name"

        print(":::::::: ID::  " + String(idChurchAnn) + ":::::::::::::")
        let indexGod = fillLocationData.firstIndex(where: {$0.id == idChurchAnn}) ?? 1
        print(":::::::: INDEX GOD::  " + String(indexGod) + ":::::::::::::")
        print("::::::::  FILL LOC COUNT ::  " + String(fillLocationData.count) + ":::::::::::::")
        print("::::::::  ANNOTATIONS COUNT ::  " + String(mapKit.annotations.count) + ":::::::::::::")

        self.mapKit.selectAnnotation(mapKit.annotations.first(where: {$0.title == nameX})!, animated: true)
        //self.mapKit.selectAnnotation(mapKit.annotations.first(where: {$0. == nameX})!, animated: true)

    }
}

extension ProfileMapViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        transition.isPresenting = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.dismiss(animated: false, completion: nil)
        }
            
        return transition
        
    }
    
}

