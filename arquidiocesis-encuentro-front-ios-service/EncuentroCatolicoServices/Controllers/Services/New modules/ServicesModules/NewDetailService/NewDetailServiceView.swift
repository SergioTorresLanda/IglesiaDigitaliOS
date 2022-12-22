//
//  NewDetailServiceView.swift
//  EncuentroCatolicoServices
//
//  Created by Pablo Luis Velazquez Zamudio on 27/07/21.
//

import UIKit
import MapKit

class NewDetailServiceView: UIViewController, NewDetailServiceViewProtocol {
    
// MARK: PROTOCOL VAR -
    var presenter: NewDetailServicePresenterProtocol?
    
// MARK: GLOBAL VAR -
    var nameService: String?
    var typeView: String?
    var idService: Int?
    let alertLoader = UIAlertController(title: "", message: "\n \n \n \n \nCargando...", preferredStyle: .alert)
    var locationStr = ""
    var stateView = "SERVICE"
    let transition = SlideTransition()
    var isCloseService = false
    
    static let singleton = NewDetailServiceView()
    
// MARK: @IBOUTLETS -
    @IBOutlet weak var contentNavBar: UIView!
    @IBOutlet weak var customNavBar: UIView!
    @IBOutlet weak var lblNavBarTitle: UILabel!
    @IBOutlet weak var backIcon: UIImageView!
    @IBOutlet weak var mainScroll: UIScrollView!
    @IBOutlet weak var mainContentView: UIView!
    @IBOutlet weak var lblMainTitle: UILabel!
    @IBOutlet weak var card1: UIView!
    @IBOutlet var lblDataCollection: [UILabel]!
    @IBOutlet weak var card2: UIView!
    @IBOutlet weak var lblResponse: UILabel!
    @IBOutlet weak var responseTextView: UITextView!
    @IBOutlet weak var btnReject: UIButton!
    @IBOutlet weak var btnAccept: UIButton!
    @IBOutlet weak var mapCard: UIView!
    @IBOutlet weak var mapService: MKMapView!
    @IBOutlet weak var shareBtn: UIButton!
    @IBOutlet weak var shareIcon: UIImageView!
    @IBOutlet weak var btnCloseService: UIButton!
    
// MARK: LIFE CYCLE FUNCS -
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupGestures()
        setupDelegates()
        showLoading()
        presenter?.callRequestDertailService(serviceID: "\(idService ?? 0)")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("VC ECServices - NewDetailServiceVC ")

    }
    
// MARK: SETUP FUNCS -
    private func setupUI() {
        customNavBar.layer.cornerRadius = 20
        customNavBar.ShadowNavBar()
        card1.layer.cornerRadius = 10
        card1.ShadowCard()
        card2.layer.cornerRadius = 10
        card2.ShadowCard()
        mapCard.ShadowCard()
        mapCard.layer.cornerRadius = 10
        btnReject.layer.cornerRadius = 8
        btnAccept.layer.cornerRadius = 8
        btnCloseService.layer.cornerRadius = 8
        btnReject.borderButtonColor(color: UIColor(red: 25/255, green: 42/255, blue: 115/255, alpha: 1))
        btnCloseService.borderButtonColor(color: UIColor(red: 25/255, green: 42/255, blue: 115/255, alpha: 1))
        let singleton = NewDetailServiceView.singleton
        singleton.isCloseService = false
        
        if nameService != nil {
            lblNavBarTitle.text = nameService
        }
        
    }
    
    private func setupGestures() {
        let tapBack = UITapGestureRecognizer(target: self, action: #selector(TapBack))
        backIcon.addGestureRecognizer(tapBack)
    }
    
    private func setupDelegates() {
        responseTextView.delegate = self
    }
    
// MARK: GENERAL FUNCTIONS -
    func showLoading(){
        let imageView = UIImageView(frame: CGRect(x: 75, y: 25, width: 140, height: 60))
        imageView.image = UIImage(named: "logoEncuentro", in: Bundle.local, compatibleWith: nil)
        alertLoader.view.addSubview(imageView)
        self.present(alertLoader, animated: false, completion: nil)
    }
    
    func searchLocation() {
        let geodecoder = CLGeocoder()
        geodecoder.geocodeAddressString(locationStr) { (places: [CLPlacemark]?, error: Error?) in
            if error == nil {
                let place = places?.first
                let anotacion = MKPointAnnotation()
                anotacion.coordinate = (place?.location?.coordinate)!
               // anotacion.title = self.addressField.text
                
                let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                let region = MKCoordinateRegion(center: anotacion.coordinate, span: span)
                self.mapService.setRegion(region, animated: true)
                self.mapService.addAnnotation(anotacion)
                self.mapService.selectAnnotation(anotacion, animated: true)
            }else{
                print("Error al encontrar dirección")
            }
        }
    }
        
    func shareLocation() {
        // let items = [URL(string: url)!] este es solo para compartir url sin otro texto
        let items: [Any] = [locationStr]
        let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(ac, animated: true)
    }
    
// MARK: @OBJC FUNCS -
    @objc func TapBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
// MARK: API SERVICE FUNCTIONS -
    func successRequestDetail(contentResponse: DetailService) {
        print(contentResponse, "....")
        locationStr = "\(contentResponse.address?.description ?? "Unspecified"), \(contentResponse.address?.neighborhood ?? "") \(contentResponse.address?.zipcode ?? "")"
        if locationStr != "Unspecified" {
            searchLocation()
        }
        lblMainTitle.text = "\(contentResponse.devotee?.name ?? "Unspecified") \(contentResponse.devotee?.first_surname ?? "") \(contentResponse.devotee?.second_surname ?? "")"//contentResponse.person_name ?? ""
        lblDataCollection[1].text = contentResponse.person_name ?? ""
        lblDataCollection[3].text = "\(contentResponse.address?.neighborhood ?? "Unspecified"), C.P \(contentResponse.address?.zipcode ?? "")"
        lblDataCollection[5].text = contentResponse.address?.neighborhood ?? ""
        lblDataCollection[7].text = contentResponse.address?.zipcode ?? ""
        lblDataCollection[9].text = contentResponse.email ?? ""
        lblDataCollection[11].text = contentResponse.phone ?? ""
        
        switch contentResponse.status {
        case "PENDING_CONFIRMATION":
            UIView.animate(withDuration: 0.3) {
                self.card1.alpha = 1
                self.card2.alpha = 1
                self.btnAccept.alpha = 1
                self.btnReject.alpha = 1
            }
        case "ACCEPTED":
            UIView.animate(withDuration: 0.3) {
                self.card1.alpha = 1
                self.mapCard.alpha = 1
                self.btnAccept.alpha = 0
                self.btnReject.alpha = 0
                self.btnCloseService.alpha = 1
            }
        
        case "COMPLETED", "REJECTED", "CANCELLED":
            UIView.animate(withDuration: 0.3) {
                self.card1.alpha = 1
            }
            
        default:
            break
        }
        
//        if typeView == "List" {
//            UIView.animate(withDuration: 0.3) {
//                self.card1.alpha = 1
//                self.card2.alpha = 1
//                self.btnAccept.alpha = 1
//                self.btnReject.alpha = 1
//            }
//        }else{
//            UIView.animate(withDuration: 0.3) {
//                self.card1.alpha = 1
//                self.card2.alpha = 1
//                self.btnAccept.alpha = 1
//                self.btnReject.alpha = 1
//            }
//            UIView.animate(withDuration: 0.3) {
//                self.card1.alpha = 1
//                self.mapCard.alpha = 1
//            }
       // }
        
        self.alertLoader.dismiss(animated: true, completion: nil)
        
    }
    
    func failRequestDetail() {
        self.alertLoader.dismiss(animated: true, completion: nil)
        
    }
    
    func succesPatchService(typePatch: String) {
        alertLoader.dismiss(animated: false, completion: nil)
        
        switch typePatch {
        case "SERVICE":
            stateView = "COMMENT"
            btnReject.alpha = 0
            card2.backgroundColor = .white
            responseTextView.isUserInteractionEnabled = true
            btnAccept.setTitle("Listo", for: .normal)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                let alert = acceptAlertService.showAlert(textAlert: "Servicio aceptado")
                self.present(alert, animated: true, completion: nil)
            }
        case "REJECTED":
            btnAccept.alpha = 0
            btnReject.alpha = 0
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                let alert = acceptAlertService.showAlert(textAlert: "Servicio rechazado")
                self.present(alert, animated: true, completion: nil)
            }
            
        case "COMMENT":
            UIView.animate(withDuration: 0.3) {
                self.mapCard.alpha = 1
                self.btnCloseService.alpha = 1
            }
            
        case "CLOSE":
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.navigationController?.popViewController(animated: true)
            }
            
        default:
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.navigationController?.popViewController(animated: true)
            }
        }
        
    }
    
    func failPatchService() {
        alertLoader.dismiss(animated: true, completion: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            let alert = acceptAlertService.showAlert(textAlert: "Ocurrio un error, por favor intenta de nuevo más tarde.")
            self.present(alert, animated: true, completion: nil)
        }
    }
    
// MARK: @IBACTIONS -
    
    @IBAction func rejecteAction(_ sender: Any) {
        let singleton = NewDetailServiceView.singleton
        singleton.isCloseService = false
        self.present(alertLoader, animated: true, completion: nil)
        presenter?.makePatchService(status: "REJECTED", serviceID: "\(idService ?? 0)", typePatch: "REJECTED", comment: "")
    }
    
    @IBAction func accpetAction(_ sender: Any) {
        let singleton = NewDetailServiceView.singleton
        singleton.isCloseService = false
        self.present(alertLoader, animated: true, completion: nil)
        if stateView == "SERVICE" {
            presenter?.makePatchService(status: "ACCEPTED", serviceID: "\(idService ?? 0)", typePatch: "SERVICE", comment: "")
        }else{
            presenter?.makePatchService(status: "", serviceID: "\(idService ?? 0)", typePatch: "COMMENT", comment: responseTextView.text)
        }
        //let alertYesNo = yesNoAlertService.showAlertYes(textAlert: "¿El servicio se atendió con éxito?")
        //alertYesNo.transitioningDelegate = self
        // present(alertYesNo, animated: true, completion: nil)
    }
    
    @IBAction func shareAction(_ sender: Any) {
        shareLocation()
    }
    
    @IBAction func cloaseServiceAction(_ sender: Any) {
        let alert = yesNoAlertService.showAlertYes(textAlert: "¿El servicio se atendio con exito?")
        alert.transitioningDelegate = self
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension NewDetailServiceView: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if responseTextView.text == "Escribe la respuesta..." {
            responseTextView.text = ""
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if responseTextView.text == "" {
            responseTextView.text = "Escribe la respuesta..."
        }
    }
    
}

extension NewDetailServiceView: UIViewControllerTransitioningDelegate {
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = false
        let singleton = NewDetailServiceView.singleton
        
        if singleton.isCloseService == true {
            self.presenter?.makePatchService(status: "COMPLETED", serviceID: "\(idService ?? 0)", typePatch: "CLOSE", comment: "")
//            
        }else{
            print("Dont close")
        }
        
        return transition
    }
}
