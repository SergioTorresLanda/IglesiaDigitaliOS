//
//  UncionSOSView.swift
//  EncuentroCatolicoVirtualLibrary
//
//  Created by Pablo Luis Velazquez Zamudio on 16/06/21.
//

import UIKit
import MapKit
import CoreLocation

class UncionSOSView: UIViewController, UncionViewProtocol, CollectionCellDelegate, PushViewControllerDelegate, CollectionCellDelegate2 {
    
    func selectedItem2() {
        print("Tap en el nuevo collection")
    }
    
    func pushViewController(vc: UIViewController) {
        print("Vas")
       
    }
    
    var locationManager = CLLocationManager()
    var latitude: CLLocationDegrees!
    var longitude: CLLocationDegrees!
    
    var storedOffsets = [Int: CGFloat]()
    var contactNames: [String] = []
    var churchNames: [String] = []
    var churchDistances: [String] = []
    var churchPhones: [String] = []
    var churchURLImages: [String] = []
    var churchListed: [ListChurches] = []
    var church: ListChurches?
    var isFisrtLoad = true
    let transition = SlideTransition()

    static let singleton = UncionSOSView()
    var presenter: UncionPresenterProtocol?
    var isPresenting = false
    let alert = AcceptAlert.showAlert(titulo: "Servicio en proceso", mensaje: "Se está atendiendo tu solicitud, favor de esperar la llamada en un rango máximo de una hora")
    let errorAlert = AcceptAlert.showAlert(titulo: "Aviso", mensaje: "No encontramos ninguna iglesia cerca de ti")
    let alertLoader = UIAlertController(title: "", message: "\n \n \n \n \nCargando...", preferredStyle: .alert)
    let defaults = UserDefaults.standard
    var isEmptychurch = false
    
// MARK: SEND VAR DATA -
    var contactID = 0
    var newServiceID = 0
    var globalLatitude = ""
    var globalLongitude = ""
    
// MARK: @IBOUTLETS -
    @IBOutlet weak var contentNavBar: UIView!
    @IBOutlet weak var customNavBar: UIView!
    @IBOutlet weak var navBarTitle: UILabel!
    @IBOutlet weak var backNavBar: UIImageView!
    @IBOutlet weak var lblMainTitle: UILabel!
    @IBOutlet weak var lblMainSubtitle: UILabel!
    @IBOutlet weak var mainCollectionV: UICollectionView!
    @IBOutlet weak var mainTableV: UITableView!
    @IBOutlet weak var placeHolderText: UILabel!
    @IBOutlet weak var pinHolder: UIImageView!
    @IBOutlet weak var newMainTable: UITableView!
    
// MARK: LIFE CYCLE APP -
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewALert()
        print("There are lat and long", globalLatitude, globalLongitude)
        self.presenter?.getRequestChurchesList(lat: globalLatitude ,long: globalLongitude) //getRequestChurchesList(lat: "19.500557", long: "-99.095101")
        setupLocation()
        setupUI()
        //19.296850 , -99.185379
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("ECVirualLibrary - NewControllers - UncionSOS - UncionSOS")

    }
    
// MARK: UI FUNCTIONS -
    func setupViewALert(){
        let imageView = UIImageView(frame: CGRect(x: 75, y: 25, width: 140, height: 60))
        imageView.image = UIImage(named: "logoEncuentro", in: Bundle.local, compatibleWith: nil)
        alertLoader.view.addSubview(imageView)
        self.present(alertLoader, animated: false, completion: nil)
    }
    
    private func setupUI() {
        let singleton = Home_SOSPrincipal.singleton
        lblMainTitle.text = singleton.nameService
        customNavBar.ShadowNavBar()
        customNavBar.layer.cornerRadius = 20
        lblMainTitle.adjustsFontSizeToFitWidth = true
        lblMainSubtitle.adjustsFontSizeToFitWidth = true
        let tapBackIcon = UITapGestureRecognizer(target: self, action: #selector(handleTapBack))
        backNavBar.addGestureRecognizer(tapBackIcon)
        
    }
    
    private func setupCollectionDelegates() {
        mainTableV.delegate = self
        mainTableV.dataSource = self
        self.mainTableV.reloadData()
        Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { (timer) in
            UIView.animate(withDuration: 0.5) {
                self.mainTableV.alpha = 1
            }
            self.mainTableV.reloadData()
            self.alertLoader.dismiss(animated: false, completion: nil)
            self.isFisrtLoad = false
        }
        
    }
    
    func newSetupDeelgates() {
        newMainTable.delegate = self
        newMainTable.dataSource = self
        newMainTable.reloadData()
        self.alertLoader.dismiss(animated: false, completion: nil)
    }
    
    private func setupLocation() {
        locationManager.delegate = self
        self.placeHolderText.bringSubviewToFront(mainTableV)
        if CLLocationManager.locationServicesEnabled() {
            if #available(iOS 14.0, *) {
                switch locationManager.authorizationStatus {
                case .notDetermined, .restricted, .denied:
                    print("No access")
                    
                    UIView.animate(withDuration: 0.3) {
                        self.mainTableV.alpha = 0
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
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        if self.latitude != nil && self.longitude != nil {
                          //  self.presenter?.getRequestChurchesList(lat: "\(19.443354745949094)", long: "\(-99.13219128878002)")
                            print("no es nil lat y long y se llamo el EP")
                        }else{
                            print("es nil lat y long")
                        }
                    }
                    
                    Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { (timer) in
                      //  self.setupViewALert()
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
    
// MARK: SERVICES FUNCS -
    func loadRequestData(data: [ListChurches]) {
        churchListed = data
        
        if data.count == 0 {
            isEmptychurch = true
            errorAlert.transitioningDelegate = self
            alertLoader.dismiss(animated: true, completion: nil)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.present(self.errorAlert, animated: true, completion: nil)
            }
           
        }else{
            newSetupDeelgates()
            isEmptychurch = false
        }
      //  setupCollectionDelegates()
        
    }
    
    func successCreateService(data: ServiceResponse) {
        let singleton = UncionSOSView.singleton
        singleton.newServiceID = data.service_id
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.alertLoader.dismiss(animated: false, completion: nil)
            self.alert.view.backgroundColor = .clear
            self.alert.transitioningDelegate = self
            self.present(self.alert, animated: true)
        }

    }
    
// MARK: NAVIGATION FUNCS -
    func selectedItem(type: String, tel: String) {
        switch type {
        case "CHURCH":
            print("Haz la llamada")
            DispatchQueue.main.async {
                let telefono = tel
                guard let url = URL(string: "TEL://" + telefono) else { return }
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
                
            }
           
        case "CONTACT":
            Go()
            
        default:
            break
        }
    }
        
    func Go() {
        self.setupViewALert()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let sing = Home_SOSPrincipal.singleton
            let singlet = UncionSOSView.singleton
            let idUser = self.defaults.integer(forKey: "id")
            self.presenter?.postCreateService(address: sing.direction, latitude: self.latitude, longitude: self.longitude, devoteeID: idUser, idService: sing.serviceID, contactID: singlet.contactID)
            
            let singleton = AcceptAlert.singleton
            singleton.type = "Uncion"
            
        }
        
    }

    
    @objc func handleTapBack() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension UncionSOSView: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
                
        if #available(iOS 14.0, *) {
            switch manager.authorizationStatus {
            case .denied:
                print("nel")
                UIView.animate(withDuration: 0.3) {
                    self.mainTableV.alpha = 0
                    self.placeHolderText.alpha = 1
                    self.pinHolder.alpha = 0.4
                }
            default:
                print("hola")
                self.placeHolderText.alpha = 0
                self.pinHolder.alpha = 0
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    if self.latitude != nil && self.longitude != nil {
                        //self.presenter?.getRequestChurchesList(lat: "\(self.latitude!)", long: "\(self.longitude!)")
                        print("no es nil lat y long y se llamo el EP")
                    }else{
                        print("es nil lat y long")
                    }
                }
              
                mainTableV.alpha = 0
                Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { (timer) in
                    //self.setupViewALert()
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
          //  print("Entro el delgte")
            //presenter?.getRequestChurchesList(lat: location.coordinate.latitude, long: location.coordinate.longitude)
            
        }
    }
    
}

extension UncionSOSView: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = true
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = false
        print("Hola desde el dismiss delegate")
        
        if self.isEmptychurch == false {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                let module = UncionServiceSOSRouter.createModule()
                self.navigationController?.pushViewController(module, animated: true)
               
            }
          
        }else{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.navigationController?.popViewController(animated: true)
            }
            
        }
       
        return transition
    }
    
}
