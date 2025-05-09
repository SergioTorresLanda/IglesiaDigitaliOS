//
//  NewListIntentionsView.swift
//  EncuentroCatolicoServices
//
//  Created by Pablo Luis Velazquez Zamudio on 27/07/21.
//

import UIKit
import EncuentroCatolicoVirtualLibrary

class NewListIntentionsView: UIViewController, NewListIntentionsViewProtocol {

// MARK: PROTOCOL VAR -
    var presenter: NewListIntentionsPresenterProtocol?
    
// MARK: GLOBAL VAR -
    var arrayDatesTimes = ["Miércoles 18 de junio", "08:00", "12:00", "19:00"]
    var arryPriest = ["Juan Perez", "Javier hernandez", "Maria Perez"]
    let alertLoader = UIAlertController(title: "", message: "\n \n \n \n \nCargando...", preferredStyle: .alert)
    var arrayIntentions = [ListIntentions]()
    let transition = SlideTransition()
    let deafults = UserDefaults.standard
    let locationcomponents = UserDefaults.standard.object(forKey: "locationModuleComponents") as? [String]
    let locationID = UserDefaults.standard.integer(forKey: "locationId")
    var usableLocationID = 2
    var alertFields : AcceptAlert?
// MARK: @IBOUTLETS -
    @IBOutlet weak var contentNavBar: UIView!
    @IBOutlet weak var customNavBar: UIView!
    @IBOutlet weak var lblNavBarTitle: UILabel!
    @IBOutlet weak var backIcon: UIImageView!
    @IBOutlet weak var mainTable: UITableView!

// MARK: LIFE CYCLE FUNCS -
    override func viewDidLoad() {
        super.viewDidLoad()
        usableLocationID = locationID
        setupUI()
        setupGestures()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("VC ECServices - NewListIntentionsVC ")
        validateUserProfile()
    }
    
// MARK: SETUP FUNCS -
    private func setupUI() {
        customNavBar.layer.cornerRadius = 20
        customNavBar.ShadowNavBar()
        
    }
    
    private func setupDelegates() {
        mainTable.delegate = self
        mainTable.dataSource = self
        mainTable.reloadData()
    }
    
    private func setupGestures() {
        let tapBack = UITapGestureRecognizer(target: self, action: #selector(TapBack))
        backIcon.addGestureRecognizer(tapBack)
    }
    
    private func validateUserProfile() {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.locale = .init(identifier: "Es_MX")
        dateFormatter.dateFormat = "yyyy-MM-dd" //EEEE, MMM d, yyyy / EEEE, d MMMM
        
        if deafults.integer(forKey: "locationModule") == 0 {//locationcomponents?.contains{ $0 == "SERVICES"} {
            print("locationModule == 0")
            showCanonAlert(title: "Atención",msg: "No tienes una comunidad o iglesia asignada para este usuario.")
            //presenter?.callRequestList(locationID: "\(deafults.integer(forKey: "locationModule"))", dateStr: dateFormatter.string(from: currentDate))
        }else{
            print("locationModule != 0")
            showLoading()
            presenter?.callRequestList(locationID: "\(deafults.integer(forKey: "locationModule"))", dateStr: dateFormatter.string(from: currentDate))
        }
    }
    
    func showCanonAlert(title:String, msg:String){
        alertFields = AcceptAlert.showAlert(titulo: title, mensaje: msg)
        alertFields!.view.backgroundColor = .clear
        self.present(alertFields!, animated: true)
    }
    
    func showLoading() {
        let imageView = UIImageView(frame: CGRect(x: 100, y: 15, width: 80, height: 80))//mitad es en 145dp
        imageView.image = UIImage(named: "iconoIglesia3", in: Bundle.local, compatibleWith: nil)
        alertLoader.view.addSubview(imageView)
        self.present(alertLoader, animated: false, completion: nil)
    }
    
// MARK: @OBJC FUNC -
    @objc func TapBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
// MARK: API SERVICES FUNCTIONS -
    func succesRequestList(contentResponse: [ListIntentions]) {
        print(contentResponse)
        arrayIntentions = contentResponse
        if arrayIntentions.count != 0 {
            arrayIntentions.insert(arrayIntentions[0], at: 1)
            alertLoader.dismiss(animated: true, completion: nil)
        }else{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.alertLoader.dismiss(animated: true, completion: nil)
                self.showCanonAlert(title: "Atención", msg: "No hay intenciones disponibles por el momento, intente con otra fecha.")
            //let acceptAlert = acceptAlertService.showAlert(textAlert: "No hay intenciones disponibles por el momento, intente con otra fecha")
                //self.present(acceptAlert, animated: true, completion: nil)
            }
        }
        setupDelegates()
    }
    
    func failrequestList() {
        alertLoader.dismiss(animated: true, completion: nil)
    }
    
}

