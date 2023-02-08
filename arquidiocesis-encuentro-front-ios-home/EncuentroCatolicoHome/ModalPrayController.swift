//
//  ModalPrayController.swift
//  EncuentroCatolicoHome
//
//  Created by Pablo Luis Velazquez Zamudio on 18/10/21.
//

import UIKit

open class ModalPrayController: UIViewController {
    
// MARK: @IBOUTLETS -
    @IBOutlet weak var backgorundShadow: UIView!
    @IBOutlet weak var addPrayCardview: UIView!
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnPublish: UIButton!
    @IBOutlet weak var lineaView: UIView!
    @IBOutlet weak var prayText: UITextView!
    @IBOutlet weak var bottomCardConstraint: NSLayoutConstraint!
    
    // Add state Outlets
    @IBOutlet weak var usersTable: UITableView!
    
// MARK: SINGLETON LET -
    static let singleton = ModalPrayController()
    
// MARK: LOCAL VAR -
    var typeView = "Unspecified"
    var arrayPersons = [String]()
    var sendText = ""
    
// MARK: LIFE CYCLE VIEW FUNCTIONS -
    open override func viewDidLoad() {
        super.viewDidLoad()
        setupBackgroundShadow()
        setupUI()
        logicTypeView()
        setupDelegatesObjects()
        setupGestures()
    }
    
// MARK: SETUP FUNCTIONS -
    private func setupBackgroundShadow() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            UIView.animate(withDuration: 0.3) {
                self.backgorundShadow.alpha = 0.4
            }
        }
    }
    
    private func setupGestures() {
        let tapSuperview = UITapGestureRecognizer(target: self, action: #selector(TapSuperview))
        self.backgorundShadow.addGestureRecognizer(tapSuperview)
    }
    
    private func setupUI() {
        addPrayCardview.layer.cornerRadius = 18
        addPrayCardview.clipsToBounds = true
        userImg.borderButtonColor(color: UIColor(red: 25/255, green: 42/255, blue: 115/255, alpha: 1), radius: userImg.bounds.width / 2)
        btnCancel.borderButtonColor(color: UIColor(red: 25/255, green: 42/255, blue: 115/255, alpha: 1), radius: 8)
        btnPublish.layer.cornerRadius = 8
        if #available(iOS 13.0, *) {
            let url = UserDefaults.standard.string(forKey: "imageUrl")
            if url == nil {
                userImg.image = UIImage(named: "userImage",in: Bundle.local, with: nil)
            }else{
                userImg.DownloadStaticImageH(url ?? "")
            }
           
        }else{
            // Fallback on earlier versions
        }
        
        let valueOfText = UserDefaults.standard.string(forKey: "COMPLETENAME")
        lblUserName.text = valueOfText
       
    }
    
    func setupDelegatesObjects() {
        prayText.delegate = self
    }
    
    func setupDelegates() {
        usersTable.delegate = self
        usersTable.dataSource = self
        usersTable.reloadData()
    }
    
// MARK: SERVICES FUNCTIONS -
    
// MARK: LOGIC FUNCTIONS -
    private func logicTypeView() {
        switch typeView {
        case "LIST":
            usersTable.isHidden = false
            btnCancel.isHidden = true
            btnPublish.setTitle("Listo", for: .normal)
            setupDelegates()
            
        default:
            usersTable.isHidden = true
        }
    }
    
    // MARK: @IBACTIONS -
    @IBAction func cancelAction(_ sender: Any) {
        self.backgorundShadow.alpha = 0
        let singletonPray = Home_CadenaOracion.singleton
        singletonPray.publish = "NO"
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func publishAction(_ sender: Any) {
        switch typeView {
        case "LIST":
            backgorundShadow.alpha = 0
            self.dismiss(animated: true, completion: nil)
        default:
            if prayText.text.trimmingCharacters(in: .whitespacesAndNewlines).count != 0 && prayText.text != "Escribe tu causa para orar" {
                backgorundShadow.alpha = 0
                let singleton = ModalPrayController.singleton
                let singletonPray = Home_CadenaOracion.singleton
                singletonPray.publish = "YES"
                singleton.sendText = prayText.text ?? ""
                self.dismiss(animated: true, completion: nil)
            }else{
                print("DEBUG: DO NOT DISMISS")
            }
        }
    }
    
// MARK: @OBJC FUNCTIONS -
    @objc func TapSuperview() {
        backgorundShadow.alpha = 0
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: - Inicialización
    class public func showModal(type: String, personList: [String]) -> ModalPrayController {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle(for: ModalPrayController.self))
        let view = storyboard.instantiateViewController(withIdentifier: "MODALPRAY") as! ModalPrayController
        view.modalPresentationStyle = .overFullScreen
        view.arrayPersons = personList
        view.typeView = type
        
        return view
    }
    
}

extension ModalPrayController: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayPersons.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LISTCELL", for: indexPath) as! ListPrayCell
        cell.lblUserName.text = arrayPersons[indexPath.row]
        cell.userImg.layer.cornerRadius = cell.userImg.bounds.width / 2
        if #available(iOS 13.0, *) {
            cell.userImg.image = UIImage(named: "userImage",in: Bundle.local, with: nil)
            
        }else{
            // Fallback on earlier versions
        }
        return cell
    }
        
}

extension ModalPrayController: UITextViewDelegate {
   
    public func textViewDidBeginEditing(_ textView: UITextView) {
        if prayText.text == "Escribe tu causa para orar" {
            prayText.text = ""
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.bottomCardConstraint.constant = 30
            }
        }
    }
    
    public func textViewDidEndEditing(_ textView: UITextView) {
        if prayText.text == "" {
            bottomCardConstraint.constant = 0
            prayText.text = "Escribe tu causa para orar"
        }
    }
    
}
