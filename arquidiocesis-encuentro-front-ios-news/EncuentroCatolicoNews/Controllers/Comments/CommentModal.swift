//
//  CommentModal.swift
//  EncuentroCatolicoNews
//
//  Created by Billy on 19/11/21.
//

import Foundation
import UIKit

class CommentModal: UIViewController /*RSCommentsViewProtocols*/{
    
    var arrayRelations = [ResultsRelations]()
    var defaults = UserDefaults.standard
    var orgId: Int?
    var asPrm: Int = 1
    var scope: Int = 1
    
    func didFinishAddPostCommnet(isReload: Bool) {
        dismiss(animated: true, completion: nil)
    }
    
    func didFinishGettingComments(isFromPage: Bool, comments: [CmComments]) {
        
    }
    
    func didFinishGettingCommentsWithErrors(error: SocialNetworkErrors) {
        print("Error  emn el comentaripo")
    }
    
    
    var presenter : RSCommentsPresenterProtocol?
    var interacto = RSCommentsInteractor()
    @IBOutlet weak var vwBackgroud: UIView!
    @IBOutlet weak var vwContainer: UIView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imvUser: UIImageView!
    @IBOutlet weak var replyTextField: UITextView!
    @IBOutlet weak var btnPublic: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    
    var nameImg = ""
    var newPost: Posts?
    
    @IBOutlet weak var BtnPicker: UIButton!
    @IBOutlet weak var pickerUsers: UIPickerView!
    @IBOutlet weak var bottomCardConstraint: NSLayoutConstraint!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        setUp()
        setupBackgroundShadow()
        setupGestures()
        setUpReplyDelegateObject()
    }
    
    func setUp(){
        imvUser.setImage(name: nameImg, image: nil)
        imvUser.loadS(urlS: UserDefaults.standard.string(forKey: "imageUrl") ?? "")
        //, imageProfile: UserDefaults.standard.string(forKey: "imageUrl") ?? ""
        lblName.text = UserDefaults.standard.string(forKey: "COMPLETENAME")
        vwContainer.layer.cornerRadius = 18
        vwContainer.clipsToBounds = true
        let bOtherUser  = arrayRelations.count > 1 ? true : false
        lblName.isHidden = bOtherUser
        BtnPicker.isHidden = !bOtherUser
        pickerUsers.isHidden = true
        pickerUsers.isHidden = true
        pickerUsers.delegate = self
        pickerUsers.dataSource = self
    }
    
    private func setupBackgroundShadow() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            UIView.animate(withDuration: 0.3) {
                self.vwBackgroud.alpha = 0.4
            }
        }
    }
    
    func setUpReplyDelegateObject(){
        replyTextField.delegate = self
    }
    
    private func setupGestures() {
        let tapSuperview = UITapGestureRecognizer(target: self, action: #selector(TapSuperviewComment))
        self.vwBackgroud.addGestureRecognizer(tapSuperview)
    }
    
    @objc func TapSuperviewComment() {
        vwBackgroud.alpha = 0
        self.bottomCardConstraint.constant = 0
        self.dismiss(animated: true, completion: nil)
    }
    
    class public func showModalComment(type: String) -> CommentModal{
        let view = CommentModal(nibName: "CommentModal", bundle: Bundle(identifier: "mx.arquidiocesis.EncuentroCatolicoNews"))
        view.modalPresentationStyle = .overFullScreen
        return view
    }
    
    @IBAction func btnCancel(_ sender: UIButton) {
        self.vwBackgroud.alpha = 0
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnActionPost(_ sender: UIButton) {
        print("publicar coment 1")
        if replyTextField.text.isEmpty{
            print("Debe de llenar el text")
        }else{
            presenter?.makeCommentToComment(postId: newPost?.id ?? 0, commentId: nil, userId: 0, content: replyTextField.text, asParam: asPrm, groupId: orgId ?? 0, scope: scope)
        }
    }
    
    @IBAction func btnActionPicker(_ sender: UIButton) {
        pickerUsers.isHidden = false
    }
    
}


extension CommentModal: UITextViewDelegate{
    public func textViewDidBeginEditing(_ textView: UITextView){
        if replyTextField.text == "Responder"{
            replyTextField.text = ""
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                UIView.animate(withDuration: 0.5) {
                    self.bottomCardConstraint.constant = 30
                }
            }
            
        }
    }
    
    public func textViewDidEndEditing(_ textView: UITextView) {
        if replyTextField.text == ""{
            self.bottomCardConstraint.constant = 0
            replyTextField.text = "Responder"
        }
    }
}

extension CommentModal: UIPickerViewDelegate, UIPickerViewDataSource{
    
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arrayRelations.count
    }
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return arrayRelations[row].name
    }
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        BtnPicker.setTitle(arrayRelations[row].name, for: .normal)
        
        if arrayRelations[row].id == nil {
            scope = 1
            asPrm = 1
        }else{
            asPrm = 2
            scope =  (arrayRelations[row].type ?? 0) + 1
            orgId = arrayRelations[row].id
        }
        
        pickerUsers.isHidden = true
    }
}

extension CommentModal{
    func successGetRelations(data: RelationsData){
        let addUser = ResultsRelations(id: nil, image: nil, name: defaults.string(forKey: "COMPLETENAME"), type: 1)
        arrayRelations = data.result ?? arrayRelations
        arrayRelations.append(addUser)
        pickerUsers.delegate = self
        pickerUsers.dataSource = self
        
        if data.result?.count == 0 {
            BtnPicker.isHidden = true
            lblName.isHidden = false
        }else{
            BtnPicker.isHidden = false
            lblName.isHidden = true
        }
    }
    
    func failGetRelations(mesage: String) {
        BtnPicker.isHidden = true
    }
}
