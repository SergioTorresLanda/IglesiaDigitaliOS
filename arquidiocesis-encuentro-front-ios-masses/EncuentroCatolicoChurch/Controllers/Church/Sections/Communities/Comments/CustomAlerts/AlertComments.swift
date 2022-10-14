//
//  AlertComments.swift
//  EncuentroCatolicoChurch
//
//  Created by Pablo Luis Velazquez Zamudio on 11/10/21.
//

import UIKit

open class AlertComments: UIViewController {
    
    var titulo: String?
    var mensaje: String?
    
// MARK: @IBOUTLETS -
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblAlertText: UILabel!
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var btnContinue: UIButton!
    @IBOutlet weak var icon: UIImageView!
    

    open override func viewDidLoad() {
        super.viewDidLoad()
        initUI()

    }
    
    func initUI() {
        cardView.layer.cornerRadius = 10
        btnDelete.layer.cornerRadius = 8
        btnContinue.layer.cornerRadius = 8
        btnDelete.roundedNborder(borderColor: UIColor.init(red: 25/255, green: 42/255, blue: 115/255, alpha: 1))
        lblTitle.text = titulo
        if mensaje == "NotEdited" {
            lblAlertText.text = ""
        }else{
            lblAlertText.text = mensaje
        }
        
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { (timer) in
            UIView.animate(withDuration: 0.2) {
                self.shadowView.alpha = 0.25
            }
        }
        
    }
    
    @IBAction func deleteAction(_ sender: Any) {
        if mensaje == "NotEdited" {
            let singleton = CommentsViewController.singleton
            singleton.yesDelete = "FALSE"
            
        }else{
            let singleton = CommentsViewController.singleton
            singleton.yesDelete = "false"
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func continueAction(_ sender: Any) {
        if mensaje == "NotEdited" {
            let singleton = CommentsViewController.singleton
            singleton.yesDelete = "TRUE"
        }else{
            let singleton = CommentsViewController.singleton
            singleton.yesDelete = "true"
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    class public func showAertDelete(titulo: String, mensaje: String) -> AlertComments {
        let storyboard = UIStoryboard(name: "CommentsStoryboard", bundle: Bundle(for: AlertComments.self))
        let view = storyboard.instantiateViewController(withIdentifier: "AlertDelete") as! AlertComments
        view.modalPresentationStyle = .overFullScreen
        view.titulo = titulo
        view.mensaje = mensaje
        
        return view
    }
    
    
}

extension UIButton {
    
    func roundedNborder(borderColor: UIColor) {
        layer.borderWidth = 1
        layer.borderColor = borderColor.cgColor
        backgroundColor = .clear
        setTitleColor(borderColor, for: .normal)
        
    }
    
}
