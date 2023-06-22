//
//  HomeServicesController.swift
//  Services
//
//  Created by Miguel Eduardo  Valdez Tellez  on 21/04/21.
//

import UIKit
import EncuentroCatolicoVirtualLibrary
import Foundation

class Home_Servicios: BaseViewController,HomeServiceViewProtocol, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var customNavBar: UIView!
    @IBAction func dissButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    let titleData = ["Intenciones", "Otros servicios", "Sacramentos"]
    let subDat = ["Menciones en la misa", "Bendiciones, celebraciones y otros" , "Requisitos"]
    let profile = UserDefaults.standard.string(forKey: "profile")
    let locationcomponents = UserDefaults.standard.object(forKey: "locationModuleComponents") as? [String]
    var imageDat: [UIImage?] = []
    var presenter: HomeServicePresenterProtocol?
    let newUser = UserDefaults.standard.bool(forKey: "isNewUser")
    var alertFields : AcceptAlert?
    var alertFields2 : AcceptAlertLogin?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setImage()
        customNavBar.layer.cornerRadius = 20
        customNavBar.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        customNavBar.ShadowNavBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("VC ECServices - HomeServiceVC ")
    }
    
    private func setImage() {
        imageDat = [
            UIImage(named: "iconInt",in: Bundle.local,compatibleWith: nil),
            UIImage(named: "iconOt",in: Bundle.local,compatibleWith: nil),
            UIImage(named: "sacramentos",in: Bundle.local,compatibleWith: nil)]
    }
    
    func showCanonAlert(title:String, msg:String){
        alertFields = AcceptAlert.showAlert(titulo: title, mensaje: msg)
        alertFields!.view.backgroundColor = .clear
        self.present(alertFields!, animated: true)
    }
    
    func showCanonAlertLogin(title:String, msg:String){
        alertFields2 = AcceptAlertLogin.showAlert(titulo: title, mensaje: msg)
        alertFields2!.view.backgroundColor = .clear
        self.present(alertFields2!, animated: true)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        titleData.count
    }
    
    //MARK: -TableView delegates
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ServiceCell", for: indexPath) as! ServiceTableViewCell
        cell.titleText.text = titleData[indexPath.row]
        cell.subText.text = subDat[indexPath.row]
        cell.imageCell.image = imageDat[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
  
        switch profile {
        case "PRIEST_ADMIN",
            "DEAN_PRIEST",
            "DEVOTED_ADMIN",
            "CLERGY_VICARAGE",
            "PASTORAL_VICARAGE",
            "CONSECRATED_LIFE_VICARAGE":
            switch indexPath.row {
            case 0:
                if newUser {//esta logueado proceder
                    let view = NewListIntentionsRouter.createModule()
                    self.navigationController?.pushViewController(view, animated: true)
                }else{
                    showCanonAlertLogin(title: "Atención", msg: "Regístrate o inicia sesión para solicitar una intención.")
                }
            case 1:
                if newUser {//esta logueado proceder
                    let view = ListServiceRouter.createModule()
                    self.navigationController?.pushViewController(view, animated: true)
                }else{
                    showCanonAlertLogin(title: "Atención", msg: "Regístrate o inicia sesión para solicitar servicios.")
                }
            case 2:
                let view = SacramentsRouter.createModule()
                self.navigationController?.pushViewController(view, animated: true)
            default:
                break
            }
        default:
            switch indexPath.row {
            case 0:
                if newUser{
                    let view = IntentionsRouter.createModule()
                    self.navigationController?.pushViewController(view, animated: true)
                }else{
                    showCanonAlertLogin(title: "Atención", msg: "Regístrate o inicia sesión para solicitar una intención.")
                }
            case 1:
                if newUser{
                    let view = OtherServicesRouter.createModule()
                    self.navigationController?.pushViewController(view, animated: true)
                }else{
                    showCanonAlertLogin(title: "Atención", msg: "Regístrate o inicia sesión para solicitar otros servicios.")
                }
            case 2:
                let view = SacramentsRouter.createModule()
                self.navigationController?.pushViewController(view, animated: true)
            default:
                break
                
            }
        }
    }
}
