//
//  AdminModulesView.swift
//  EncuentroCatolicoProfile
//
//  Created by 4n4rk0z on 06/05/21.
//

import UIKit
import EncuentroCatolicoVirtualLibrary

class AdminModulesView: UIViewController {
    var presenter: ProtocolosAdminModulesPresenter?
    var name = String()
    var isSuperAdmin = Bool()
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var buttonAdmin: NSLayoutConstraint!
    @IBOutlet weak var buttonDesable: UIButton!
    @IBOutlet weak var buttonCancel: UIButton!
    @IBOutlet weak var buttonConfirm: UIButton!
    @IBOutlet weak var doAdminBtn: UIButton!
    @IBOutlet weak var starImage: UIImageView!
    
    var index = IndexPath()
    var table = UITableView()
    @IBOutlet weak var lblNewTitle: UILabel!
    var modules: Modules?
    var modulesLocation: [ModulesLocation] = []
    public weak var delegate: SellectedModeuleButtonDelegate?
    var sellectedArray: [String] = []
    var sellectedIntArray: [Int] = []
    let loadingAlert = UIAlertController(title: "", message: "\n \n \n \n \nCargando...", preferredStyle: .alert)
    var arrayLocationInfo: [ModulesList] = []
    var arrayServices: [ModulesList] = []
    var arraySos: [ModulesList] = []
    var arrayDonations: [ModulesList] = []
    var arrayNombrar: [ModulesList] = []
    var arraySocial: [ModulesList] = []
    
    @IBOutlet weak var tableViewEdiInfo: UITableView!
    @IBOutlet weak var tableViewServices: UITableView!
    @IBOutlet weak var tableViewSocial: UITableView!
    @IBOutlet weak var tableViewDonations: UITableView!
    @IBOutlet weak var tableViewEmergency: UITableView!
    @IBOutlet weak var tableViewNameAdmin: UITableView!
    
    // New UI
    @IBOutlet weak var mainCard: UIView!
    @IBOutlet var mainCardLblCollection: [UILabel]!
    @IBOutlet var containerViewCollection: [UIView]!
    @IBOutlet var cardsCollection: [UIView]!
    @IBOutlet weak var enableCard1btn: UIButton!
    @IBOutlet weak var enableCard2btn: UIButton!
    @IBOutlet weak var enableCard3btn: UIButton!
    @IBOutlet weak var enableCard4btn: UIButton!
    @IBOutlet weak var enableCard5btn: UIButton!
    @IBOutlet weak var enableCard6btn: UIButton!
    @IBOutlet var questionIconsCollection: [UIImageView]!
    @IBOutlet weak var customNavBar: UIView!
    @IBOutlet weak var mainCardContainer: UIView!
    @IBOutlet weak var disableContainer: UIView!
    
    @IBOutlet weak var heightTableInfo: NSLayoutConstraint!
    @IBOutlet weak var heightTableServices: NSLayoutConstraint!
    @IBOutlet weak var heightSocial: NSLayoutConstraint!
    @IBOutlet weak var heightTableDontaions: NSLayoutConstraint!
    @IBOutlet weak var heightTableSos: NSLayoutConstraint!
    @IBOutlet weak var heightTableAdmin: NSLayoutConstraint!
    
    var userId = Int()
    var locationId = Int()
    var comesFromList = Int()
    
    var isFromEnable1 = false
    var isFromEnable2 = false
    var isFromEnable3 = false
    var isFromEnable4 = false
    var isFromEnable5 = false
    var isFromEnable6 = false
    var setEnableCell = false
    
    override func viewWillAppear(_ animated: Bool) {
        print("VC ECProfile - AdminModulesVC ")

    }
    override func viewDidAppear(_ animated: Bool) {
        loadingAlert.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        showLoading()
        presenter?.getAdminDetail(userID: userId, locationID: locationId)
        if comesFromList == 1 {
            presenter?.getData(id: userId, locationId: locationId)
          //  presenter?.getData(id: 771, locationId: 929)
        }else{
            presenter?.getModulesData(locationId: locationId)
            lblName.isHidden = true
            starImage.isHidden = true
        }
        if isSuperAdmin == true {
            starImage.isHidden = false
            doAdminBtn.isHidden = true
            
        }
        initUI()
        //        setNavigationBar()
        //  setTableView()
        lblName.text = name
        if comesFromList == 1 {
            lblNewTitle.text = "Nombrar Administradores"
        }else{
            lblNewTitle.text = "Administrar Módulos"
            mainCardContainer.isHidden = true
        }
    }
    func setTableView() {
        tableViewEdiInfo.register(SelectModulesTableViewCell.nib, forCellReuseIdentifier: SelectModulesTableViewCell.reuseIdentifier)
        tableViewEdiInfo.register(TitleTableViewCell.nib, forCellReuseIdentifier: TitleTableViewCell.reuseIdentifier)
        tableViewServices.register(SelectModulesTableViewCell.nib, forCellReuseIdentifier: SelectModulesTableViewCell.reuseIdentifier)
        tableViewServices.register(TitleTableViewCell.nib, forCellReuseIdentifier: TitleTableViewCell.reuseIdentifier)
        tableViewSocial.register(SelectModulesTableViewCell.nib, forCellReuseIdentifier: SelectModulesTableViewCell.reuseIdentifier)
        tableViewSocial.register(TitleTableViewCell.nib, forCellReuseIdentifier: TitleTableViewCell.reuseIdentifier)
        tableViewDonations.register(SelectModulesTableViewCell.nib, forCellReuseIdentifier: SelectModulesTableViewCell.reuseIdentifier)
        tableViewDonations.register(TitleTableViewCell.nib, forCellReuseIdentifier: TitleTableViewCell.reuseIdentifier)
        tableViewEmergency.register(SelectModulesTableViewCell.nib, forCellReuseIdentifier: SelectModulesTableViewCell.reuseIdentifier)
        tableViewEmergency.register(TitleTableViewCell.nib, forCellReuseIdentifier: TitleTableViewCell.reuseIdentifier)
        tableViewNameAdmin.register(SelectModulesTableViewCell.nib, forCellReuseIdentifier: SelectModulesTableViewCell.reuseIdentifier)
        tableViewNameAdmin.register(TitleTableViewCell.nib, forCellReuseIdentifier: TitleTableViewCell.reuseIdentifier)
        
        tableViewEdiInfo.delegate = self
        tableViewEdiInfo.dataSource = self
        tableViewServices.delegate = self
        tableViewServices.dataSource = self
        tableViewSocial.delegate = self
        tableViewSocial.dataSource = self
        tableViewDonations.delegate = self
        tableViewDonations.dataSource = self
        tableViewEmergency.delegate = self
        tableViewEmergency.dataSource = self
        tableViewNameAdmin.delegate = self
        tableViewNameAdmin.dataSource = self
    }
    func setNavigationBar() {
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 44))
        view.addSubview(navBar)
        var title: String {
            if comesFromList == 1 {
                return "Nombrar Administradores"
            }else{
                return "Administrar Módulos"
            }
        }
        let navItem = UINavigationItem(title: title)
        let img = UIImage(named: "navbar_image",in: Bundle.local,compatibleWith: nil)
        navBar.setBackgroundImage(img, for: .default)
        navBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 22.0)]
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navBar.titleTextAttributes = textAttributes
        var image = UIImage(named:  "atrasIzq",in: Bundle.local,compatibleWith: nil)
        image = image?.withRenderingMode(.alwaysOriginal)
        let leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(addTapped))
        leftBarButtonItem.tintColor = UIColor(red: 117/255, green: 120/255, blue: 123/255, alpha: 1)
        navItem.leftBarButtonItem = leftBarButtonItem
        
        //        let rightBarButtonItem = UIBarButtonItem(title: "Listo", style: .plain, target: self, action: #selector(addTapped))
        //        rightBarButtonItem.tintColor = UIColor(red: 190/255, green: 169/255, blue: 120/255, alpha: 1)
        //        navItem.rightBarButtonItem = rightBarButtonItem
        
        navBar.setItems([navItem], animated: false)
    }
    
    private func initUI() {
        customNavBar.layer.cornerRadius = 10
        customNavBar.ShadowNavBar()
        mainCard.layer.cornerRadius = 10
        mainCard.ShadowCard()
        cardsCollection.forEach { card in
            card.layer.cornerRadius = 10
            card.ShadowCard()
        }
        lblNewTitle.adjustsFontSizeToFitWidth = true
        lblName.adjustsFontSizeToFitWidth = true
        mainCardLblCollection.forEach { label in
            label.adjustsFontSizeToFitWidth = true
        }
        questionIconsCollection.forEach { image in
            image.isHidden = true
        }
    }
    
    func showLoading() {
        let imageView = UIImageView(frame: CGRect(x: 100, y: 15, width: 80, height: 80))//mitad es en 145dp
        imageView.image = UIImage(named: "iconoIglesia3", in: Bundle.local, compatibleWith: nil)
        loadingAlert.view.addSubview(imageView)
        present(loadingAlert, animated: true, completion: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            self.loadingAlert.dismiss(animated: true, completion: nil)
        })
    }
    
    
    @IBAction func isTouched(_ sender: UIButton) {
        sender.checkboxAnimation {
            print(sender.tag)
        }
        if sender.isSelected {
            
        }else{
            
        }
    }
    @IBAction func returnTo(_ sender: UIButton) {
        AdminAllert.instance.parentView.removeFromSuperview()
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func addTapped() {
        //navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func buttonDesableAction(_ sender: Any) {
        
        for section in 0..<tableViewEdiInfo.numberOfSections {
            for row in 0..<tableViewEdiInfo.numberOfRows(inSection: section) {
                let indexPath = IndexPath(row: row, section: section)
                if let cell = tableViewEdiInfo.cellForRow(at: indexPath) as? SelectModulesTableViewCell {
                    if cell.chackButton.state == .selected {
                        _ = table.delegate?.tableView?(tableViewEdiInfo, willSelectRowAt: indexPath)
                        tableViewEdiInfo.selectRow(at: indexPath, animated: false, scrollPosition: .none)
                        tableViewEdiInfo.delegate?.tableView?(tableViewEdiInfo, didSelectRowAt: indexPath)
                    }
                }
            }
        }
        for section in 0..<tableViewServices.numberOfSections {
            for row in 0..<tableViewServices.numberOfRows(inSection: section) {
                let indexPath = IndexPath(row: row, section: section)
                if let cell = tableViewServices.cellForRow(at: indexPath) as? SelectModulesTableViewCell {
                    if cell.chackButton.state == .selected {
                        _ = table.delegate?.tableView?(tableViewServices, willSelectRowAt: indexPath)
                        tableViewServices.selectRow(at: indexPath, animated: false, scrollPosition: .none)
                        tableViewServices.delegate?.tableView?(tableViewServices, didSelectRowAt: indexPath)
                    }
                }
            }
        }
        for section in 0..<tableViewSocial.numberOfSections {
            for row in 0..<tableViewSocial.numberOfRows(inSection: section) {
                let indexPath = IndexPath(row: row, section: section)
                if let cell = tableViewSocial.cellForRow(at: indexPath) as? SelectModulesTableViewCell {
                    if cell.chackButton.state == .selected {
                        _ = table.delegate?.tableView?(tableViewSocial, willSelectRowAt: indexPath)
                        tableViewSocial.selectRow(at: indexPath, animated: false, scrollPosition: .none)
                        tableViewSocial.delegate?.tableView?(tableViewSocial, didSelectRowAt: indexPath)
                    }
                }
            }
        }
        for section in 0..<tableViewDonations.numberOfSections {
            for row in 0..<tableViewDonations.numberOfRows(inSection: section) {
                let indexPath = IndexPath(row: row, section: section)
                if let cell = tableViewDonations.cellForRow(at: indexPath) as? SelectModulesTableViewCell {
                    if cell.chackButton.state == .selected {
                        _ = table.delegate?.tableView?(tableViewDonations, willSelectRowAt: indexPath)
                        tableViewDonations.selectRow(at: indexPath, animated: false, scrollPosition: .none)
                        tableViewDonations.delegate?.tableView?(tableViewDonations, didSelectRowAt: indexPath)
                    }
                }
            }
        }
        for section in 0..<tableViewEmergency.numberOfSections {
            for row in 0..<tableViewEmergency.numberOfRows(inSection: section) {
                let indexPath = IndexPath(row: row, section: section)
                if let cell = tableViewEmergency.cellForRow(at: indexPath) as? SelectModulesTableViewCell {
                    if cell.chackButton.state == .selected {
                        _ = table.delegate?.tableView?(tableViewEmergency, willSelectRowAt: indexPath)
                        tableViewEmergency.selectRow(at: indexPath, animated: false, scrollPosition: .none)
                        tableViewEmergency.delegate?.tableView?(tableViewEmergency, didSelectRowAt: indexPath)
                    }
                }
            }
        }
        for section in 0..<tableViewNameAdmin.numberOfSections {
            for row in 0..<tableViewNameAdmin.numberOfRows(inSection: section) {
                let indexPath = IndexPath(row: row, section: section)
                if let cell = tableViewNameAdmin.cellForRow(at: indexPath) as? SelectModulesTableViewCell {
                    if cell.chackButton.state == .selected {
                        _ = table.delegate?.tableView?(tableViewNameAdmin, willSelectRowAt: indexPath)
                        tableViewNameAdmin.selectRow(at: indexPath, animated: false, scrollPosition: .none)
                        tableViewNameAdmin.delegate?.tableView?(tableViewNameAdmin, didSelectRowAt: indexPath)
                    }
                }
            }
        }
    }
    @IBAction func buttonDoAdminAction(_ sender: UIButton) {
        selectAllRowsAdmin()
        AdminAllert.instance.showAllert(chourchName: "Name")
        AdminAllert.instance.delegate = self
    }
    
    @IBAction func buttonConfirmAction(_ sender: Any) {
        let array = sellectedArray
        SellectedModulesAllert.instance.showAllert(sellectedModules: array)
        SellectedModulesAllert.instance.tableView.reloadData()
        SellectedModulesAllert.instance.delegate = self
    }
    
    @IBAction func buttonCancelAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // New @IBACTIONS
    @IBAction func enableCard1Action(_ sender: Any) {
        if enableCard1btn.titleLabel?.text == "Activar" {
            isFromEnable1 = true
            enableCard1btn.setTitle("Desactivar", for: .normal)
            selectAllRows()
        }else{
            enableCard1btn.setTitle("Activar", for: .normal)
            isFromEnable1 = false
            deselectAllRows()
        }
        
    }
    
    @IBAction func enableCard2Action(_ sender: Any) {
        if enableCard2btn.titleLabel?.text == "Activar" {
            isFromEnable2 = true
            enableCard2btn.setTitle("Desactivar", for: .normal)
            selectAllRowsServices()
        }else{
            isFromEnable2 = false
            enableCard2btn.setTitle("Activar", for: .normal)
            deselectAllRowsServices()
        }
        
    }
    
    @IBAction func enableCard3Action(_ sender: Any) {
        if enableCard3btn.titleLabel?.text == "Activar" {
            isFromEnable3 = true
            enableCard3btn.setTitle("Desactivar", for: .normal)
            selectAllRowsSocial()
        }else{
            isFromEnable3 = false
            enableCard3btn.setTitle("Activar", for: .normal)
            deselectAllRowsSocial()
        }
        
    }
    
    @IBAction func enableCard4Action(_ sender: Any) {
        if enableCard4btn.titleLabel?.text == "Activar" {
            isFromEnable4 = true
            enableCard4btn.setTitle("Desactivar", for: .normal)
            selectAllRowsDonations()
        }else{
            isFromEnable4 = false
            enableCard4btn.setTitle("Activar", for: .normal)
            deselectAllRowsDonations()
        }
        
    }
    
    @IBAction func enableCard5Action(_ sender: Any) {
        if enableCard5btn.titleLabel?.text == "Activar" {
            isFromEnable5 = true
            enableCard5btn.setTitle("Desactivar", for: .normal)
            selectAllRowsEmergency()
        }else{
            isFromEnable5 = false
            enableCard5btn.setTitle("Activar", for: .normal)
            deselectAllRowsEmergency()
        }
        
    }
    
    @IBAction func enableCard6Action(_ sender: Any) {
        if enableCard6btn.titleLabel?.text == "Activar" {
            isFromEnable6 = true
            enableCard6btn.setTitle("Desactivar", for: .normal)
            selectAllRowsAdmin()
        }else{
            isFromEnable6 = false
            enableCard6btn.setTitle("Activar", for: .normal)
            deselectAllRowsAdmin()
        }
        
    }
    
}

extension AdminModulesView: ProtocolosAdminModulesView {
    func isSuccesChangeModules() {
        
    }
    
    func isSuccessModulesData(_ modules: [ModulesLocation]) {
        print("^^^ Entro aqui")
        self.modulesLocation = modules
        setupEnableStateSingle(modules: modules)
        
        modules.forEach { mod in
            print(mod)
            
        }
        
        DispatchQueue.main.async { [self] in
            tableViewEdiInfo.reloadData()
            tableViewServices.reloadData()
            tableViewSocial.reloadData()
            tableViewDonations.reloadData()
            tableViewEmergency.reloadData()
            tableViewNameAdmin.reloadData()
            loadingAlert.dismiss(animated: true, completion: nil)
        }
        
    }
    
    func isSuccessData(_ modules: Modules) {
        self.modules = modules
       // print("%%%%% nel entro este bro", modules) //
       setupEnableState(modules: modules)
        modules.modules?.forEach({ mod in
           // print("$$&", mod.category)
            switch mod.category {
            case "LOCATION_INFORMATION" :
                arrayLocationInfo.append(mod)
                //print("&&&", arrayLocationInfo)
                
            case "SERVICES":
                arrayServices.append(mod)
                //print("&&&", arrayServices)
                
            case "DONATIONS":
                arrayDonations.append(mod)
               // print("&&&", arrayDonations)
                
            case "SOS":
                arraySos.append(mod)
               // print("&&&", arraySos)
                
            case "SOCIAL_NETWORKS":
                arraySocial.append(mod)
               // print("&&&", arraySocial)
                
            case "APPOINT_ADMINISTRATOR":
                arrayNombrar.append(mod)
                print(print("&&&", arrayNombrar))
                
            default:
                print("default")
            }
        })
        
        if arrayLocationInfo.count == 0 {
            containerViewCollection[0].isHidden = true
        }else{
            containerViewCollection[0].isHidden =  false
        }
        
        if arrayServices.count == 0 {
            containerViewCollection[1].isHidden = true
        }else{
            containerViewCollection[1].isHidden =  false
        }
        
        if arraySocial.count == 0 {
            containerViewCollection[2].isHidden = true
        }else{
            containerViewCollection[2].isHidden =  false
        }
        
        if arrayDonations.count == 0 {
            containerViewCollection[3].isHidden = true
        }else{
            containerViewCollection[3].isHidden =  false
        }
        
        if arraySos.count == 0 {
            containerViewCollection[4].isHidden = true
        }else{
            containerViewCollection[4].isHidden =  false
        }
        
        if arrayServices.count ==  0{
            containerViewCollection[5].isHidden = true
        }else{
            containerViewCollection[5].isHidden =  false
        }
        
        DispatchQueue.main.async { [self] in
            tableViewEdiInfo.reloadData()
            tableViewServices.reloadData()
            tableViewSocial.reloadData()
            tableViewDonations.reloadData()
            tableViewEmergency.reloadData()
            tableViewNameAdmin.reloadData()
            loadingAlert.dismiss(animated: true, completion: nil)
        }
    
    }
    
    func showError(_ error: String) {
        
    }
    
    func succesGetDetail(data: DetailAdminEntity) {
        
        data.modules?.forEach({ item in
            print("\(item.name ?? ""): \(item.enabled ?? true)")
            
        })
        mainCardLblCollection[1].text = "   \(data.life_status ?? "")"
        mainCardLblCollection[3].text = "   \(data.services?[0].name ?? "")"
        mainCardLblCollection[5].text = "   \(data.location?.name ?? "")"
        mainCardLblCollection[7].text = "   \(data.email ?? "")"
        
    }
    
    func failGetDetail(message: String) {
        print(message)
    }
    
    func setupEnableState(modules: Modules) {
        modules.modules?.forEach({ module in
            print("[[[", module)
            switch module.category {
            case "LOCATION_INFORMATION":
                if module.enabled == true {
                    enableCard1btn.setTitle("Desactivar", for: .normal)
                    isFromEnable1 = true
                }else{
                    enableCard1btn.setTitle("Activar", for: .normal)
                    isFromEnable1 = false
                }
            case "SERVICES":
                if module.enabled == true {
                    enableCard2btn.setTitle("Desactivar", for: .normal)
                    isFromEnable2 = true
                }else{
                    enableCard2btn.setTitle("Activar", for: .normal)
                    isFromEnable2 = false
                }
            case "SOCIAL_NETWORKS":
                if module.enabled == true {
                    enableCard3btn.setTitle("Desactivar", for: .normal)
                    isFromEnable3 = true
                }else{
                    enableCard3btn.setTitle("Activar", for: .normal)
                    isFromEnable3 = false
                }
            case "DONATIONS":
                if module.enabled == true {
                    enableCard4btn.setTitle("Desactivar", for: .normal)
                    isFromEnable4 = true
                }else{
                    enableCard4btn.setTitle("Activar", for: .normal)
                    isFromEnable4 = false
                }
            case "SOS":
                if module.enabled == true {
                    enableCard5btn.setTitle("Desactivar", for: .normal)
                    isFromEnable5 = true
                }else{
                    enableCard5btn.setTitle("Activar", for: .normal)
                    isFromEnable5 = false
                }
            case "APPOINT_ADMINISTRATOR":
                if module.enabled == true {
                    enableCard6btn.setTitle("Desactivar", for: .normal)
                    isFromEnable6 = true
                }else{
                    enableCard6btn.setTitle("Activar", for: .normal)
                    isFromEnable6 = false
                }
            default:
                break
            }
            
        })
        setTableView()
    }
    
    func setupEnableStateSingle(modules: [ModulesLocation]) {
        modules.forEach({ module in
            print("[[[", module)
            switch module.category {
            case "LOCATION_INFORMATION":
                if module.enable == true {
                    enableCard1btn.setTitle("Desactivar", for: .normal)
                    isFromEnable1 = true
                }else{
                    enableCard1btn.setTitle("Activar", for: .normal)
                    isFromEnable1 = false
                }
            case "SERVICES":
                if module.enable == true {
                    enableCard2btn.setTitle("Desactivar", for: .normal)
                    isFromEnable2 = true
                }else{
                    enableCard2btn.setTitle("Activar", for: .normal)
                    isFromEnable2 = false
                }
            case "SOCIAL_NETWORK":
                if module.enable == true {
                    enableCard3btn.setTitle("Desactivar", for: .normal)
                    isFromEnable3 = true
                }else{
                    enableCard3btn.setTitle("Activar", for: .normal)
                    isFromEnable3 = false
                }
            case "DONATIONS":
                if module.enable == true {
                    enableCard4btn.setTitle("Desactivar", for: .normal)
                    isFromEnable4 = true
                }else{
                    enableCard4btn.setTitle("Activar", for: .normal)
                    isFromEnable4 = false
                }
            case "SOS":
                if module.enable == true {
                    enableCard5btn.setTitle("Desactivar", for: .normal)
                    isFromEnable5 = true
                }else{
                    enableCard5btn.setTitle("Activar", for: .normal)
                    isFromEnable5 = false
                }
            case "APPOINT_ADMINISTRATOR":
                if module.enable == true {
                    enableCard6btn.setTitle("Desactivar", for: .normal)
                    isFromEnable6 = true
                }else{
                    enableCard6btn.setTitle("Activar", for: .normal)
                    isFromEnable6 = false
                }
            default:
                break
            }
            
        })
        setTableView()
    }
}

//MARK: - Custome Aller delegates
extension AdminModulesView: SellectedModeuleButtonDelegate {
    func didPressYesButton(_ sender: UIButton) {
        if comesFromList == 1 {
            presenter?.changeModules(id: userId, locationId: locationId, moduleId: sellectedIntArray)
        }else{
            presenter?.cahngeModulesLocation(locationId: locationId, moduleId: sellectedIntArray)
        }
        SellectedModulesAllert.instance.parentView.removeFromSuperview()
        self.navigationController?.popViewController(animated: true)
    }
    
    func didPresNoButton(_ tag: Int) {
    }
}

extension AdminModulesView: AdminAllertButtonDelegate {
    func didPressYesAdminButton(_ sender: UIButton) {
        if comesFromList == 1 {
            presenter?.changeModules(id: userId, locationId: locationId, moduleId: sellectedIntArray)
        }else{
            presenter?.cahngeModulesLocation(locationId: locationId, moduleId: sellectedIntArray)
        }
        AdminAllert.instance.parentView.removeFromSuperview()
        self.navigationController?.popViewController(animated: true)
    }
}

extension AdminModulesView: ConfirmAllertButtonDelegate {
    func didPressYesConfirmButton(_ sender: UIButton) {
        if comesFromList == 1 {
            presenter?.changeModules(id: userId, locationId: locationId, moduleId: sellectedIntArray)
        }else{
            presenter?.cahngeModulesLocation(locationId: locationId, moduleId: sellectedIntArray)
        }
        ConfirmAllert.instance.parentView.removeFromSuperview()
        self.navigationController?.popViewController(animated: true)
    }
}

extension AdminModulesView: TitleCellButtonDelegate {
    func didTapSellectButton(_ sender: UIButton) {
        print("got here")
        let indexPathRow = sender.tag
        switch indexPathRow {
        case tableViewEdiInfo.hash:
            selectAllRows()
        case tableViewServices.hash:
            selectAllRowsServices()
        case tableViewSocial.hash:
            selectAllRowsSocial()
        case tableViewDonations.hash:
            selectAllRowsDonations()
        case tableViewEmergency.hash:
            selectAllRowsEmergency()
        case tableViewNameAdmin.hash:
            selectAllRowsAdmin()
        default:
            fatalError("Invalid table")
        }
        
    }
    
    func removeFromIndex(pos: Int) {
        if let index = sellectedIntArray.firstIndex(of: pos) {
            sellectedIntArray.remove(at: index)
        }
    }
    
    func selectAllRows() {
        for section in 0..<tableViewEdiInfo.numberOfSections {
            for row in 0..<tableViewEdiInfo.numberOfRows(inSection: section) {
                let indexPath = IndexPath(row: row, section: section)
                if let cell = tableViewEdiInfo.cellForRow(at: indexPath) as? SelectModulesTableViewCell {
                    if cell.chackButton.state == .normal {
                        _ = table.delegate?.tableView?(tableViewEdiInfo, willSelectRowAt: indexPath)
                        tableViewEdiInfo.selectRow(at: indexPath, animated: false, scrollPosition: .none)
                        tableViewEdiInfo.delegate?.tableView?(tableViewEdiInfo, didSelectRowAt: indexPath)
                    }
                }
            }
        }
        print(sellectedIntArray)
    }
    
    func deselectAllRows() {
        print(sellectedIntArray)
        for section in 0..<tableViewEdiInfo.numberOfSections {
            for row in 0..<tableViewEdiInfo.numberOfRows(inSection: section) {
                let indexpath = IndexPath(row: row, section: section)
                if let cell = tableViewEdiInfo.cellForRow(at: indexpath) as? SelectModulesTableViewCell {
                    if cell.chackButton.state == .selected {
                        cell.chackButton.isSelected = false
                    }
                }
            }
        }
//        var index = 0
//        sellectedIntArray.forEach { id in
//            switch id {
//            case 1, 2:
//                sellectedIntArray.remove(at: index)
//            default:
//                index += 1
//            }
//        }
//        index = 0
//        if let index = sellectedIntArray.firstIndex(of: 1) {
//            sellectedIntArray.remove(at: index)
//        }
//        if let index1 = sellectedIntArray.firstIndex(of: 2) {
//            sellectedIntArray.remove(at: index1)
//        }
        removeFromIndex(pos: 1)
        removeFromIndex(pos: 2)
        removeFromIndex(pos: 17)
        print(sellectedIntArray)
        tableViewEdiInfo.reloadData()
    }
    
    func selectAllRowsServices() {
        for section in 0..<tableViewServices.numberOfSections {
            for row in 0..<tableViewServices.numberOfRows(inSection: section) {
                let indexPath = IndexPath(row: row, section: section)
                if let cell = tableViewServices.cellForRow(at: indexPath) as? SelectModulesTableViewCell {
                    if cell.chackButton.state == .normal {
                        _ = table.delegate?.tableView?(tableViewServices, willSelectRowAt: indexPath)
                        tableViewServices.selectRow(at: indexPath, animated: false, scrollPosition: .none)
                        tableViewServices.delegate?.tableView?(tableViewServices, didSelectRowAt: indexPath)
                    }
                }
            }
        }
        print(sellectedIntArray)
    }
    
    func deselectAllRowsServices() {
        print(sellectedIntArray)
        for section in 0..<tableViewServices.numberOfSections {
            for row in 0..<tableViewServices.numberOfRows(inSection: section) {
                let indexpath = IndexPath(row: row, section: section)
                if let cell = tableViewServices.cellForRow(at: indexpath) as? SelectModulesTableViewCell {
                    if cell.chackButton.state == .selected {
                        cell.chackButton.isSelected = false
                    }
                }
            }
        }

        removeFromIndex(pos: 3)
        removeFromIndex(pos: 4)
        removeFromIndex(pos: 5)
        removeFromIndex(pos: 6)
        print(sellectedIntArray)
        tableViewServices.reloadData()
    }
    
    func selectAllRowsSocial() {
        for section in 0..<tableViewSocial.numberOfSections {
            for row in 0..<tableViewSocial.numberOfRows(inSection: section) {
                let indexPath = IndexPath(row: row, section: section)
                if let cell = tableViewSocial.cellForRow(at: indexPath) as? SelectModulesTableViewCell {
                    if cell.chackButton.state == .normal {
                        _ = table.delegate?.tableView?(tableViewSocial, willSelectRowAt: indexPath)
                        tableViewSocial.selectRow(at: indexPath, animated: false, scrollPosition: .none)
                        tableViewSocial.delegate?.tableView?(tableViewSocial, didSelectRowAt: indexPath)
                    }
                }
            }
        }
        print(sellectedIntArray)
    }
    
    func deselectAllRowsSocial() {
        for section in 0..<tableViewSocial.numberOfSections {
            for row in 0..<tableViewSocial.numberOfRows(inSection: section) {
                let indexpath = IndexPath(row: row, section: section)
                if let cell = tableViewSocial.cellForRow(at: indexpath) as? SelectModulesTableViewCell {
                    if cell.chackButton.state == .selected {
                        cell.chackButton.isSelected = false
                    }
                }
            }
        }

        removeFromIndex(pos: 7)
        removeFromIndex(pos: 8)
        removeFromIndex(pos: 9)
        removeFromIndex(pos: 18)
        print(sellectedIntArray)
        tableViewSocial.reloadData()
    }
    
    func selectAllRowsDonations() {
        for section in 0..<tableViewDonations.numberOfSections {
            for row in 0..<tableViewDonations.numberOfRows(inSection: section) {
                let indexPath = IndexPath(row: row, section: section)
                if let cell = tableViewDonations.cellForRow(at: indexPath) as? SelectModulesTableViewCell {
                    if cell.chackButton.state == .normal {
                        _ = table.delegate?.tableView?(tableViewDonations, willSelectRowAt: indexPath)
                        tableViewDonations.selectRow(at: indexPath, animated: false, scrollPosition: .none)
                        tableViewDonations.delegate?.tableView?(tableViewDonations, didSelectRowAt: indexPath)
                    }
                }
            }
        }
        print(sellectedIntArray)
    }
    
    func deselectAllRowsDonations() {
        for section in 0..<tableViewDonations.numberOfSections {
            for row in 0..<tableViewDonations.numberOfRows(inSection: section) {
                let indexpath = IndexPath(row: row, section: section)
                if let cell = tableViewDonations.cellForRow(at: indexpath) as? SelectModulesTableViewCell {
                    if cell.chackButton.state == .selected {
                        cell.chackButton.isSelected = false
                    }
                }
            }
        }

        removeFromIndex(pos: 10)
        removeFromIndex(pos: 11)
        print(sellectedIntArray)
        tableViewDonations.reloadData()
    }
    
    func selectAllRowsEmergency() {
        for section in 0..<tableViewEmergency.numberOfSections {
            for row in 0..<tableViewEmergency.numberOfRows(inSection: section) {
                let indexPath = IndexPath(row: row, section: section)
                if let cell = tableViewEmergency.cellForRow(at: indexPath) as? SelectModulesTableViewCell {
                    if cell.chackButton.state == .normal {
                        _ = table.delegate?.tableView?(tableViewEmergency, willSelectRowAt: indexPath)
                        tableViewEmergency.selectRow(at: indexPath, animated: false, scrollPosition: .none)
                        tableViewEmergency.delegate?.tableView?(tableViewEmergency, didSelectRowAt: indexPath)
                    }
                }
            }
        }
        print(sellectedIntArray)
    }
    
    func deselectAllRowsEmergency() {
        for section in 0..<tableViewEmergency.numberOfSections {
            for row in 0..<tableViewEmergency.numberOfRows(inSection: section) {
                let indexpath = IndexPath(row: row, section: section)
                if let cell = tableViewEmergency.cellForRow(at: indexpath) as? SelectModulesTableViewCell {
                    if cell.chackButton.state == .selected {
                        cell.chackButton.isSelected = false
                    }
                }
            }
        }
        
        removeFromIndex(pos: 12)
        removeFromIndex(pos: 13)
        print(sellectedIntArray)
        tableViewEmergency.reloadData()
    }
    
    func selectAllRowsAdmin() {
        for section in 0..<tableViewNameAdmin.numberOfSections {
            for row in 0..<tableViewNameAdmin.numberOfRows(inSection: section) {
                let indexPath = IndexPath(row: row, section: section)
                if let cell = tableViewNameAdmin.cellForRow(at: indexPath) as? SelectModulesTableViewCell {
                    if cell.chackButton.state == .normal {
                        _ = table.delegate?.tableView?(tableViewNameAdmin, willSelectRowAt: indexPath)
                        tableViewNameAdmin.selectRow(at: indexPath, animated: false, scrollPosition: .none)
                        tableViewNameAdmin.delegate?.tableView?(tableViewNameAdmin, didSelectRowAt: indexPath)
                    }
                }
            }
        }
        print(sellectedIntArray)
    }
    
    func deselectAllRowsAdmin() {
        for section in 0..<tableViewNameAdmin.numberOfSections {
            for row in 0..<tableViewNameAdmin.numberOfRows(inSection: section) {
                let indexpath = IndexPath(row: row, section: section)
                if let cell = tableViewNameAdmin.cellForRow(at: indexpath) as? SelectModulesTableViewCell {
                    if cell.chackButton.state == .selected {
                        cell.chackButton.isSelected = false
                    }
                }
            }
        }
       
        removeFromIndex(pos: 14)
        removeFromIndex(pos: 15)
        removeFromIndex(pos: 16)
        print(sellectedIntArray)
        tableViewNameAdmin.reloadData()
    }
    
}
//MARK: - Table View delegates
extension AdminModulesView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var countTableView: Int {
            if comesFromList == 1 && tableView == tableViewEdiInfo {
               // guard let filtered = modules?.modules?.filter({(1...2).contains($0.id!)}) else {return 1}
                return arrayLocationInfo.count //filtered.count //+ 1
            }else if comesFromList == 2 && tableView == tableViewEdiInfo{
                let filtered = modulesLocation.filter({(1...2).contains($0.id!)})
                return filtered.count //+ 1
                
            }else if comesFromList == 1 && tableView == tableViewServices {
               // guard let filtered = modules?.modules?.filter({(3...6).contains($0.id!)}) else {return 1}
                return arrayServices.count//filtered.count //+ 1
            }else if comesFromList == 2 && tableView == tableViewServices {
                let filtered = modulesLocation.filter({(3...6).contains($0.id!)})
                return filtered.count //+ 1
                
            }else if comesFromList == 1 && tableView == tableViewSocial {
              //  guard let filtered = modules?.modules?.filter({(7...9).contains($0.id!)}) else {return 1}
                return arraySocial.count//filtered.count //+ 1
            }else if comesFromList == 2 && tableView == tableViewSocial {
                let filtered = modulesLocation.filter({(7...9).contains($0.id!)})
                return filtered.count //+ 1
                
            }else if comesFromList == 1 && tableView == tableViewDonations {
               // guard let filtered = modules?.modules?.filter({(10...11).contains($0.id!)}) else {return 1}
                return arrayDonations.count//filtered.count //+ 1
            }else if comesFromList == 2 && tableView == tableViewDonations {
                let filtered = modulesLocation.filter({(10...11).contains($0.id!)})
                return filtered.count //+ 1
                
            }else if comesFromList == 1 && tableView == tableViewEmergency {
               // guard let filtered = modules?.modules?.filter({(12...13).contains($0.id!)}) else {return 1}
                return arraySos.count //filtered.count //+ 1
            }else if comesFromList == 2 && tableView == tableViewEmergency {
                let filtered = modulesLocation.filter({(12...13).contains($0.id!)})
                return filtered.count //+ 1
                
            }else if comesFromList == 1 && tableView == tableViewNameAdmin {
               // guard let filtered = modules?.modules?.filter({(14...16).contains($0.id!)}) else {return 1}
                return arrayNombrar.count //filtered.count //+ 1
            }else if comesFromList == 2 && tableView == tableViewNameAdmin {
                let filtered = modulesLocation.filter({(14...16).contains($0.id!)})
                return filtered.count //+ 1
            }else{
                return 1
            }
        }
        
        return countTableView
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tableViewEdiInfo {
            let create = createTableViewEdit(indexPath: indexPath, tableView: tableView)
            return create
        }else if tableView == tableViewServices {
            let create = createServiceTable(indexPath: indexPath)
            return create
        }else if tableView == tableViewSocial {
            let create = createSocialTable(indexPath: indexPath)
            return create
        }else if tableView == tableViewDonations {
            let create = createDonationsTable(indexPath: indexPath)
            return create
        }else if tableView == tableViewEmergency {
            let create = createEmergencyTable(indexPath: indexPath)
            return create
        }else if tableView == tableViewNameAdmin {
            let create = createTableNameAdmin(indexPath: indexPath)
            return create
        }
        self.index = indexPath
        self.table = tableView
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == tableViewEdiInfo {
            if let cell = tableViewEdiInfo.cellForRow(at: indexPath) as? SelectModulesTableViewCell {
                if cell.chackButton.state == .selected {
                    removeItem(index: indexPath, tableView: tableViewEdiInfo)
                    cell.chackButton.checkboxAnimation {
                    }
                    cell.backgroundColor = .none
                    cell.titleLabel.textColor = .black
                    cell.chackButton.setImage(UIImage(named:"check_off", in: Bundle.local, compatibleWith: nil), for: .normal)
                    print("check off")
                }else if cell.chackButton.state == .normal {
                    print("Check on")
                    cell.chackButton.checkboxAnimation {
                    }
                    cell.backgroundColor = .systemBlue
                    cell.titleLabel.textColor = .white
                    cell.chackButton.setImage(UIImage(named:"check_on", in: Bundle.local, compatibleWith: nil), for: .selected)
                    addItem(index: indexPath, tableView: tableViewEdiInfo)
                }
            }
            
        }else if tableView == tableViewServices {
            if let cell = tableViewServices.cellForRow(at: indexPath) as? SelectModulesTableViewCell {
                if cell.chackButton.state == .selected {
                    removeItem(index: indexPath, tableView: tableViewServices)
                    cell.chackButton.checkboxAnimation {
                    }
                    cell.backgroundColor = .none
                    cell.titleLabel.textColor = .black
                    cell.chackButton.setImage(UIImage(named:"check_off", in: Bundle.local, compatibleWith: nil), for: .normal)
                }else if cell.chackButton.state == .normal {
                    cell.chackButton.checkboxAnimation {
                    }
                    cell.backgroundColor = .systemBlue
                    cell.titleLabel.textColor = .white
                    cell.chackButton.setImage(UIImage(named:"check_on", in: Bundle.local, compatibleWith: nil), for: .selected)
                    addItem(index: indexPath, tableView: tableViewServices)
                }
            }
        }else if tableView == tableViewSocial {
            if let cell = tableViewSocial.cellForRow(at: indexPath) as? SelectModulesTableViewCell {
                if cell.chackButton.state == .selected {
                    removeItem(index: indexPath, tableView: tableViewSocial)
                    cell.chackButton.checkboxAnimation {
                    }
                    cell.backgroundColor = .none
                    cell.titleLabel.textColor = .black
                    cell.chackButton.setImage(UIImage(named:"check_off", in: Bundle.local, compatibleWith: nil), for: .normal)
                }else if cell.chackButton.state == .normal {
                    cell.chackButton.checkboxAnimation {
                    }
                    cell.backgroundColor = .systemBlue
                    cell.titleLabel.textColor = .white
                    cell.chackButton.setImage(UIImage(named:"check_on", in: Bundle.local, compatibleWith: nil), for: .selected)
                    addItem(index: indexPath, tableView: tableViewSocial)
                }
            }
        }else if tableView == tableViewDonations {
            if let cell = tableViewDonations.cellForRow(at: indexPath) as? SelectModulesTableViewCell {
                if cell.chackButton.state == .selected {
                    removeItem(index: indexPath, tableView: tableViewDonations)
                    cell.chackButton.checkboxAnimation {
                    }
                    cell.backgroundColor = .none
                    cell.titleLabel.textColor = .black
                    cell.chackButton.setImage(UIImage(named:"check_off", in: Bundle.local, compatibleWith: nil), for: .normal)
                }else if cell.chackButton.state == .normal {
                    cell.chackButton.checkboxAnimation {
                    }
                    cell.backgroundColor = .systemBlue
                    cell.titleLabel.textColor = .white
                    cell.chackButton.setImage(UIImage(named:"check_on", in: Bundle.local, compatibleWith: nil), for: .selected)
                    addItem(index: indexPath, tableView: tableViewDonations)
                }
            }
        }else if tableView == tableViewEmergency {
            if let cell = tableViewEmergency.cellForRow(at: indexPath) as? SelectModulesTableViewCell {
                if cell.chackButton.state == .selected {
                    removeItem(index: indexPath, tableView: tableViewEmergency)
                    cell.chackButton.checkboxAnimation {
                    }
                    cell.backgroundColor = .none
                    cell.titleLabel.textColor = .black
                    cell.chackButton.setImage(UIImage(named:"check_off", in: Bundle.local, compatibleWith: nil), for: .normal)
                }else if cell.chackButton.state == .normal {
                    cell.chackButton.checkboxAnimation {
                    }
                    cell.backgroundColor = .systemBlue
                    cell.titleLabel.textColor = .white
                    cell.chackButton.setImage(UIImage(named:"check_on", in: Bundle.local, compatibleWith: nil), for: .selected)
                    addItem(index: indexPath, tableView: tableViewEmergency)
                }
            }
        }else if tableView == tableViewNameAdmin {
            if let cell = tableViewNameAdmin.cellForRow(at: indexPath) as? SelectModulesTableViewCell {
                if cell.chackButton.state == .selected {
                    removeItem(index: indexPath, tableView: tableViewNameAdmin)
                    cell.chackButton.checkboxAnimation {
                    }
                    cell.backgroundColor = .none
                    cell.titleLabel.textColor = .black
                    cell.chackButton.setImage(UIImage(named:"check_off", in: Bundle.local, compatibleWith: nil), for: .normal)
                }else if cell.chackButton.state == .normal {
                    cell.chackButton.checkboxAnimation {
                    }
                    cell.backgroundColor = .systemBlue
                    cell.titleLabel.textColor = .white
                    cell.chackButton.setImage(UIImage(named:"check_on", in: Bundle.local, compatibleWith: nil), for: .selected)
                    addItem(index: indexPath, tableView: tableViewNameAdmin)
                }
            }
        }
    }
    
    func removeItem (index: IndexPath, tableView: UITableView) {
        if tableView == tableViewEdiInfo {
            guard let cell = tableViewEdiInfo.cellForRow(at: index) as? SelectModulesTableViewCell else { return }
            guard let string = cell.titleLabel.text else { return  }
            let int = cell.id
            if let index = sellectedIntArray.lastIndex(where: {_ in int == int}) {
                sellectedIntArray.remove(at: index)
            }
            if let string = sellectedArray.lastIndex(where: {$0.hasPrefix(string)}) {
                sellectedArray.remove(at: string)
            }
        }else if tableView == tableViewServices {
            guard let cell = tableViewServices.cellForRow(at: index) as? SelectModulesTableViewCell else { return }
            guard let string = cell.titleLabel.text else { return  }
            let int = cell.id
            if let index = sellectedIntArray.lastIndex(where: {_ in int == int}) {
                sellectedIntArray.remove(at: index)
            }
            if let string = sellectedArray.lastIndex(where: {$0.hasPrefix(string)}) {
                sellectedArray.remove(at: string)
            }
        }else if tableView == tableViewSocial {
            guard let cell = tableViewSocial.cellForRow(at: index) as? SelectModulesTableViewCell else { return }
            guard let string = cell.titleLabel.text else { return  }
            let int = cell.id
            if let index = sellectedIntArray.lastIndex(where: {_ in int == int}) {
                sellectedIntArray.remove(at: index)
            }
            if let string = sellectedArray.lastIndex(where: {$0.hasPrefix(string)}) {
                sellectedArray.remove(at: string)
            }
        }else if tableView == tableViewDonations {
            guard let cell = tableViewDonations.cellForRow(at: index) as? SelectModulesTableViewCell else { return }
            guard let string = cell.titleLabel.text else { return  }
            let int = cell.id
            if let index = sellectedIntArray.lastIndex(where: {_ in int == int}) {
                sellectedIntArray.remove(at: index)
            }
            if let string = sellectedArray.lastIndex(where: {$0.hasPrefix(string)}) {
                sellectedArray.remove(at: string)
            }
        }else if tableView == tableViewEmergency {
            guard let cell = tableViewEmergency.cellForRow(at: index) as? SelectModulesTableViewCell else { return }
            guard let string = cell.titleLabel.text else { return  }
            let int = cell.id
            if let index = sellectedIntArray.lastIndex(where: {_ in int == int}) {
                sellectedIntArray.remove(at: index)
            }
            if let string = sellectedArray.lastIndex(where: {$0.hasPrefix(string)}) {
                sellectedArray.remove(at: string)
            }
        }else if tableView == tableViewNameAdmin {
            guard let cell = tableViewNameAdmin.cellForRow(at: index) as? SelectModulesTableViewCell else { return }
            guard let string = cell.titleLabel.text else { return  }
            let int = cell.id
            if let index = sellectedIntArray.lastIndex(where: {_ in int == int}) {
                sellectedIntArray.remove(at: index)
            }
            if let string = sellectedArray.lastIndex(where: {$0.hasPrefix(string)}) {
                sellectedArray.remove(at: string)
            }
        }
    }
    func addItem(index: IndexPath, tableView: UITableView) {
        
        if tableView == tableViewEdiInfo {
            guard let cell = tableViewEdiInfo.cellForRow(at: index) as? SelectModulesTableViewCell else { return }
            let string = cell.titleLabel.text
            let int = cell.id
            if sellectedArray.isEmpty {
                sellectedArray.insert(string!, at: 0)
            } else {
                sellectedArray.append(string!)
            }
            if sellectedIntArray.isEmpty {
                sellectedIntArray.insert(int, at: 0)
            }else{
                sellectedIntArray.append(int)
            }
        }else if tableView == tableViewServices {
            guard let cell = tableViewServices.cellForRow(at: index) as? SelectModulesTableViewCell else { return }
            let string = cell.titleLabel.text
            let int = cell.id
            if sellectedArray.isEmpty {
                sellectedArray.insert(string!, at: 0)
            } else {
                sellectedArray.append(string!)
            }
            if sellectedIntArray.isEmpty {
                sellectedIntArray.insert(int, at: 0)
            }else{
                sellectedIntArray.append(int)
            }
        }else if tableView == tableViewSocial {
            guard let cell = tableViewSocial.cellForRow(at: index) as? SelectModulesTableViewCell else { return }
            let string = cell.titleLabel.text
            let int = cell.id
            if sellectedArray.isEmpty {
                sellectedArray.insert(string!, at: 0)
            } else {
                sellectedArray.append(string!)
            }
            if sellectedIntArray.isEmpty {
                sellectedIntArray.insert(int, at: 0)
            }else{
                sellectedIntArray.append(int)
            }
        }else if tableView == tableViewDonations {
            guard let cell = tableViewDonations.cellForRow(at: index) as? SelectModulesTableViewCell else { return }
            let string = cell.titleLabel.text
            let int = cell.id
            if sellectedArray.isEmpty {
                sellectedArray.insert(string!, at: 0)
            } else {
                sellectedArray.append(string!)
            }
            if sellectedIntArray.isEmpty {
                sellectedIntArray.insert(int, at: 0)
            }else{
                sellectedIntArray.append(int)
            }
        }else if tableView == tableViewEmergency {
            guard let cell = tableViewEmergency.cellForRow(at: index) as? SelectModulesTableViewCell else { return }
            let string = cell.titleLabel.text
            let int = cell.id
            if sellectedArray.isEmpty {
                sellectedArray.insert(string!, at: 0)
            } else {
                sellectedArray.append(string!)
            }
            if sellectedIntArray.isEmpty {
                sellectedIntArray.insert(int, at: 0)
            }else{
                sellectedIntArray.append(int)
            }
        }else if tableView == tableViewNameAdmin {
            guard let cell = tableViewNameAdmin.cellForRow(at: index) as? SelectModulesTableViewCell else { return }
            let string = cell.titleLabel.text
            let int = cell.id
            if sellectedArray.isEmpty {
                sellectedArray.insert(string!, at: 0)
            } else {
                sellectedArray.append(string!)
            }
            if sellectedIntArray.isEmpty {
                sellectedIntArray.insert(int, at: 0)
            }else{
                sellectedIntArray.append(int)
            }
        }
    }
    func createTableViewEdit(indexPath: IndexPath, tableView: UITableView) -> UITableViewCell {
        if comesFromList == 1 {
            let cell = tableViewEdiInfo.dequeueReusableCell(withIdentifier: "SelectModulesTableViewCell", for: indexPath) as! SelectModulesTableViewCell
            let filtered = modules?.modules?.filter({(1...3).contains($0.id!)})
            cell.selectionStyle = .none
            cell.isUserInteractionEnabled = false
            cell.isMultipleTouchEnabled = true
           // cell.titleLabel.text = filtered?[indexPath.row].name // -1
            cell.titleLabel.text = arrayLocationInfo[indexPath.row].name
            cell.titleLabel.sizeToFit()
            cell.id = arrayLocationInfo[indexPath.row].id ?? 1
           // cell.id = filtered?[indexPath.row].id ?? 1 // -1
            heightTableInfo.constant = tableView.contentSize.height
            
            if isFromEnable1 == true {
                cell.chackButton.checkboxAnimation {
                }
                cell.backgroundColor = .systemBlue
                cell.titleLabel.textColor = .white
                cell.chackButton.setImage(UIImage(named:"check_on", in: Bundle.local, compatibleWith: nil), for: .selected)
                let string = cell.titleLabel.text
                let int = cell.id
                if sellectedArray.isEmpty {
                    sellectedArray.insert(string!, at: 0)
                } else {
                    sellectedArray.append(string!)
                }
                if sellectedIntArray.isEmpty {
                    sellectedIntArray.insert(int, at: 0)
                }else{
                    sellectedIntArray.append(int)
                }
            }else{
                cell.backgroundColor = .none
                cell.titleLabel.textColor = .black
                cell.chackButton.setImage(UIImage(named:"check_off", in: Bundle.local, compatibleWith: nil), for: .normal)
            }
            
            return cell
        }else{
            
            let cell = tableViewEdiInfo.dequeueReusableCell(withIdentifier: "SelectModulesTableViewCell", for: indexPath) as! SelectModulesTableViewCell
            let filtered = modulesLocation.filter({(1...3).contains($0.id!)})
            cell.selectionStyle = .none
            cell.isUserInteractionEnabled = false
            cell.isMultipleTouchEnabled = true
            cell.titleLabel.text = filtered[indexPath.row].name //- 1].name
            cell.titleLabel.sizeToFit()
            cell.id = filtered[indexPath.row].id ?? 1 //-1
            heightTableInfo.constant = tableView.contentSize.height
            
            if isFromEnable1 == true {
                cell.chackButton.checkboxAnimation {
                }
                cell.backgroundColor = .systemBlue
                cell.titleLabel.textColor = .white
                cell.chackButton.setImage(UIImage(named:"check_on", in: Bundle.local, compatibleWith: nil), for: .selected)
                let string = cell.titleLabel.text
                let int = cell.id
                if sellectedArray.isEmpty {
                    sellectedArray.insert(string!, at: 0)
                } else {
                    sellectedArray.append(string!)
                }
                if sellectedIntArray.isEmpty {
                    sellectedIntArray.insert(int, at: 0)
                }else{
                    sellectedIntArray.append(int)
                }
            }else{
                cell.backgroundColor = .none
                cell.titleLabel.textColor = .black
                cell.chackButton.setImage(UIImage(named:"check_off", in: Bundle.local, compatibleWith: nil), for: .normal)
            }
            
//            if filtered[indexPath.row].enable == true { // -1
//
//            }else{
//
//            }
            
            return cell
            
        }
    }
    func createServiceTable(indexPath: IndexPath) -> UITableViewCell {
        if comesFromList == 1 {
            
            let cell = tableViewServices.dequeueReusableCell(withIdentifier: "SelectModulesTableViewCell", for: indexPath) as! SelectModulesTableViewCell
            let filtered = modules?.modules?.filter({(3...6).contains($0.id!)})
            cell.selectionStyle = .none
            cell.isUserInteractionEnabled = false
            cell.isMultipleTouchEnabled = true
           // cell.titleLabel.text = filtered?[indexPath.row].name // -1
            cell.titleLabel.text = arrayServices[indexPath.row].name
            cell.titleLabel.sizeToFit()
            cell.id = arrayServices[indexPath.row].id ?? 1
           // cell.id = filtered?[indexPath.row].id ?? 1 // -1
            heightTableServices.constant = tableViewServices.contentSize.height
            
            if isFromEnable2 == true {
                cell.chackButton.checkboxAnimation {
                }
                cell.backgroundColor = .systemBlue
                cell.titleLabel.textColor = .white
                cell.chackButton.setImage(UIImage(named:"check_on", in: Bundle.local, compatibleWith: nil), for: .selected)
                let string = cell.titleLabel.text
                let int = cell.id
                if sellectedArray.isEmpty {
                    sellectedArray.insert(string!, at: 0)
                } else {
                    sellectedArray.append(string!)
                }
                if sellectedIntArray.isEmpty {
                    sellectedIntArray.insert(int, at: 0)
                }else{
                    sellectedIntArray.append(int)
                }
            }else{
                cell.backgroundColor = .none
                cell.titleLabel.textColor = .black
                cell.chackButton.setImage(UIImage(named:"check_off", in: Bundle.local, compatibleWith: nil), for: .normal)
            }
            //                if filtered?[indexPath.row].enabled! == true { // -1
            //                    cell.chackButton.checkboxAnimation {
            //                    }
            //                    cell.backgroundColor = .systemBlue
            //                    cell.titleLabel.textColor = .white
            //                    cell.chackButton.setImage(UIImage(named:"check_on", in: Bundle.local, compatibleWith: nil), for: .selected)
            //                    let string = cell.titleLabel.text
            //                    let int = cell.id
            //                    if sellectedArray.isEmpty {
            //                        sellectedArray.insert(string!, at: 0)
            //                    } else {
            //                        sellectedArray.append(string!)
            //                    }
            //                    if sellectedIntArray.isEmpty {
            //                        sellectedIntArray.insert(int, at: 0)
            //                    }else{
            //                        sellectedIntArray.append(int)
            //                    }
            //                }else{
            //                    cell.backgroundColor = .none
            //                    cell.titleLabel.textColor = .black
            //                    cell.chackButton.setImage(UIImage(named:"check_off", in: Bundle.local, compatibleWith: nil), for: .normal)
            //                }
            return cell
            
        }else{
            
            let cell = tableViewServices.dequeueReusableCell(withIdentifier: "SelectModulesTableViewCell", for: indexPath) as! SelectModulesTableViewCell
            let filtered = modulesLocation.filter({(3...6).contains($0.id!)})
            cell.selectionStyle = .none
            cell.isUserInteractionEnabled = false
            cell.isMultipleTouchEnabled = true
            cell.titleLabel.text = filtered[indexPath.row].name //-1
            cell.titleLabel.sizeToFit()
            cell.id = filtered[indexPath.row].id ?? 1 // -1
            heightTableServices.constant = tableViewServices.contentSize.height
            
            if isFromEnable2 == true {
                cell.chackButton.checkboxAnimation {
                }
                cell.backgroundColor = .systemBlue
                cell.titleLabel.textColor = .white
                cell.chackButton.setImage(UIImage(named:"check_on", in: Bundle.local, compatibleWith: nil), for: .selected)
                let string = cell.titleLabel.text
                let int = cell.id
                if sellectedArray.isEmpty {
                    sellectedArray.insert(string!, at: 0)
                } else {
                    sellectedArray.append(string!)
                }
                if sellectedIntArray.isEmpty {
                    sellectedIntArray.insert(int, at: 0)
                }else{
                    sellectedIntArray.append(int)
                }
            }else{
                cell.backgroundColor = .none
                cell.titleLabel.textColor = .black
                cell.chackButton.setImage(UIImage(named:"check_off", in: Bundle.local, compatibleWith: nil), for: .normal)
            }
            
            return cell
        }
    }
    func createSocialTable(indexPath: IndexPath) -> UITableViewCell {
        if comesFromList == 1 {
            //                if indexPath.row == 0 {
            //                    let cell = tableViewSocial.dequeueReusableCell(withIdentifier: "TitleTableViewCell", for: indexPath) as! TitleTableViewCell
            //                    cell.delegte = self
            //                    cell.sellectButton.tag = tableViewSocial.hash
            //                    cell.selectionStyle = .none
            //                    return cell
            //                }
            let cell = tableViewSocial.dequeueReusableCell(withIdentifier: "SelectModulesTableViewCell", for: indexPath) as! SelectModulesTableViewCell
            let filtered = modules?.modules?.filter({(7...9).contains($0.id!)})
            cell.selectionStyle = .none
            cell.isUserInteractionEnabled = false
            cell.isMultipleTouchEnabled = true
            cell.titleLabel.text = arraySocial[indexPath.row].name
           // cell.titleLabel.text = filtered?[indexPath.row].name //-1
            cell.titleLabel.sizeToFit()
            cell.id = arraySocial[indexPath.row].id ?? 0
           // cell.id = filtered?[indexPath.row].id ?? 1 // -1
            heightSocial.constant = tableViewSocial.contentSize.height
            
            if isFromEnable3 == true {
                cell.chackButton.checkboxAnimation {
                }
                cell.backgroundColor = .systemBlue
                cell.titleLabel.textColor = .white
                cell.chackButton.setImage(UIImage(named:"check_on", in: Bundle.local, compatibleWith: nil), for: .selected)
                let string = cell.titleLabel.text
                let int = cell.id
                if sellectedArray.isEmpty {
                    sellectedArray.insert(string!, at: 0)
                } else {
                    sellectedArray.append(string!)
                }
                if sellectedIntArray.isEmpty {
                    sellectedIntArray.insert(int, at: 0)
                }else{
                    sellectedIntArray.append(int)
                }
            }else{
                cell.backgroundColor = .none
                cell.titleLabel.textColor = .black
                cell.chackButton.setImage(UIImage(named:"check_off", in: Bundle.local, compatibleWith: nil), for: .normal)
            }
            
            return cell
            
        }else{
            
            let cell = tableViewSocial.dequeueReusableCell(withIdentifier: "SelectModulesTableViewCell", for: indexPath) as! SelectModulesTableViewCell
            let filtered = modulesLocation.filter({(7...9).contains($0.id!)})
            cell.selectionStyle = .none
            cell.isUserInteractionEnabled = false
            cell.isMultipleTouchEnabled = true
            cell.titleLabel.text = filtered[indexPath.row].name // -1
            cell.titleLabel.sizeToFit()
            cell.id = filtered[indexPath.row].id ?? 1 // -1
            heightSocial.constant = tableViewSocial.contentSize.height
            
            if isFromEnable3 == true {
                cell.chackButton.checkboxAnimation {
                }
                cell.backgroundColor = .systemBlue
                cell.titleLabel.textColor = .white
                cell.chackButton.setImage(UIImage(named:"check_on", in: Bundle.local, compatibleWith: nil), for: .selected)
                let string = cell.titleLabel.text
                let int = cell.id
                if sellectedArray.isEmpty {
                    sellectedArray.insert(string!, at: 0)
                } else {
                    sellectedArray.append(string!)
                }
                if sellectedIntArray.isEmpty {
                    sellectedIntArray.insert(int, at: 0)
                }else{
                    sellectedIntArray.append(int)
                }
            }else{
                cell.backgroundColor = .none
                cell.titleLabel.textColor = .black
                cell.chackButton.setImage(UIImage(named:"check_off", in: Bundle.local, compatibleWith: nil), for: .normal)
            }
        
            return cell
        }
    }
    func createDonationsTable(indexPath: IndexPath) -> UITableViewCell {
        if comesFromList == 1 {
            let cell = tableViewDonations.dequeueReusableCell(withIdentifier: "SelectModulesTableViewCell", for: indexPath) as! SelectModulesTableViewCell
            let filtered = modules?.modules?.filter({(10...11).contains($0.id!)})
            cell.selectionStyle = .none
            cell.isUserInteractionEnabled = false
            cell.isMultipleTouchEnabled = true
            cell.titleLabel.text = arrayDonations[indexPath.row].name
           // cell.titleLabel.text = filtered?[indexPath.row].name //-1
            cell.titleLabel.sizeToFit()
            cell.id = arrayDonations[indexPath.row].id ?? 1
            //cell.id = filtered?[indexPath.row].id ?? 1 //-1
            heightTableDontaions.constant = tableViewDonations.contentSize.height
            
            if isFromEnable4 == true {
                cell.chackButton.checkboxAnimation {
                }
                cell.backgroundColor = .systemBlue
                cell.titleLabel.textColor = .white
                cell.chackButton.setImage(UIImage(named:"check_on", in: Bundle.local, compatibleWith: nil), for: .selected)
                let string = cell.titleLabel.text
                let int = cell.id
                if sellectedArray.isEmpty {
                    sellectedArray.insert(string!, at: 0)
                } else {
                    sellectedArray.append(string!)
                }
                if sellectedIntArray.isEmpty {
                    sellectedIntArray.insert(int, at: 0)
                }else{
                    sellectedIntArray.append(int)
                }
            }else{
                cell.backgroundColor = .none
                cell.titleLabel.textColor = .black
                cell.chackButton.setImage(UIImage(named:"check_off", in: Bundle.local, compatibleWith: nil), for: .normal)
            }
            
            return cell
        }else{
            
            let cell = tableViewDonations.dequeueReusableCell(withIdentifier: "SelectModulesTableViewCell", for: indexPath) as! SelectModulesTableViewCell
            let filtered = modulesLocation.filter({(10...11).contains($0.id!)})
            cell.selectionStyle = .none
            cell.isUserInteractionEnabled = false
            cell.isMultipleTouchEnabled = true
            cell.titleLabel.text = filtered[indexPath.row].name //-1
            cell.titleLabel.sizeToFit()
            cell.id = filtered[indexPath.row].id ?? 1 //-1
            heightTableDontaions.constant = tableViewDonations.contentSize.height
            
            if isFromEnable4 == true {
                cell.chackButton.checkboxAnimation {
                }
                cell.backgroundColor = .systemBlue
                cell.titleLabel.textColor = .white
                cell.chackButton.setImage(UIImage(named:"check_on", in: Bundle.local, compatibleWith: nil), for: .selected)
                let string = cell.titleLabel.text
                let int = cell.id
                if sellectedArray.isEmpty {
                    sellectedArray.insert(string!, at: 0)
                } else {
                    sellectedArray.append(string!)
                }
                if sellectedIntArray.isEmpty {
                    sellectedIntArray.insert(int, at: 0)
                }else{
                    sellectedIntArray.append(int)
                }
            }else{
                cell.backgroundColor = .none
                cell.titleLabel.textColor = .black
                cell.chackButton.setImage(UIImage(named:"check_off", in: Bundle.local, compatibleWith: nil), for: .normal)
            }
            
            return cell
        }
    }
    
    func createEmergencyTable(indexPath: IndexPath) -> UITableViewCell {
        if comesFromList == 1 {
            let cell = tableViewEmergency.dequeueReusableCell(withIdentifier: "SelectModulesTableViewCell", for: indexPath) as! SelectModulesTableViewCell
            let filtered = modules?.modules?.filter({(12...13).contains($0.id!)})
            cell.selectionStyle = .none
            cell.isUserInteractionEnabled = false
            cell.isMultipleTouchEnabled = true
          //  cell.titleLabel.text = filtered?[indexPath.row].name //-1
            cell.titleLabel.text = arraySos[indexPath.row].name
            cell.id = arraySos[indexPath.row].id ?? 1
           // cell.id = filtered?[indexPath.row].id ?? 1 //-1
            cell.titleLabel.sizeToFit()
            heightTableSos.constant = tableViewEmergency.contentSize.height
            
            if isFromEnable5 == true {
                cell.chackButton.checkboxAnimation {
                }
                cell.backgroundColor = .systemBlue
                cell.titleLabel.textColor = .white
                cell.chackButton.setImage(UIImage(named:"check_on", in: Bundle.local, compatibleWith: nil), for: .selected)
                let string = cell.titleLabel.text
                let int = cell.id
                if sellectedArray.isEmpty {
                    sellectedArray.insert(string!, at: 0)
                } else {
                    sellectedArray.append(string!)
                }
                if sellectedIntArray.isEmpty {
                    sellectedIntArray.insert(int, at: 0)
                }else{
                    sellectedIntArray.append(int)
                }
            }else{
                cell.backgroundColor = .none
                cell.titleLabel.textColor = .black
                cell.chackButton.setImage(UIImage(named:"check_off", in: Bundle.local, compatibleWith: nil), for: .normal)
            }
            
            return cell
        }else{
            
            let cell = tableViewEmergency.dequeueReusableCell(withIdentifier: "SelectModulesTableViewCell", for: indexPath) as! SelectModulesTableViewCell
            let filtered = modulesLocation.filter({(12...13).contains($0.id!)})
            cell.selectionStyle = .none
            cell.isUserInteractionEnabled = false
            cell.isMultipleTouchEnabled = true
            cell.titleLabel.text = filtered[indexPath.row].name //-1
            cell.id = filtered[indexPath.row].id ?? 1 //-1
            cell.titleLabel.sizeToFit()
            heightTableSos.constant = tableViewEmergency.contentSize.height
            
            if isFromEnable5 == true {
                cell.chackButton.checkboxAnimation {
                }
                cell.backgroundColor = .systemBlue
                cell.titleLabel.textColor = .white
                cell.chackButton.setImage(UIImage(named:"check_on", in: Bundle.local, compatibleWith: nil), for: .selected)
                let string = cell.titleLabel.text
                let int = cell.id
                if sellectedArray.isEmpty {
                    sellectedArray.insert(string!, at: 0)
                } else {
                    sellectedArray.append(string!)
                }
                if sellectedIntArray.isEmpty {
                    sellectedIntArray.insert(int, at: 0)
                }else{
                    sellectedIntArray.append(int)
                }
            }else{
                cell.backgroundColor = .none
                cell.titleLabel.textColor = .black
                cell.chackButton.setImage(UIImage(named:"check_off", in: Bundle.local, compatibleWith: nil), for: .normal)

            }
           
            return cell
        }
    }
    
    func createTableNameAdmin(indexPath: IndexPath) -> UITableViewCell {
        if comesFromList == 1 {
            
            let cell = tableViewNameAdmin.dequeueReusableCell(withIdentifier: "SelectModulesTableViewCell", for: indexPath) as! SelectModulesTableViewCell
            let filtered = modules?.modules?.filter({(14...16).contains($0.id!)})
            cell.selectionStyle = .none
            cell.isUserInteractionEnabled = false
            cell.isMultipleTouchEnabled = true
           // cell.titleLabel.text = filtered?[indexPath.row].name //-1
           // cell.id = filtered?[indexPath.row].id ?? 1 //-1
            cell.titleLabel.text = arrayNombrar[indexPath.row].name
            cell.id = arrayNombrar[indexPath.row].id ?? 0
            cell.titleLabel.sizeToFit()
            heightTableAdmin.constant = tableViewNameAdmin.contentSize.height
            
            if isFromEnable6 == true {
                cell.chackButton.checkboxAnimation {
                }
                cell.backgroundColor = .systemBlue
                cell.titleLabel.textColor = .white
                cell.chackButton.setImage(UIImage(named:"check_on", in: Bundle.local, compatibleWith: nil), for: .selected)
                let string = cell.titleLabel.text
                let int = cell.id
                if sellectedArray.isEmpty {
                    sellectedArray.insert(string!, at: 0)
                } else {
                    sellectedArray.append(string!)
                }
                if sellectedIntArray.isEmpty {
                    sellectedIntArray.insert(int, at: 0)
                }else{
                    sellectedIntArray.append(int)
                }
            }else{
                cell.backgroundColor = .none
                cell.titleLabel.textColor = .black
                cell.chackButton.setImage(UIImage(named:"check_off", in: Bundle.local, compatibleWith: nil), for: .normal)
            }
            
            return cell
        }else{
            
            let cell = tableViewNameAdmin.dequeueReusableCell(withIdentifier: "SelectModulesTableViewCell", for: indexPath) as! SelectModulesTableViewCell
            let filtered = modulesLocation.filter({(14...16).contains($0.id!)})
            cell.selectionStyle = .none
            cell.isUserInteractionEnabled = false
            cell.isMultipleTouchEnabled = true
            cell.titleLabel.text = filtered[indexPath.row].name //-1
            cell.id = filtered[indexPath.row].id ?? 1 //-1
            cell.titleLabel.sizeToFit()
            heightTableAdmin.constant = tableViewNameAdmin.contentSize.height
            
            if isFromEnable6 == true {
                cell.chackButton.checkboxAnimation {
                }
                cell.backgroundColor = .systemBlue
                cell.titleLabel.textColor = .white
                cell.chackButton.setImage(UIImage(named:"check_on", in: Bundle.local, compatibleWith: nil), for: .selected)
                let string = cell.titleLabel.text
                let int = cell.id
                if sellectedArray.isEmpty {
                    sellectedArray.insert(string!, at: 0)
                } else {
                    sellectedArray.append(string!)
                }
                if sellectedIntArray.isEmpty {
                    sellectedIntArray.insert(int, at: 0)
                }else{
                    sellectedIntArray.append(int)
                }
            }else{
                cell.backgroundColor = .none
                cell.titleLabel.textColor = .black
                cell.chackButton.setImage(UIImage(named:"check_off", in: Bundle.local, compatibleWith: nil), for: .normal)
            }
                        
            return cell
        }
    }
}


