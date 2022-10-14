//
//  NewListIntentionsView.swift
//  EncuentroCatolicoServices
//
//  Created by Pablo Luis Velazquez Zamudio on 27/07/21.
//

import UIKit

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
        showLoading()
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
        
        if ((locationcomponents?.contains{ $0 == "SERVICES"}) == true){
            presenter?.callRequestList(locationID: "\(deafults.integer(forKey: "locationModule"))", dateStr: dateFormatter.string(from: currentDate))
        }else {
            presenter?.callRequestList(locationID: "\(deafults.integer(forKey: "locationModule"))", dateStr: dateFormatter.string(from: currentDate))
        }
    }
    
    func showLoading() {
        let imageView = UIImageView(frame: CGRect(x: 75, y: 25, width: 140, height: 60))
        imageView.image = UIImage(named: "logoEncuentro", in: Bundle.local, compatibleWith: nil)
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
            let acceptAlert = acceptAlertService.showAlert(textAlert: "No hay intenciones disponibles por el momento, intente con otra fecha")
            alertLoader.dismiss(animated: true, completion: nil)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.present(acceptAlert, animated: true, completion: nil)
            }
            
        }
        
        setupDelegates()
        
    }
    
    func failrequestList() {
        alertLoader.dismiss(animated: true, completion: nil)
    }
    
}

