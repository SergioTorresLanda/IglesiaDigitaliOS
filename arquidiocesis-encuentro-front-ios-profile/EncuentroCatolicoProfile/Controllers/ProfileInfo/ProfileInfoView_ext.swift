//
//  ProfileInfoView_ext.swift
//  EncuentroCatolicoProfile
//
//  Created by valente guevara on 15/10/22.
//
import Foundation
import UIKit
import EncuentroCatolicoVirtualLibrary
import Toast_Swift


// MARK: - Actions

extension ProfileInfoView {
    @objc func popView() {
        presenter?.showConfigController()
    }
    
    @objc func toLogOut(){
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "nombre")
        defaults.removeObject(forKey: "role")
        defaults.removeObject(forKey: "profile")
        presenter?.cerrarSesion()
        self.view.window?.rootViewController?.dismiss(animated: true, completion: {
            NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: "LogOut"),
                                                         object: nil, userInfo: nil))
        })
    }
    func logOut() {
        UserDefaults.standard.removeObject(forKey: "nombre")
        UserDefaults.standard.removeObject(forKey: "id")
        presenter?.cerrarSesion()
        self.view.window?.rootViewController?.dismiss(animated: true, completion: {
            NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: "newLogOut"),
                                                         object: nil, userInfo: nil))
        })
        NotificationCenter.default.removeObserver(self, name: Notification.Name(rawValue: "newLogOut"), object: nil)
    }
    @objc private func didSelectLifeState() {
        view.endEditing(true)
        //Aqui ocultas view de iglesias!!
        var name = lifeStateTextField.text
        if name == "" {
            name = "Soltero"
            
        }
        
        if name == "Soltero" || name == "Casado" || name == "Viudo" {
            self.ShowUpTopic()
        }else if name == "Sacerdote" {
            saveButton.setTitle("Continuar", for: .normal)
        }else {
            saveButton.setTitle("Guardar", for: .normal)
        }
        
    }
    
    @objc private func didSelectTopics() {
        var topicId: Int = 0
        var name = topicsTextField.text
        if name == "" {
            name = "Familia"
        }
        switch name {
        case "Familia":
            topicId = 1
        case "Catequesis":
            topicId = 2
        case "Sacramentos":
            topicId = 3
        case "El papa":
            topicId = 4
        case "Apostolado":
            topicId = 5
        case "Voluntariado":
            topicId = 6
        case "Oración":
            topicId = 7
        default:
            break
        }
        let ids = nameTopics.map({$0})
        if ids.contains(name ?? "") {
            let alert = UIAlertController(title: "Actividad repetida", message: "La actividad ya se encuetra agregada", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: nil))
            self.present(alert, animated: true)
        }else {
            let topic1 = Topics(id: topicId)
            nameTopics.append(name ?? "")
            topicArray.append(topic1)
        }
        view.endEditing(true)
        topicCollectionView.reloadData()
    }
}
// MARK: - UI

extension ProfileInfoView {
     func setupNavBarImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "navbar_image", in: Bundle.local, compatibleWith: nil)
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }
    
     func setupTexfield(placeholder: String = "", textLabel: String = "") -> LineLabelTextField {
        let textField = LineLabelTextField()
        textField.delegate = self
        textField.labelColor = UIColor(red: 25 / 255, green: 42 / 255, blue: 114 / 255, alpha: 1.0)
        textField.font = UIFont(name: "Roboto-Regular", size: 14.0) ?? .systemFont(ofSize: 14, weight: .regular)
        textField.placeholder = placeholder
        textField.textLabel = textLabel
        return textField
    }
    
     func setupLabel(_ text: String, font: UIFont, color: UIColor) -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = text
        label.font = font
        label.textColor = color
        return label
    }
    
     func setupLabelTwo(_ text: String, font: UIFont, color: UIColor) -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = text
        label.font = font
        label.textColor = color
        return label
    }
    
     func setupRadioButton(_ titleText: String) -> RadioButton {
        let radioButton = RadioButton()
        radioButton.isSelected = false
        radioButton.titleText = titleText
        radioButton.deselectedColor = UIColor(red: 160 / 255, green: 160 / 255, blue: 160 / 255, alpha: 1.0)
        radioButton.selectedColor = UIColor(red: 25 / 255, green: 42 / 255, blue: 115 / 255, alpha: 1.0)
        radioButton.addTarget(self, action: #selector(radioSelected(_ :)), for: .touchUpInside)
        return radioButton
    }
    
     func setupToolButton() -> UIButton {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "tool_image", in: Bundle.local, compatibleWith: nil), for: .normal)
        button.addTarget(self, action: #selector(popView), for: .touchUpInside)
        return button
    }
    
//    private func setupLogOutButton() -> UIButton {
//        let button = UIButton(type: .custom)
//        button.setImage(UIImage(named:"logout", in: Bundle.local, compatibleWith: nil), for: .normal)
//        button.addTarget(self, action: #selector(toLogOut), for: .touchUpInside)
//        return button
//    }
    
     func setupUserImageView() -> UIImageView {
            let imageView = UIImageView()
            imageView.clipsToBounds = true
            imageView.contentMode = .scaleToFill
            
            if let imageData = UserDefaults.standard.data(forKey: "userImage"), let image = UIImage(data: imageData) {
                imageView.image = image
            } else {
                
               // imageView.image = UIImage(named: "userImage", in: Bundle.local, compatibleWith: nil)
            }
            
            return imageView
        }
    
     func setupSaveButton() -> UIButton {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 10
        button.backgroundColor = UIColor(red: 19 / 255, green: 39 / 255, blue: 124 / 255, alpha: 1.0)
        button.titleLabel?.font = UIFont(name: "Roboto-Bold", size: 15) ?? .systemFont(ofSize: 15, weight: .bold)
        button.setTitle("Guardar", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(didSaveAction), for: .touchUpInside)
        return button
    }
}

// MARK: UITextFieldDelegate -
extension ProfileInfoView: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        pickerLifeStyle.selectRow(0, inComponent: 0, animated: true)
       // pickerTopics.selectRow(0, inComponent: 0, animated: true)
        pickerServiceCong.selectRow(0, inComponent: 0, animated: true)
        switch textField {
        case fieldsCollection[5]:
            selectedRow = 0
            if fieldsCollection[5].text == "" {
                if lifeStyleList.count != 0 {
                    fieldsCollection[5].text = lifeStyleList[0]
                    //selectedRow = 0
                }
               
            }
            
        case fieldsCollection[7]:
            if fieldsCollection[7].text == "" {
                if topicsList.count != 0 {
                    fieldsCollection[7].text = topicsList[0]
                   // selectedAcitity = topicsList[0]
                    selectedRow = 101
                }
                
            }
            
        case fieldsCollection[8]:
            if fieldsCollection[8].text == "" {
                if serviceCongList.count != 0 {
                    fieldsCollection[8].text = serviceCongList[0]
                }
                
            }
            
        default:
            break
        }
        
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        //        if textField == Constants.Tags.fieldSecurityCode {
        //            securityCodeTextField = textField
        //            datePickerTapped(textField)
        //            return false
        //        }
        
        return true
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension ProfileInfoView: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        let image = info[.originalImage] as! UIImage
        let cameraPhotoURL = HttpRequestSingleton.shareManager.convertImageToBase64String(img: image)
        EditionPromisseDataManager.shareInstance.addNewProfile(profileModel: ProfileModel(email: UserDefaults.standard.value(forKey: "email") as? String ?? "", image: cameraPhotoURL))
        picker.dismiss(animated: true, completion: nil)
    }
}

extension ProfileInfoView: PromisseAlertViewProtocol {
    func dissmisAlert() {
    }
}

extension ProfileInfoView: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        
        case 2:
            return topicsArray.count
            
        case 3:
            return lifeStyleList.count
            
        case 4:
            return serviceCongList.count
            
        case 5:
            return topicsList.count
            
        case 6:
            return arrayPrefix.count
       
        default:
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        
        case 2:
            return topicsArray[row].description
            
        case 3:
            return lifeStyleList[row]
            
        case 4:
            return serviceCongList[row]
            
        case 5 :
            return topicsList[row]
            
        case 6:
            return arrayPrefix[row]
        
        default:
            return "Sin Datos"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        
        case 2:
            //            selectedTopic = topicsArray[row]
            topicsTextField.text = topicsArray[row].description
            
        case 3:
            fieldsCollection[5].text = lifeStyleList[row]
            selectedRow = row
            lifeStatusSingleton = lifeStyleList[row]
            selectedCode = codesLifeStatus[row]
            
        case 4:
            fieldsCollection[8].text = serviceCongList[row]
            selectedRow = 100
            
        case 5:
            fieldsCollection[7].text = topicsList[row]
            selectedAcitity = topicsList[row]
            selectedRow = 101
            
        case 6:
            prefixField.text = arrayPrefix[row]
            selectedPrefixID = arrayPrefixID[row]
            
        default:
            print("Entro el defaul")
            break
            
        }
    }
}

// MARK: RESPONSE SERVICES FUNCTIONS -
extension ProfileInfoView: ProfileInfoViewProtocol {
   
    func showStatesResponnse() {
        hideLoading()
        /*DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.view.makeToast("Datos Guardados Exitosamente", duration: 3.0, position: .top)
        }*/
    }
    
    func showCongregationResponse() {
        hideLoading()
    }
    
    func showSacerdoteResponse() {
        hideLoading()
    }
    
    func showDiaconoResponse() {
        hideLoading()
    }
    
    func showDetalles(detail: DetailProfile) {
        //print("çççç", detail)
        print("showDetalles return")
        // New Code
        lifeStatusSingleton = detail.data?.User?.life_status?.name ?? ""
        lblUserName.text = "\(detail.data?.User?.name ?? "Unspecified") \(detail.data?.User?.first_surname ?? "Unspecified") \(detail.data?.User?.second_surname ?? " ")"
        fieldsCollection[0].text = detail.data?.User?.name
        fieldsCollection[1].text = detail.data?.User?.first_surname
        fieldsCollection[2].text = detail.data?.User?.second_surname
        fieldsCollection[3].text = detail.data?.User?.phone_number
        fieldsCollection[4].text = detail.data?.User?.email
        fieldsCollection[5].text = detail.data?.User?.life_status?.name
        //
        switch detail.data?.User?.life_status?.name {
        case "Soltero", "Casado", "Viudo":
            isCongregation = false
            isLaico = false
            fieldsCollection[6].placeholder = "¿En qué iglesia prestas el servicio?"
            serachStack.isHidden = true
            miniContentCongregation.isHidden = true
            lineasViewCollection[6].isHidden = true
            miniContentSwitch.isHidden = false
            lblYouCan.isHidden = false
            hideOrShowPrefix(isShow: true)
          
            if detail.data?.User?.location_modules?.count != 0 {
                switchState.isOn = true
                lblState.text = "Sí"
                serachStack.isHidden = false
                lineasViewCollection[6].isHidden = false
                arrayChurches.removeAll()
                arrayImgchurches.removeAll()
                
                detail.data?.User?.location_modules?.forEach({ module in
                    arrayChurches.append(module.name ?? "")
                    arrayImgchurches.append("Unspecified")
                })

                churchCollection.reloadData()
                churchCollection.isHidden = false
                let height = churchCollection.collectionViewLayout.collectionViewContentSize.height
                heightChurchCollection.constant = height
                self.view.layoutIfNeeded()
                print(heightChurchCollection.constant)
            }
            
        case "Religioso":
            isCongregation = true
            isLaico = false
            fieldsCollection[6].placeholder = "Congregación a la que perteneces"
            fieldsCollection[6].text = detail.data?.User?.congregation?.name
            miniContentSwitch.isHidden = true
            serachStack.isHidden = false
            cardLaico.isHidden = false
            cardLaico2.isHidden = false
            lineasViewCollection[6].isHidden = false
            miniContentCongregation.isHidden = false
            lblYouCan.isHidden = true
            prefixField.text = detail.data?.User?.prefix?.description
            prefixField.placeholder = "Selecciona"
            selectedPrefixID = detail.data?.User?.prefix?.id ?? 0
            presenter?.requestPrefixes(code: "RELIGIOUS")
            hideOrShowPrefix(isShow: false)
            
            switch detail.data?.User?.profile {
            case "COMMUNITY_RESPONSIBLE":
                switchResponsable.isOn = true
                lblStateResp.text = "Sí"
                cardLaico2.isHidden = false
            default:
                switchResponsable.isOn = false
                lblStateResp.text = "No"
                cardLaico2.isHidden = true
            }
        
        case "Laico":
            isLaico = true
            cardLaico.isHidden = true
            cardLaico2.isHidden = true
            hideOrShowPrefix(isShow: true)
            radioBtnCollection.isHidden = false
            lblLaicoAsk.isHidden = false
            print("IS PROVIDER IS PROVIDER IS PROVIDER IS PROVIDER")
            print(detail.data?.User?.is_provider ?? "WASs")
            switch detail.data?.User?.is_provider {
            case "CHURCH":
                typeService="iglesia"
                arrayIsActive[0] = true
                isLaico = false //revisar
                switchState.isOn = false
                lblState.text = "No"
                serachStack.isHidden = false //revisar
                lineasViewCollection[6].isHidden = false //revisar
                hideOrShowPrefix(isShow: true)
                isCongregation = false
                //TARJETA
                mostrarTarjeta(detail: detail)
                //
                cardLaico.isHidden = true
                cardLaico2.isHidden = true
                miniContentCongregation.isHidden = true
                miniContentSwitch.isHidden = true
                let height = activityCollection.collectionViewLayout.collectionViewContentSize.height
                heightTopicColection.constant = height
                self.view.layoutIfNeeded()
                serviceProvider = "CHURCH"
                
            case "COMMUNITY":
                typeService="comunidad"
                arrayIsActive[1] = true
                isLaico = true //revisar
                switchResponsable.isOn = false
                isCongregation = false
                lblStateResp.text = "No"
                //funcion para mostrar tarjeta
                mostrarTarjeta(detail: detail)
                //
                fieldsCollection[6].placeholder = "Congregación a la que perteneces"
                selectedPrefixID = 0
                prefixField.text = "N/A"
                miniContentSwitch.isHidden = true
                serachStack.isHidden = true
                lineasViewCollection[6].isHidden = true
                miniContentCongregation.isHidden = true
                lblYouCan.isHidden = true
                cardLaico.isHidden = false
                cardLaico2.isHidden = false
                hideOrShowPrefix(isShow: true)
                serviceProvider = "COMMUNITY"
                
            default:
                arrayIsActive[2] = true
            }
            
            radioBtnCollection.reloadData()
            
            switch detail.data?.User?.profile {
            case "COMMUNITY_RESPONSIBLE":
                switchResponsable.isOn = true
                lblStateResp.text = "Sí"
               // cardLaico2.isHidden = false
            default:
                switchResponsable.isOn = false
                lblStateResp.text = "No"
               // cardLaico2.isHidden = true
            }
            
        case "Diácono (Transitorio o permanente)":
            isCongregation = false
            isLaico = false
            fieldsCollection[6].placeholder = "¿En qué iglesia prestas el servicio?"
            serachStack.isHidden = false
            miniContentCongregation.isHidden = true
            lineasViewCollection[6].isHidden = true
            miniContentSwitch.isHidden = true
            lblYouCan.isHidden = true
            hideOrShowPrefix(isShow: true)
          
            if detail.data?.User?.location_modules?.count != 0 {
                switchState.isOn = true
                lblState.text = "Sí"
                serachStack.isHidden = false
                lineasViewCollection[6].isHidden = false
                fieldsCollection[6].text = detail.data?.User?.location_modules?[0].name ?? ""
                arrayChurches.removeAll()
                arrayImgchurches.removeAll()
                
                detail.data?.User?.location_modules?.forEach({ module in
                    arrayChurches.append(module.name ?? "")
                    arrayImgchurches.append("Unspecified")
                })

                churchCollection.reloadData()
                churchCollection.isHidden = false
                let height = churchCollection.collectionViewLayout.collectionViewContentSize.height
                heightChurchCollection.constant = height
                self.view.layoutIfNeeded()
                print(heightChurchCollection.constant)
            }
            
            selectedPrefixID = detail.data?.User?.prefix?.id ?? 0
            prefixField.text = detail.data?.User?.prefix?.description
            prefixField.placeholder = "Selecciona"
            presenter?.requestPrefixes(code: "DEACON")
            hideOrShowPrefix(isShow: false)
           
        case "Sacerdote":
            isLaico = false
            isCongregation = false
            miniContentSwitch.isHidden = true
            miniContentCongregation.isHidden = true
            serachStack.isHidden = true
            lineasViewCollection[6].isHidden = true
            lblYouCan.isHidden = true
            prefixField.text = detail.data?.User?.prefix?.description
            prefixField.placeholder = "Selecciona"
            selectedPrefixID = detail.data?.User?.prefix?.id ?? 0
            presenter?.requestPrefixes(code: "PRIEST")
            hideOrShowPrefix(isShow: false)
            
        default:
            break
        }
         
        if ((detail.data?.User?.interest_topics?.count ?? 0) != 0) {
            detail.data?.User?.interest_topics?.forEach({ topic in
                nameTopics.append("\(topic.name ?? "Unspecified")")
            })
            topicArray = detail.data?.User?.interest_topics ?? topicArray
            activityCollection.isHidden = false
            activityCollection.reloadData()
            let height = activityCollection.collectionViewLayout.collectionViewContentSize.height
            heightTopicColection.constant = height
         
            self.view.layoutIfNeeded()
           
        }else{
           // mainContentHeight.constant += 60
        }
        
        self.hideLoading()
    
    }
    
    func mostrarTarjeta(detail:DetailProfile){
        btnSave.setTitle("Guardar", for: .normal)
        fieldsCollection[6].text = detail.data?.User?.services_provided?.first?.location_name
        arrayChurches.removeAll()
        arrayImgchurches.removeAll()
        detail.data?.User?.services_provided?.forEach({ item in
            arrayChurches.append(item.location_name ?? "")
            arrayImgchurches.append("unspecified")
            nameService.append(item.service_name ?? "")
        })
        churchCollection.reloadData()
        churchCollection.isHidden = false
        
        let heightC = churchCollection.collectionViewLayout.collectionViewContentSize.height
        heightChurchCollection.constant = heightC
        self.view.layoutIfNeeded()
        print(heightChurchCollection.constant)
    }
    
    func showLifeStates(lifeStates: StatesResponse) {
        //print(lifeStates)
        lifeStatesArray = lifeStates.data
        lifeStates.data.forEach { state in
            switch state.name {
            case "Soltero", "Casado", "Viudo":
                print("Dont append")
            default:
                lifeStyleList.append(state.name)
                codesLifeStatus.append(state.code ?? "")
            }
            
        }
        print("CODE LIFE STATUS: ", codesLifeStatus)
        createPicker(texfield: lifeStateTextField, tag: 1, with: #selector(didSelectLifeState))
    }
    
    func showTopics(topics: TopicsResponse) {
        //print(topics)
        topicsArray = topics.data
        topics.data.forEach { topic in
            topicsList.append(topic.description)
            arrayDictionariesTopics.append(["id":topic.id])
            
        }
       // selectedAcitity = topicsList[0]
        createPicker(texfield: topicsTextField, tag: 2, with: #selector(didSelectTopics))
        
    }
    
    func showServices(services: ServiceResponse) {
        //print("XXXXXXXXX")
        //print(services)
        var servicesData: [ProvidedService] = []
        services.data.forEach { service in
            serviceCongList.append(service.description)
            serviceListID.append(service.id)
        }
        services.data.forEach {
            servicesData.append(ProvidedService(id: $0.id, name: $0.description))
        }
        AllServicesData = servicesData
        profileUserInfoView.options = servicesData
        self.presenter?.getUserDetailP()
        self.presenter?.getAllUserDetail()
    }
    
    func showUserInfo(user: UserRespProfile) {
        //        hideLoading()
        //        lblNombre.text = user.UserAttributes.name + " " + user.UserAttributes.last_name + " " + user.UserAttributes.middle_name
        //        txtEail.text = user.UserAttributes.email
        //        txtCelulat.text = user.UserAttributes.phone_number.replacingOccurrences(of: "+52", with: "")
    }
    
    func showOffice(offices: Array<ActivitiesResponse>) {
    }
    
    func showError(error: String) {
        print("SHOW Error")
        showCanonAlert(title:"Error", msg: error)
    }
    
    func showRegisterResponse(response: RegisterPriestResponse) {
    }
    
    func mostrarInfo(dtcAlerta: [String: String]?, user: UserRespProfile?) {
        hideLoading()
        loadingAlert.dismiss(animated: true, completion: { [self] in
            if let alerta = dtcAlerta {
                let alertaView = UIAlertController(title: alerta["titulo"], message: alerta["cuerpo"], preferredStyle: .alert)
                alertaView.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: nil))
                self.present(alertaView, animated: true, completion: nil)
            } else {
                //                guard let nombre = user?.UserAttributes.name, let apellido1 = user?.UserAttributes.last_name, let apellido2 = user?.UserAttributes.middle_name else {
                //                    return
                //                }
                //                lblNombre.text = nombre + " " + apellido1 + " " + apellido2
            }
        })
    }
    
    func successPrefix(data: PrefixResponse) {
        arrayPrefix.removeAll()
        arrayPrefixID.removeAll()
        loadingAlert.dismiss(animated: true, completion: nil)
        arrayPrefix.append("Selecciona")
        arrayPrefixID.append(0)
        
        data.data?.forEach({ prefix in
            arrayPrefix.append(prefix.description ?? "")
            arrayPrefixID.append(prefix.id ?? 0)
        })

        pickerPrefix.reloadAllComponents()
        
    }
    
    func failPrefix(message: String) {
        loadingAlert.dismiss(animated: true, completion: nil)
    }
    
    // TODO: implement view output methods
    func mostrarMSG(dtcAlerta: [String: String]) {
        let alerta = UIAlertController(title: dtcAlerta["titulo"], message: dtcAlerta["cuerpo"], preferredStyle: .alert)
        alerta.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: nil))
        present(alerta, animated: true, completion: nil)
    }
}

// MARK: CALENDAR -
extension Calendar {
    func numberOfDaysBetween(_ from: Date, and to: Date) -> Int {
        let fromDate = startOfDay(for: from) // <1>
        let toDate = startOfDay(for: to) // <2>
        let numberOfDays = dateComponents([.day], from: fromDate, to: toDate) // <3>
        
        return numberOfDays.day!
    }
}

// MARK: UITEXFIELD -
extension UITextField {
    func setBottomBorder() {
        borderStyle = .none
        layer.backgroundColor = UIColor.white.cgColor
        
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 0.0
    }
}

extension ProfileInfoView: ProtocolProfileUserInfoX {
    func closeAction() {
        self.hidePartial()
        radioButtonNo.isSelected = true
        radioButtonYes.isSelected = false
    }
}


// MARK: EXTENSION COLLECTION VIEW -
extension ProfileInfoView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, ActivitiesCardDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch collectionView {
        case churchCollection:
            return arrayChurches.count
        case activityCollection:
            return nameTopics.count
            
        case radioBtnCollection:
            return arrayRadioBtn.count
            
        default:
            return 1
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView {
        case churchCollection:
            
            let cellChurch = collectionView.dequeueReusableCell(withReuseIdentifier: "CELLCHURCH", for: indexPath) as! ChurchesCardViewCell
            
            cellChurch.subCardView.ShadowCard()
            cellChurch.subCardView.layer.cornerRadius = 10
            cellChurch.cardView.layer.cornerRadius = 10
            cellChurch.cardView.clipsToBounds = true
            cellChurch.lblAsk.adjustsFontSizeToFitWidth = true
            cellChurch.lblChurchName.adjustsFontSizeToFitWidth = true
            cellChurch.btnDelete.addTarget(self, action: #selector(deleteChurchCard), for: .touchUpInside)
            cellChurch.btnDelete.tag = indexPath.item
            if arrayChurches.count != 0 {
                cellChurch.lblChurchName.text = arrayChurches[indexPath.item]
                cellChurch.churchImg.DownloadStaticImage(arrayImgchurches[indexPath.item])
            }
            
            if nameService.count != 0 {
                if nameService[indexPath.row] != "Unspecified" && nameService[indexPath.row] != "" && nameService.count != 0 {
                    cellChurch.fieldServices.text = nameService[indexPath.row]
                }
            }
            cellChurch.setupPickerField(vc: self, dataNames: serviceCongList, dataId: serviceListID,type: typeService)
            //            cellChurch.fieldServices.text = "Sacristán"
            
            return cellChurch
            
        case radioBtnCollection:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CELLRADIO", for: indexPath) as! RadioBtnCollectionViewCell
            cell.lblName.text = arrayRadioBtn[indexPath.item]
            cell.lblName.adjustsFontSizeToFitWidth = true
            cell.btnRadio.tag = indexPath.item
            cell.btnRadio.addTarget(self, action: #selector(selectRadioButton), for: .touchUpInside)
            cell.btnRadio.setTitle("", for: .normal)
            
            if arrayIsActive[indexPath.item] == true {
                cell.fillCircle.isHidden = false
            }else{
                cell.fillCircle.isHidden = true
            }
            
            return cell
            
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ActivitiesCardCollectionViewCell.reuseIdentifier, for: indexPath)
            let activity = nameTopics[indexPath.item]
            (cell as? ActivitiesCardCollectionViewCell)?.delegate = self
            (cell as? ActivitiesCardCollectionViewCell)?.activitiesNameLabel.text = activity.description
            return cell
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        switch collectionView {
        case radioBtnCollection:
            return 0.2
            
        default:
            return 2.0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        switch collectionView {
        case radioBtnCollection:
            return 0.5
        default:
            return 2.0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch collectionView {
        case churchCollection:
            switch miniContentSwitch.isHidden {
            case true:
                return CGSize(width: churchCollection.frame.width - 20, height: 255)
            
            default:
                return CGSize(width: churchCollection.frame.width - 20, height: 225)
            }
            
        case radioBtnCollection:
            return CGSize(width: 200, height: 40)
            
        default:
            return CGSize(width: 110 , height: 40)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    
    func deleteActivity(index: IndexPath) {
        nameTopics.remove(at: index.item)
        topicArray.remove(at: index.item)
        activityCollection.reloadData()
        let height = activityCollection.collectionViewLayout.collectionViewContentSize.height
        heightTopicColection.constant = height
        self.view.layoutIfNeeded()
        switch nameTopics.count {
        case 3:
            //  mainContentHeight.constant -= 50
            print("3")
        case 6:
            // mainContentHeight.constant -= 50
            print("6")
        default:
            break
        }
        if nameTopics.count == 0 {
            activityCollection.isHidden = true
            // mainContentHeight.constant -= 50
            
            print(nameTopics)
        }
    }
}


open class HttpRequestSingleton: NSObject {
    public static var shareManager = HttpRequestSingleton()
    
    public func convertImageToBase64String(img: UIImage) -> String {
        let imageData: Data? = img.jpegData(compressionQuality: 0.4)
        let imageStr = imageData?.base64EncodedString(options: .lineLength64Characters) ?? ""
        return imageStr
    }
    
    public func convertBase64StringToImage(imageBase64String: String) -> UIImage {
        var image = UIImage()
        if imageBase64String != "" {
            let dataDecoded: Data = Data(base64Encoded: imageBase64String, options: .ignoreUnknownCharacters)!
            image = UIImage(data: dataDecoded) ?? UIImage()
        } else {
            image = UIImage()
        }
        return image
    }
}

class ImagePickerManager: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var picker = UIImagePickerController();
    var alert = UIAlertController(title: "Escoger imagen", message: nil, preferredStyle: .actionSheet)
    var viewController: UIViewController?
    var pickImageCallback : ((UIImage) -> ())?;
    
    override init(){
        super.init()
        let cameraAction = UIAlertAction(title: "Camara", style: .default){
            UIAlertAction in
            self.openCamera()
        }
        let galleryAction = UIAlertAction(title: "Galeria", style: .default){
            UIAlertAction in
            self.openGallery()
        }
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel){
            UIAlertAction in
        }

        // Add the actions
        picker.delegate = self
        alert.addAction(cameraAction)
        alert.addAction(galleryAction)
        alert.addAction(cancelAction)
    }

    func pickImage(_ viewController: UIViewController, _ callback: @escaping ((UIImage) -> ())) {
        print("Se da clic en la funcion de pickImage")
        pickImageCallback = callback;
        self.viewController = viewController;

        alert.popoverPresentationController?.sourceView = self.viewController!.view

        viewController.present(alert, animated: true, completion: nil)
    }
    func openCamera(){
        alert.dismiss(animated: true, completion: nil)
        if(UIImagePickerController .isSourceTypeAvailable(.camera)){
            picker.sourceType = .camera
            self.viewController!.present(picker, animated: true, completion: nil)
        } else {
            let alertWarning = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertWarning.addAction(cancelAction)
            viewController?.present(alertWarning, animated: true, completion: nil)
        }
    }
    func openGallery(){
        print("Se abre la galeria del dispositivo")
        alert.dismiss(animated: true, completion: nil)
        picker.sourceType = .photoLibrary
        self.viewController!.present(picker, animated: true, completion: nil)
    }

    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("Se cancela la acción")
        picker.dismiss(animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("Se da clic en la funcion de imagePickerController")
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        pickImageCallback?(image)
    }

    @objc func imagePickerController(_ picker: UIImagePickerController, pickedImage: UIImage?) {
    }

}

// MARK:
extension ProfileInfoView {
    
    func succesUpload64(responseData: UploadImageData) {
        print("Upload image successfully")
       
        Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { (timer) in
            if self.imgChoosed != nil {
                self.userImg.image = self.imgChoosed
            }else{
                self.userImg.DownloadStaticImage(responseData.url ?? "nil")
            }
           
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.loadingAlert.dismiss(animated: true, completion: nil)
            }
        }
       
    }
    
    func failUpload64() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.loadingAlert.dismiss(animated: true, completion: nil)
        }
        
    }
    
    func succesGetDetailProfile(responseData: ProfileDetailImg) {

        if responseData.data?.User?.image == nil {
            userImg.image = UIImage(named: "userImage", in: Bundle.local, compatibleWith: nil)
        }else{
            if imgChoosed != nil {
                userImg.image = imgChoosed
            }else{
                
                if responseData.data?.User?.image == "s/n" {
                    userImg.image = UIImage(named: "userImage", in: Bundle.local, compatibleWith: nil)
                }else{
                    userImg.DownloadStaticImage(responseData.data?.User?.image ?? "nil")
                }
            }
        }
    }
    
    func failGetDataProfile() {
        showCanonAlert(title:"Error",msg: "Error obteniendo tus datos, contacta al administrador.")
    }
    
}

// MARK: TRANSITION DELEGATE -
extension ProfileInfoView: UIViewControllerTransitioningDelegate {

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        transition.isPresenting = false
            if isLaico == true {
                if isCongregation == true {
                    if indexFlow == 0 {
                        let singleton = ProfileMapViewController.singleton
                        if singleton.nameChurch != "Unspecified" {
                            arrayChurches.removeAll()
                            arrayImgchurches.removeAll()
                            arrayChurches.append(singleton.nameChurch)
                            arrayImgchurches.append(singleton.urlImgChurch)
                            fieldsCollection[6].text = singleton.nameChurch
                            churchCollection.reloadData()
                            let height = churchCollection.collectionViewLayout.collectionViewContentSize.height
                            heightChurchCollection.constant = height
                            self.view.layoutIfNeeded()
                            print(heightChurchCollection.constant)
                            
                            churchRespField.text = singleton.nameChurch
                            //miniContentCongregation.isHidden=false
                            churchCollection.isHidden = false
                            print("IsCong True")
                        }else{
                            print("Is not a church from laico")
                        }
                    }else{
                        let singleton = CongregationsView.singleton
                        fieldsCollection[6].text = singleton.selectedCong
                    }
                }else{
                    print("IsCong False")
                    let singleton = ProfileMapViewController.singleton
                    if singleton.nameChurch != "Unspecified" {
                        arrayChurches.removeAll()
                        arrayImgchurches.removeAll()
                        arrayChurches.append(singleton.nameChurch)
                        arrayImgchurches.append(singleton.urlImgChurch)
                        fieldsCollection[6].text = singleton.nameChurch
                        churchCollection.reloadData()
                        let height = churchCollection.collectionViewLayout.collectionViewContentSize.height
                        heightChurchCollection.constant = height
                        self.view.layoutIfNeeded()
                        print(heightChurchCollection.constant)
                        
                        churchRespField.text = singleton.nameChurch
                        //miniContentCongregation.isHidden=false
                        churchCollection.isHidden = false
                    }else{
                        print("Is not a church from laico")
                    }
                }
               
            }else{
                if isCongregation == false {
                    let singleton = ProfileMapViewController.singleton
                    if singleton.nameChurch != "Unspecified" {
                        arrayChurches.removeAll()
                        arrayImgchurches.removeAll()
                        arrayChurches.append(singleton.nameChurch)
                        arrayImgchurches.append(singleton.urlImgChurch)
                        fieldsCollection[6].text = singleton.nameChurch
                        churchCollection.reloadData()
                        churchCollection.isHidden = false
                        let height = churchCollection.collectionViewLayout.collectionViewContentSize.height
                        heightChurchCollection.constant = height
                        self.view.layoutIfNeeded()
                        print(heightChurchCollection.constant)
                      
                    }else{
                        print("Is not a nameChurch  ")
                    }
                    
                }else{
                    print("return from congregation view")
                    let singleton = CongregationsView.singleton
                    fieldsCollection[6].text = singleton.selectedCong
                }
            }
            
        return transition
        
    }
    
}


enum LifeState: Int {
    case single = 1
    case married = 2
    case widower = 3
    case laic = 4
    case religious = 5
    case diacan = 6
    case priest = 7
}

enum estado: Int {
    case Soltero = 1
    case Casado = 2
    case Viudo = 3
    case Laico = 4
    case Religioso = 5
    case Diacono = 6
    case Sacerdote = 7
}
