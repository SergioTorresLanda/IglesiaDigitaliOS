//
//  RegisterFirmulary.swift
//  EncuentroCatolicoChurch
//
//  Created by Jorge Garcia on 20/08/21.
//

import UIKit
import MapKit

public protocol RefisterFormularyButtonDelegate: AnyObject {
    func didPressReadyFormularyButton(_ sender: UIButton)
}
protocol RegisterFormDataSendingDelegateProtocol {
    func sendDataFormToComMainViewController(name: String, intitution: String, charism: String, resposable: String, description: String, address: String, lvText: String, lvHour: String, sdText: String, sdHour: String, email: String, phone: String, latitude: Double, longitude: Double)
}
class RegisterFirmulary: UIView, UITextFieldDelegate {
    public weak var delegate: RefisterFormularyButtonDelegate?
    public var delegateData: RegisterFormDataSendingDelegateProtocol? = nil
    @IBOutlet weak var lvTitleLabel: UILabel!
    @IBOutlet weak var sdTitleLabel: UILabel!
    @IBOutlet weak var title1Label: UILabel!
    @IBOutlet weak var separator1View: UIView!
    @IBOutlet weak var title2Label: UILabel!
    @IBOutlet weak var separator2View: UIView!
    @IBOutlet weak var title3Label: UILabel!
    @IBOutlet weak var separator3View: UIView!
    @IBOutlet weak var title4Label: UILabel!
    @IBOutlet weak var title5Label: UILabel!
    @IBOutlet var parentView: UIView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var institutinTextField: UITextField!
    @IBOutlet weak var charismaTextField: UITextField!
    @IBOutlet weak var responsableTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var lvTextField: UITextField!
    @IBOutlet weak var lvHourTextField: UITextField!
    @IBOutlet weak var sdTextField: UITextField!
    @IBOutlet weak var sdHourTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var readyButton: UIButton!
    static let instance = RegisterFirmulary()
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    private lazy var lvTimePicker: TimePicker = {
        let picker = TimePicker()
        picker.setup()
        picker.didSelectDates = { [weak self] (startDate, endDate) in
            let text = Date.buildTimeRangeString(startDate: startDate, endDate: endDate)
            self?.lvHourTextField.text = text
        }
        return picker
    }()
    private lazy var sdTimePicker: TimePicker = {
        let picker = TimePicker()
        picker.setup()
        picker.didSelectDates = { [weak self] (startDate, endDate) in
            let text = Date.buildTimeRangeString(startDate: startDate, endDate: endDate)
            self?.sdHourTextField.text = text
        }
        return picker
    }()
    
    private lazy var sdDayPicker: DayPicker = {
        let picker = DayPicker()
        picker.setup()
        picker.didSelectDates = { [weak self] (startDate, endDate) in
            let text = Date.buildDayRangeString(startDate: startDate, endDate: endDate)
            self?.sdTextField.text = text
        }
        return picker
    }()
    
    private lazy var lvDayPicker: DayPicker = {
        let picker = DayPicker()
        picker.setup()
        picker.didSelectDates = { [weak self] (startDate, endDate) in
            let text = Date.buildDayRangeString(startDate: startDate, endDate: endDate)
            self?.lvTextField.text = text
        }
        return picker
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        Bundle.local.loadNibNamed("RegisterFirmulary", owner: self, options: nil)
        nibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        nibSetup()
    }
    private func nibSetup() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.init(named: "eMainBlue")
        toolBar.sizeToFit()

        let doneButton = UIBarButtonItem(title: "Listo", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.doneClick))
        toolBar.setItems([doneButton], animated: false)
        
        nameTextField.tag = 0
        institutinTextField.tag = 1
        charismaTextField.tag = 2
        responsableTextField.tag = 3
        descriptionTextField.tag = 4
        addressTextField.tag = 5
        emailTextField.tag = 6
        phoneTextField.tag = 7
        
        nameTextField.delegate = self
        institutinTextField.delegate = self
        charismaTextField.delegate = self
        responsableTextField.delegate = self
        descriptionTextField.delegate = self
        addressTextField.delegate = self
        emailTextField.delegate = self
        phoneTextField.delegate = self
        
        nameTextField.returnKeyType = .next
        institutinTextField.returnKeyType = .next
        charismaTextField.returnKeyType = .next
        responsableTextField.returnKeyType = .next
        descriptionTextField.returnKeyType = .next
        addressTextField.returnKeyType = .search
        emailTextField.returnKeyType = .next
        phoneTextField.returnKeyType = .done
        
        lvHourTextField.inputView = lvTimePicker.inputView
        sdHourTextField.inputView = sdTimePicker.inputView
        
        lvTextField.inputView = lvDayPicker.inputView
        sdTextField.inputView = sdDayPicker.inputView
        
        lvHourTextField.adjustsFontSizeToFitWidth = true
        sdHourTextField.adjustsFontSizeToFitWidth = true
        lvTextField.adjustsFontSizeToFitWidth = true
        sdTextField.adjustsFontSizeToFitWidth = true
        
        lvHourTextField.inputAccessoryView = toolBar
        sdHourTextField.inputAccessoryView = toolBar
        lvTextField.inputAccessoryView = toolBar
        sdTextField.inputAccessoryView = toolBar
        phoneTextField.inputAccessoryView = toolBar
        
        phoneTextField.keyboardType = .asciiCapableNumberPad
        
    }
    func showAllert() {
        UIApplication.shared.keyWindow?.addSubview(parentView)
    }
    @objc func doneClick() {
        lvHourTextField.resignFirstResponder()
        sdHourTextField.resignFirstResponder()
        lvTextField.resignFirstResponder()
        sdTextField.resignFirstResponder()
        phoneTextField.resignFirstResponder()
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
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.parentView.frame.origin.y == 0 {
                self.parentView.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.parentView.frame.origin.y != 0 {
            self.parentView.frame.origin.y = 0
        }
    }
    private func switchBasedNextTextField(_ textField: UITextField) {
        switch textField {
        case self.nameTextField:
            self.nameTextField.becomeFirstResponder()
        case self.institutinTextField:
            self.institutinTextField.becomeFirstResponder()
        case self.charismaTextField:
            self.charismaTextField.becomeFirstResponder()
        case self.responsableTextField:
            self.responsableTextField.becomeFirstResponder()
        case self.descriptionTextField:
            self.descriptionTextField.becomeFirstResponder()
        case self.addressTextField:
            self.addressTextField.resignFirstResponder()
        case self.emailTextField:
            self.emailTextField.becomeFirstResponder()
        default:
            self.phoneTextField.resignFirstResponder()
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == addressTextField {
            addPinToMap()
        }
    }
    func addPinToMap() {
        //Activity Indicator
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = UIActivityIndicatorView.Style.gray
        activityIndicator.center = self.parentView.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        
        self.parentView.addSubview(activityIndicator)
        //Create the search request
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = addressTextField.text
        
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
                annotation.title = self.addressTextField.text
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
    
    @IBAction func readyButtonAction(_ sender: UIButton) {
        delegate?.didPressReadyFormularyButton(sender)
        if self.delegateData != nil {
            delegateData?.sendDataFormToComMainViewController(name: nameTextField.text ?? "", intitution: institutinTextField.text ?? "", charism: charismaTextField.text ?? "", resposable: responsableTextField.text ?? "", description: descriptionTextField.text ?? "", address: addressTextField.text ?? "", lvText: lvTextField.text ?? "", lvHour: lvHourTextField.text ?? "", sdText: sdTextField.text ?? "", sdHour: sdHourTextField.text ?? "", email: emailTextField.text ?? "", phone: phoneTextField.text ?? "", latitude: latitude, longitude: longitude)
        }
    }
}

