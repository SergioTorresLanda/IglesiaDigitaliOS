//
//  AddMasses.swift
//  EncuentroCatolicoChurch
//
//  Created by Jorge Garcia on 28/09/21.
//

import UIKit

public protocol AddMassesModalButtonDelegate: AnyObject {
    func didPressReadyMassesButton(_ sender: UIButton, hourTxt: String, daysTxt: [Bool])
    func didPressAdMassesButton(_ sender: UIButton, hourTxt: String, daysTxt: String)
}

class AddMasses: UIView, UITextFieldDelegate {
    public weak var delegate: AddMassesModalButtonDelegate?
    static let instance = AddMasses()
    @IBOutlet var parentView: UIView!
    @IBOutlet weak var dyasTextfield: UITextField!
    @IBOutlet weak var hourTextField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var readyButton: UIButton!
    
    private lazy var sdTimePicker: TimePicker = {
        let picker = TimePicker()
        picker.setup()
        picker.didSelectDates = { [weak self] (startDate, endDate) in
            let text = Date.buildTimeRangeString(startDate: startDate, endDate: endDate)
            self?.hourTextField.text = text
        }
        return picker
    }()
    
    private lazy var sdDayPicker: DayPicker = {
        let picker = DayPicker()
        picker.setup()
        picker.didSelectDates = { [weak self] (startDate, endDate) in
            let text = Date.buildDayRangeString(startDate: startDate, endDate: endDate)
            self?.dyasTextfield.text = text
        }
        return picker
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        Bundle.local.loadNibNamed("AddMasses", owner: self, options: nil)
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
        hourTextField.inputView = sdTimePicker.inputView
        dyasTextfield.inputView = sdDayPicker.inputView
        hourTextField.delegate = self
        dyasTextfield.delegate = self
        hourTextField.inputAccessoryView = toolBar
        dyasTextfield.inputAccessoryView = toolBar
    }
    
    func showAllert() {
        UIApplication.shared.keyWindow?.addSubview(parentView)
    }
    
    @objc func doneClick() {
        hourTextField.resignFirstResponder()
        dyasTextfield.resignFirstResponder()
     }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            self.parentView.frame.origin.y -= keyboardSize.height
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.parentView.frame.origin.y != 0 {
            if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                self.parentView.frame.origin.y += keyboardSize.height
            }
        }
    }
    @IBAction func addButtonAction(_ sender: UIButton) {
        delegate?.didPressAdMassesButton(sender, hourTxt: "", daysTxt: "")
        hourTextField.text = ""
        dyasTextfield.text = ""
    }
    @IBAction func readyButtonAction(_ sender: UIButton) {
        delegate?.didPressReadyMassesButton(sender, hourTxt: "", daysTxt: [])
        hourTextField.text = ""
        dyasTextfield.text = ""
        parentView.removeFromSuperview()
    }
}
