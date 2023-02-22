//
//  SocialSearchView.swift
//  EncuentroCatolicoPrayers
//
//  Created by Pablo Luis Velazquez Zamudio on 25/01/22.
//

import UIKit
import EncuentroCatolicoVirtualLibrary

class SocialSearchView: UIViewController, SocialSearchViewProtocol {
    
// MARK: PROTOCOL VAR -
    var presenter: SocialSearchPresenterProtocol?
    
// MARK: @IBOUTLETS -
    @IBOutlet weak var customNavBar: UIView!
    @IBOutlet weak var lblNavBar: UILabel!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var mainTableView: UITableView!
    @IBOutlet weak var btnCross: UIButton!
    
// MARK: LOCAL VAR -
    var arrayDataDummy = ["San Francisco de Asís", "San Francisco de Borja", "Comunidad de Paula", "San Francisco de Sales", "Francisco Javier Lopez", "Francisco Hugo Rojas", "Francisca Luigi Beltran"]
    var isFollowing = [false, false, true, false, true, true, false]
    
    var arrayResults = [ResultsSearch]()
    var paloma = "https://firebasestorage.googleapis.com/v0/b/emerwise-479d1.appspot.com/o/randomAssets%2Fspirit.webp?alt=media&token=dd020c20-d8ec-45f6-a8a2-3783c0234012"
    let loadingAlert = UIAlertController(title: "", message: "\n \n \n \n \nCargando...", preferredStyle: .alert)
// MARK: LIFE CYCLE VIEW FUNCTIONS -
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        hideKeyboardWhenTappedAround()
        setupUI()
        addDoneButtonOnKeyboard()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if searchField.text != ""{
            presenter?.requestSearch(searchText: searchField.text ?? "")
        }
    }
    
// MARK: SETUP FUNCTIONS -
    private func setupTableView() {
        if #available(iOS 13.0, *) {
            mainTableView.register(UINib(nibName: "followCell", bundle: Bundle.local), forCellReuseIdentifier: "FOLLOWCELL")
        }else {
            // Fallback on earlier versions
        }
        mainTableView.delegate = self
        mainTableView.dataSource = self
    }
    
    private func setupUI() {
        customNavBar.layer.cornerRadius = 20
        backBtn.setTitle("", for: .normal)
        btnCross.setTitle("", for: .normal)
    }
    
// MARK: @IBACTIONS -
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func textDidChangeEditing(_ sender: Any) {
        self.presenter?.requestSearch(searchText: searchField.text ?? "")
        if searchField.text != "" {
            btnCross.isHidden = false
        }else{
            btnCross.isHidden = true
        }
    }
    
    @IBAction func clearAction(_ sender: Any) {
        searchField.text = ""
        btnCross.isHidden = true
    }
    
    func hideKeyboardWhenTappedAround(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
// MARK: @OBJC FUNCTIONS -
    @objc func TapFollow(sender: UIButton) {////ya no se usa
        showLoading()
        let sectionData = arrayResults[sender.tag]
        var type = 5
        switch sectionData.type {
        case "Church":
            type = 2
        case "Community":
            type = 3
        default:
            type = 1
        }
        if sectionData.relationship != nil {
            presenter?.requestFollowUF(method: "DELETE", entityId: sectionData.id ?? 0, entityType: type)
        }else{
            presenter?.requestFollowUF(method: "POST", entityId: sectionData.id ?? 0, entityType: type)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.hideLoading()
            self.presenter?.requestSearch(searchText: self.searchField.text ?? "")
        }
    }
    
    func showLoading() {
        let imageView = UIImageView(frame: CGRect(x: 75, y: 25, width: 140, height: 60))
        imageView.image = UIImage(named: "logoEncuentro", in: Bundle.local, compatibleWith: nil)
        loadingAlert.view.addSubview(imageView)
        present(loadingAlert, animated: true, completion: nil)
    }
    func hideLoading() {
        loadingAlert.dismiss(animated: true, completion: nil)
    }
    
    //MARK: KEYBOARD
    func addDoneButtonOnKeyboard(){
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
             doneToolbar.barStyle = .default
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Listo", style: .done, target: self, action: #selector(self.doneButtonAction))
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        searchField.inputAccessoryView = doneToolbar
    }

    @objc func doneButtonAction(){
        searchField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    // For showing/hiding keyboard
    func registerForKeyboardNotifications(){
        //Adding notifies on keyboard appearing
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWasShown(notification:)),
            name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func deregisterFromKeyboardNotifications(){
        //Removing notifies on keyboard appearing
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
 
    @objc func keyboardWasShown(notification: NSNotification){
    }
    
    @objc func keyboardWillBeHidden(notification: NSNotification){
        self.view.endEditing(true)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField){
    }
    
    func textFieldDidEndEditing(_ textField: UITextField){
    }

}

// MARK: SEARCH REPONSE -
extension SocialSearchView {
    func successSearch(data: SerachResponse) {
        arrayResults = data.result?.results ?? arrayResults
        mainTableView.reloadData()
    }
    
    func failSearch(message: String) {
        print(message)
    }
}

extension SocialSearchView {
    func successFollowUF(data: FollowResponse) {
        self.presenter?.requestSearch(searchText: searchField.text ?? "")
    }
    
    func failFollowUF(message: String) {
        print(message)
    }
}

extension SocialSearchView: followCellProtocol{
    func actionSelected(index: Int) {
        showLoading()
        let sectionData = arrayResults[index]
        var type = 5
        switch sectionData.type {
        case "Church":
            type = 2
        case "Community":
            type = 3
        default:
            type = 1
        }
        if sectionData.relationship != nil {
            print("presenter DELETE")
            presenter?.requestFollowUF(method: "DELETE", entityId: sectionData.id ?? 0, entityType: type)
        }else{
            print("presenter POST")
            presenter?.requestFollowUF(method: "POST", entityId: sectionData.id ?? 0, entityType: type)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.hideLoading()
            self.presenter?.requestSearch(searchText: self.searchField.text ?? "")
        }
    }
}

