//
//  DonationsWindow.swift
//  EncuentroCatolicoHome
//
//  Created by Desarrollo on 08/05/21.
//

import UIKit
import EncuentroCatolicoDonations

class DonationsWindow: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var alertTitle            : UILabel!
    @IBOutlet weak var btnAzteca             : UIButton!
    @IBOutlet weak var imgViewAzteca         : UIImageView!
    @IBOutlet weak var imgViewArrowA         : UIImageView!
    @IBOutlet weak var txtDonations          : UITextField!
    @IBOutlet weak var containerMonto        : UIView!
    @IBOutlet weak var stackView             : UIStackView! 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        designView()
        hideKeyboardWhenTappedAround()
    }
    
    func designView(){
        containerMonto.isHidden = true
        alertTitle.clipsToBounds = true
        alertTitle.layer.cornerRadius = 10
        alertTitle.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        let textSing = UILabel(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        textSing.text = "$"
        textSing.textAlignment = .center
        let viewToLeft = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        viewToLeft.addSubview(textSing)
        viewToLeft.translatesAutoresizingMaskIntoConstraints = false
        txtDonations.leftViewMode = .always
        txtDonations.leftView = nil
        txtDonations.leftView = viewToLeft
        txtDonations.keyboardType = .decimalPad
        txtDonations.setBottomBorder()
        txtDonations.delegate = self
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = CharacterSet(charactersIn: "1234567890")
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }
    
    @IBAction func openBAZ(_ sender: Any){
        if containerMonto.isHidden{
            UIView.animate(
                withDuration: 0.35,
                delay: 0,
                usingSpringWithDamping: 0.9,
                initialSpringVelocity: 1,
                options: [],
                animations: { [self] in
                    imgViewArrowA.image = UIImage(named: "arrowUp", in: Bundle.local, compatibleWith: nil)
                    containerMonto.isHidden = false
                    stackView.layoutIfNeeded()
                },
                completion: nil
            )
        }else{
            UIView.animate(
                withDuration: 0.35,
                delay: 0,
                usingSpringWithDamping: 0.9,
                initialSpringVelocity: 1,
                options: [],
                animations: { [self] in
                    imgViewArrowA.image = UIImage(named: "arrowDown", in: Bundle.local, compatibleWith: nil)
                    containerMonto.isHidden = true
                    stackView.layoutIfNeeded()
                },
                completion: nil
            )
        }
    }
    
    @IBAction func donationToOtherBanks(_ sender: Any){
        self.dismiss(animated: true, completion: {
            NotificationCenter.default.post(name: Notification.Name("openDonation"), object: nil)
        })
    }
    
    @IBAction func payWithQR(_ sender: Any){
        self.dismiss(animated: true, completion: {
            NotificationCenter.default.post(name: Notification.Name("openQR"), object: nil)
        })
    }
    
    @IBAction func goToBAZ(_ sender: Any){
        self.dismiss(animated: true, completion: { [self] in
            NotificationCenter.default.post(name: Notification.Name("goToBaz"), object: txtDonations.text!)
        })
    }
    
    @IBAction func close(_ sender: Any){
        self.dismiss(animated: true, completion: nil)
    }
}
