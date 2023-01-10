//
//  HomeViewController.swift
//  EncuentroCatolicoHome
//
//  Created Diego Martinez on 23/02/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit
import EncuentroCatolicoDonations
import EncuentroCatolicoLive
import EncuentroCatolicoScanner
import EncuentroCatolicoProfile
import EncuentroCatolicoVirtualLibrary
import EncuentroCatolicoChurch
import EncuentroCatolicoPrayers
import Foundation
import EncuentroCatolicoNewFormation

//import EncuentroCatolicoLogin
//import EncuentroCatolicoRegister

class HomeViewController: UIViewController, HomeViewProtocol, UITextFieldDelegate, UNUserNotificationCenterDelegate, YourCellDelegate, MyCellDelegate {
    func didPressCell(sender: Any) {
        print("HomeVC Did press cell")
    }
    
    var presenter: HomePresenterProtocol?
    
    //MARK: - View
    @IBOutlet weak var homeCV                : UICollectionView!
    @IBOutlet weak var viewArriba            : UIView!
    @IBOutlet weak var containerDonations    : UIView!
    @IBOutlet weak var vistaConNombre        : UIView!
    @IBOutlet weak var nombrePersona         : UILabel!
    @IBOutlet weak var userImage             : UIImageView!
    @IBOutlet weak var btnToNotifications    : UIButton!
    @IBOutlet weak var profileStackView      : UIStackView!
    @IBOutlet weak var donatiosButtonSpace   : NSLayoutConstraint!
    @IBOutlet weak var transmitionsView: UIView!
    @IBOutlet weak var mainTable: UITableView!
    @IBOutlet weak var heightMainTable: NSLayoutConstraint!
    @IBOutlet weak var gearIcon: UIImageView!
    @IBOutlet weak var lblGoodMorning: UILabel!
    @IBOutlet weak var lblAdmin: UILabel!
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var btnStreaming: UIButton!
    
    static let singleton = HomeViewController()
    
    var arraySelectedCell = [false, false, false, false, false, false, false]
    let alert = UIAlertController(title: "", message: "\n \n \n \n \nCargando...", preferredStyle: .alert)
    var data: UserRespHome?
    var isAlert = true
    var flagState = "Unspecified"
    var idCommunity = 0
    var isWillAppear = false
    let transition = SlideTransition()
    // let showOnboarding = UserDefaults.standard.bool(forKey: "onboarding")
    let showOnboarding = UserDefaults.standard.string(forKey: "NewOnboarding")
    var arraySections: [Bool] = []
    var saintOfDay: [HomeSaintOfDay] = []
    var realesesPost: [HomeSaintOfDay] = []
    var suggestions: [HomeSuggestions] = []
    var isFirstLoad = 0
    var modulesList: [LocationComponents] = []
    var allSections: [Any] = []
    var isFromPrayModal = "OTHER"
    var emptyStreaming = false
    let blueBackground = UIColor.init(red: 28/255, green: 117/255, blue: 188/255, alpha: 1)
    let redBackground = UIColor.init(red: 184/255, green: 12/255, blue: 12/255, alpha: 1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        //setupTableView()
        //presenter?.cargarDatosUsuario()
        presenter?.requestUserDetail()
        lblMessage.text = setMessageHour()
        //let formatter = DateFormatter()
        //formatter.dateFormat = "yyyy-MM-dd"
        //let now = Date()
        //let dateString = formatter.string(from: now)
        //self.presenter?.requestHomeData(type: "SAINT", date: "\(dateString)")
        
        //2021-07-27 2021-12-12
        self.hideKeyboardWhenTappedAround()
        collectionRegister()
        setupBarra()
        setupNewUI()
        //addTapGestures()
        //validateUserColors()
        profileStackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(notifyTap(_:))))
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            self.alert.dismiss(animated: true, completion: nil)
        })
        UNUserNotificationCenter.current().delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(popViews), name: NSNotification.Name(rawValue: "NotificationFeed"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(payWithQR), name: NSNotification.Name(rawValue: "openQR"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(openDonation), name: NSNotification.Name(rawValue: "openDonation"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(goToBAZ(sender:)), name: NSNotification.Name(rawValue: "goToBaz"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(showNotification), name: NSNotification.Name(rawValue: "intentionCreated"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(showSOSNotification), name: NSNotification.Name(rawValue: "SOSCreated"), object: nil)
        
        if let imageData = UserDefaults.standard.data(forKey: "userImage"), let image = UIImage(data: imageData) {
            userImage.image = image
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {

        let tabBar = self.tabBarController as? SocialNetworkController
        tabBar?.tabBar.isHidden = true
        tabBar?.customTabBar.isHidden = false
        if(EditionPromisseDataManager.shareInstance.findByEmail(profileID: UserDefaults.standard.value(forKey: "email") as? String ?? "").count > 0){
            let user = EditionPromisseDataManager.shareInstance.findByEmail(profileID: UserDefaults.standard.value(forKey: "email") as? String ?? "")
            userImage.image = HttpRequestSingleton.shareManager.convertBase64StringToImage(imageBase64String: user[0].image ?? "")
        }
    }
    
    func loadUserAttributs() {
        switch data?.UserAttributes.role {
        case UserRoleEnum.fiel.rawValue:
            print("fiel")
        case UserRoleEnum.fieladministrador.rawValue:
            print("fiel admin")
        case UserRoleEnum.sacerdote.rawValue:
            print("sacer")
        case UserRoleEnum.Sacerdoteadministrador.rawValue:
            print("sacer admin")
        case UserRoleEnum.Sacerdotedecano.rawValue:
            print("sacer decano")
        default:
            break
        }
    }

    func failLoadImg() {
        
    }
    
    func mostrarInfo(dtcAlerta: [String : String]?, user: UserRespHome?) {
        self.data = user
        alert.dismiss(animated: false, completion: { [self] in
            if let alerta = dtcAlerta {
                let alertaView = UIAlertController(title: alerta["titulo"], message: alerta["cuerpo"], preferredStyle: .alert)
                alertaView.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: nil))
                self.present(alertaView, animated: true, completion: nil)
            } else {
                vistaConNombre.isHidden = false
                guard let nombre = user?.UserAttributes.name, let role = user?.UserAttributes.role, let profile = user?.UserAttributes.profile
                else {
                    return
                }
                
                //UserDefaults.standard.set(user?.UserAttributes.id, forKey: "fiel_id")
                DispatchQueue.main.async {
                    let defaults = UserDefaults.standard
                    let apellido1 = user?.UserAttributes.last_name ?? " "
                    defaults.setValue(user?.UserAttributes.phone_number, forKey: "phone2")
                    defaults.setValue(user?.UserAttributes.last_name, forKey: "LastName2")
                    defaults.setValue(user?.UserAttributes.userRole, forKey: "role")
                    defaults.setValue(user?.UserAttributes.profile, forKey: "profile")
                    defaults.setValue("\(nombre) \(apellido1 )", forKey: "COMPLETENAME")
                    self.nombrePersona.adjustsFontSizeToFitWidth = true
                    self.nombrePersona.text = nombre + " " + apellido1
                    self.nombrePersona.adjustsFontSizeToFitWidth = true
                    if profile == "DEVOTED_ADMIN" || profile == "DEAN_PRIEST"{
                        UserDefaults.standard.set(true, forKey: "isPriest")
                        
                    }else{
                        UserDefaults.standard.set(false, forKey: "isPriest")
                    }
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    alert.dismiss(animated: true, completion: nil)
                })
            }
        })
    }
    
    @objc override func dismissKeyboard() {
        view.endEditing(true)
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("VC ECHome - HomeVC ")
        
        realesesPost=[]
        allSections=[]
        arraySections=[]
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let now = Date()
        let dateString = formatter.string(from: now)
        self.presenter?.requestHomeData(type: "SAINT", date: "\(dateString)")
        
        presenter?.cargarDatosUsuario()
        presenter?.requestStreaming()
        if let imageData = UserDefaults.standard.data(forKey: "userImage"), let image = UIImage(data: imageData) {
            userImage.image = image
        }else{
            presenter?.requestUserDetail()
        }
        validateUserColors()
        
    }
    
    // MARK: NEW FUCNTIONS -
    func successLoadImg(dataResponse: ProfileDetailImgH) {
        
        guard let nombre = dataResponse.data?.User?.name, let apellido1 = dataResponse.data?.User?.first_surname
        else {
            return
        }
        self.nombrePersona.text = nombre + " " + apellido1
        let status = dataResponse.data?.User?.community?.status
        let locationValidate = dataResponse.data?.User?.location_id
        let locationComponentsModules = dataResponse.data?.User?.location_modules?.first?.modules
        idCommunity = dataResponse.data?.User?.community?.id ?? 1
        UserDefaults.standard.setValue(dataResponse.data?.User?.image, forKey: "imageUrl")
        
        if locationValidate == nil {
            UserDefaults.standard.setValue(0, forKey: "locationId")
        }else{
            UserDefaults.standard.setValue(locationValidate, forKey: "locationId")
        }
        
        if locationComponentsModules == nil {
            UserDefaults.standard.set([], forKey: "locationModuleComponents")
        }else {
            UserDefaults.standard.set(locationComponentsModules, forKey: "locationModuleComponents")
        }
        
        if dataResponse.data?.User?.location_modules?.first?.id == nil {
            UserDefaults.standard.setValue(0, forKey: "locationModule")
        }else{
            UserDefaults.standard.setValue(dataResponse.data?.User?.location_modules?.first?.id, forKey: "locationModule")
        }
        
        modulesList = dataResponse.data?.User?.location_modules ?? modulesList
        modulesList.forEach({ item in
            if let array = item.modules {
                //print(array)
                array.forEach { sub in
                    switch sub{
                    case "LOCATION_INFORMATION":
                        switch item.type {
                        case "COMMUNITY":
                            arraySelectedCell.remove(at: 2)
                            arraySelectedCell.insert(true, at: 2)
                        default:
                            arraySelectedCell.remove(at: 1)
                            arraySelectedCell.insert(true, at: 1)
                        }
                        
                    case "SERVICES":
                        arraySelectedCell.remove(at: 3)
                        arraySelectedCell.insert(true, at: 3)
                        
                    case "SOCIAL_NETWORKS":
                        arraySelectedCell.remove(at: 0)
                        arraySelectedCell.insert(true, at: 0)
                        
//                    case "APPOINT_ADMINISTRATOR"
                        
                    default:
                        break
                    }
                }
            }
        })
        
        homeCV.reloadData()
        
        if dataResponse.data?.User?.image == nil {
            userImage.image = UIImage(named: "userImage", in: Bundle.local, compatibleWith: nil)
        }else{
            userImage.DownloadStaticImageH(dataResponse.data?.User?.image ?? "nil")
        }
        
        if isWillAppear == false {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.validateProfileOnboarding()
                self.isWillAppear = true
            }
            
        }else{
            print("Don't do the validation")
        }
        
    }
    
    func validateUserColors() {
        let blueEncuentro = UIColor.init(red: 25/255, green: 42/255, blue: 115/255, alpha: 1)
        let goldEncuentro = UIColor.init(red: 190/255, green: 169/255, blue: 120/255, alpha: 1)
        let profile = UserDefaults.standard.string(forKey: "profile")
        switch profile {
        case UserProfileEnum.fiel.rawValue, UserProfileEnum.sacerdote.rawValue:
            viewArriba.backgroundColor = .white
            lblGoodMorning.textColor = blueEncuentro
            nombrePersona.textColor = blueEncuentro
            lblAdmin.isHidden = true
            gearIcon.image = UIImage(named: "gearBlue", in: Bundle.local, compatibleWith: nil)
            userImage.layer.borderWidth = 2
            userImage.layer.borderColor = blueEncuentro.cgColor
            
        case UserProfileEnum.fieladministrador.rawValue, UserProfileEnum.Sacerdoteadministrador.rawValue:
            viewArriba.backgroundColor = .white
            lblGoodMorning.textColor = blueEncuentro
            nombrePersona.textColor = blueEncuentro
            lblAdmin.isHidden = false
            gearIcon.image = UIImage(named: "gearGold", in: Bundle.local, compatibleWith: nil)
            userImage.layer.borderWidth = 2
            userImage.layer.borderColor = goldEncuentro.cgColor
            
        case UserProfileEnum.Sacerdotedecano.rawValue:
            viewArriba.backgroundColor = blueEncuentro
            lblGoodMorning.textColor = .white
            nombrePersona.textColor = .white
            lblAdmin.isHidden = true
            gearIcon.image = UIImage(named: "gearGold", in: Bundle.local, compatibleWith: nil)
            userImage.layer.borderWidth = 2
            userImage.layer.borderColor = goldEncuentro.cgColor
            
        default:
            viewArriba.backgroundColor = .white
            lblGoodMorning.textColor = blueEncuentro
            nombrePersona.textColor = blueEncuentro
            lblAdmin.isHidden = true
            gearIcon.image = UIImage(named: "gearBlue", in: Bundle.local, compatibleWith: nil)
            userImage.layer.borderWidth = 2
            userImage.layer.borderColor = blueEncuentro.cgColor
            
        }
    }
    
    private func getInstalledVersion() -> String? {
                if let info = Bundle.main.infoDictionary,
                   let currentVersion = info["CFBundleShortVersionString"] as? String {
                    return currentVersion
                }
                return nil
        }
    
    
    private func setMessageHour() -> String {
            let hour = Calendar.current.component(.hour, from: Date())
            
            switch hour {
                
            case 0..<12:
                return "Buenos días,"
            case 12..<18:
                return "Buenas tardes,"
            case 18..<24:
                return "Buenas noches,"
            default:
                break
            }
            return ""
        }
    
    
    func validateProfileOnboarding() {
        let singleton = HomeViewController.singleton
        singleton.isFromPrayModal = "OTHER"
        let profile = UserDefaults.standard.string(forKey: "profile")
        if showOnboarding == "true" {
            switch profile {
            case UserProfileEnum.fiel.rawValue:
                UserDefaults.standard.set("false", forKey: "NewOnboarding")
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    let view = NewOnboardingRouter.createModule(typeOnboarding: "FirstOnboarding")
                    view.transitioningDelegate = self
                    view.modalPresentationStyle = .overFullScreen
                    self.present(view, animated: true, completion: nil)
                }
                
            case UserProfileEnum.fieladministrador.rawValue:
                UserDefaults.standard.set("false", forKey: "NewOnboarding")
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    let view = NewOnboardingRouter.createModule(typeOnboarding: "FaithfulAdmin")
                    view.modalPresentationStyle = .overFullScreen
                    view.transitioningDelegate = self
                    self.present(view, animated: true, completion: nil)
                }
                
            case UserProfileEnum.AdministradorComunidad.rawValue:
                UserDefaults.standard.set("false", forKey: "NewOnboarding")
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    let view = NewOnboardingRouter.createModule(typeOnboarding: "CommunityAdmin")
                    view.modalPresentationStyle = .overFullScreen
                    view.transitioningDelegate = self
                    self.present(view, animated: true, completion: nil)
                }
                
            case UserProfileEnum.ResponsableComunidad.rawValue:
                UserDefaults.standard.set("false", forKey: "NewOnboarding")
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    let view = NewOnboardingRouter.createModule(typeOnboarding: "CommunityResp")
                    view.modalPresentationStyle = .overFullScreen
                    view.transitioningDelegate = self
                    self.present(view, animated: true, completion: nil)
                }
                
            case UserProfileEnum.Sacerdoteadministrador.rawValue:
                UserDefaults.standard.set("false", forKey: "NewOnboarding")
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    let view = NewOnboardingRouter.createModule(typeOnboarding: "PriestAdmin")
                    view.modalPresentationStyle = .overFullScreen
                    view.transitioningDelegate = self
                    self.present(view, animated: true, completion: nil)
                }
                
            default:
                break
            }
        }else{
            print("Dont show onboarding")
        }
        
    }
    
    private func setupTableView() {
        mainTable.register(UINib(nibName: "HomeMainCell", bundle: Bundle.local), forCellReuseIdentifier: "HOMECELLT")
        
        mainTable.register(UINib(nibName: "HomeSliderCell", bundle: Bundle.local), forCellReuseIdentifier: "SLIDERCELL")
        
        mainTable.register(UINib(nibName: "AlertTableCell", bundle: Bundle.local), forCellReuseIdentifier: "ALERTCELL")
        
        mainTable.delegate = self
        mainTable.dataSource = self
        mainTable.reloadData()
        
    }
    
    private func setupNewUI() {
        transmitionsView.layer.cornerRadius = 8
    }
    
    func validateCommunityStatus(dataResponse: ProfileDetailImgH){
        let idC = dataResponse.data?.User?.community?.id ?? 0
        idCommunity = idC
        let profile = UserDefaults.standard.string(forKey: "profile")
        let communityStaus = dataResponse.data?.User?.community?.status
        UserDefaults.standard.set(dataResponse.data?.User?.location_modules?.first?.id, forKey: "locationCommunityId")
        UserDefaults.standard.set(communityStaus, forKey: "communityStatus")
        
        switch profile {
        case UserProfileEnum.ResponsableComunidad.rawValue:
            switch  communityStaus {
            case UserCommunityStatus.pendingApproval.rawValue:
                flagState = "PENDING_VICARAGE_APPROVAL"
            case UserCommunityStatus.complete.rawValue:
                flagState = "COMPLETED"
            case UserCommunityStatus.pendindCompletion.rawValue:
                flagState = "PENDING_COMPLETION"
                
//            case nil:
//                let view = AnswerFoemularyWireFrame.createModule()
//                 present(view, animated: true, completion: nil)
                
            default:
                break
            }
            
        default:
            break
            
        }
        
    }
    
    func didPressButtonPost(url: String){
        let view = ModalWebViewController.showWebModal(url: url , type: "OTHER")
        self.present(view, animated: true, completion: nil)
    }
    
    func didPressButton(_ tag: Int, type: String, library: String, url: String, id: Int) {
        print("&&&", tag)
        switch tag {
        case 500:
            let view = CommunitiesMainViewWireFrame.getControllerFormHome(id: idCommunity)
            self.navigationController?.pushViewController(view, animated: true)
            print(idCommunity)
        default:
            print(type, library)
            switch type {
            case "VIDEO":
                let singleton = HomeViewController.singleton
                singleton.isFromPrayModal = "VIDEO"
                guard let url = URL(string: url) else { return }
                let view = ModalWebViewController.showWebModal(url: url.absoluteString.embedAndPlayYoutubeURL(), type: "VIDEO")
                view.transitioningDelegate = self
                view.modalPresentationStyle = .overFullScreen
                self.present(view, animated: true, completion: nil)

            case "LINK":
                if library == "PRAYERS" {
                    let singleton = HomeViewController.singleton
                    singleton.isFromPrayModal = "PRAY"
                    let view = OracionesDetailRouter.getDetailView(id: id)
                    view.transitioningDelegate = self
                    view.modalPresentationStyle = .overFullScreen
                    self.navigationController?.pushViewController(view, animated: true)
                }else{
                    let singleton = HomeViewController.singleton
                    singleton.isFromPrayModal = "OTHER"
                    let view = ModalWebViewController.showWebModal(url: url, type: "OTHER")
                    view.modalPresentationStyle = .overFullScreen
                    self.present(view, animated: true, completion: nil)
                }
                
            default:
                break
            }
        }
        
    }
    
    // NEW HOME FUNCTIONS
    func succesGetHome(data: [HomeSaintOfDay], type: String) {
        switch type {
        case "SAINT":
            DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                print("::::::succesGetHome SAINT::;;;")
             })
            saintOfDay = data
            if saintOfDay.count != 0 {
                allSections.append(saintOfDay)
            }
            //print("----", saintOfDay)
            if data.count != 0 {
                arraySections.append(true)
            }else{
                arraySections.append(false)
            }
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            let now = Date()
            let dateString = formatter.string(from: now)
            self.presenter?.requestHomeData(type: "RELEASE", date: "\(dateString)")
            
        default:
            realesesPost = data
            DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                print("::::::succesGetHome Default::;;;")
                print(String(self.realesesPost.count))
             })
            if realesesPost.count != 0 {
                allSections.append(realesesPost)
            }
            if data.count != 0 {
                arraySections.append(true)
            }else{
                arraySections.append(false)
            }
            
            self.presenter?.requestSuggestions(type: "SUGGESTIONS")
        }
    }
    
    func onSuccessGetSuggestions(data: [HomeSuggestions]) {
        suggestions = data
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
            print("::::::onSuccessGetSuggestions::;;;")
         })
        if suggestions.count != 0 {
            allSections.append(suggestions)
        }
        setupTableView()
    }
    
    func failGetHome(message: String) {
        arraySections.append(false)
    }
    
    func onFialGetSuggestions(message: String) {
        print("Error HomeVC: "+message)
    }
    
    func successStreaming(data: [LiveModel]) {
        
        if data.count == 0 {
            transmitionsView.backgroundColor = blueBackground
            emptyStreaming = false
        }else{
            transmitionsView.backgroundColor = redBackground
            emptyStreaming = true
        }
        print("~~~", data)
    }
    
    func failStreaming(message: String) {
        print("Error Streming Home : "+message)
        emptyStreaming = false
    }
    
    // MARK: OLD FUNCTIONS -
    func collectionRegister(){
        homeCV.dataSource = self
        homeCV.delegate = self
        homeCV.register(UINib(nibName: "HomeCV",bundle: Bundle.local), forCellWithReuseIdentifier: "HomeCV")
    }
    
    func setupView(){
        userImage.contentMode = .scaleAspectFill
        containerDonations.layer.cornerRadius = 10
        userImage.layer.cornerRadius = userImage.layer.bounds.width / 2
        let imageView = UIImageView(frame: CGRect(x: 75, y: 25, width: 140, height: 60))
        imageView.image = UIImage(named: "logoEncuentro", in: Bundle.local, compatibleWith: nil)
        alert.view.addSubview(imageView)
        self.present(alert, animated: false, completion: nil)
    }
    
    func setupBarra() {
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1334:
                print("iPhone 6/6S/7/8")
                //donatiosButtonSpace.constant = 91.0
            default:
                //donatiosButtonSpace.constant = 73.0
                print("Default case")
            }
        }
        
        viewArriba.layer.cornerRadius = 20
        viewArriba.ShadowNavBar()
    }
    
    func animateViewMoving (up:Bool, moveValue :CGFloat){
        let movementDuration:TimeInterval = 0.3
        let movement:CGFloat = ( up ? -moveValue : moveValue)
        UIView.beginAnimations( "animateView", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(movementDuration )
        self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement)
        UIView.commitAnimations()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        animateViewMoving(up: true, moveValue: 200.0)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        animateViewMoving(up: false, moveValue: 200.0)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = CharacterSet(charactersIn: "1234567890")
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .badge, .sound])
    }
    
    @objc func goToBAZ(sender: Notification){
        if sender.object != nil{
            let donation = sender.object as! String
            presenter?.abrirBancoAppParaApoyar(mount: donation)
        }
    }
    
    @objc func openDonation(_ sender: Any){
        let view = DonationsRouter.createModule()
        self.navigationController?.pushViewController(view, animated: true)
    }
    
    @objc func payWithQR(_ sender: Any){
        let scanner = SQRRouter.createModule(navigation: self.navigationController!)
        self.navigationController?.pushViewController(scanner, animated: true)
    }
    
    @objc func notifyTap(_ sender: UITapGestureRecognizer){
        print("HomeVC PERFIL CLICK")
        NotificationCenter.default.post(name: Notification.Name("handleSuperTapVirtual"), object: nil)
        let view = ProfileInfoRouter.createModule()
        self.navigationController?.pushViewController(view, animated: true)
    }
    
    @objc func popViews(){
        for controller in self.navigationController!.viewControllers as Array {
            if controller.isKind(of: HomeViewController.self) {
                self.navigationController!.popToViewController(controller, animated: true)
                break
            }
        }
    }
    
    @objc func showNotification(){
        let content = UNMutableNotificationContent()
        content.title = "Encuentro Catolico"
        content.subtitle = "Su intención ha sido agendada con exito"
        content.badge = 1
        content.sound = .defaultCritical
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest(identifier: "SimplifiedIOSNotification", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
    @objc func showSOSNotification(){
        let content = UNMutableNotificationContent()
        content.title = "Encuentro Catolico"
        content.subtitle = "Solicitud de S.O.S enviada correctamente"
        content.badge = 1
        content.sound = .defaultCritical
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 2.5, repeats: false)
        let request = UNNotificationRequest(identifier: "showSOSNOT", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: { [self]_ in
            confirmSOSService()
        })
    }
    
    @objc func confirmSOSService(){
        let content = UNMutableNotificationContent()
        content.title = "Encuentro Catolico"
        content.subtitle = "Su solicitud se encuentra en progreso"
        content.badge = 1
        content.sound = .defaultCritical
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 7, repeats: false)
        let request = UNNotificationRequest(identifier: "CONFIRMSOS", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
    @IBAction func openDonations(_ sender: Any){
        let view = NewDonationsRouter.createModule()//DonationsWindow(nibName: "DonationsWindow", bundle: Bundle.local)
        self.navigationController?.pushViewController(view, animated: true)
        //self.present(view, animated: true, completion: nil)
    }
    
    @IBAction func goToProfile(_ sender: Any){
        let view = ProfileInfoRouter.createModule()
        self.navigationController?.pushViewController(view, animated: true)
    }
    
    @IBAction func enVivoAction(_ sender: Any) {
        let profile = LiveRouter.createModule()
        if emptyStreaming == true {
            self.navigationController?.pushViewController(profile, animated: true)
        }else{
            print("Dont go")
        }
    }
    
    @IBAction func toNotifications(_ sender: Any) {
        let view = NotificationRouter.presentModule()
        self.navigationController?.pushViewController(view, animated: true)
    }
}

extension UIViewController {
    
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension String{
    
    func toImage() -> UIImage? {
        if let data = Data(base64Encoded: self, options: .ignoreUnknownCharacters){
            return UIImage(data: data)
        }
        return nil
    }
    
    func random(digits:Int) -> String {
        var number = String()
        for _ in 1...digits {
            number += "\(Int.random(in: 1...9))"
        }
        return number
    }
    
    func index(from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
    }
    
    func substring(from: Int) -> String {
        let fromIndex = index(from: from)
        return String(self[fromIndex...])
    }
    
    func substring(to: Int) -> String {
        let toIndex = index(from: to)
        return String(self[..<toIndex])
    }
    
    func substring(with r: Range<Int>) -> String {
        let startIndex = index(from: r.lowerBound)
        let endIndex = index(from: r.upperBound)
        return String(self[startIndex..<endIndex])
    }
}

extension UITextField {
    func setBottomBorder() {
        self.borderStyle = .none
        self.layer.backgroundColor = UIColor.white.cgColor
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 0.0
    }
}

extension UIImage {
    func rotate(radians: CGFloat) -> UIImage {
        let rotatedSize = CGRect(origin: .zero, size: size)
            .applying(CGAffineTransform(rotationAngle: CGFloat(radians)))
            .integral.size
        UIGraphicsBeginImageContext(rotatedSize)
        if let context = UIGraphicsGetCurrentContext() {
            let origin = CGPoint(x: rotatedSize.width / 2.0,
                                 y: rotatedSize.height / 2.0)
            context.translateBy(x: origin.x, y: origin.y)
            context.rotate(by: radians)
            draw(in: CGRect(x: -origin.y, y: -origin.x,
                            width: size.width, height: size.height))
            let rotatedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            return rotatedImage ?? self
        }
        
        return self
    }
}

extension HomeViewController: UIViewControllerTransitioningDelegate {
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = false
        let profile = UserDefaults.standard.string(forKey: "profile")
        
        let singleton = HomeViewController.singleton
        
        switch singleton.isFromPrayModal {
        case "PRAY":
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                let view = OracionesRouter.getController()
                self.navigationController?.pushViewController(view, animated: true)
            }
            
        case "VIDEO":
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                let view = YoungView_Route.createView(navigation: self.navigationController!)
                self.navigationController?.pushViewController(view, animated: true)
            }
            
        default:
            if isWillAppear == true {
                let goProfile = UserDefaults.standard.string(forKey: "GoProfile")
                
                if goProfile == nil && profile == "DEVOTED" {
                    let view = ProfileInfoRouter.createModule()
                    self.navigationController?.pushViewController(view, animated: true)
                }else{
                    print("DEBUG: Dont go to profile")
                }
                
            }
        }
        
        return transition
        
    }
}
