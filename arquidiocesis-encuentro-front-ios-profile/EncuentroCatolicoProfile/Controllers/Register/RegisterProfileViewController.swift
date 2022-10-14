//
//  RegisterProfileViewController.swift
//  EncuentroCatolicoProfile
//
//  Created by Miguel Eduardo  Valdez Tellez  on 28/02/21.
//

import Foundation
import UIKit
import IQKeyboardManagerSwift

class RegisterProfileViewController: BaseViewController, ProfileInfoViewProtocol{
    
    func successPrefix(data: PrefixResponse) {
        print(data)
    }
    
    func failPrefix(message: String) {
        
    }

    func successDiacano() {
        
    }
    
    func failDiacano() {
    }
    
    func successLaicoReligioso() {
    }
    
    func failLaicoReligioso() {
    }
    
    func showServices(services: ServiceResponse) {
    }
    
    
    func showStatesResponnse() {
    }
    
    func showCongregationResponse() {
    }

    
    func showLifeStates(lifeStates: StatesResponse) {
        //
    }
    
    func showTopics(topics: TopicsResponse) {
        //
    }
    
    func reloadPromisse(promisse: [PromiseModel]) {
        
    }
    
    func reloadPromisse() {
        
    }
    
    func mostrarInfo(dtcAlerta: [String : String]?, user: UserRespProfile?) {
        
    }
    
    func showUserInfo(user: UserRespProfile) {
        
    }

    func mostrarMSG(dtcAlerta: [String : String]) {
        
    }
    
    func succesUpload64(responseData: UploadImageData) {
        
    }
    
    func failUpload64() {
        
    }
    
    func succesGetDetailProfile(responseData: ProfileDetailImg) {
        
    }
    
    func failGetDataProfile() {
        
    }
    
    //MARK: - IBOutlets
    @IBOutlet weak var descriptionTextOutlet: UITextField!
    @IBOutlet weak var lastNameRequired: UILabel!
    @IBOutlet weak var otherTextOutlet: UITextField!
    @IBOutlet weak var otherStackView: UIStackView!
    @IBOutlet weak var dateRequired: UILabel!
    @IBOutlet weak var pickerRequired: UILabel!
    @IBOutlet weak var emailRequired: UILabel!
    @IBOutlet weak var urlRequired: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var nameRequired: UILabel!
    @IBOutlet weak var firstLastNameTextField: UITextField!
    @IBOutlet weak var secondLastNameTextField: UITextField!
    @IBOutlet weak var birthdayPicker: DatePickerTextField!
    @IBOutlet weak var orditionPicker: DatePickerTextField!
    @IBOutlet weak var activitesPicker: PickerViewTextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var urlTextField: UITextField!
    @IBOutlet weak var ordenReligiosaPicker: PickerViewTextField!
    @IBOutlet weak var stackViewOrdenReligioso: UIStackView!
    @IBOutlet weak var ReligiosoTextOutlet: UIButton!
    @IBOutlet weak var diocesanoTextOutlet: UIButton!
    @IBOutlet weak var diocesanoPointBlueOutlet: UIImageView!
    @IBOutlet weak var ReligiosoPointBlueOutlet: UIImageView!
    
    //MARK: - IBActions
    
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveButton(_ sender: Any) {
        let alert = UIAlertController(title: "App Encuentro", message: "Se modificaran tus datos", preferredStyle: .actionSheet)
        
        let cancel = UIAlertAction(title: "Cancelar", style: .cancel)
        
        let accept = UIAlertAction(title: "Aceptar", style: .default, handler: {
            [weak self]
            _ in
            self?.updateData()
        })
        
        alert.addAction(accept)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
    
    @IBAction func religiosoAction(_ sender: Any) {
        flagDiocesanoReligioso = true
        ReligiosoPointBlueOutlet.isHidden = false
        ReligiosoTextOutlet.setTitleColor(.eMainBlue, for: .normal)
        diocesanoPointBlueOutlet.isHidden = true
        diocesanoTextOutlet.setTitleColor(.eLightGray, for: .normal)
        stackViewOrdenReligioso.isHidden = false
        otherStackView.isHidden = true
        activitesPicker.text = ""
        otherTextOutlet.text = ""
    }
    @IBAction func diocesanoAction(_ sender: Any) {
        flagDiocesanoReligioso = true
        ReligiosoPointBlueOutlet.isHidden = true
        ReligiosoTextOutlet.setTitleColor(.eLightGray, for: .normal)
        diocesanoPointBlueOutlet.isHidden = false
        diocesanoTextOutlet.tintColor = .eMainBlue
        diocesanoTextOutlet.setTitleColor(.eMainBlue, for: .normal)
        stackViewOrdenReligioso.isHidden = true
        otherStackView.isHidden = true
        activitesPicker.text = ""
        otherTextOutlet.text = ""
    }
    
    @IBAction func activitesPickerAction(_ sender: Any) {
        activitesPicker.becomeFirstResponder()
    }
    
    @IBAction func ordenPickerAction(_ sender: Any) {
        ordenReligiosaPicker.becomeFirstResponder()
    }
    @IBAction func addOtherButton(_ sender: Any) {
//        let activityResponse = ActivitiesResponse(name: otherTextField.text ?? "", id: 7)
//        let activityOtherResponse = ActivitiesOtherResponse(id: 7, name: otherTextField.text ?? "")
//        activitiesArray.append(activityResponse)
//        activitiesResponseService.append(activityOtherResponse)
//        self.pickerPlus.isHidden = true
//        otherTextField.text = nil
//        //activitiesColletionView.reloadData()
//        otherTextField.resignFirstResponder()
    }
    
    //MARK:- Local variables
    var presenter: ProfileInfoPresenterProtocol?
    var activitiesArray: Array<ActivitiesResponse> = Array()
    var activitiesIdArray: [ActivitiesResponse] = []
    var activitiesResponseService: [ActivitiesOtherResponse] = []
    var activitySeleted: ActivitiesResponse?
    var activityNewSelect: Array<Activity> = Array()
    
    var congreNewSelect: Array<Congregation> = Array()
    
    var flagDiocesanoReligioso = false
    var congregationArray: CongregationsResponse?
    var congregationIdArray: CongregationsResponse?
    var congregationSeleted: CongregationsResponse?
    
    
    var congregationNewArray: Array<CongregationsResponse> = Array()
    var congregationNewIdArray: [CongregationsResponse] = []
    var congregationNewSeleted: Array<CongregationsResponse>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        initView()
        initContent()
        print(UserDefaults.standard.integer(forKey: "id"))
        }
    

    //MARK: - View controls
    private func initContent()
    {
        IQKeyboardManager.shared.enable = true
        birthdayPicker.initialize()
        orditionPicker.initialize()
        activitesPicker.initialize()
        ordenReligiosaPicker.initialize()
        presenter?.cargarDatosUsuario()
        presenter?.getOffice()
        presenter?.getCongregations()
        presenter?.getDetalles()
        presenter?.getLifeStates()
        presenter?.getTopics()
    }
    
    private func initView()
    {
//        activitiesColletionView.register(ActivitiesCardCollectionViewCell.nib, forCellWithReuseIdentifier: ActivitiesCardCollectionViewCell.reuseIdentifier)
//        activitiesColletionView.dataSource = self
//        activitiesColletionView.delegate = self
        addLines()
        ///TextFieleDelegate
        nameTextField.delegate = self
        firstLastNameTextField.delegate = self
        secondLastNameTextField.delegate = self
        emailTextField.delegate = self
        ///TextViewDelegate
        //otherTextField.delegate = self
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    private func addLines() {
        self.descriptionTextOutlet.addLine(color: .lightGray, width: 0.6)
        self.nameTextField.addLine(color: .lightGray, width: 0.6)
        self.firstLastNameTextField.addLine(color: .lightGray, width: 0.6)
        self.secondLastNameTextField.addLine(color: .lightGray, width: 0.6)
        self.emailTextField.addLine(color: .lightGray, width: 0.6)
        self.urlTextField.addLine(color: .lightGray, width: 0.6)
        self.activitesPicker.addLine(color: .lightGray, width: 0.6)
        self.ordenReligiosaPicker.addLine(color: .lightGray, width: 0.6)
        self.otherTextOutlet.addLine(color: .lightGray, width: 0.6)
    }
    
    func nextTextField(_ textField: UITextField) {
        switch textField {
        case nameTextField:
            firstLastNameTextField.becomeFirstResponder()
        case firstLastNameTextField:
            secondLastNameTextField.becomeFirstResponder()
        case secondLastNameTextField:
            descriptionTextOutlet.becomeFirstResponder()
        case descriptionTextOutlet:
            emailTextField.becomeFirstResponder()
        case emailTextField:
            birthdayPicker.becomeFirstResponder()
        case birthdayPicker:
            orditionPicker.becomeFirstResponder()
        case activitesPicker:
            urlTextField.becomeFirstResponder()
        default:
            urlTextField.resignFirstResponder()
        }
    }

    
    func showOffice(offices: Array<ActivitiesResponse>) {
        activitiesIdArray = offices
        activitesPicker.pickOptions = offices.map({$0.name})
        activitesPicker.closure = {index in
            self.activitySeleted = self.activitiesIdArray[index]
        }
        activitesPicker.addRightLeftOnKeyboardWithTarget(self,leftButtonTitle: "Cerrar", rightButtonTitle: "Agregar", leftButtonAction: #selector(closeActivitiesPicker), rightButtonAction: #selector(addActivity))
        activitesPicker.initialize()
    }
    
    func showCongregations(congregation: CongregationsResponse) {
        congregationIdArray = congregation
        ordenReligiosaPicker.pickOptions = congregation.data.map({$0.descripcion})
        ordenReligiosaPicker.closure = {index in
           // self.congregationSeleted = self.congregationIdArray.data[index]
        }
        ordenReligiosaPicker.addRightLeftOnKeyboardWithTarget(self,leftButtonTitle: "Cerrar", rightButtonTitle: "", leftButtonAction: #selector(closeCongrePicker), rightButtonAction: #selector(closeCongrePicker))
        ordenReligiosaPicker.initialize()
    }
    
    func showDetalles(detail: DetailProfile) {
        nameTextField.text = detail.data?.User?.name
        firstLastNameTextField.text = detail.data?.User?.first_surname
        secondLastNameTextField.text = detail.data?.User?.second_surname
        emailTextField.text = detail.data?.User?.email
    }
    
    //funciones para picker
    @objc func closeActivitiesPicker() {
        activitesPicker.resignFirstResponder()
    }
    
    @objc func closeCongrePicker() {
        ordenReligiosaPicker.resignFirstResponder()
    }
    
    @objc func addActivity() {
        if activitySeleted?.name == "Otros" {
            self.otherStackView.isHidden = false
        }else {
            self.otherStackView.isHidden = true
            otherTextOutlet.text = nil
            if let activitySeleted = self.activitySeleted {
                let ids = activitiesArray.map({$0.id})
                if ids.contains(activitySeleted.id){
                    let alert = UIAlertController(title: "Actividad repetida", message: "La actividad ya se encuetra agregada", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: nil))
                    self.present(alert, animated: true)
                }else{
                    let activityOther = ActivitiesOtherResponse(id: activitySeleted.id, name: activitySeleted.name)
                    let activityNew: Activity = Activity(id: activitySeleted.id,name: activitySeleted.name)
                    self.activitiesArray.append(activitySeleted)
                    self.activityNewSelect.append(activityNew)
                    self.activitiesResponseService.append(activityOther)
                }
            }
            print(activityNewSelect)
        }
        activitesPicker.resignFirstResponder()
    }
    
    func showError(error: String) {
        DispatchQueue.main.async { [self] in
            let alert = UIAlertController(title: "App Encuentro", message: "Verifica que cancillería tenga tus datos, en caso de duda o aclaración enviar correo electrónico a la siguiente dirección cancilleria@arquidiocesismexico.org para que se autorice tu registro", preferredStyle: .alert)
            let accept = UIAlertAction(title: "Aceptar", style: .default)
            alert.addAction(accept)
            present(alert, animated: true)
        }
    }
    
    private func updateData() {
        if let name = nameTextField.text, !name.isEmpty,
           let firstLastName = firstLastNameTextField.text, !firstLastName.isEmpty,
           let secondLastName = secondLastNameTextField.text, !secondLastName.isEmpty,
           let description = descriptionTextOutlet.text,
           let birthDate = birthdayPicker.text, !birthDate.isEmpty,
           let ordinationDate = orditionPicker.text, !ordinationDate.isEmpty,
           let email = emailTextField.text, !email.isEmpty,
           let activities = activitesPicker.text, !activities.isEmpty,
           let url = urlTextField.text
        {
            
            var birthDate: Date!
            var birthDateFormat: String!
            if birthdayPicker.selectedDate != Date(){
                birthDate = birthdayPicker.selectedDate
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                let dateString = dateFormatter.string(from: birthDate)
                birthDateFormat = dateString
            }
            
            var ordinationDate: Date!
            var ordinationDateFormat: String!
            if orditionPicker.selectedDate != Date(){
                ordinationDate = orditionPicker.selectedDate
                let ordinationFormatter = DateFormatter()
                ordinationFormatter.dateFormat = "yyyy-MM-dd"
                let ordinationString = ordinationFormatter.string(from: ordinationDate)
                ordinationDateFormat = ordinationString
            }
            
            //TEST
            let idGloba = UserDefaults.standard.integer(forKey: "id")
            let life: Status = Status(id: 7, name: "")
            let congre: Congregation = Congregation(id: 1, name: "")
            let phone = UserDefaults.standard.string(forKey: "telefono") ?? ""
            
            var topic: [Topics] = []
            let topic1 = Topics(id: 1,name: "")
            topic.append(topic1)
            
            var loca: [Locations] = []
            let loca1 = Locations(id: 1)
            loca.append(loca1)
            
            let prefixID  = UserDefaults.standard.integer(forKey: "Prefix")
            let prefixObject = Prefix(id: prefixID)
            
            if flagDiocesanoReligioso == true {
                var registerDiocecsanoReli: ProfilePriest = ProfilePriest(username: emailTextField.text ?? "", id: idGloba, name: nameTextField.text ?? "", first_surname: firstLastNameTextField.text ?? "", second_surname: secondLastNameTextField.text ?? "", phone_number: phone, email: emailTextField.text ?? "", life_status: life, interest_topics: topic, birthdate: birthDateFormat, ordination_date: ordinationDateFormat, description: descriptionTextOutlet.text ?? "", position: "Without", congregation: congre, activities: activityNewSelect, stream: urlTextField.text ?? "")
                
                if prefixID != 0 {
                    registerDiocecsanoReli = ProfilePriest(username: emailTextField.text ?? "", id: idGloba, name: nameTextField.text ?? "", first_surname: firstLastNameTextField.text ?? "", second_surname: secondLastNameTextField.text ?? "", phone_number: phone, email: emailTextField.text ?? "", life_status: life, prefix: prefixObject, interest_topics: topic, birthdate: birthDateFormat, ordination_date: ordinationDateFormat, description: descriptionTextOutlet.text ?? "", position: "Without", congregation: congre, activities: activityNewSelect, stream: urlTextField.text ?? "")
                }
                presenter?.postSacerdote(request: registerDiocecsanoReli)
                
            } else if flagDiocesanoReligioso == false {
                var  registerSacerdote: ProfilePriest = ProfilePriest(username: emailTextField.text ?? "", id: idGloba, name: nameTextField.text ?? "", first_surname: firstLastNameTextField.text ?? "", second_surname: secondLastNameTextField.text ?? "", phone_number: phone, email: emailTextField.text ?? "", life_status: life, interest_topics: topic, birthdate: birthDateFormat, ordination_date: ordinationDateFormat, description: descriptionTextOutlet.text ?? "", position: "Without", congregation: congre, activities: activityNewSelect, stream: urlTextField.text ?? "")
                if prefixID != 0 {
                    registerSacerdote = ProfilePriest(username: emailTextField.text ?? "", id: idGloba, name: nameTextField.text ?? "", first_surname: firstLastNameTextField.text ?? "", second_surname: secondLastNameTextField.text ?? "", phone_number: phone, email: emailTextField.text ?? "", life_status: life, prefix: prefixObject, interest_topics: topic, birthdate: birthDateFormat, ordination_date: ordinationDateFormat, description: descriptionTextOutlet.text ?? "", position: "Without", congregation: congre, activities: activityNewSelect, stream: urlTextField.text ?? "")
                }
                presenter?.postSacerdote(request: registerSacerdote)
            }

        }
        else {
            if let name = nameTextField.text, name.isEmpty{
                nameRequired.isHidden = false
            }
            if let firstLastName = firstLastNameTextField.text, firstLastName.isEmpty{
                lastNameRequired.isHidden = false
                
            }
            if let secondLastName = secondLastNameTextField.text, secondLastName.isEmpty{
                lastNameRequired.isHidden = false
                
            }
            if let email = emailTextField.text, email.isEmpty{
                emailRequired.isHidden = false
                
            }
            if let birthDate = birthdayPicker.text, birthDate.isEmpty{
                dateRequired.isHidden = false
                
            }
            if let ordinationDate = orditionPicker.text, ordinationDate.isEmpty{
                dateRequired.isHidden = false
                
            }
            if let activities = activitesPicker.text, activities.isEmpty{
                pickerRequired.isHidden = false
                
            }
           
            
            let alert = UIAlertController(title: "Campos vacios", message: "Uno o varios campos vacios", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Intenta de nuevo", style: .default, handler: nil))
            self.present(alert, animated: true)
            
        }
        
        
    }
    
    func showRegisterResponse(response: RegisterPriestResponse) {
        DispatchQueue.main.async { [self] in
            let alert = UIAlertController(title: "App Encuentro", message: "Se guardaron sus datos correctamente", preferredStyle: .alert)
            let accept = UIAlertAction(title: "Aceptar", style: .default, handler: {
                [weak self]
                _ in
                self?.navigationController?.popViewController(animated: true)
            })
            alert.addAction(accept)
            present(alert, animated: true)
        }
    }
    
    func showDiaconoResponse() {
        DispatchQueue.main.async { [self] in
            let alert = UIAlertController(title: "App Encuentro", message: "Se guardaron sus datos correctamente", preferredStyle: .alert)
            let accept = UIAlertAction(title: "Aceptar", style: .default, handler: {
                [weak self]
                _ in
                self?.navigationController?.popViewController(animated: true)
            })
            alert.addAction(accept)
            present(alert, animated: true)
        }
    }
    
    func showSacerdoteResponse() {
        DispatchQueue.main.async { [self] in
            let alert = UIAlertController(title: "App Encuentro", message: "Se guardaron sus datos correctamente", preferredStyle: .alert)
            let accept = UIAlertAction(title: "Aceptar", style: .default, handler: {
                [weak self]
                _ in
                let singleton = ProfileInfoView.sinleton
                singleton.isPresentPriestAlert = true
                UserDefaults.standard.set("sacerdote", forKey: "profile")
                self?.navigationController?.popViewController(animated: true)
            })
            alert.addAction(accept)
            present(alert, animated: true)
            
        }
    }
    
    @IBAction func goBack(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true)
    }
}



extension RegisterProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return activitiesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ActivitiesCardCollectionViewCell.reuseIdentifier, for: indexPath)
        let activity = activitiesArray[indexPath.item]
        (cell as? ActivitiesCardCollectionViewCell)?.delegate = self
        (cell as? ActivitiesCardCollectionViewCell)?.activitiesNameLabel.text = activity.name
        return cell
    }
    
    
}

extension RegisterProfileViewController: ActivitiesCardDelegate{
    func deleteActivity(index: IndexPath) {
        activitiesArray.remove(at: index.item)
        //activitiesColletionView.reloadData()
    }
}

//MARK: - TextField Delegate Implementation
extension RegisterProfileViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var returnVa: Bool = true
        
        switch textField {
        case nameTextField:
            returnVa = (textField.text?.count ?? 0) <= 60
        case firstLastNameTextField:
            returnVa = (textField.text?.count ?? 0) <= 60
        case secondLastNameTextField:
            returnVa = (textField.text?.count ?? 0) <= 60
        case emailTextField:
            returnVa = (textField.text?.count ?? 0) <= 60
        default:
            break
        }
        return returnVa
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case emailTextField:
            if emailTextField.text?.isValidEmail() ?? false {
                emailRequired.text = "Campo Obligatorio*"
                emailRequired.isHidden = true
            } else {
                emailRequired.text = "Email inválido*"
                emailRequired.isHidden = false
            }
        default:
            break
        }
    }
   
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.nextTextField(textField)
        return true
    }
}

//MARK: - TextView Delegate Implementation
extension RegisterProfileViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        textView.text.count < 255
    }
    func textViewDidChange(_ textView: UITextView) {
        //descriptionPlaceholderLabel.isHidden = !textView.text.isEmpty
    }
}


    
    

