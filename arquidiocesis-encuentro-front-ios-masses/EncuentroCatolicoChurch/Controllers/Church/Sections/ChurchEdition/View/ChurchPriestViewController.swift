//
//  ChurchPriestViewController.swift
//  ChurchPriest_framework
//
//  Created by Ulises Atonatiuh González Hernández on 11/02/21.
//

import Foundation
import UIKit
import IQKeyboardManagerSwift
import AlamofireImage
import AVFoundation

class ChurchPriestViewController: BaseViewController {
    
    var churchDetailFill: ChurchDetail?
    //MARK: - VIPER variables
    var presenter: ChurchPriestPresenterProtocol?
    
    //MARK: - Local variables
    var churchId: Int?
    var selectedMasses: Array<ChurchDetail.Masses> = Array()
    var selectedServices: Array<ChurchDetail.Service>  = Array()
    var selectedPriest: Array<ChurchDetail.Parson> = Array()
    let imagePicker = UIImagePickerController()
    var servicesCatalog: [ChurchDetail.Service] = Array()
    var massesCatalog: [ChurchDetail.Attention] = Array()
    
    //MARK: - IBOutlets
    @IBOutlet weak var churchImage: UIImageView!
    @IBOutlet weak var churchNameTextField: UILabel!
    @IBOutlet weak var txtDescripcion: UITextField!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var txtSacerdote: UITextField!
    @IBOutlet weak var daysPickerTextField: DaysPickerTextField!
    @IBOutlet weak var hoursPickerTextField: HourPickerTextField!
    @IBOutlet weak var officeDaysPickerTextField: DaysPickerTextField!
    @IBOutlet weak var officeHoursPickerTextField: HourPickerTextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtNumeroContacto: UITextField!
    @IBOutlet weak var pickerMisas: PickerViewTextField!
    @IBOutlet weak var massesCollectionView: UICollectionView!
    @IBOutlet weak var switchEnVivo: UISwitch!
    @IBOutlet weak var liveTransmissionUrlTextField: UITextField!
    @IBOutlet weak var pickerServicios: PickerViewTextField!
    @IBOutlet weak var servicesCollectionView: UICollectionView!
    @IBOutlet weak var txtNombreSacerdote: UITextField!
    @IBOutlet weak var txtNumeroDeCuenta: UITextField!
    @IBOutlet weak var otherPriestTableView: UITableView!
    @IBOutlet weak var otherPriestTableViewHeightConstraint: NSLayoutConstraint!
    
    
    
    private var maxLengthEmail = 60
    private var maxLengthName = 60
    private var maxLengthApellidos = 60
    private var maxLengthTelefono = 10
    private var maxLengthCuenta = 16
    
    //MARK: - IBActions
    @IBAction func editPhotoAction() {
        let alert = UIAlertController(title: "App encuentro", message: "Selecciona una método para obtener la imagen", preferredStyle: UIAlertController.Style.actionSheet)
        
        let galery = UIAlertAction(title: "Seleccionar foto", style: .default) {
            [weak self] UIAlertAction in
            if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
                self?.imagePicker.delegate = self
                self?.imagePicker.sourceType = .savedPhotosAlbum
                self?.imagePicker.allowsEditing = false
                if let imagePicker = self?.imagePicker {
                    self?.present(imagePicker, animated: true, completion: nil)
                }
            }
        }
        
        let camera = UIAlertAction(title: "Tomar foto", style: .default) {
            [weak self] UIAlertAction in
            
            self?.imagePicker.allowsEditing = true
            self?.imagePicker.sourceType = .camera
            self?.imagePicker.delegate = self
            
            switch AVCaptureDevice.authorizationStatus(for: AVMediaType.video) {
            case .authorized:
                DispatchQueue.main.async() {
                    if let imagePicker = self?.imagePicker {
                        self?.present(imagePicker, animated: true, completion: nil)
                    }
                }
            case .denied, .restricted:
                self?.showMessage("No se pudo acceder a la cámara\nRevisa tus ajustes.")
            case .notDetermined:
                AVCaptureDevice.requestAccess(for: AVMediaType.video, completionHandler: {
                    [weak self]
                    (granted :Bool) -> Void in
                    if granted == true {
                        DispatchQueue.main.async() {
                            if let imagePicker = self?.imagePicker {
                                self?.present(imagePicker, animated: true, completion: nil)
                            }
                        }
                    } else {
                        self?.showMessage("No se pudo acceder a la cámara\nRevisa tus ajustes.")
                    }
                });
            @unknown default:
                self?.showMessage("No se pudo acceder a la cámara\nRevisa tus ajustes.")
            }
            
        }
        
        let deletePhoto = UIAlertAction(title: "Eliminar foto", style: .destructive) {
            _ in
            self.churchImage.image = UIImage(named: "church-placeholder", in: Bundle(for: ChurchPriestViewController.self), compatibleWith: nil)
        }
        
        let cancel = UIAlertAction(title: "Cancelar", style: .cancel)
        
        
        alert.addAction(galery)
        if UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            alert.addAction(camera)
        }
        alert.addAction(cancel)
        alert.addAction(deletePhoto)
        
        present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func returnTo(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func editOfficeDaysAction() {
        officeDaysPickerTextField.becomeFirstResponder()
    }
    
    @IBAction func editOfficeHoursAction() {
        officeHoursPickerTextField.becomeFirstResponder()
    }
    
    @IBAction func editDaysAction() {
        daysPickerTextField.becomeFirstResponder()
    }
    
    @IBAction func editHoursAction() {
        hoursPickerTextField.becomeFirstResponder()
    }
    
    @IBAction func changeLiveTransmissionSwitch(_ sender: UISwitch) {
        liveTransmissionUrlTextField.isHidden = !sender.isOn
    }
    
    @IBAction func addPriestAction() {
//        if let priestName = txtNombreSacerdote.text, !priestName.isEmpty,
//           let accountNumber = txtNumeroDeCuenta.text, !accountNumber.isEmpty {
//            let priest = ChurchDetail.Parson(id: 0,
//                                             appointment: "",
//                                             name: priestName,
//                                             firstSurname: accountNumber,
//                                             secondSurname: "")
//            selectedPriest.insert(priest, at: 0)
//            txtNombreSacerdote.text = nil
//            txtNumeroDeCuenta.text = nil
//            otherPriestTableView.reloadData()
//            view.endEditing(true)
//        } else {
//            showMessage("Por favor llena los datos nacesarios para agregar un nuevo sacerdote")
//        }
    }
    
    @IBAction func saveAction() {
        showLoader()
        let updateRequest = ChurchEditionRequest()
        presenter?.updateChurchData(id: churchId ?? 1, updateRequest)
    }
    
  
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
//
    
        setDelegates()
        initUI()
        setData(dataPriest: churchDetailFill)
        
        guard let massesReady = churchDetailFill?.masses else {
            return
        }
        
        guard let servicesReady = churchDetailFill?.services else {
            return
        }
        self.massesCatalog = massesReady
        self.servicesCatalog = servicesReady
//        DispatchQueue.global().async {
//            self.presenter?.getDataInteractor(id: "1", idChurch: "1")
//        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("VC ECChurch - ChurchEdition - ChurchPriestVC ")
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    
        if !selectedPriest.isEmpty,
           otherPriestTableViewHeightConstraint.constant != otherPriestTableView.contentSize.height {
            otherPriestTableViewHeightConstraint.constant = otherPriestTableView.contentSize.height
            otherPriestTableView.layoutIfNeeded()
        }
    }
    
    //MARK: - View controls
    private func initUI() {
        IQKeyboardManager.shared.enable = true
        
        self.addLineTextFields()
        
        self.txtEmail.tag = 1
        self.txtSacerdote.tag = 2
        self.txtDescripcion.tag = 3
        self.txtNombreSacerdote.tag = 4
        self.txtNumeroContacto.tag = 5
        self.txtNumeroDeCuenta.tag = 6
        
        self.txtNumeroDeCuenta.keyboardType = .numberPad
        self.txtNumeroContacto.keyboardType = .numberPad
        
        switchEnVivo.isOn = false
        liveTransmissionUrlTextField.isHidden = true
        massesCollectionView.isHidden = true
        servicesCollectionView.isHidden = true
        otherPriestTableView.isHidden = true
        
        otherPriestTableView.register(PriestTableViewCell.nib,
                                      forCellReuseIdentifier: PriestTableViewCell.reuseIdentifier)
        
        massesCollectionView.register(ServiceCollectionViewCell.nib,
                                      forCellWithReuseIdentifier: ServiceCollectionViewCell.reuseIdentifier)
        servicesCollectionView.register(ServiceCollectionViewCell.nib,
                                      forCellWithReuseIdentifier: ServiceCollectionViewCell.reuseIdentifier)
        
        otherPriestTableView.dataSource = self
        otherPriestTableView.delegate = self
        
        massesCollectionView.dataSource = self
        massesCollectionView.delegate = self
        
        servicesCollectionView.dataSource = self
        servicesCollectionView.delegate = self
        
        pickerMisas.addRightLeftOnKeyboardWithTarget(self,
                                                     leftButtonTitle: "Cerrar",
                                                     rightButtonTitle: "Agregar",
                                                     leftButtonAction: #selector(closePicker),
                                                     rightButtonAction: #selector(addMass))
        
        pickerServicios.addRightLeftOnKeyboardWithTarget(self,
                                                         leftButtonTitle: "Cerrar",
                                                         rightButtonTitle: "Agregar",
                                                         leftButtonAction: #selector(closePicker),
                                                         rightButtonAction: #selector(addService))
        
        hoursPickerTextField.initialize()
        daysPickerTextField.initialize()
        officeHoursPickerTextField.initialize()
        officeDaysPickerTextField.initialize()
    }
    
    
    private func addLineTextFields() {
        self.txtEmail.addLine(color: .lightGray, width: 2)
        self.txtSacerdote.addLine(color: .lightGray, width: 2)
        self.txtDescripcion.addLine( color: .lightGray, width: 2)
        self.txtNombreSacerdote.addLine( color: .lightGray, width: 2)
        self.txtNumeroContacto.addLine( color: .lightGray, width: 2)
        self.txtNumeroDeCuenta.addLine( color: .lightGray, width: 2)
        //
    }
    
    private func isError(msg: String) {
        removeLoader()
        self.showAlert(title: "Error", msg: msg)
    }
    
    
    
    private func setData(dataPriest: ChurchDetail?) {
        
        if let url = URL(string: dataPriest?.image_url ?? "") {
            churchImage.af.setImage(withURL: url)
        }
        churchNameTextField.text = dataPriest?.name
        txtDescripcion.text = dataPriest?.description
        addressLabel.text = dataPriest?.address
        txtSacerdote.text = dataPriest?.parson?.name
        daysPickerTextField.text = dataPriest?.horary?.first?.days?.first?.name
        hoursPickerTextField.text = dataPriest?.horary?.first?.hour_start
        officeDaysPickerTextField.text = dataPriest?.attention?.first?.days?.first?.name
        officeHoursPickerTextField.text = dataPriest?.attention?.first?.hour_end
        txtEmail.text = dataPriest?.email
        txtNumeroContacto.text = dataPriest?.phone
        selectedMasses = dataPriest?.masses as! Array<ChurchDetail.Masses>
        liveTransmissionUrlTextField.text = dataPriest?.stream
        liveTransmissionUrlTextField.isHidden = liveTransmissionUrlTextField.text == ""
        switchEnVivo.isOn = liveTransmissionUrlTextField.text != ""
        selectedServices = dataPriest?.services ?? Array()
        selectedPriest = dataPriest?.priests ?? Array()
        
        massesCollectionView.reloadData()
        servicesCollectionView.reloadData()
        otherPriestTableView.reloadData()
        
      
        let nameMasess = massesCatalog.first?.days.map({$0.map({$0.name ?? ""})}) 
       // let nameServices = servicesCatalog.first.
        pickerMisas.pickOptions = nameMasess ?? []
        pickerServicios.pickOptions = ["Service", "Service 1"]
        
        pickerMisas.initialize()
        pickerServicios.initialize()
        
        removeLoader()
    }
    
    ///Picker functions
    @objc func closePicker() {
        pickerServicios.text = nil
        pickerMisas.text = nil
        pickerServicios.resignFirstResponder()
        pickerMisas.resignFirstResponder()
    }
    
    @objc func addMass() {
//        if let selectedMass = massesCatalog[safe: pickerMisas.pickerView.selectedRow(inComponent: 0)] {
//            let mass = ChurchDetail.Mass(id: selectedMass.id,
//                                         icon: "https://img.icons8.com/ios-glyphs/2x/church.png",
//                                         name: selectedMass.name,
//                                         days: "Lunes-Viernes",
//                                         hours: "9:30 hrs, 12:00 hrs, 13:00 hrs, 18:00 hrs")
//            selectedMasses.insert(mass, at: 0)
//            massesCollectionView.reloadData()
//        }
//
//        pickerMisas.text = nil
//        pickerMisas.resignFirstResponder()
    }
    
    @objc func addService() {
//        if let selectedService = servicesCatalog[safe: pickerServicios.pickerView.selectedRow(inComponent: 0)] {
//            let service = ChurchDetail.Service(id: selectedService.id,
//                                               icon: selectedService.icon,
//                                               name: selectedService.name,
//                                               day: "Lunes-Miercoles",
//                                               hours: "9:30 hrs, 12:00 hrs")
//            
//            selectedServices.insert(service, at: 0)
//            servicesCollectionView.reloadData()
//        }
//        
//        pickerServicios.text = nil
//        pickerServicios.resignFirstResponder()
    }
    
    
    private func setDelegates() {
            self.txtEmail.delegate = self
            self.txtDescripcion.delegate = self
            self.txtSacerdote.delegate = self
            self.txtNombreSacerdote.delegate = self
            self.txtNumeroContacto.delegate = self
            self.txtNumeroDeCuenta.delegate = self
        
        self.txtNumeroDeCuenta.addTarget(self, action: #selector(didChangeText(textField:)), for: .editingChanged)
  
        }
    
    @objc func didChangeText(textField:UITextField) {
            textField.text = self.modifyCreditCardString(creditCardString: textField.text!)
        }
    
   private func modifyCreditCardString(creditCardString : String) -> String {
            let trimmedString = creditCardString.components(separatedBy: "-").joined()
            
            let arrOfCharacters = Array(trimmedString)
            var modifiedCreditCardString = ""
            
            if(arrOfCharacters.count > 0) {
                for i in 0...arrOfCharacters.count-1 {
                    modifiedCreditCardString.append(arrOfCharacters[i])
                    if((i+1) % 4 == 0 && i+1 != arrOfCharacters.count){
                        modifiedCreditCardString.append("-")
                    }
                }
            }
            return modifiedCreditCardString
        }

    
}

//MARK: - Text field delegates

//MARK: - View protocol
extension ChurchPriestViewController: ChurchPriestViewProtocol {
    
    func succesUpdate(response: ChurchEditionResponse?) {
        removeLoader()
        showMessage("Actualización correcta") {
            [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
    }
    
    func isSuccess(churchDetail: ChurchDetail?, servicesCatalog: Array<ServiceCatalogItem>?, massesCatalog: Array<MassesCatalogItem>?) {
//        self.massesCatalog = massesCatalog ?? Array()
//        self.servicesCatalog = servicesCatalog ?? Array()
//        setData(dataPriest: churchDetail)
    }
    
    func showError(message: String) {
        self.isError(msg: message)
    }

}

//MARK: - Collection view delegates
extension ChurchPriestViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        var numberOfItems = 0
        
        switch collectionView {
        case massesCollectionView:
            numberOfItems = selectedMasses.count
            massesCollectionView.isHidden = numberOfItems == 0
        case servicesCollectionView:
            numberOfItems = selectedServices.count
            servicesCollectionView.isHidden = numberOfItems == 0
        default:
            break
        }
        
        return numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ServiceCollectionViewCell.reuseIdentifier,
                                                      for: indexPath)
        
        
        (cell as? ServiceCollectionViewCell)?.delegate = self
        switch collectionView {
        case massesCollectionView:
            break
          //  (cell as? ServiceCollectionViewCell)?.fill(with: selectedMasses[safe: indexPath.row], index: indexPath.row)
        case servicesCollectionView:
            break
           // (cell as? ServiceCollectionViewCell)?.fillService(with: selectedServices.first, index: indexPath.row)
        default:
            break
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height: CGFloat = collectionView.frame.size.height - 15
        let width: CGFloat = 215
        
        return CGSize(width: width, height: height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}

//MARK: - Service Cell Delegate
extension ChurchPriestViewController: ServiceCellDelegate {
    
    func editHours(collectionView: UICollectionView, at indexPath: IndexPath, hours: String) {
        print("TODO: - IMPLEMENT EDIT \(hours)")
    }
    
    func editDays(collectionView: UICollectionView, at indexPath: IndexPath, days: String) {
        print("TODO: - IMPLEMENT EDIT \(days)")
    }
    
    func delete(collectionView: UICollectionView, at indexPath: IndexPath) {
        switch collectionView {
        case servicesCollectionView:
            selectedServices.remove(at: indexPath.item)
            servicesCollectionView.reloadData()
        case massesCollectionView:
            selectedMasses.remove(at: indexPath.item)
            massesCollectionView.reloadData()
        default:
            break
        }
        
        print("TODO: - IMPLEMENT DELETE")
    }
    
    
}

//MARK: - TableView delegates
extension ChurchPriestViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let priestData = selectedPriest[safe: indexPath.row]?.name ?? ""
        
        let alert = UIAlertController(title: "Iglesia Digital", message: "Se eliminara:\n\(priestData)", preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel)
        let deleteAction = UIAlertAction(title: "Borrar", style: .destructive) {
            [weak self]
            _ in
            self?.selectedPriest.remove(at: indexPath.row)
            self?.otherPriestTableView.reloadData()
        }
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
}

extension ChurchPriestViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfRows = selectedPriest.count
        otherPriestTableView.isHidden = numberOfRows == 0
        
        return selectedPriest.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: PriestTableViewCell.reuseIdentifier,
                                                  for: indexPath)
        
        (cell as? PriestTableViewCell)?.fill(with: selectedPriest[safe: indexPath.row])
        
        return cell
    }
    
}

//MARK: - Image picker delegate
extension ChurchPriestViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            return
        }
        churchImage.image = image
        picker.dismiss(animated: true)
    }
}


extension ChurchPriestViewController: UITextFieldDelegate {
   
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text!.isEmpty {
            textField.shake()
        }
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        
        switch textField.tag {
        case 1...4:
            if range.location > self.maxLengthName - 1 {
                textField.text?.removeLast()
            }
            break
            
        case 5:
            if range.location > self.maxLengthTelefono - 1 {
                textField.text?.removeLast()
            }
            break
            
        case 6:
            if range.location > self.maxLengthCuenta - 1 {
                textField.text?.removeLast()
            }
            break
            
        default:
            break
        }
       

        return true
    }
}
