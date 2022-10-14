//
//  AnswerFoemularyViewController.swift
//  EncuentroCatolicoChurch
//
//  Created by Jorge Garcia on 03/08/21.
//

import UIKit
import MapKit

class AnswerFoemularyViewController: UIViewController, AnswerFoemularyViewProtocol, UITextFieldDelegate {
    
    var presenter: AnswerFoemularyPresenterProtocol?

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var adressTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var communityTextField: UITextField!
    @IBOutlet weak var communityNameField: UITextField!
    @IBOutlet weak var suburbField: UITextField!
    @IBOutlet weak var zipCode: UITextField!
    @IBOutlet weak var mayoralty: UITextField!
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var cardView: UIView!
    
    let pickerView = UIPickerView()
    var communityCatalog: CommunityTypeCatalog?
    var sellecetComTypeId = Int()
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    let alertLoader = UIAlertController(title: "", message: "\n \n \n \n \nCargando...", preferredStyle: .alert)
    let transition = SlideTransition()
    let userName = UserDefaults.standard.string(forKey: "COMPLETENAME")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGestures()
        presenter?.callComunityType()
        pickerView.delegate = self
        cardView.layer.cornerRadius = 10
        cardView.ShadowCard()
        nameTextField.text = userName
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.init(named: "eMainBlue")
        toolBar.sizeToFit()

        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.doneClick))
        toolBar.setItems([doneButton], animated: false)
        
        communityNameField.tag = 0
        nameTextField.tag = 1
        adressTextField.tag = 2
        suburbField.tag = 3
        zipCode.tag = 4
        mayoralty.tag = 5
        phoneTextField.tag = 6
        emailTextField.tag = 7
        communityTextField.tag = 8
        
        nameTextField.delegate = self
        adressTextField.delegate = self
        phoneTextField.delegate = self
        emailTextField.delegate = self
        communityTextField.delegate = self
        communityNameField.delegate = self
        suburbField.delegate = self
        zipCode.delegate = self
        mayoralty.delegate = self
        
        nameTextField.returnKeyType = .next
        adressTextField.returnKeyType = .search
        phoneTextField.returnKeyType = .next
        emailTextField.returnKeyType = .next
        
        communityTextField.inputView = pickerView
        communityTextField.inputAccessoryView = toolBar
       
    }
    
    private func setupGestures() {
        let tapSuperview = UITapGestureRecognizer(target: self, action: #selector(TapSuperview))
        self.view.addGestureRecognizer(tapSuperview)
    }
    
    @IBAction func acceptButton(_ sender: Any) {
        if nameTextField.text != "" && communityNameField.text != "" && adressTextField.text != "" && suburbField.text != "" && zipCode.text != "" && mayoralty.text != "" && phoneTextField.text != "" && emailTextField.text != "" && communityTextField.text != "" {
//            showLoading()
            presenter?.sendCommunityType(name: communityNameField.text ?? "", address: "\(adressTextField.text ?? "") \(suburbField.text ?? ""), \(zipCode.text ?? ""), \(mayoralty.text ?? "")", long: self.longitude, lat: self.latitude, email: emailTextField.text ?? "", phone: phoneTextField.text ?? "", type: sellecetComTypeId)
        }else{
            let view = alertModalCommController.showAlert(textAlert: "Por favor llena todos los campos")
            view.modalPresentationStyle = .overFullScreen
            
            self.present(view, animated: true, completion: nil)
        }
        
    }
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func TapSuperview() {
        self.view.endEditing(true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == adressTextField {
            addPinToMap()
        }else{
            if textField.text == "" {
                textField.text = ""
            }
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text == "" {
            textField.text = ""
        }
       
    }
    
    func communityTypeSuccess(response: CommunityTypeCatalog) {
        communityCatalog = response
    }
    
    func postAddCommunitySuccess() {
//        alertLoader.dismiss(animated: true, completion: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            let view = alertModalCommController.showAlert(textAlert: "Se envió el registro con éxito")
            view.modalPresentationStyle = .overFullScreen
            view.transitioningDelegate = self
            
            self.present(view, animated: true, completion: nil)
        }
        
    }
    
    func postAddCommunityFail(message: String) {
//        alertLoader.dismiss(animated: true, completion: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            let view = alertModalCommController.showAlert(textAlert: message)
            view.modalPresentationStyle = .overFullScreen
            
            self.present(view, animated: true, completion: nil)
        }
    }
    
    @objc func doneClick() {
        communityTextField.resignFirstResponder()
     }
    
    private func switchBasedNextTextField(_ textField: UITextField) {
        switch textField {
        case self.nameTextField:
            self.nameTextField.becomeFirstResponder()
        case self.adressTextField:
            self.adressTextField.resignFirstResponder()
        case self.phoneTextField:
            self.phoneTextField.becomeFirstResponder()
        default:
            self.emailTextField.resignFirstResponder()
            
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.tagBasedTextField(textField)
        return true
    }
    
    private func tagBasedTextField(_ textField: UITextField) {
        let nextTextFieldTag = textField.tag + 1
        
        if let nextTextField = textField.superview?.viewWithTag(nextTextFieldTag) as? UITextField {
            nextTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
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
        searchRequest.naturalLanguageQuery = communityTextField.text
        
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
                let annotations = self.mapView.annotations
                self.mapView.removeAnnotations(annotations)
                
                //Getting data
                self.latitude = response?.boundingRegion.center.latitude ?? 0.0
                self.longitude = response?.boundingRegion.center.longitude ?? 0.0
                
                //Create annotation
                let annotation = MKPointAnnotation()
                annotation.title = self.communityTextField.text
                annotation.coordinate = CLLocationCoordinate2DMake(self.latitude, self.longitude)
                self.mapView.addAnnotation(annotation)
                
                //Zooming in on annotation
                let coordinate:CLLocationCoordinate2D = CLLocationCoordinate2DMake(self.latitude, self.longitude)
                let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
                let region = MKCoordinateRegion(center: coordinate, span: span)
                self.mapView.setRegion(region, animated: true)
            }
            
        }
    }
    
    func showLoading() {
        let imageView = UIImageView(frame: CGRect(x: 75, y: 25, width: 140, height: 60))
        imageView.image = UIImage(named: "logoEncuentro", in: Bundle.local, compatibleWith: nil)
        alertLoader.view.addSubview(imageView)
        self.present(alertLoader, animated: false, completion: nil)
    }
    
}

extension AnswerFoemularyViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return communityCatalog?.data?.count ?? 1
    }
    
    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return communityCatalog?.data?[row].datumDescription
    }
    
    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        communityTextField.text = " \(communityCatalog?.data?[row].datumDescription ?? "")"
        communityTextField.adjustsFontSizeToFitWidth = true
        sellecetComTypeId = communityCatalog?.data?[row].id ?? 1
    }
    
    
}

extension AnswerFoemularyViewController: UIViewControllerTransitioningDelegate {
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = false
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.dismiss(animated: true, completion: nil)
        }
        
        return transition
        
    }
}
