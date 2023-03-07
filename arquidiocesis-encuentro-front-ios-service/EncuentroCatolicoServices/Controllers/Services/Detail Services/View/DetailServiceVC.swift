//
//  DetailServiceViewController.swift
//  EncuentroCatolicoServices
//
//  Created by Miguel Eduardo  Valdez Tellez  on 20/04/21.
//

import UIKit
import Foundation
import MapKit
import CoreLocation
import EncuentroCatolicoProfile

class DetailServiceViewController: BaseViewController, DetailServiceViewProtocol, UIViewControllerTransitioningDelegate{
    
// MARK: GLOBAL VARIABLES -
    var arrayOfSububs : [Sububs] = []
    var picker: UIPickerView!
    var arryDummy = ["Colonia 1", "Colonia 2"]
    let alertLoader = UIAlertController(title: "", message: "\n \n \n \n \nCargando...", preferredStyle: .alert)
    var isDataComplete: Bool = false
    var longitude: Double?
    var latitude: Double?
    var finalLocationId: Int?
    var blessType = UserDefaults.standard.bool(forKey: "DetailView")
    
// MARK: - @IBOUTLETS
    @IBOutlet weak var mainTitleText: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var applicantLabel: UILabel!
    @IBOutlet weak var sickStackView: UIStackView!
    @IBOutlet weak var sickNameText: UITextField!
    @IBOutlet weak var sickRequired: UILabel!
    @IBOutlet weak var familyStackView: UIStackView!
    @IBOutlet weak var familyText: UITextField!
    @IBOutlet weak var familyRequired: UILabel!
    @IBOutlet weak var directionText: UITextField!
    @IBOutlet weak var directionRequired: UILabel!
    @IBOutlet weak var suburdText: UITextField!
    @IBOutlet weak var suburdRequerid: UILabel!
    @IBOutlet weak var postalCodeText: UITextField!
    @IBOutlet weak var postalCodeRequerid: UILabel!
    @IBOutlet weak var justificationStackView: UIStackView!
    @IBOutlet weak var serachButton: UIButton!
    @IBOutlet weak var justificationText: UITextField!
    @IBOutlet weak var justificationRequerid: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var phoneRealNumber: UILabel!
    
    @IBAction func searchChuchButton(_ sender: Any) {
        if isDataComplete == true {
            if blessType == false {
                presenter?.postBlessService(familyName: familyText.text ?? "", email: emailLabel.text ?? "", phone: phoneRealNumber.text ?? "", description: suburdText.text ?? "", zipcode: postalCodeText.text ?? "", neighborhood: suburdText.text ?? "", longitude: longitude ?? 0.0, latitude: latitude ?? 0.0, location_id: finalLocationId ?? 1, service_id: 28)
            }else {
                presenter?.postComuService(personName: familyText.text ?? "", email: emailLabel.text ?? "", phone: phoneRealNumber.text ?? "", expanation: justificationText.text ?? "", zipcode: postalCodeText.text ?? "", neighborhood: suburdText.text ?? "", longitude: longitude ?? 0.0, latitude: latitude ?? 0.0, location_id: finalLocationId ?? 1, service_id: 30)
            }
        }else {
            if flagService == false {
                if let familia = familyText.text, !familia.isEmpty,
                   let direccion = directionText.text, !direccion.isEmpty,
                   let colonia = suburdText.text, !colonia.isEmpty,
                   let codigo = postalCodeText.text, !codigo.isEmpty {
                } else {
                    if let familia = familyText.text, familia.isEmpty {
                        familyRequired.isHidden = false
                    }
                    if let direccion = familyText.text, direccion.isEmpty {
                        directionRequired.isHidden = false
                    }
                    if let coloina = suburdText.text, coloina.isEmpty {
                        suburdRequerid.isHidden = false
                    }
                    if let codigo = postalCodeText.text, codigo.isEmpty {
                        postalCodeRequerid.isHidden = false
                    }
                    
                    let alert = UIAlertController(title: "Campos vacios", message: "Uno o varios campos vacios", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Intenta de nuevo", style: .default, handler: nil))
                    self.present(alert, animated: true)
                }
                presenter?.goToMaps(isPrincipal: 4)
                NotificationCenter.default.addObserver(self, selector: #selector(self.mapInfoReturn(_:)), name: NSNotification.Name(rawValue: "getMapData"), object: nil)
            } else {
                if let nombre = sickNameText.text, !nombre.isEmpty,
                   let direccion = directionText.text, !direccion.isEmpty,
                   let colonia = suburdText.text, !colonia.isEmpty,
                   let codigo = postalCodeText.text, !codigo.isEmpty,
                   let justificacion = justificationText.text, !justificacion.isEmpty {
                    
                } else {
                    if let nombre = sickNameText.text, nombre.isEmpty {
                        sickRequired.isHidden = false
                    }
                    if let direccion = familyText.text, direccion.isEmpty {
                        directionRequired.isHidden = false
                    }
                    if let coloina = suburdText.text, coloina.isEmpty {
                        suburdRequerid.isHidden = false
                    }
                    if let codigo = postalCodeText.text, codigo.isEmpty {
                        postalCodeRequerid.isHidden = false
                    }
                    if let justificacion = justificationText.text, justificacion.isEmpty {
                        justificationRequerid.isHidden = false
                    }
                    
                    
                    let alert = UIAlertController(title: "Campos vacios", message: "Uno o varios campos vacios", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Intenta de nuevo", style: .default, handler: nil))
                    self.present(alert, animated: true)
                }
                presenter?.goToMaps(isPrincipal: 4)
                NotificationCenter.default.addObserver(self, selector: #selector(self.mapInfoReturn(_:)), name: NSNotification.Name(rawValue: "getMapData"), object: nil)
            }
        }
    }
    @objc func mapInfoReturn(_ notification: NSNotification) {

      if let locationId = notification.userInfo?["locationId"] as? Int {
      finalLocationId = locationId
        isDataComplete = true
      }
     }
    @IBAction func dissmissButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    
    //True = Comunion de enfermo
    //False = Bendición de casa
    
    var presenter: DetailServicePresenterProtocol?
    var flagService = UserDefaults.standard.bool(forKey: "DetailView")
    
    override func viewWillAppear(_ animated: Bool) {
        print("VC ECServices - DetailServiceVC ")
        if isDataComplete == true {
            serachButton.setTitle("Registrar Servico", for: .normal)
        }
    }
      
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        setupPickerField()
    }
    
    @objc func donePicker() {
        self.view.endEditing(true)
    }
    
    @objc func cancelPicker() {
        self.view.endEditing(true)
        suburdText.text = ""
    }
    
    func showLoading(){
        let imageView = UIImageView(frame: CGRect(x: 100, y: 15, width: 80, height: 80))//mitad es en 145dp
        imageView.image = UIImage(named: "iconoIglesia3", in: Bundle.local, compatibleWith: nil)
        alertLoader.view.addSubview(imageView)
        self.present(alertLoader, animated: false, completion: nil)
    }
    
    func setupPickerField() {
        picker = UIPickerView(frame: CGRect(x: 0, y: 200, width: view.frame.width, height: 300))
        picker.backgroundColor = .white

        picker.showsSelectionIndicator = true
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()

        let doneButton = UIBarButtonItem(title: "Listo", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.donePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancelar", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.cancelPicker))

        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.items?.forEach({ (button) in
            button.tintColor = UIColor.init(red: 25/255, green: 42/255, blue: 115/255, alpha: 1)
        })
        
        toolBar.isUserInteractionEnabled = true

        suburdText.inputView = picker
        suburdText.inputAccessoryView = toolBar
    }
    
    func initView() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        initViewSevice(flag: flagService)
        applicantLabel.text = UserDefaults.standard.string(forKey: "nombre")
        emailLabel.text = UserDefaults.standard.string(forKey: "email")
        phoneRealNumber.text = UserDefaults.standard.string(forKey: "telefono")
        addLines()
        sickNameText.delegate = self
        familyText.delegate = self
        directionText.delegate = self
        suburdText.delegate = self
        postalCodeText.delegate = self
        justificationText.delegate = self
        familyText.delegate = self
    }
    
    func initViewSevice(flag: Bool) {
        if flag == false {
            mainTitleText.text = "Bendiciones"
            titleLabel.text = "Bendición de casa"
            sickStackView.isHidden = true
            familyStackView.isHidden = false
            justificationStackView.isHidden = true
        }else {
            mainTitleText.text = "Comunión de los enfermos"
            titleLabel.text = "¡Queremos ayudarte!"
            sickStackView.isHidden = false
            familyStackView.isHidden = true
            justificationStackView.isHidden = false
        }
    }
    
    func addLines() {
        sickNameText.addLine(color: .lightGray, width: 0.6)
        directionText.addLine(color: .lightGray, width: 0.6)
        suburdText.addLine(color: .lightGray, width: 0.6)
        postalCodeText.addLine(color: .lightGray, width: 0.6)
        justificationText.addLine(color: .lightGray, width: 0.6)
        familyText.addLine(color: .lightGray, width: 0.6)
    }
    
    func nextTextField(_ textField: UITextField) {
        if flagService == false {
            switch textField {
            case familyText:
                directionText.becomeFirstResponder()
            case directionText:
                suburdRequerid.becomeFirstResponder()
            case suburdText:
                postalCodeText.becomeFirstResponder()
            default:
                familyText.resignFirstResponder()
            }
            } else {
                switch textField {
                case sickNameText:
                    directionText.becomeFirstResponder()
                case directionText:
                    suburdRequerid.becomeFirstResponder()
                case suburdText:
                    postalCodeText.becomeFirstResponder()
                case postalCodeRequerid:
                    justificationText.becomeFirstResponder()
                default:
                    sickRequired.resignFirstResponder()
            }
        }
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func getCoordinates() {
        //Create the search request
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = directionText.text
        
        let activeSearch = MKLocalSearch(request: searchRequest)
        
        activeSearch.start { (response, error) in
            
            UIApplication.shared.endIgnoringInteractionEvents()
            
            if response == nil
            {
                print("ERROR")
            }
            else
            {
                //Getting data
                self.latitude = response?.boundingRegion.center.latitude ?? 0.0
                self.longitude = response?.boundingRegion.center.longitude ?? 0.0
                
                //Create annotation
                let annotation = MKPointAnnotation()
                guard let adress = self.directionText.text else {return}
                annotation.title = "\(adress)"
                annotation.coordinate = CLLocationCoordinate2DMake(self.latitude ?? 0.0, self.longitude ?? 0.0)
            }
            
        }
    }
    
    func saveComuSucces() {
        //creating the notification content
        let content = UNMutableNotificationContent()

        //adding title, subtitle, body and badge
        content.title = "Comunion registrada con éxito"
//        content.subtitle = "iOS Development is fun"
//        content.body = "We are learning about iOS Local Notification"
        content.badge = 1

        //getting the notification trigger
        //it will be called after 5 seconds
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

        //getting the notification request
        let request = UNNotificationRequest(identifier: "SimplifiedIOSNotification", content: content, trigger: trigger)

        //adding the notification to notification center
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        isDataComplete = false
        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func saveComuError() {
        DispatchQueue.main.async { [self] in
            let alert = UIAlertController(title: "Error", message: "Error en el servico, intenta de nuevo más trde", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertAction.Style.default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
        isDataComplete = false
    }
    
    func saveBelssSucces() {
        //creating the notification content
        let content = UNMutableNotificationContent()

        //adding title, subtitle, body and badge
        content.title = "Servicio registrado con éxito"
//        content.subtitle = "iOS Development is fun"
//        content.body = "We are learning about iOS Local Notification"
        content.badge = 1

        //getting the notification trigger
        //it will be called after 5 seconds
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

        //getting the notification request
        let request = UNNotificationRequest(identifier: "SimplifiedIOSNotification", content: content, trigger: trigger)

        //adding the notification to notification center
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        isDataComplete = false
        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func saveBlessError() {
        DispatchQueue.main.async { [self] in
            let alert = UIAlertController(title: "Error", message: "Error en el servico, intenta de nuevo más trde", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertAction.Style.default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
        isDataComplete = false
    }
}

extension UITextField{
   @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
        }
    }
}

//MARK: - TextField Delegate Implementation
extension DetailServiceViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var returnVa: Bool = true
        
        switch textField {
        case sickNameText:
            returnVa = (textField.text?.count ?? 0) <= 60
        case directionText:
            returnVa = (textField.text?.count ?? 0) <= 60
        case suburdText:
            returnVa = (textField.text?.count ?? 0) <= 60
        case postalCodeText:
            let maxLength = 5
            let currentString: NSString = (textField.text ?? "") as NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        //            returnVa = (textField.text?.count ?? 0) <= 4
        case justificationText:
            returnVa = (textField.text?.count ?? 0) <= 60
        case familyText:
            returnVa = (textField.text?.count ?? 0) <= 60
        default:
        break
        
        }
                
        return returnVa
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("textfield delgate")
    
        if textField == suburdText {
            print("Es el suburb field")
            if postalCodeText.text != "" {
                print("Show picker")
 
            }else{
                
                print("Dont show picker")
                suburdText.text = ""
                self.view.endEditing(true)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    let alert = UIAlertController(title: "", message: "Por favor ingresa tu código postal y después selecciona tu colonia", preferredStyle: .alert)
                    let accept = UIAlertAction(title: "Aceptar", style: .default) { (action) in
                        alert.dismiss(animated: true, completion: nil)
                        self.postalCodeText.becomeFirstResponder()
                    }

                    alert.addAction(accept)
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField == postalCodeText {
            if postalCodeText.text != "" {
                DispatchQueue.main.asyncAfter(deadline: .now()) {
                    self.showLoading()
                }
                self.presenter?.requestSububs(zipCode: postalCodeText.text ?? "0")
            }
        }else if textField == directionText {
            getCoordinates()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch textField {
        case postalCodeText:
            self.view.endEditing(true)
            
        case directionText:
            self.postalCodeText.becomeFirstResponder()
            
        default:
            self.nextTextField(textField)
            
        }
       
        return true
    }
}

extension DetailServiceViewController {
    
    func succesRequestSububs(responseData: DetailServiceEntity) {
        print("******** Success from request of sububs **********")
        print(responseData)
        arrayOfSububs = responseData.data!
        picker.delegate = self
        picker.dataSource = self
        if arrayOfSububs.count == 0 {
            suburdText.text = "Codigo postal invalido"
            alertLoader.dismiss(animated: false, completion: nil)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            }
        }else {
            guard  let arrayColony =  arrayOfSububs[0].name else {
                return
            }
            suburdText.text = arrayColony
            alertLoader.dismiss(animated: false, completion: nil)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.suburdText.becomeFirstResponder()
            }
        }
        
    }
    
    func failRequestSububs() {
        print("Error in request of subs")
    }
    
}

extension DetailServiceViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arrayOfSububs.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.arrayOfSububs[row].name
       }

       func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.suburdText.text = self.arrayOfSububs[row].name
       }
    
    
}
