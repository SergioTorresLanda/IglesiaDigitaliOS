//
//  InputAlertController.swift
//  EncuentroCatolicoVirtualLibrary
//
//  Created by Pablo Luis Velazquez Zamudio on 17/06/21.
//

import UIKit

open class InputAlertController: UIViewController {

    var tagAlert: Int?
    
    @IBOutlet weak var shadowAlert: UIView!
    // MARK: Two factor alert -
    @IBOutlet weak var cardAlertTwo: UIView!
    @IBOutlet weak var lblMainTwo: UILabel!
    @IBOutlet weak var lblNombre: UILabel!
    @IBOutlet weak var lineaNombreTF: UIView!
    @IBOutlet weak var lblDireccion: UILabel!
    @IBOutlet weak var lineaDireccionTF: UIView!
    @IBOutlet weak var btnEnviarTwo: UIButton!
    @IBOutlet weak var nameFieldTwo: UITextField!
    @IBOutlet weak var directionFieldTwo: UITextField!
    @IBOutlet weak var directionFieldOne: UITextField!
    
//MARK: One factor alert -
    @IBOutlet weak var cardAlertOne: UIView!
    @IBOutlet weak var lblMainOne: UILabel!
    @IBOutlet weak var lblDireccionOne: UILabel!
    @IBOutlet weak var lineaDireccionTFOne: UIView!
    @IBOutlet weak var btnEnviarOne: UIButton!
    
    open override func viewDidLoad() {
        super.viewDidLoad()

        setupGestures()

        cardAlertOne.layer.cornerRadius = 12
        cardAlertTwo.layer.cornerRadius = 12
        btnEnviarTwo.layer.cornerRadius = 8
        btnEnviarOne.layer.cornerRadius = 8
        nameFieldTwo.delegate = self
        directionFieldTwo.delegate = self
        directionFieldOne.delegate = self
        
        nameFieldTwo.returnKeyType = .next
        directionFieldTwo.returnKeyType = .done
        directionFieldOne.returnKeyType = .done
        
        switch tagAlert {
        case 0:
            cardAlertOne.alpha = 0
            cardAlertTwo.alpha = 1
        default:
            cardAlertOne.alpha = 1
            cardAlertTwo.alpha = 0
        }
        
    }
    
   open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    print("View will appear")
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { (timer) in
            UIView.animate(withDuration: 0.2) {
                self.shadowAlert.alpha = 0.25
            }
            
        }
    }
    
     func setupGestures() {
        let tapShadowGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapShadow))
        self.shadowAlert.addGestureRecognizer(tapShadowGesture)
        
    }
    
    @objc func handleTapShadow() {
        let singleton = PrincipalViewSOS.singleton
        singleton.isTap = true
        UIView.animate(withDuration: 0.1) {
            self.shadowAlert.alpha = 0
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnEnviarTwo(_ sender: Any) {
        
        if nameFieldTwo.text != "" && directionFieldTwo.text != "" {
            let singleton = PrincipalViewSOS.singleton
            singleton.isTap = false
            singleton.direction = directionFieldTwo.text ?? "nil"
            UIView.animate(withDuration: 0.1) {
                self.shadowAlert.alpha = 0
            }
            self.dismiss(animated: true) {
            }
        }
        
    }
    
    @IBAction func btnEnviarOne(_ sender: Any) {
        
        if directionFieldOne.text != "" {
            let singleton = PrincipalViewSOS.singleton
            singleton.isTap = false
            singleton.direction = directionFieldOne.text ?? "nil"
            UIView.animate(withDuration: 0.1) {
                self.shadowAlert.alpha = 0
            }
            self.dismiss(animated: true) {
            }
        }
        
    }
    
    class public func showAlertInput(index: Int, controller: UIViewControllerTransitioningDelegate) -> InputAlertController {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle(for: InputAlertController.self))
        let view = storyboard.instantiateViewController(withIdentifier: "InputAlertController") as! InputAlertController
        view.transitioningDelegate = controller
        view.modalPresentationStyle = .overFullScreen
       // view.modalPresentationStyle = .overCurrentContext
        
        view.tagAlert = index
        
        return view
    }

}

extension InputAlertController: UITextFieldDelegate{
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch textField {
        case nameFieldTwo:
            directionFieldTwo.becomeFirstResponder()
        default:
            self.view.endEditing(true)
        }
        
        return true
    }
    
}
