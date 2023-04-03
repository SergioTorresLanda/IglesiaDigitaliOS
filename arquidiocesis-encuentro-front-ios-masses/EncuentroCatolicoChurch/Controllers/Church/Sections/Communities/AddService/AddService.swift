//
//  AddService.swift
//  EncuentroCatolicoChurch
//
//  Created by Jorge Garcia on 24/08/21.
//

import UIKit

public protocol AddServiceModalButtonDelegate: AnyObject {
    func didPressReadyServiceButton(_ sender: UIButton)
    func didPressAdServicemButton(_ sender: UIButton)
}
//protocol AddServiceDataSendingDelegateProtocol {
//    func sendDatAddServiceEditToComMainViewController(serviceData: [ActivityEditProfile], serviceDay: [ServiceHourEditProfile], serviceHour: [ScheduleEditPrifile])
//    func sendDatAddServiceFinishToComMainViewController(serviceData: [ActivityFinReg], serviceDay: [ServiceHourFinReg], serviceHour: [SchedulefinReg])
//}

struct hoursSchedule: Codable {
    let hourStar: String
    let hourend: String
}

class AddService: UIView, UITextFieldDelegate {
    
    static let instance = AddService()
    var daysArray = [Int]()
    var hoursArray = [String]()
    var hourStruct: [hoursSchedule] = []
    var serviceCatalog: ServiceCatalogModel?
    var serviceID = Int()
    var keyboardShown: Bool = false
    public weak var delegate: AddServiceModalButtonDelegate?
    let pickerView = UIPickerView()
    //var delegatedata: AddServiceDataSendingDelegateProtocol? = nil
    @IBOutlet weak var nameServiceTextField: UITextField!
    @IBOutlet weak var audienceTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var daysTextField: UITextField!
    @IBOutlet weak var timeTextField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet var parentView: UIView!
    private lazy var sdTimePicker: TimePicker = {
        let picker = TimePicker()
        picker.setup()
        picker.didSelectDates = { [weak self] (startDate, endDate) in
            let text = Date.buildTimeRangeString(startDate: startDate, endDate: endDate)
            self?.timeTextField.text = text
        }
        return picker
    }()
    
    private lazy var sdDayPicker: DayPicker = {
        let picker = DayPicker()
        picker.setup()
        picker.didSelectDates = { [weak self] (startDate, endDate) in
            let text = Date.buildDayRangeString(startDate: startDate, endDate: endDate)
            self?.daysTextField.text = text
        }
        return picker
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        Bundle.local.loadNibNamed("AddService", owner: self, options: nil)
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
        
        let donePickerButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.doneClick))
        toolBar.setItems([donePickerButton], animated: false)
        
        nameServiceTextField.tag = 0
        audienceTextField.tag = 1
        descriptionTextField.tag = 2
        
        nameServiceTextField.delegate = self
        audienceTextField.delegate = self
        descriptionTextField.delegate = self
        timeTextField.delegate = self
        daysTextField.delegate = self
        
        self.nameServiceTextField.returnKeyType = UIReturnKeyType.next
        self.audienceTextField.returnKeyType = UIReturnKeyType.next
        self.descriptionTextField.returnKeyType = UIReturnKeyType.done
        
        timeTextField.inputView = sdTimePicker.inputView
        daysTextField.inputView = sdDayPicker.inputView
        
        timeTextField.inputAccessoryView = toolBar
        daysTextField.inputAccessoryView = toolBar
    }
    func showAllert() {
        UIApplication.shared.keyWindow?.addSubview(parentView)
    }
    func showAllertChurch(data: ServiceCatalogModel) {
        UIApplication.shared.keyWindow?.addSubview(parentView)
        serviceCatalog = data
        print("serviceCatalog es:")
        print(serviceCatalog)
        setupServicePicker()
    }
    
    func setupServicePicker() {
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.init(named: "eMainBlue")
        toolBar.sizeToFit()
        
        let donePickerButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.doneClick))
        toolBar.setItems([donePickerButton], animated: false)
        nameServiceTextField.inputAccessoryView = toolBar
        nameServiceTextField.inputView = pickerView
        pickerView.delegate = self
        pickerView.dataSource=self
    }
    
    @objc func doneClick() {
        timeTextField.resignFirstResponder()
        daysTextField.resignFirstResponder()
        nameServiceTextField.resignFirstResponder()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == daysTextField {
            let dyasString = daysTextField.text
            let daysStringArray = dyasString?.components(separatedBy: " ")
            var daysToInt: [Int] {
                if daysStringArray == ["Saturday, Monday"]{
                    return [1, 2, 3]
                }else {
                    return [0,1,2,3,4,5,6,7]
                }
            }
            daysArray = daysToInt
            
        }else if textField == timeTextField {
            if timeTextField.text?.isEmpty == false {
                let hoursString = timeTextField.text
                let hoursStringArray = hoursString?.components(separatedBy: " ")
                hoursArray = hoursStringArray ?? []
                hourStruct.append(hoursSchedule.init(hourStar: hoursArray[0], hourend: hoursArray[3]))
            }
            if nameServiceTextField.text?.isEmpty == false && audienceTextField.text?.isEmpty == false && descriptionTextField.text?.isEmpty == false && daysTextField.text?.isEmpty == false {
                addButton.isEnabled = true
                doneButton.isEnabled = true
                addButton.alpha = 1
                doneButton.alpha = 1
            }
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
    private func switchBasedNextTextField(_ textField: UITextField) {
        switch textField {
        case self.nameServiceTextField:
            self.nameServiceTextField.becomeFirstResponder()
        case self.audienceTextField:
            self.audienceTextField.becomeFirstResponder()
        default:
            self.descriptionTextField.resignFirstResponder()
        }
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        //if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if keyboardShown == false {
                self.parentView.frame.origin.y -= 100
                //self.parentView.frame.origin.y -= keyboardSize.height
                keyboardShown = true
            }
        //}
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.parentView.frame.origin.y != 0 {
            if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                if keyboardShown == true {
                    //self.parentView.frame.origin.y += keyboardSize.height
                    self.parentView.frame.origin.y += 100
                    keyboardShown = false
                }
            }
        }
    }
    @IBAction func addButtonAction(_ sender: UIButton) {
        delegate?.didPressAdServicemButton(sender)
        nameServiceTextField.text = ""
        audienceTextField.text = ""
        descriptionTextField.text = ""
        daysTextField.text = ""
        timeTextField.text = ""
    }
    
    @IBAction func doneButtonAction(_ sender: UIButton) {
        delegate?.didPressReadyServiceButton(sender)
        nameServiceTextField.text = ""
        audienceTextField.text = ""
        descriptionTextField.text = ""
        daysTextField.text = ""
        timeTextField.text = ""
        parentView.removeFromSuperview()
    }
}

extension AddService: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return serviceCatalog?.count ?? 1
    }
    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return serviceCatalog?[row].name
    }
    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        nameServiceTextField.text = serviceCatalog?[row].name
        serviceID = serviceCatalog?[row].id ?? 1
    }
}
