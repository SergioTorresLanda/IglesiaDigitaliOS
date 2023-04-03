//
//  AddSocial.swift
//  EncuentroCatolicoChurch
//
//  Created by Jorge Garcia on 25/08/21.
//

import UIKit

class AddSocial: UIView, UITextFieldDelegate {
    
    var keyboardShown: Bool = false
    static let instance = AddSocial()
    public weak var delegate: AddSocialModalButtonDelegate?
    @IBOutlet var parentView: UIView!
    @IBOutlet weak var socialSellectorTextField: UITextField!
    @IBOutlet weak var socialTextField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var raedyButton: UIButton!
    @IBOutlet weak var socialLabel: UILabel!
    @IBOutlet weak var CBottomKeyboard: NSLayoutConstraint!
    let pickerView = UIPickerView()
    let socialArray = ["Facebook", "Twitter", "Instagram", "Streaming", "Web"]
    var sellectedSocial = Int()
    override init(frame: CGRect) {
        super.init(frame: frame)
        Bundle.local.loadNibNamed("AddSocial", owner: self, options: nil)
        nibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        nibSetup()
    }
    
    private func nibSetup() {
        socialLabel.isHidden = true
        socialTextField.isHidden = true
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.init(named: "eMainBlue")
        toolBar.sizeToFit()

        let donePickerButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.doneClick))
        toolBar.setItems([donePickerButton], animated: false)
        
        socialSellectorTextField.inputView = pickerView
        socialSellectorTextField.inputAccessoryView = toolBar
        pickerView.delegate = self
        
        socialTextField.delegate = self
        socialTextField.returnKeyType = UIReturnKeyType.done

        addButton.isEnabled = false
        raedyButton.isEnabled = false
        addButton.alpha = 0.5
        raedyButton.alpha = 0.5
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == socialTextField {
            if socialSellectorTextField.text?.isEmpty == false && socialTextField.text?.isEmpty == false {
                addButton.isEnabled = true
                raedyButton.isEnabled = true
                addButton.alpha = 1
                raedyButton.alpha = 1
                NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
            }else {
                NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
            }
        }
    }
    func showAllert() {
        UIApplication.shared.keyWindow?.addSubview(parentView)
    }
    
    @objc func doneClick() {
        socialSellectorTextField.resignFirstResponder()
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
        delegate?.didPressAddSocialmButton(sender)
        socialTextField.text = ""
    }
    @IBAction func raedyButtonAction(_ sender: UIButton) {
        delegate?.didPressReadySocialButton(sender)
        socialTextField.text = ""
        parentView.removeFromSuperview()
    }
}

extension AddSocial:  UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return socialArray.count
    }
    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
     return socialArray[row]
    }
    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        socialSellectorTextField.text = socialArray[row]
        socialLabel.isHidden = false
        socialTextField.isHidden = false
        socialLabel.text = socialArray[row]
        
        switch row {
        case 0:
            socialTextField.placeholder = "www.facebook.com/yourprofileid"
            sellectedSocial = 0
        case 1:
            socialTextField.placeholder = "@miiglesia"
            sellectedSocial = 1
        case 2:
            socialTextField.placeholder = "www.instagram.com/yourprofileid"
            sellectedSocial = 2
        case 3:
            socialTextField.placeholder = "www.youtube.com/yourprofileid"
            sellectedSocial = 3
        case 4:
            socialTextField.placeholder = "www.ejemplo.com"
            sellectedSocial = 4
        default:
            socialTextField.placeholder = ""
        }
        
    }
}
