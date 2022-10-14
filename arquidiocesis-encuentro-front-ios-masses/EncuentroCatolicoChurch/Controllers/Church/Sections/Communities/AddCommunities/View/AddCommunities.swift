//
//  AddCommunities.swift
//  EncuentroCatolicoChurch
//
//  Created by Jorge Garcia on 16/08/21.
//

import UIKit
public protocol AddCommunitiesModalButtonDelegate: AnyObject {
    func didPressReadyRegisterButton(_ sender: UIButton)
    func didPressAddComButton(_ sender: UIButton)
}

protocol AddComDataSendingDelegateProtocol {
    func sendDatAddComToComMainViewController(array: [LinkedCommunity])
}

struct AddCommunityModel: Codable {
    let name: String?
    let email: String?
    let phone: String?
    let leader: String?
}
class AddCommunities: UIView, UITextFieldDelegate {
    var delegatedata: AddComDataSendingDelegateProtocol? = nil
    public weak var delegate: AddCommunitiesModalButtonDelegate?
    @IBOutlet weak var communityNameText: UITextField!
    @IBOutlet weak var responsableTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var mailTextField: UITextField!
    @IBOutlet var parentView: UIView!
    static let instance = AddCommunities()
    var addCommunitiesArray: [LinkedCommunity] = []
    override init(frame: CGRect) {
        super.init(frame: frame)
        Bundle.local.loadNibNamed("AddCommunities", owner: self, options: nil)
        nibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        nibSetup()
    }
    
    private func nibSetup() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        parentView.frame = CGRect(x: 0, y: 350, width: 414, height: 534)
        parentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        self.communityNameText.tag = 0
        self.responsableTextField.tag = 1
        self.phoneTextField.tag = 2
        self.mailTextField.tag = 3
        
        self.communityNameText.delegate = self
        self.responsableTextField.delegate = self
        self.phoneTextField.delegate = self
        self.mailTextField.delegate = self
        
        self.communityNameText.returnKeyType = UIReturnKeyType.next
        self.responsableTextField.returnKeyType = UIReturnKeyType.next
        self.phoneTextField.returnKeyType = UIReturnKeyType.next
        self.mailTextField.returnKeyType = UIReturnKeyType.done
        
        self.mailTextField.keyboardType = .emailAddress
        self.phoneTextField.keyboardType = .numberPad
    }
    
    func showAllert() {
        UIApplication.shared.keyWindow?.addSubview(parentView)
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
        case self.communityNameText:
            self.communityNameText.becomeFirstResponder()
        case self.responsableTextField:
            self.responsableTextField.becomeFirstResponder()
        case self.phoneTextField:
            self.phoneTextField.becomeFirstResponder()
        default:
            
            self.mailTextField.resignFirstResponder()
        }
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.parentView.frame.origin.y == 350 {
                self.parentView.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.parentView.frame.origin.y != 0 {
            self.parentView.frame.origin.y = 350
        }
    }
    
    @IBAction func addButtonAction(_ sender: UIButton) {
        delegate?.didPressAddComButton(sender)
        let nameCom = communityNameText.text
        let nameResp = responsableTextField.text
        let phone = phoneTextField.text
        let email = mailTextField.text
        if addCommunitiesArray.isEmpty {
            addCommunitiesArray.insert(LinkedCommunity.init(name: nameCom, email: email, phone: phone, leader: nameResp), at: 0)
        }else {
            addCommunitiesArray.append(LinkedCommunity.init(name: nameCom, email: email, phone: phone, leader: nameResp))
        }
        communityNameText.text = ""
        responsableTextField.text = ""
        phoneTextField.text = ""
        mailTextField.text = ""
    }
    @IBAction func readyButtonAction(_ sender: UIButton) {
        delegate?.didPressReadyRegisterButton(sender)
        delegatedata?.sendDatAddComToComMainViewController(array: addCommunitiesArray )
    }
}
