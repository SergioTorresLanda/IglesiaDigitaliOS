//
//  CommunitiesFormularyViewController.swift
//  EncuentroCatolicoChurch
//
//  Created by Jorge Garcia on 27/07/21.
//

import UIKit
import MapKit

class CommunitiesFormularyViewController: UIViewController, CommunitiesFormularyViewProtocol {
    var presenter: CommunitiesFormularyPresenterProtocol?
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var communityTypePiker: UITextField!
    @IBOutlet weak var charismpaTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var adressTextField: UITextField!
    @IBOutlet weak var cpTextField: UITextField!
    @IBOutlet weak var suburbTextField: UITextField!
    @IBOutlet weak var townshipTextField: UITextField!
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var lvFromPiker: UITextField!
    @IBOutlet weak var lvToPiker: UITextField!
    @IBOutlet weak var yesNoPiker: UITextField!
    @IBOutlet weak var sdFromPiker: UITextField!
    @IBOutlet weak var sdToPiker: UITextField!
    @IBOutlet weak var webTextField: UITextField!
    @IBOutlet weak var twitterTextField: UITextField!
    @IBOutlet weak var faceBookTextField: UITextField!
    @IBOutlet weak var intagramTextField: UITextField!
    @IBOutlet weak var otherTextField: UITextField!
    @IBOutlet weak var youTubeTextField: UITextField!
    @IBOutlet weak var addImageView: UIImageView!
    @IBOutlet weak var upLoadImageView: UIImageView!
    
    let yesNoArray = ["Si", "No"]
    let emtyArray = [""]
    var pickercommunity = UIPickerView()
    var pickelvFrom = UIPickerView()
    var pickerlvTo = UIPickerView()
    var pickersdFrom = UIPickerView()
    var pickersdTo = UIPickerView()
    var pickerYesNo = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(CommunitiesFormularyViewController.tappedMe))
        addImageView.addGestureRecognizer(tap)
        addImageView.isUserInteractionEnabled = true
        upLoadImageView.addGestureRecognizer(tap)
        upLoadImageView.isUserInteractionEnabled = true
       setUpPockers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("VC ECChurch - Communities - CommunitiesFormularyVC ")
    }
    func setUpPockers() {
        pickercommunity.delegate = self
        pickelvFrom.delegate = self
        pickerlvTo.delegate = self
        pickersdFrom.delegate = self
        pickersdTo.delegate = self
        pickerYesNo.delegate = self
        pickercommunity.dataSource = self
        pickelvFrom.dataSource = self
        pickerlvTo.dataSource = self
        pickersdFrom.dataSource = self
        pickersdTo.dataSource = self
        pickerYesNo.dataSource = self
        
        communityTypePiker.inputView = pickercommunity
        lvFromPiker.inputView = pickelvFrom
        lvToPiker.inputView = pickelvFrom
        sdFromPiker.inputView = pickersdFrom
        sdToPiker.inputView = pickersdFrom
        yesNoPiker.inputView = pickerYesNo
    }
    @objc func tappedMe() {
        switch UIImageView() {
        case addImageView:
            print("")
        case upLoadImageView:
            print("")
        default:
            break
        }
    }
    @IBAction func cancelAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func preViewAction(_ sender: Any) {
    }
    @IBAction func saveAction(_ sender: Any) {
    }
    @IBAction func backButtonAction(_ sender: Any) {
    }
    
}

extension CommunitiesFormularyViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch UIPickerView() {
        case pickercommunity:
            return 1
        case pickelvFrom:
            return 1
        case pickerlvTo:
            return 1
        case pickersdFrom:
            return 1
        case pickerYesNo:
            return yesNoArray.count
        default:
            return 1
        }
    }
    func addPinToMap() {
        //Activity Indicator
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = UIActivityIndicatorView.Style.gray
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        
        self.view.addSubview(activityIndicator)
        //Create the search request
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = adressTextField.text
        
        let activeSearch = MKLocalSearch(request: searchRequest)
        
        activeSearch.start { (response, error) in
            
            activityIndicator.stopAnimating()
            UIApplication.shared.endIgnoringInteractionEvents()
            
            if response == nil
            {
                print("ERROR")
            }
            else
            {
                //Remove annotations
                let annotations = self.map.annotations
                self.map.removeAnnotations(annotations)
                
                //Getting data
                let latitude = response?.boundingRegion.center.latitude
                let longitude = response?.boundingRegion.center.longitude
                
                //Create annotation
                let annotation = MKPointAnnotation()
                annotation.title = self.adressTextField.text
                annotation.coordinate = CLLocationCoordinate2DMake(latitude!, longitude!)
                self.map.addAnnotation(annotation)
                
                //Zooming in on annotation
                let coordinate:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude!, longitude!)
                let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
                let region = MKCoordinateRegion(center: coordinate, span: span)
                self.map.setRegion(region, animated: true)
            }
            
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch UIPickerView() {
        case pickercommunity:
            return emtyArray[row]
        case pickelvFrom:
            return emtyArray[row]
        case pickerlvTo:
            return emtyArray[row]
        case pickersdFrom:
            return emtyArray[row]
        case pickerYesNo:
            return yesNoArray[row]
        default:
            return emtyArray[row]
        }
    }
    
    
}
