//
//  NewAddSocialController.swift
//  EncuentroCatolicoChurch
//
//  Created by Pablo Luis Velazquez Zamudio on 04/02/22.
//

import UIKit

public protocol AddSocialModalButtonDelegate: AnyObject {
    func didPressReadySocialButton(_ sender: UIButton)
    func didPressAddSocialmButton(_ sender: UIButton)
    func pressReadySocial(sender: UIButton, socialTxt: String, socialIndex: Int)
    func pressAddSocial(sender: UIButton, socialTxt: String, socialIndex: Int)
}

class NewAddSocialController: UIViewController {
    
// MARK: @IBOUTLETS -
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var mainContentCard: UIView!
    @IBOutlet weak var subContentCard: UIView!
    @IBOutlet weak var lblSocialNetwork: UILabel!
    @IBOutlet weak var socialSellectorTextField: UITextField!
    @IBOutlet weak var socialTextField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var readyButton: UIButton!
    @IBOutlet weak var socialLabel: UILabel!
    @IBOutlet weak var firstLine: UIView!
    @IBOutlet weak var secondLine: UIView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    var keyboardShown: Bool = false
    static let instance = NewAddSocialController()
    public weak var delegate: AddSocialModalButtonDelegate?
    let pickerView = UIPickerView()
    let socialArray = ["Facebook", "Twitter", "Instagram", "Streaming", "Web"]
    var sellectedSocial = Int()

// MARK: LIFE CYCLE VIEW FUNCTIONS -
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        nibSetup()
        setupGestures()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("VC ECChurch - AddSocial - NewAddSocialVC")
    }
    
// MARK: SETUP FUNCTIONS -
    private func setupUI() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            UIView.animate(withDuration: 0.3) {
                self.shadowView.alpha = 0.4
            }
        }
        
        mainContentCard.layer.cornerRadius = 10
    }
    
    private func setupGestures() {
        let tapShadow = UITapGestureRecognizer(target: self, action: #selector(TapDissmiss))
        shadowView.addGestureRecognizer(tapShadow)
    }
    
    private func nibSetup() {
        socialLabel.isHidden = true
        socialTextField.isHidden = true
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
        readyButton.isEnabled = false
        secondLine.isHidden = true
        addButton.alpha = 0.5
        readyButton.alpha = 0.5
    }
    
// MARK: @IBACTIONS -
    @IBAction func addButtonAction(_ sender: UIButton) {
        //delegate?.didPressAddSocialmButton(sender)
        delegate?.pressAddSocial(sender: sender, socialTxt: socialTextField.text ?? "", socialIndex: sellectedSocial)
        socialTextField.text = ""
    }
    
    @IBAction func readyButtonAction(_ sender: UIButton) {
        //delegate?.didPressReadySocialButton(sender)
        delegate?.pressReadySocial(sender: sender, socialTxt: socialTextField.text ?? "", socialIndex: sellectedSocial)
        socialTextField.text = ""
        shadowView.alpha = 0
        self.dismiss(animated: true, completion: nil)
    }
    
// MARK: @OBJC FUNCTIONS -
    @objc func doneClick() {
        UIView.animate(withDuration: 0.5) {
            self.bottomConstraint.constant = 0
        }
        socialSellectorTextField.resignFirstResponder()
     }
    
    @objc func TapDissmiss() {
        shadowView.alpha = 0
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: UIPICKER VIEW DELEGATES -
extension NewAddSocialController: UIPickerViewDelegate, UIPickerViewDataSource {
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
        secondLine.isHidden = false
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

//MARK: UITEXTFIELD DELEGATE -
extension NewAddSocialController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        UIView.animate(withDuration: 0.5) {
            self.bottomConstraint.constant = 0
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case socialTextField:
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                self.bottomConstraint.constant = 70
                
            }
        default:
            break
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == socialTextField {
            if socialSellectorTextField.text?.isEmpty == false && socialTextField.text?.isEmpty == false {
                addButton.isEnabled = true
                readyButton.isEnabled = true
                addButton.alpha = 1
                readyButton.alpha = 1
            
            }
        }
    }
}
