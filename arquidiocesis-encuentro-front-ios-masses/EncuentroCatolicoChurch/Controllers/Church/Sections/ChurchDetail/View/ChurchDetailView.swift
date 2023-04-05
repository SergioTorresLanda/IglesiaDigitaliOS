//
//  ChurchDetailView.swift
//  Encuentro
//
//  Created by Edgar Hernandez Solis on 02/12/2021.
//  Copyright © 2021 Linko. All rights reserved.
//

import Foundation
import UIKit
import AlamofireImage
import MapKit
import MessageUI
import Toast_Swift
import EncuentroCatolicoVirtualLibrary

struct NewMassesData {
    var daysStr: String?
    var hour: String
}

class MiIglesia_InfoIglesia: BaseViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var btnRealPhone: UIButton!
    @IBOutlet weak var socialTableView: UITableView!
    @IBOutlet weak var addSocialButton: UIButton!
    @IBOutlet weak var addMassesButton: UIButton!
    
    @IBOutlet weak var deleteMassesButton: UIButton!
    @IBOutlet weak var addServicesButton: UIButton!
    @IBOutlet weak var btnRealMail: UIButton!
    @IBOutlet var imgFav: UIImageView!
  
    @IBOutlet weak var churchHeaderImage: UIImageView!
    @IBOutlet weak var churchNameLabel: UILabel!
    @IBOutlet weak var churchSubtitleLabel: UILabel!
    @IBOutlet weak var churchAddressLabel: UILabel!
    @IBOutlet weak var churchResponsibleLabel: UILabel!
    @IBOutlet weak var churchScheduleLabel: UILabel!
    @IBOutlet weak var churchOfficeScheduleLabel: UILabel!
    @IBOutlet weak var massCollectionView: UICollectionView!
    @IBOutlet weak var churchMassContainer: UIView!
    
    @IBOutlet weak var servicesCollectionView: UICollectionView!
    @IBOutlet weak var churchServicesContainer: UIView!
    
    @IBOutlet weak var btnPhoneNumber: UIButton!
    @IBOutlet weak var btnMailInfo: UIButton!
    @IBOutlet weak var lblPhoneNumber: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var stackLblMail: UIStackView!
    @IBOutlet weak var stackLblPhone: UIStackView!
    @IBOutlet weak var firstCardStack: UIStackView!
    @IBOutlet weak var stkPhone: UIStackView!
    @IBOutlet weak var stkMail: UIStackView!
    @IBOutlet weak var contentCardView: UIView!
    @IBOutlet weak var subContentCard: UIView!
    @IBOutlet weak var btnGoComments: UIButton!
    @IBOutlet weak var btnEdit: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var stkButtonSave: UIStackView!
    @IBOutlet weak var newChurchMassCollection: UICollectionView!
    @IBOutlet weak var socialContainer: UIView!
    @IBOutlet weak var contentNavBar: UIView!
    @IBOutlet weak var customNavBar: UIView!
    @IBOutlet weak var lblTitleNavBar: UILabel!
    @IBOutlet weak var backIcon: UIImageView!
    // COMMENTS SECTION
    @IBOutlet weak var commentsCard: UIView!
    @IBOutlet weak var lblSectionComments: UILabel!
    @IBOutlet weak var star1: UIImageView!
    @IBOutlet weak var star2: UIImageView!
    @IBOutlet weak var star3: UIImageView!
    @IBOutlet weak var star4: UIImageView!
    @IBOutlet weak var star5: UIImageView!
    @IBOutlet weak var lblNmberComments: UILabel!
    @IBOutlet weak var commentsTable: UITableView!
    @IBOutlet weak var socialShadowCard: UIView!
    @IBOutlet weak var btnPrincipal: UIButton!
    @IBOutlet weak var hComments: NSLayoutConstraint!
    @IBOutlet weak var hServices: NSLayoutConstraint!
    
    @IBOutlet weak var hMasses: NSLayoutConstraint!
    @IBOutlet weak var hSocial: NSLayoutConstraint!
    @IBOutlet weak var lblRedesSociales: UILabel!
    @IBOutlet weak var hSocialS: NSLayoutConstraint!
    @IBOutlet weak var progress: UIActivityIndicatorView!
    
    @IBOutlet weak var viewAsFielBtn: UIButton!
    
    var alertFields : AcceptAlert?
    var presenter: ChurchDetailPresenterProtocol?
    var showTutorial = true
    let transition = SlideTransition()
    var isTappedFav: Bool = true
    var isPrincipal: Int?
    var isEditProfile: Bool = true
    var lvInt = Int()
    var nameNew = String()
    var intitutionNew = String()
    var charismNew = String()
    var resposableNew = String()
    var descriptionNew = String()
    var addressNew = String()
    var lvTextNew = String()
    var lvHourNew = String()
    var sdTextNew = String()
    var sdHourNew = String()
    var emailNew = String()
    var phoneNew = String()
    var latitudeNew = Double()
    var longitudeNew = Double()
    var webNew = String()
    var instaNew = String()
    var twittNew = String()
    var faceNew = String ()
    var streamNew = String()
    var bankNew = String()
    var flagEdit: Bool = false
    var pricipalID = Int()
    var serviceCatalog: ServiceCatalogModel?
    var serviceHourEditlv: [AttentionEditChurch] = []
    var serviceHourEditsd: [AttentionEditChurch] = []
    var serviceDayEdit: [ServiceHourEditProfile] = []
    var serviceHourEdit: [ScheduleEditPrifile] = []
    var serviceEditNew: [DayEditChurch] = []
    var serviceDaySd: [DayEditChurch] = []
    var serviceDaylv: [DayEditChurch] = []
    var masesNuew: [MassEditChurch] = []
    var massesDayNew: [DayEditChurch] = []
    var strDaysAct = [String]()
    var arrayOfIndex = [[Int]]()
    var attentionnew: [AttentionEditChurch] = []
    var attentionDaysNew: [DayEditChurch] = []
    var serviceType: TypeClassEditChurch?
    var serviceSchedules: [AttentionEditChurch] = []
    var serviceDay: [DayEditChurch] = []
    var serviceNew: [ServiceEditChurch] = []
    var scheduleDay: [AttentionEditChurch] = []
    var scheduleHour: [DayEditChurch] = []
    var commentList: [CommentsList] = []
    var churcuPrincipalId: Int?
    var social: [String] = []
    var socialIdentifier: [String] = []
    let facebookIcon = UIImage(named: "facebookIcon", in: Bundle.local, compatibleWith: nil)
    let twitterIcon = UIImage(named: "tuitterIcon", in: Bundle.local, compatibleWith: nil)
    let webIcon = UIImage(named: "webIcon", in: Bundle.local, compatibleWith: nil)
    let stramIcon = UIImage(named: "streamIcon", in: Bundle.local, compatibleWith: nil)
    let instaIcon = UIImage(named: "instagramIcon", in: Bundle.local, compatibleWith: nil)
    var socialIcon = ["facebookIcon", "instagramIcon", "tuitterIcon", "streamIcon", "webIcon"]
    let profileRole = UserDefaults.standard.string(forKey: "profile")
    let userRole = UserDefaults.standard.string(forKey: "role")
    let locationId = UserDefaults.standard.integer(forKey: "locationId")
    let locationComponent = UserDefaults.standard.integer(forKey: "locationModule")
    let locationcomponents = UserDefaults.standard.object(forKey: "locationModuleComponents") as? [String]
    let userID = UserDefaults.standard.integer(forKey: "id")
    var scheduleHoreResponse: String?
    var offieceHourResponse: String?
    let defaults = UserDefaults.standard
    let loadingAlert = UIAlertController(title: "", message: "\n \n \n \n \nCargando...", preferredStyle: .alert)
    var arrayNewObject = [NewMassesData]()
    var globalArray: [NewMassesData] = []
    var globalArray2: [NewMassesData] = []
    var church: ChurchDetail?
    var churchId: Int?
    
    var firstDaySer = String()
    var lastDaySer = String()
    var firstDayAt = String()
    var lastDayAt = String()
    var hStrartSer = String()
    var hEndSer = String()
    var hStartAt = String()
    var hEndAt = String()
    
    @IBAction func viewAsFielClick(_ sender: Any) {
        canEdit(b: false)
        
    }
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        let flagTutorial = defaults.bool(forKey: "SHOWTUTORIAL")
        if flagTutorial == false {
            let view = TutorialView.showTutorial()
            view.transitioningDelegate = self
            self.present(view, animated: false, completion: nil)
            defaults.set(true, forKey: "SHOWTUTORIAL")
        }else{
            print("Dont show tutorial")
            initContent()
            showTutorial = false
        }
        
        if let count = navigationController?.viewControllers.count {
            navigationController?.viewControllers[0..<(count-1)].removeAll(where: {$0 is MiIglesia_InfoIglesia})
        }
        
        presenter?.getServiceCatalog()
        initView()
        validateProfile()
        setupUI()
        setupGestures()
        churchNameLabel.sizeToFit()
        massCollectionView.isHidden = true
        servicesCollectionView.isHidden = true
        churchNameLabel.adjustsFontSizeToFitWidth = true
        
        if !showTutorial {
            switch isPrincipal {
            case 0:
                isTappedFav = false
                imgFav.alpha = 0
                btnPrincipal.isHidden = false
            case 1:
                imgFav.image = UIImage(named: "unfav", in: Bundle(for: MiIglesia_InfoIglesia.self), compatibleWith: nil)
                btnPrincipal.isHidden = true
                isTappedFav = false
                imgFav.isUserInteractionEnabled = true
            case 2:
                imgFav.image = UIImage(named: "fav", in: Bundle(for: MiIglesia_InfoIglesia.self), compatibleWith: nil)
                btnPrincipal.isHidden = true
                isTappedFav = true
                imgFav.isUserInteractionEnabled = true
            case 3:
                imgFav.alpha = 0
                btnPrincipal.isHidden = true
            default:
                break
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("EC MiIglesia_InfoIglesia")
        progress.isHidden=true
        presenter?.requestListComments(queryParams: "\(churchId ?? 1)/reviews?page=1&per_page=10")
    }
    
    //MARK: - IBActions
    @IBAction func editAction() {
        contentCardView.layer.masksToBounds = true
        subContentCard.layer.masksToBounds = true
        subContentCard.ShadowCard()
        if let id = churchId {
            guard let church = self.church else {
                return
            }
            presenter?.goToEdition(id: id, churchDetail: church)
        }
    }
    
    func actionSave(){
        stkButtonSave.isHidden=true
        view.alpha = 0.5
        progress.isHidden=false
        progress.startAnimating()
        presenter?.putChurchEdition(locationId: churchId ?? 1, description: descriptionNew, email: emailNew, phone: phoneNew, website: webNew, instagram: instaNew, twitter: twittNew, facebook: faceNew, streaming: streamNew, bankAcount: bankNew, principal: pricipalID, schedules: scheduleDay, attention: attentionnew, masses: masesNuew, services: serviceNew)
    }
    
    @IBAction func goToMapsActions() {
        
        guard let latitud =  church?.latitude else {return}
        guard let longitude =  church?.longitude else {return}
        
        let coordinates = CLLocationCoordinate2D(latitude: CLLocationDegrees(CGFloat(latitud)), longitude: CLLocationDegrees(CGFloat(longitude)))
        
        let mapsAlert = UIAlertController(title: "Iglesia Digital", message: "Selecciona una opción", preferredStyle: .actionSheet)
        let appleMaps = UIAlertAction(title: "Apple Maps", style: .default) {
            _ in
            let churchMapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinates))
            churchMapItem.name = self.church?.name
            churchMapItem.openInMaps()
        }
        
        let googleMaps = UIAlertAction(title: "Google Maps", style: .default) {
            _ in
            let mapsUrl = URL(string:"https://www.google.com/maps/place/\(coordinates.latitude),\(coordinates.longitude)")!
            if (UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!)) {
                UIApplication.shared.open(mapsUrl, options: [:]) {
                    _ in
                }
            } else if (UIApplication.shared.canOpenURL(URL(string:"https://www.google.com/maps")!)) {
                UIApplication.shared.open(mapsUrl, options: [:]) {
                    _ in
                }
            }
        }
        
        let waze = UIAlertAction(title: "Waze", style: .default) {
            _ in
            let mapsUrl = URL(string:"https://www.waze.com/ul?ll=\(coordinates.latitude),\(coordinates.longitude)&navigate=yes&zoom=17")!
            
            if (UIApplication.shared.canOpenURL(URL(string:"waze://")!)) || (UIApplication.shared.canOpenURL(URL(string:"https://www.waze.com/")!)) {
                UIApplication.shared.open(mapsUrl, options: [:]) {
                    _ in
                }
            }
        }
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel)
        mapsAlert.addAction(appleMaps)
        mapsAlert.addAction(googleMaps)
        mapsAlert.addAction(waze)
        mapsAlert.addAction(cancelAction)
        present(mapsAlert, animated: true)
    }
    
    @IBAction func goToComments(_ sender: Any) {
        let newUser = UserDefaults.standard.bool(forKey: "isNewUser")
        if newUser {//esta logueado proceder
            commentList.removeAll()
            let view = CommentsRouter.createModule(param: "\(churchId ?? 1)/reviews?page=1&per_page=10", locationID: churchId ?? 1, churchName: churchNameLabel.text ?? "")
            self.navigationController?.pushViewController(view, animated: true)
        }else{
            showCanonAlert(title: "Atención", msg: "Regístrate o inicia sesión para escribir una opinión.")
        }
    }
    
    @IBAction func editAction(_ sender: Any) {
        RegisterFirmulary.instance.showAllert()
        RegisterFirmulary.instance.title1Label.isHidden = true
        RegisterFirmulary.instance.title2Label.isHidden = true
        RegisterFirmulary.instance.title3Label.isHidden = true
        RegisterFirmulary.instance.nameTextField.isHidden = true
        RegisterFirmulary.instance.institutinTextField.isHidden = true
        RegisterFirmulary.instance.charismaTextField.isHidden = true
        RegisterFirmulary.instance.separator1View.isHidden = true
        RegisterFirmulary.instance.separator2View.isHidden = true
        RegisterFirmulary.instance.separator3View.isHidden = true
        RegisterFirmulary.instance.title4Label.text = "Nombre de la Iglesia"
        RegisterFirmulary.instance.title5Label.text = "Párroco Responsable"
        RegisterFirmulary.instance.responsableTextField.placeholder = "Parroquia del Señor de la Santísima Resurrección"
        RegisterFirmulary.instance.descriptionTextField.placeholder = "Pbro Juan José López Rodríguez"
        RegisterFirmulary.instance.lvTitleLabel.text = "Horario de templo"
        RegisterFirmulary.instance.sdTitleLabel.text = "Horario de oficina"
        if addressNew != "" {
            RegisterFirmulary.instance.addressTextField.text = addressNew
        }
        if emailNew != "" {
            RegisterFirmulary.instance.emailTextField.text = emailNew
        }
        if phoneNew != "" {
            RegisterFirmulary.instance.phoneTextField.text = phoneNew
        }
        if nameNew != "" {
            RegisterFirmulary.instance.responsableTextField.text = nameNew
        }
        if resposableNew != "" {
            RegisterFirmulary.instance.descriptionTextField.text = resposableNew
        }
        if church?.horary?.isEmpty == false {
            RegisterFirmulary.instance.lvHourTextField.text = "\(hStrartSer)  \(hEndSer)"
        }
        if church?.attention?.isEmpty == false {
            RegisterFirmulary.instance.sdHourTextField.text = "\(hStartAt)  \(hEndAt)"
        }
        if church?.horary?.isEmpty == false {
            RegisterFirmulary.instance.lvTextField.text = "\(firstDaySer.lowercased())  \(lastDaySer.lowercased())"
        }
        if church?.attention?.isEmpty == false {
            RegisterFirmulary.instance.sdTextField.text = "\(firstDayAt.lowercased())  \(lastDayAt.lowercased())"
        }
        RegisterFirmulary.instance.responsableTextField.isUserInteractionEnabled=false
        RegisterFirmulary.instance.descriptionTextField.isUserInteractionEnabled=false
        RegisterFirmulary.instance.delegate = self
        RegisterFirmulary.instance.delegateData = self
        RegisterFirmulary.instance.parentView.frame = CGRect(x: 0, y: 100, width: self.view.frame.width, height: RegisterFirmulary.instance.parentView.frame.height-125)
        flagEdit = true
        validateProfile()
    }
    
    //MARK: - Local variables
    
    @IBAction func makePrincipal(_ sender: Any) {
        //verificar login
        let newUser = UserDefaults.standard.bool(forKey: "isNewUser")
        if newUser {//esta logueado proceder
            if self.isTappedFav {
                self.removeFavoriteFiel()
            } else {
                self.addFavoriteFiel()
            }
        }else{
            showCanonAlert(title: "Atención", msg: "Regístrate o inicia sesión para agregar esta iglesia como principal.")
        }
    }
    
    func showCanonAlert(title:String, msg:String){
        alertFields = AcceptAlert.showAlert(titulo: title, mensaje: msg)
        alertFields!.view.backgroundColor = .clear
        self.present(alertFields!, animated: true)
    }
    
    @IBAction func addSocialButtonAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "AddSocial", bundle: Bundle.local)
        if let nAS: NewAddSocialController = storyboard.instantiateViewController(withIdentifier: "NewAddSocial") as? NewAddSocialController {
            nAS.delegate = self
            nAS.modalPresentationStyle = .overFullScreen
            self.present(nAS, animated: true, completion: nil)
        }
    }
    
    @IBAction func addMassesButtonAction(_ sender: Any) {
        print("addMasses")
        let storyboard = UIStoryboard(name: "StoryboardAddMasses", bundle: Bundle.local)
        if let nAM: NewAddMassesView = storyboard.instantiateViewController(withIdentifier: "NewAddMasses") as? NewAddMassesView {
            nAM.delegate = self
            nAM.modalPresentationStyle = .overFullScreen
            self.present(nAM, animated: true, completion: nil)
        }
    }
    
    @IBAction func addServicesButtonAction(_ sender: Any) {
        print("addServices")
        guard let service = serviceCatalog else {return} //no hay servicios
        AddService.instance.showAllertChurch(data: service)
        AddService.instance.delegate = self
        let mainViewHeight = view.frame.size.height
        AddService.instance.parentView.frame = CGRect(x: 0, y: 105, width: self.view.frame.width, height: AddService.instance.parentView.frame.height)
        view.isUserInteractionEnabled = false
        view.alpha = 0.5
    }
    //MARK: - View controls
    private func initView() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapImageFav))
        self.imgFav.addGestureRecognizer(tapGestureRecognizer)
        self.validatePhoneAndMail()
    }
    
    private func setupUI() {
        customNavBar.layer.cornerRadius = 20
        customNavBar.ShadowNavBar()
        btnGoComments.layer.cornerRadius = 20
        socialShadowCard.layer.cornerRadius = 10
        socialTableView.layer.cornerRadius = 10
        socialShadowCard.ShadowCard()
    }
    
    private func setupGestures() {
        let tapBack = UITapGestureRecognizer(target: self, action: #selector(TapBack))
        backIcon.addGestureRecognizer(tapBack)
    }
    
    @objc func TapBack() {
        if flagEdit{
            RegisterFirmulary.instance.parentView.frame = CGRect(x: 0, y: 100, width: self.view.frame.width, height: RegisterFirmulary.instance.parentView.frame.height+125)
            RegisterFirmulary.instance.parentView.removeFromSuperview()
            flagEdit=false
        }else{
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func setupCollectionDelegates() {
        servicesCollectionView.register(ServiceCollectionViewCell.nib, forCellWithReuseIdentifier: ServiceCollectionViewCell.reuseIdentifier)
        servicesCollectionView.delegate = self
        servicesCollectionView.dataSource = self
        massCollectionView.register(ServiceCollectionViewCell.nib, forCellWithReuseIdentifier: ServiceCollectionViewCell.reuseIdentifier)
        massCollectionView.delegate = self
        massCollectionView.dataSource = self
        //newChurchMassCollection.register(UINib(nibName: "ServiceCollectionViewCell", bundle: Bundle.local), forCellWithReuseIdentifier: "ServiceCollectionViewCell")
        newChurchMassCollection.register(ServiceCollectionViewCell.nib, forCellWithReuseIdentifier: ServiceCollectionViewCell.reuseIdentifier)
        newChurchMassCollection.delegate = self
        newChurchMassCollection.dataSource = self
      
        socialTableView.register(SocialTableViewCell.nib, forCellReuseIdentifier: SocialTableViewCell.reuseIdentifier)
        socialTableView.delegate = self
        socialTableView.dataSource = self
    }
    
    func loadUserAttributs() {
        switch userRole {
        case UserRoleEnum.fiel.rawValue:
            print("")
        case UserRoleEnum.fieladministrador.rawValue:
            print("")
        case UserRoleEnum.sacerdote.rawValue:
            print("")
        case UserRoleEnum.Sacerdoteadministrador.rawValue:
            print("")
        case UserRoleEnum.Sacerdotedecano.rawValue:
            print("")
        default:
            break
        }
    }
    
    @objc private func tapImageFav() {
        let newUser = UserDefaults.standard.bool(forKey: "isNewUser")
        if newUser {//esta logueado proceder
            if self.isTappedFav {
                self.removeFavoriteFiel()
            } else {
                self.addFavoriteFiel()
            }
        }else{
            showCanonAlert(title: "Atención", msg: "Regístrate o inicia sesión para agregar esta iglesia como favorita.")
        }
    }
    
    func updateFavImage() {
        if isPrincipal == 0 {
            DispatchQueue.main.async {
                self.btnPrincipal.isHidden = true
                self.isTappedFav = false
            }
        }else{
            DispatchQueue.main.async {
                self.imgFav.image = UIImage(named: "unfav", in: Bundle(for: MiIglesia_InfoIglesia.self), compatibleWith: nil)
                self.isTappedFav = false
            }
        }
    }
    func updateDeleteImage() {
        if isPrincipal == 0 {
            DispatchQueue.main.async {
                self.btnPrincipal.isHidden = true
                self.imgFav.isUserInteractionEnabled = false
            }
        }else{
            DispatchQueue.main.async {
                self.imgFav.image = UIImage(named: "fav", in: Bundle(for: MiIglesia_InfoIglesia.self), compatibleWith: nil)
                self.isTappedFav = true
            }
        }
    }
    
    func showLoading() {
        let imageView = UIImageView(frame: CGRect(x: 100, y: 15, width: 80, height: 80))//mitad es en 145dp
        imageView.image = UIImage(named: "iconoIglesia3", in: Bundle.local, compatibleWith: nil)
        loadingAlert.view.addSubview(imageView)
        present(loadingAlert, animated: true, completion: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
            self.loadingAlert.dismiss(animated: true, completion: nil)
        })
    }
    
    func hideLoading() {
        loadingAlert.dismiss(animated: false, completion: nil)
    }
    
    private func validateProfile() {
        print("VALIDATE PROFILE::")
        print(profileRole)
        if locationComponent != 0 {
            if locationComponent == churchId { //condicion locationId == churchId sobra
                switch profileRole {
                case UserProfileEnum.Sacerdoteadministrador.rawValue,
                    UserProfileEnum.clergyVicarage.rawValue,
                    UserProfileEnum.Sacerdotedecano.rawValue:
                    canEdit(b:true)
                case UserProfileEnum.fieladministrador.rawValue:
                    if ((locationcomponents?.contains("LOCATION_INFORMATION")) == true){
                        canEdit(b:true)
                    }else {
                        canEdit(b: false)
                    }
                case UserProfileEnum.AdministradorComunidad.rawValue, UserProfileEnum.sacerdote.rawValue, UserProfileEnum.ResponsableComunidad.rawValue, UserProfileEnum.fiel.rawValue, UserProfileEnum.MiembroComunidad.rawValue:
                    canEdit(b: false)
                default:
                    canEdit(b: false)
                }
            }else{
                canEdit(b: false)
            }
        }else {
            canEdit(b: false)
        }
    }
    
    func canEdit(b:Bool){
        print("canEdit::"+String(b))
        btnEdit.isHidden = !b
        imgFav.isHidden = b
        addMassesButton.isHidden = !b
        addSocialButton.isHidden = !b
        addServicesButton.isHidden = !b
        btnGoComments.isHidden = b
    }
    
    private func initContent() {
        churchHeaderImage.image = UIImage(named: "church-placeholder", in: Bundle(for: MiIglesia_InfoIglesia.self), compatibleWith: nil)
        if let id = churchId {
            showLoading()
            presenter?.getDetail(id: id)
        }
    }
    
    private func validatePhoneAndMail() {
        lblPhoneNumber.text = church?.phone
        lblEmail.text = church?.email
        hidePhone(b: church?.phone == nil)
        hideMail(b: church?.email == nil)
    }
    
    func hidePhone(b:Bool){
        stkPhone.isHidden = b
        btnRealPhone.isHidden = b
        btnPhoneNumber.isHidden = b
        stackLblPhone.isHidden = b
    }
    
    func hideMail(b:Bool){
        stkMail.isHidden = b
        btnMailInfo.isHidden = b
        btnRealMail.isHidden = b
        stackLblMail.isHidden = b
    }
    
    private func fillData() {
        let url = church?.image_url ?? "https://arquidiocesis-app-mx.s3.amazonaws.com/SEDES/0/image.png"
        if let imageUrl = URL(string: url) {
            churchHeaderImage.af.setImage(withURL: imageUrl)
        }
        churchNameLabel.text = church?.name
        //churchSubtitleLabel.text = church?.description
        churchAddressLabel.text = church?.address
        churchResponsibleLabel.text = church?.principal?.name ?? "No disponible"
        scheduleHoreResponse = "\(church?.horary?.first?.hour_start ?? "") \(church?.attention?.first?.hour_end ?? "")"
        print("scheduleHoreResponse...scheduleHoreResponse")
        print("\(church?.horary?.first?.hour_start ?? "") \(church?.attention?.first?.hour_end ?? "")")
        
        massCollectionView.reloadData()
        massCollectionView.isHidden = church?.masses?.isEmpty ?? true
        
        servicesCollectionView.reloadData()
        servicesCollectionView.isHidden = church?.services?.isEmpty ?? true
        pricipalID = church?.principal?.id ?? 1
        //New social logic
        social.removeAll()
        socialIdentifier.removeAll()
        if let fb = church?.facebook {
            social.append(fb)
            socialIdentifier.append("F")
        }
        if let twitter = church?.twitter {
            social.append(twitter)
            socialIdentifier.append("T")
        }
        if let instagram = church?.instagram {
            social.append(instagram)
            socialIdentifier.append("I")
        }
        if let web = church?.website {
            social.append(web)
            socialIdentifier.append("W")
        }
        if let steram = church?.stream {
            social.append(steram)
            socialIdentifier.append("S")
        }
        if social.count == 0 {
            socialShadowCard.isHidden = true
        }else{
            socialShadowCard.isHidden = false
        }

        print("RELOADD:; redes")
        print(social)
        socialTableView.reloadData()
      
        nameNew = church?.name ?? ""
        descriptionNew = church?.description ?? ""
        addressNew = church?.address ?? ""
        emailNew = church?.email ?? ""
        phoneNew = church?.phone ?? ""
        faceNew = church?.facebook ?? ""
        instaNew = church?.instagram ?? ""
        twittNew = church?.twitter ?? ""
        webNew = church?.website ?? ""
        streamNew = church?.stream ?? ""
        latitudeNew = church?.latitude ?? 0.0
        longitudeNew = church?.longitude ?? 0.0
        if church?.priests?.isEmpty == false {
            guard let priestId = church?.priests?[0].id else {return}
            churcuPrincipalId = priestId
        }
        bankNew = church?.bank_account ?? ""
        print("CHURCH ... CHURCH ... CHURCH ... CHURCH")
        //print(church)
        var scheduleTempl = "No disponible"
        for response in church?.horary ?? [] {
            if church?.horary?.isEmpty == false {
                print("ENTRO A VER LOS QUE NO ESTAN VACIOS")
                for respDay in response.days ?? [] {
                    if scheduleHour.isEmpty {
                        scheduleHour.insert(DayEditChurch.init(id: respDay.id, name: respDay.name, checked: respDay.checked), at: 0)
                    }else {
                        scheduleHour.append(DayEditChurch.init(id: respDay.id, name: respDay.name, checked: respDay.checked))
                    }
                    let firstDay = response.days?.first(where: {$0.checked == true})
                    let lastDay = response.days?.last(where: {$0.checked == true})
                    firstDaySer = firstDay?.name ?? ""
                    lastDaySer = lastDay?.name ?? ""
                    hStrartSer = response.hour_start ?? ""
                    hEndSer = response.hour_end ?? ""
                    let churchScheduleText = "\(firstDay?.name ?? "") a \(lastDay?.name ?? "") de \(response.hour_start ?? "") a \(response.hour_end ?? "")"
                    scheduleTempl = ""
                    scheduleTempl = churchScheduleText
                }
                if scheduleDay.isEmpty {
                    scheduleDay.insert(AttentionEditChurch.init(days: scheduleHour.unique(map: {$0.id}), hourStart: response.hour_start, hourEnd: response.hour_end), at: 0)
                }else {
                    scheduleDay.append(AttentionEditChurch.init(days: scheduleHour.unique(map: {$0.id}), hourStart: response.hour_start, hourEnd: response.hour_end))
                }
            }
        }
        churchScheduleLabel.text = scheduleTempl
        churchScheduleLabel.adjustsFontSizeToFitWidth = true
        for response in church?.services ?? [] {
            if church?.services?.isEmpty == false {
                for respHoray in response.schedules ?? [] {
                    serviceSchedules.removeAll()
                    serviceDay.removeAll()
                    for respDay in respHoray.days ?? [] {
                        if serviceDay.isEmpty {
                            serviceDay.insert(DayEditChurch.init(id: respDay.id, name: respDay.name, checked: respDay.checked), at: 0)
                        }else {
                            serviceDay.append(DayEditChurch.init(id: respDay.id, name: respDay.name, checked: respDay.checked))
                        }
                    }
                    if serviceSchedules.isEmpty {
                        serviceSchedules.insert(AttentionEditChurch.init(days: serviceDay.unique(map: {$0.id}), hourStart: respHoray.hour_start, hourEnd: respHoray.hour_end), at: 0)
                    }else {
                        serviceSchedules.append(AttentionEditChurch.init(days: serviceDay.unique(map: {$0.id}), hourStart: respHoray.hour_start, hourEnd: respHoray.hour_end))
                    }
                }
                if serviceNew.isEmpty {
                    serviceNew.insert(ServiceEditChurch.init(type: TypeClassEditChurch.init(id: response.type?.id, name: response.type?.name), gearedToward: response.geared_toward, serviceDescription: response.description, schedules: serviceSchedules.unique(map: {$0.days})), at: 0)
                }else {
                    serviceNew.append(ServiceEditChurch.init(type: TypeClassEditChurch.init(id: response.type?.id, name: response.type?.name), gearedToward: response.geared_toward, serviceDescription: response.description, schedules: serviceSchedules.unique(map: {$0.days})))
                }
            }
        }
        var churchOfficeScheduleTextt = "No disponible"
        var sundayActive = [String]() //Domingo
        var mondayActive = [String]() // Lunes
        var tuesdayActive = [String]() // Martes
        var wednesdayActive = [String]() // Miercoles
        var thursdayActive = [String]() // Jueves
        var fridayActive = [String]() // Viernes
        var saturdayActive = [String]() // Sabado
        var weekActive = [[String]]()
        let mapDays:[String] = ["Domingo","Lunes","Martes","Miércoles","Jueves","Viernes","Sábado"]
        let atten = church?.attention ?? []
        let att = atten.sorted{ $0.hour_start!.compare($1.hour_start!, options: .numeric) == .orderedAscending}
        for response in att {

            if church?.attention?.isEmpty == false {
                for respDays in response.days ?? [] {
                    if respDays.checked! {
                        switch respDays.name{
                        case "Domingo":
                            sundayActive.append("\(response.hour_start ?? "") a \(response.hour_end ?? "")")
                        case "Lunes":
                            mondayActive.append("\(response.hour_start ?? "") a \(response.hour_end ?? "")")
                        case "Martes":
                            tuesdayActive.append("\(response.hour_start ?? "") a \(response.hour_end ?? "")")
                        case "Miércoles":
                            wednesdayActive.append("\(response.hour_start ?? "") a \(response.hour_end ?? "")")
                        case "Jueves":
                            thursdayActive.append("\(response.hour_start ?? "") a \(response.hour_end ?? "")")
                        case "Viernes":
                            fridayActive.append("\(response.hour_start ?? "") a \(response.hour_end ?? "")")
                        case "Sábado":
                            saturdayActive.append("\(response.hour_start ?? "") a \(response.hour_end ?? "")")
                        default:
                        print("no pasa")
                        }
                    }
                    if attentionDaysNew.isEmpty {
                        attentionDaysNew.insert(DayEditChurch.init(id: respDays.id, name: respDays.name, checked: respDays.checked), at: 0)
                    }else {
                        attentionDaysNew.append(DayEditChurch.init(id: respDays.id, name: respDays.name, checked: respDays.checked))
                    }
                    let firstDay = response.days?.first(where: {$0.checked == true})
                    let lastDay = response.days?.last(where: {$0.checked == true})
                    firstDayAt = firstDay?.name ?? ""
                    lastDayAt = lastDay?.name ?? ""
                    hStartAt = church?.attention?.first?.hour_start ?? ""
                    hEndAt = church?.attention?.first?.hour_end ?? ""

                }
                if attentionnew.isEmpty {
                    attentionnew.insert(AttentionEditChurch.init(days: attentionDaysNew.unique(map: {$0.id}), hourStart: response.hour_start, hourEnd: response.hour_end), at: 0)
                }else {
                    attentionnew.append(AttentionEditChurch.init(days: attentionDaysNew.unique(map: {$0.id}), hourStart: response.hour_start, hourEnd: response.hour_end))
                }
            }
        }
        weekActive.append(sundayActive)
        weekActive.append(mondayActive)
        weekActive.append(tuesdayActive)
        weekActive.append(wednesdayActive)
        weekActive.append(thursdayActive)
        weekActive.append(fridayActive)
        weekActive.append(saturdayActive)
        var i = 0
        for dayActive in weekActive{
            if dayActive.count > 0{
                var hoursDay = ""
                for day in dayActive{
                    print("un dia mas en day active::")
                    hoursDay = "\(hoursDay) \n \(day)"
                }
                if churchOfficeScheduleTextt != "No disponible" {
                    churchOfficeScheduleTextt = "\(churchOfficeScheduleTextt) \n \(mapDays[i]) : \(hoursDay)"
                    print("Se agrego el texto a texto:")
                    print("\(churchOfficeScheduleTextt) \n \(mapDays[i]) : \(hoursDay)")
                } else {
                    churchOfficeScheduleTextt = ""
                    churchOfficeScheduleTextt = "\(mapDays[i]) : \(hoursDay)"
                }
            }
            i+=1
        }
        churchOfficeScheduleLabel.text = churchOfficeScheduleTextt
        masesNuew.removeAll()
        for response in church?.masses ?? [] {
            if church?.masses?.isEmpty == false {
                massesDayNew.removeAll()
                for respDays in response.days ?? [] {
                    if massesDayNew.isEmpty {
                        massesDayNew.insert(DayEditChurch.init(id: respDays.id, name: respDays.name, checked: respDays.checked), at: 0)
                    }else {
                        massesDayNew.append(DayEditChurch.init(id: respDays.id, name: respDays.name, checked: respDays.checked))
                    }
                }
                var days = [String]()
                massesDayNew.forEach { item in
                    if item.checked == true {
                        days.append(item.name ?? "")
                    }
                }
                if masesNuew.isEmpty {
                    masesNuew.insert(MassEditChurch.init(days: massesDayNew.unique(map: {$0.id}), hourStart: response.hour_start, hourEnd: response.hour_end), at: 0)
                }else {
                    masesNuew.append(MassEditChurch.init(days: massesDayNew.unique(map: {$0.id}), hourStart: response.hour_start, hourEnd: response.hour_end))
                }
            }
        }
        setupCollectionDelegates()
        validateProfile()
        validateSameDaysChurch()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            self.loadingAlert.dismiss(animated: true, completion: nil)
        })
    }
    
    func makePhoneCall(phoneNumber: String) {
        let fixPhoneNumber = phoneNumber.replacingOccurrences(of: "-|\\s+|\\s+|\\s+$", with: "", options: .regularExpression, range: nil)
        guard let phoneURL = URL(string: "tel://" + fixPhoneNumber) else{return}
        UIApplication.shared.open(phoneURL, options: [:], completionHandler: nil)
        
    }
    
    private func sendMail() -> MFMailComposeViewController {
        let mailComposeVC = MFMailComposeViewController()
        let mailRep = self.church?.email ?? ""
        mailComposeVC.mailComposeDelegate = self
        mailComposeVC.setToRecipients(["\(mailRep)"])
        mailComposeVC.setSubject("Contacto")
        mailComposeVC.setMessageBody("", isHTML: false)
        return mailComposeVC
    }
    
    private func goToYt() {
        //        let YoutubeID =  "Ktync4j_nmA" // Your Youtube ID here
        let appURL = NSURL(string: "youtube://m.youtube.com/user/BasilicadeGuadalupe/playlists")!
        let webURL = NSURL(string: "https://m.youtube.com/user/BasilicadeGuadalupe/playlists")!
        let application = UIApplication.shared
        
        if application.canOpenURL(appURL as URL) {
            application.open(appURL as URL)
        } else {
            application.open(webURL as URL)
        }
    }
    
    @IBAction func goToPhone(_ sender: Any) {
        makePhoneCall(phoneNumber: church?.phone ?? "")
        
    }
    
    @IBAction func goToMail(_ sender: Any) {
        let mailCompose = sendMail()
        if MFMailComposeViewController.canSendMail() {
            self.present(mailCompose, animated: true, completion: nil)
        }else {
            print("cant send mail")
        }
    }
    
    @IBAction func goToLive(_ sender: Any) {
        goToYt()
    }
    
    @IBAction func goToDismiss(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        switch profileRole {
        case UserProfileEnum.Sacerdoteadministrador.rawValue, UserProfileEnum.fieladministrador.rawValue, UserProfileEnum.Sacerdotedecano.rawValue:
            flagEdit = false
            validateProfile()
        default:
            break
        }
    }
    
    @IBAction func goToSAve(_ sender: Any) {
        actionSave()
    }
    
    private func addFavoriteFiel() {
        self.presenter?.saveFavorite(id: Int(churchId ?? 0), idPriest: 1, isPrincipal: isPrincipal ?? 1)
    }
    
    private func removeFavoriteFiel(){
        self.presenter?.removeFavorite(id: Int(churchId ?? 0), idPriest: 1, isPrincipal: isPrincipal ?? 1)
        print("ID is : \(String(describing: churchId))")
    }
    
    private func addFavoriteChurchSacerdote() {
        self.presenter?.saveChurch(idLocation: Int(churchId ?? 0), idPriest: 1)
    }
    
    private func removeChurchSacerdote(idChurch: Int){
        self.presenter?.removeChurch(idLocation: idChurch, idPriest: 1)
    }
    
    func successRequestComments(data: Comments) {
        print(data, "$$$$")
        var ratings: [Double] = []
        if data.my_review != nil {
            let myComment = CommentsList(id: data.my_review?.id, review: data.my_review?.review, creation_date: data.my_review?.creation_date, rating: data.my_review?.rating, devotee: data.my_review?.devotee)
            commentList.append(myComment)
            ratings.append(data.my_review?.rating ?? 0.0)
        }
        
        data.other_reviews?.forEach({ item in
            commentList.append(item)
        })
        commentsTable.delegate = self
        commentsTable.dataSource = self
        commentsTable.reloadData()
        
        data.other_reviews?.forEach({ item in
            ratings.append(item.rating ?? 0.0)
        })
        calculateRating(arrayRating: ratings)
        if ratings.count == 1 {
            lblNmberComments.text = "1 comentario"
        }else{
            lblNmberComments.text = "\(ratings.count) comentarios"
        }
        ratings.removeAll()
    }
    
    func failRequestComments() {
        print("Error Comments")
    }
    
    let dateFormat = "yyyy-MM-dd HH:mm:ss"
    
    func timeInterval(timeAgo:String) -> String {
        let df = DateFormatter()
        
        df.dateFormat = dateFormat
        guard let dateWithTime = df.date(from: timeAgo) else {return ""}
        
        let interval = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: dateWithTime, to: Date())
        
        if let year = interval.year, year > 0 {
            return year == 1 ? "hace \(year)" + " " + " año" : "hace \(year)" + " " + "años"
        } else if let month = interval.month, month > 0 {
            return month == 1 ? "hace \(month)" + " " + "mes" : "hace \(month)" + " " + "meses"
        } else if let day = interval.day, day > 0 {
            return day == 1 ? "hace \(day)" + " " + "día" : "hace \(day)" + " " + "dias"
        }else if let hour = interval.hour, hour > 0 {
            return hour == 1 ? "hace \(hour)" + " " + "hora" : "hace \(hour)" + " " + "horas"
        }else if let minute = interval.minute, minute > 0 {
            return minute == 1 ? "hace \(minute)" + " " + "minuto" : "hace \(minute)" + " " + "minutos"
        }else if let second = interval.second, second > 0 {
            return second == 1 ? "hace \(second)" + " " + "segundo" : "\(second)" + " " + "segundos"
        } else {
            return "hace un momento"
        }
    }
    
    func calculateRating(arrayRating: [Double]) {
        let average = arrayRating.reduce(0, +)
        if arrayRating.count != 0 {
            let finalRate = Int(average) / arrayRating.count
            let imgFill = UIImage(named: "Trazado 6941", in: Bundle.local, compatibleWith: nil)
            let imgEmpty = UIImage(named: "Trazado 6945", in: Bundle.local, compatibleWith: nil)
            
            if #available(iOS 13.0, *) {
                if finalRate == 0 {
                    print("Is zero")
                    star1.image = imgEmpty
                    star2.image = imgEmpty
                    star3.image = imgEmpty
                    star4.image = imgEmpty
                    star5.image = imgEmpty
                }else if finalRate == 1{
                    star1.image = imgFill
                    star2.image = imgEmpty
                    star3.image = imgEmpty
                    star4.image = imgEmpty
                    star5.image = imgEmpty
                }else if finalRate  == 2 {
                    star1.image = imgFill
                    star2.image = imgFill
                    star3.image = imgEmpty
                    star4.image = imgEmpty
                    star5.image = imgEmpty
                }else if finalRate == 3 {
                    star1.image = imgFill
                    star2.image = imgFill
                    star3.image = imgFill
                    star4.image = imgEmpty
                    star5.image = imgEmpty
                }else if finalRate == 4 {
                    star1.image = imgFill
                    star2.image = imgFill
                    star3.image = imgFill
                    star4.image = imgFill
                    star5.image = imgEmpty
                }else if finalRate == 5{
                    star1.image = imgFill
                    star2.image = imgFill
                    star3.image = imgFill
                    star4.image = imgFill
                    star5.image = imgFill
                }
            }
        }else{
            lblSectionComments.isHidden = true
            commentsCard.isHidden = true
            commentsTable.isHidden = true
        }
    }
    
    func showDeleteBtn(btn: UIButton) {
        if locationComponent != 0 {
            if locationId == churchId && locationComponent == churchId {
                switch profileRole {
                case UserProfileEnum.Sacerdoteadministrador.rawValue, UserProfileEnum.Sacerdotedecano.rawValue:
                    btn.isHidden = false
                    
                case UserProfileEnum.fieladministrador.rawValue:
                    if ((locationcomponents?.contains("LOCATION_INFORMATION")) == true){
                        btn.isHidden = false
                    }else {
                        btn.isHidden = true
                    }
                    
                case UserProfileEnum.AdministradorComunidad.rawValue, UserProfileEnum.sacerdote.rawValue, UserProfileEnum.ResponsableComunidad.rawValue, UserProfileEnum.fiel.rawValue, UserProfileEnum.MiembroComunidad.rawValue:
                    btn.isHidden = true
                    
                default:
                    break
                }
            }
            else if locationComponent == self.churchId {
                switch profileRole {
                case UserProfileEnum.Sacerdoteadministrador.rawValue, UserProfileEnum.Sacerdotedecano.rawValue:
                    btn.isHidden = false
                case UserProfileEnum.fieladministrador.rawValue:
                    if ((locationcomponents?.contains{ $0 == "LOCATION_INFORMATION"}) == true){
                        btn.isHidden = false
                    }else {
                        btn.isHidden = true
                    }
                case UserProfileEnum.AdministradorComunidad.rawValue, UserProfileEnum.sacerdote.rawValue, UserProfileEnum.ResponsableComunidad.rawValue, UserProfileEnum.fiel.rawValue, UserProfileEnum.MiembroComunidad.rawValue:
                    btn.isHidden = true
                default:
                    break
                }
            }else{
                btn.isHidden = true
            }
        }else {
            btn.isHidden = true
        }
    }
    
    
    
    @objc func deleteMasses(sender: UIButton) {
        print("Se pretende a borrar misa elemento::") // nofunciona pq ya no van en el mismo formto las listas
        print(sender.tag)
        print("tamaño:;")
        print(masesNuew.count)
        /*
        masesNuew.remove(at: sender.tag)
        church?.masses?.remove(at: sender.tag)
        arrayNewObject.removeAll()
        globalArray = []
        validateSameDaysChurch()
        
        newChurchMassCollection.reloadData()*/
        deleteLastMasses()
    }


    func deleteLastMasses(){
        print("Se pretende a borrar ultimo elemento::")
        print(masesNuew.count)
        masesNuew.removeLast()
        church?.masses?.removeLast()
        arrayNewObject.removeAll()
        globalArray = []
        actionSave()
        //validateSameDaysChurch()
        //newChurchMassCollection.reloadData()
    }
    
    @objc func deleteServices(sender: UIButton) {
        church?.services?.remove(at: sender.tag)
        serviceNew.remove(at: sender.tag)
        servicesCollectionView.reloadData()
        actionSave()
    }
    
    @objc func deleteSocial(sender: UIButton) {
        print(sender.tag)
        print(social, social[sender.tag], socialIdentifier[sender.tag])
        switch socialIdentifier[sender.tag] {
        case "F":
            faceNew = ""
        case "T":
            twittNew = ""
        case "I":
            instaNew = ""
        case "S":
            streamNew = ""
        case "W":
            webNew = ""
        default:
            break
        }
        social.remove(at: sender.tag)
        socialIdentifier.remove(at: sender.tag)
        socialTableView.reloadData()
        actionSave()
    }
}
//MARK: - TableView view delegates
extension MiIglesia_InfoIglesia: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var countTable = 0
        
        switch tableView {
        case socialTableView:
            countTable = social.count
            if addSocialButton.isHidden {
                print("VVV: addsocial is hidden")
                if !(social.count > 0 ) {
                    print("VVV: social count mayor 0")
                    self.lblRedesSociales.isHidden = true
                    self.hSocial.constant = 0
                    self.hSocialS.constant = 0
                    self.view.layoutIfNeeded()
                }else{
                    print("VVV: social 0")
                }
            }else{
                print("VVV: addsocial no hidden")
                print(social.count)
            }
        case commentsTable:
            countTable = commentList.count
        default:
            break
        }
        print("return noris:")
        print(social.count)
        return countTable
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView {
        case socialTableView:
            let cell = socialTableView.dequeueReusableCell(withIdentifier: SocialTableViewCell.reuseIdentifier, for: indexPath) as! SocialTableViewCell
            cell.titleLabel.text = social[indexPath.row]
            cell.selectionStyle = .none
            switch socialIdentifier[indexPath.row] {
            case "W":
                cell.iconImage.image = webIcon
            case "T":
                cell.iconImage.image = twitterIcon
            case "F":
                cell.iconImage.image = facebookIcon
            case "I":
                cell.iconImage.image = instaIcon
            case "S":
                cell.iconImage.image = stramIcon
            default:
                break
            }
            showDeleteBtn(btn: cell.deleteButton)
            cell.deleteButton.tag = indexPath.row
            cell.deleteButton.addTarget(self, action: #selector(deleteSocial), for: .touchUpInside)
            hSocial.constant = cell.frame.height * CGFloat(social.count)
            hSocialS.constant = hSocial.constant+10
            self.view.layoutIfNeeded()
            return cell
            
        default:
            print("c4rat DEF0*")
            let cell = tableView.dequeueReusableCell(withIdentifier: "COMMCELL", for: indexPath) as! ChurchCommentCell
            cell.cardView.layer.cornerRadius = 10
            cell.cardView.ShadowCard()
            cell.userImg.layer.cornerRadius = cell.userImg.bounds.width / 2
            cell.selectionStyle = .none
            print(commentList)
            cell.lblDate.text = timeInterval(timeAgo: commentList[indexPath.row].creation_date ?? "")
            
            cell.userImg.DownloadStaticImage(commentList[indexPath.row].devotee?.image_url ?? "")
            cell.lblComment.text = commentList[indexPath.row].review ?? ""
            cell.lblName.text = "\(commentList[indexPath.row].devotee?.name ?? "") \(commentList[indexPath.row].devotee?.first_surname ?? "") \(commentList[indexPath.row].devotee?.second_surname ?? "")"
            
            hComments.constant = CGFloat(124 * commentList.count)
            
            let imgFill = UIImage(named: "Trazado 6941", in: Bundle.local, compatibleWith: nil)
            let rating = commentList[indexPath.row].rating ?? 0.0
            if #available(iOS 13.0, *) {
                
                if rating == 0.0 {
                    print("Is zero")
                }else if rating <= 1.0 {
                    cell.starComm1.image = imgFill
                }else if rating  <= 2.0 {
                    cell.starComm1.image = imgFill
                    cell.starComm2.image = imgFill
                }else if rating <= 3.0 {
                    cell.starComm1.image = imgFill
                    cell.starComm2.image = imgFill
                    cell.starComm3.image = imgFill
                }else if rating <= 4.0 {
                    cell.starComm1.image = imgFill
                    cell.starComm2.image = imgFill
                    cell.starComm3.image = imgFill
                    cell.starComm4.image = imgFill
                }else if rating <= 5.0 {
                    cell.starComm1.image = imgFill
                    cell.starComm2.image = imgFill
                    cell.starComm3.image = imgFill
                    cell.starComm4.image = imgFill
                    cell.starComm5.image = imgFill
                }
            }
            return cell
        }
    }
    
}
//MARK: - Collection view delegates
extension MiIglesia_InfoIglesia: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("c4r@::0")
        var numberOfItems = 0
        switch collectionView {
        case newChurchMassCollection:
            print("c4r@::newChurch")
            numberOfItems = globalArray.count //church?.masses?.count ??
            if locationId != churchId || locationComponent != churchId {
                print("condicion rara")
                churchMassContainer.isHidden = church?.masses?.count == 0
            }
            print(numberOfItems)
            if numberOfItems==0{
                hMasses.constant = CGFloat(1)
            }
        case servicesCollectionView:
            print("c4r@::services")
            numberOfItems = church?.services?.count ?? 0
            if locationId != churchId || locationComponent != churchId{
                churchServicesContainer.isHidden = numberOfItems == 0
            }
            print(numberOfItems)
        default:
            print("c4r@::default")
            break
        }
        return numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("c4i@::00")
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ServiceCollectionViewCell.reuseIdentifier, for: indexPath) as! ServiceCollectionViewCell
        cell.delegate = self
        switch collectionView {
        case newChurchMassCollection:
            print("c4i@::01")
            cell.deleteBtn.tag = indexPath.item
            cell.deleteBtn.addTarget(self, action: #selector(deleteMasses), for: .touchUpInside)
            showDeleteBtn(btn: cell.deleteBtn)
            let dataCount = globalArray.count
            print(dataCount)
            hMasses.constant = CGFloat(120 * dataCount)
            let sortedDays = globalArray.sorted {
                $0.daysStr! < $1.daysStr!
            }
            if church != nil {
                cell.fill(with: sortedDays[indexPath.item], index: indexPath.item)
            }
        case servicesCollectionView:
            print("c4i@::02")
            if let churchData = church {
                cell.deleteBtn.tag = indexPath.item
                cell.deleteBtn.addTarget(self, action: #selector(deleteServices), for: .touchUpInside)
                showDeleteBtn(btn: cell.deleteBtn)
                let dataCount = church?.services?.count ?? 0
                hServices.constant = CGFloat(150 * dataCount)
                cell.isHidden = true
                if church?.services?.isEmpty == false {
                    cell.isHidden = false
                    cell.fillService(with: churchData, index: indexPath.row)
                }
            }
        default:
            break
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var height: CGFloat = 130
        let width: CGFloat = newChurchMassCollection.frame.width
        
        if collectionView == newChurchMassCollection {
            height = 100
        }else if collectionView == servicesCollectionView{
            height = 150
        }
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}

extension MiIglesia_InfoIglesia: ChurchDetailViewProtocol {
    
    func serviceCatalogSuccess(response: ServiceCatalogModel) {
        print("CATALOG SUCCESS")
        serviceCatalog = response
    }
    
    func serviceCatalogError() {
        print("CATALOG ERROR")
        DispatchQueue.main.async { [self] in
            self.showCanonAlert(title: "Atención", msg: "Error en el servicio, intenta de nuevo más tarde.")
        }
    }
    
    func saveChurchSucces() {
        DispatchQueue.main.async { [self] in
            self.view.alpha=1
            self.progress.stopAnimating()
            self.progress.isHidden=true
            self.showCanonAlert(title: "Éxito", msg: "Datos guardados correctamente.")
            flagEdit = false
            validateProfile()
            if let id = churchId {
                showLoading()
                presenter?.getDetail(id: id)
            }
        }
    }
    
    func saveChurchError() {
        DispatchQueue.main.async { [self] in
            self.view.alpha=1
            self.progress.stopAnimating()
            self.progress.isHidden=true
            self.showCanonAlert(title: "Error", msg: "Error en el servicio 401, reporta esta falla a un administrador.")
        }
    }
    
    func isCorrectFavorite() {
        DispatchQueue.main.async {
            self.loadingAlert.dismiss(animated: true, completion: nil)
            self.servicesCollectionView.reloadData()
            self.massCollectionView.reloadData()
        }
    }
    
    func showError(_ error: String) {
        self.isTappedFav = false
        DispatchQueue.main.async {
            [weak self] in
            self?.hideLoading()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            [weak self] in
            self?.showMessage(error)
        }
    }
    
    func showDetail(church: ChurchDetail) {
        self.church = church
        
        DispatchQueue.main.async {
            [weak self] in
            self?.initView()
            self?.fillData()
        }
    }
    
    func validateSameDaysChurch() {
        let mapDayInt:[String:String]=["Domingo":"0","Lunes":"1","Martes":"2","Miércoles":"3","Jueves":"4","Viernes":"5","Sábado":"6"]
        var mapDayhour:[String:[String]]=["0":[],"1":[],"2":[],"3":[],"4":[],"5":[],"6":[]]
        // print(church?.masses)  //PARA TABLA EDIT
        print(masesNuew, "-----------------------------")
        var arrayOfDays = [NewMassesData]()
        var arrayOfDays2 = [NewMassesData]()
        var arry = [String]() //PARA TABLA EDIT
        
        masesNuew.forEach { item in
            var days = [String]() //PARA TABLA EDIT
            var checked = [Bool]() //PARA TABLA EDIT
            arry.append("\(item)") //PARA TABLA EDIT
            
            item.days?.forEach({ day in
                checked.append(day.checked ?? false) //PARA TABLA EDIT
                if day.checked == true {
                    mapDayhour[mapDayInt[day.name!]!]!.append(item.hourStart ?? "")
                    days.append(day.name ?? "") //PARA TABLA EDIT
                }
            })
      //PARA TABLA EDIT
            var strOfDays = ""
            /*
            if days.count != 0 && days.count != 1{
                 strOfDays = "\(days.first ?? "") a \(days.last ?? "")"
                
                if days.first == "Domingo" && checked[1] == false {
                    strOfDays = "\(days.last ?? "") a \(days.first ?? "")"
                }else if days.first == "Domingo" && days.last == "Sábado" {
                    strOfDays = "Lunes a Domingo"
                }
            }else if days.count == 1 {
                strOfDays = "\(days.first ?? "")"
            }*/
            for day in days{
                strOfDays += day+", "
            }
            let newObject = NewMassesData(daysStr: strOfDays, hour: item.hourStart ?? "")
            arrayOfDays2.append(newObject)
        //
        }
        
        for item in mapDayhour{
            if !item.value.isEmpty{
                let sortedHours = item.value.sorted()
                let newO = NewMassesData(daysStr: item.key, hour: sortedHours.joined(separator:", "))
                arrayOfDays.append(newO)
            }
        }
        globalArray=arrayOfDays
       
        
        //print(arrayOfDays)
        let group = Dictionary(grouping: arrayOfDays, by: {$0.daysStr})//PARA TABLA EDIT
        let arrayGrouped = Array(group.values)//PARA TABLA EDIT
        //print(arrayGrouped)
        //globalArray2 = arrayGrouped//PARA TABLA EDIT
        newChurchMassCollection.reloadData()
    }
    
}

//MARK: - Service Cell Delegate
extension MiIglesia_InfoIglesia: ServiceCellDelegate {
    func editHours(collectionView: UICollectionView, at indexPath: IndexPath, hours: String) {
        print("TODO: - IMPLEMENT EDIT \(hours)")
    }
    
    func editDays(collectionView: UICollectionView, at indexPath: IndexPath, days: String) {
        print("TODO: - IMPLEMENT EDIT \(days)")
    }
    
    func delete(collectionView: UICollectionView, at indexPath: IndexPath) {
        switch collectionView {
        case servicesCollectionView:
            church?.services?.remove(at: indexPath.item)
            servicesCollectionView.reloadData()
        case massCollectionView:
            church?.masses?.remove(at: indexPath.item)
            let id = church?.masses?[indexPath.item].days?.first?.id ?? 0
            self.removeChurchSacerdote(idChurch:  Int(id))
            
        default:
            break
        }
        print("TODO: - IMPLEMENT DELETE")
    }
    
}

//MARK: - Mail Extension
extension MiIglesia_InfoIglesia: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}

extension MiIglesia_InfoIglesia: RefisterFormularyButtonDelegate, RegisterFormDataSendingDelegateProtocol{
    func didPressReadyFormularyButton(_ sender: UIButton) {
        RegisterFirmulary.instance.parentView.frame = CGRect(x: 0, y: 100, width: self.view.frame.width, height: RegisterFirmulary.instance.parentView.frame.height+125)
        RegisterFirmulary.instance.parentView.removeFromSuperview()
        flagEdit=false
    }
    
    func sendDataFormToComMainViewController(name: String, intitution: String, charism: String, resposable: String, description: String, address: String, lvText: String, lvHour: String, sdText: String, sdHour: String, email: String, phone: String, latitude: Double, longitude: Double) {
        print("sendDataToComMain 11::")
        let daylv = [1, 2, 3, 4, 5, 6, 7]
        print(lvText)
        var daysActiveLv: [Bool] {
            returnBooleanWeekArray(s: lvText)
        }
        let daysd = [1, 2, 3, 4, 5, 6, 7]
        var daysActiveSd: [Bool] {
            returnBooleanWeekArray(s: sdText)
        }
        let hoursStringArray = lvHour.components(separatedBy: " ")
        let hoursSdStringArray = sdHour.components(separatedBy: " ")
        if RegisterFirmulary.instance.institutinTextField.text?.isEmpty == false {
            intitutionNew = intitution
        }
        if RegisterFirmulary.instance.responsableTextField.text?.isEmpty == false {
            nameNew = resposable
            churchNameLabel.text = nameNew
        }
        //if RegisterFirmulary.instance.nameTextField.text?.isEmpty == false {}
        if RegisterFirmulary.instance.emailTextField.text?.isEmpty == false {
            emailNew = email
            lblEmail.text = email
        }
        if RegisterFirmulary.instance.phoneTextField.text?.isEmpty == false {
            phoneNew = phone
            lblPhoneNumber.text = phone
        }
        if RegisterFirmulary.instance.addressTextField.text?.isEmpty == false {
            addressNew = address
            latitudeNew = latitude
            longitudeNew = longitude
            churchAddressLabel.text = address
        }
        if RegisterFirmulary.instance.sdTextField.text?.isEmpty == false && RegisterFirmulary.instance.lvTextField.text?.isEmpty == false {
            serviceEditNew.removeAll()
            if isEditProfile == true {
                if serviceEditNew.isEmpty {
                    for (days, daysActiveLv) in zip(daylv, daysActiveLv) {
                        guard let getDays = DaysInt.init(rawValue: days) else {return}
                        serviceDaylv.insert(DayEditChurch.init(id: days, name:  getDays.daysString, checked: daysActiveLv), at: 0)
                    }
                    for (days, daysActiveSd) in zip(daysd, daysActiveSd) {
                        guard let getDays = DaysInt.init(rawValue: days) else {return}
                        serviceDaySd.insert(DayEditChurch.init(id: days, name: getDays.daysString, checked: daysActiveSd), at: 0)
                    }
                }
            }
        }
        if RegisterFirmulary.instance.lvHourTextField.text?.isEmpty == false && RegisterFirmulary.instance.sdHourTextField.text?.isEmpty == false && RegisterFirmulary.instance.lvTextField.text?.isEmpty == false && RegisterFirmulary.instance.sdTextField.text?.isEmpty == false {
            scheduleDay.removeAll()
            attentionnew.removeAll()
            print("Horarios fin::")
            var getHoraryData: String {
                print("N")
                if hoursStringArray.count < 4{//sin am pm
                    print(hoursStringArray[2])
                    return hoursStringArray[2]
                }else{
                    print(hoursStringArray[3])
                    return hoursStringArray[3]
                }
            }
            var getHorarySDData: String {
                print("SD")
                if hoursSdStringArray.count < 4{
                    print(hoursSdStringArray[2])
                    return hoursSdStringArray[2]
                }else {
                    print(hoursSdStringArray[3])
                    return hoursSdStringArray[3]
                }
            }
            if isEditProfile {
                if scheduleDay.isEmpty {
                    scheduleDay.insert(AttentionEditChurch.init(days: serviceDaylv.unique(map: {$0.id}), hourStart: hoursStringArray[0], hourEnd: getHoraryData), at: 0)
                }else{
                    scheduleDay.append(AttentionEditChurch.init(days: serviceDaylv.unique(map: {$0.id}), hourStart: hoursStringArray[0], hourEnd: getHoraryData))
                }
                if attentionnew.isEmpty {
                    attentionnew.insert(AttentionEditChurch.init(days: serviceDaySd.unique(map: {$0.id}), hourStart: hoursSdStringArray[0], hourEnd: getHorarySDData), at: 0)
                }else {
                    attentionnew.append(AttentionEditChurch.init(days: serviceDaySd.unique(map: {$0.id}), hourStart: hoursSdStringArray[0], hourEnd: getHorarySDData))
                }
            }
        }
        actionSave()
    }
}

extension MiIglesia_InfoIglesia: SuccessAllertButtonDelegate {
    func didPressYesSuccessAllertButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}

extension MiIglesia_InfoIglesia: AddServiceModalButtonDelegate {
    func didPressReadyServiceButton(_ sender: UIButton) {
        let day = [1, 2, 3, 4, 5, 6, 7]
        var daysActive: [Bool] {
            returnBooleanWeekArray(s: AddService.instance.daysTextField.text ?? " ")
        }
        serviceDay.removeAll()
        serviceSchedules.removeAll()
        if AddService.instance.daysTextField.text != ""  && AddService.instance.timeTextField.text != "" && AddService.instance.nameServiceTextField.text != "" && AddService.instance.descriptionTextField.text != "" && AddService.instance.audienceTextField.text != "" {
            
            for (days, daysActive) in zip(day, daysActive) {
                guard let getDays = DaysInt.init(rawValue: days) else {return}
                if serviceDay.isEmpty {
                    serviceDay.insert(DayEditChurch.init(id: days, name: getDays.daysString, checked: daysActive), at: 0)
                }else {
                    serviceDay.append(DayEditChurch.init(id: days, name: getDays.daysString, checked: daysActive))
                }
            }
            
            guard let hoursStringArray = AddService.instance.timeTextField.text?.components(separatedBy: " ") else {return}
            var getHoraryData: String {
                if AddService.instance.timeTextField.text != "" {
                    if hoursStringArray.count < 4{
                        return hoursStringArray[1]
                    }else {
                        return hoursStringArray[3]
                    }
                }
                return ""
            }
            if serviceSchedules.isEmpty {
                if AddService.instance.hourStruct.isEmpty == false {
                    serviceSchedules.insert(AttentionEditChurch.init(days: serviceDay, hourStart: hoursStringArray[0], hourEnd: getHoraryData), at: 0)
                }
            }else {
                if AddService.instance.hourStruct.isEmpty == false {
                    serviceSchedules.append(AttentionEditChurch.init(days: serviceDay, hourStart: hoursStringArray[0], hourEnd: getHoraryData))
                }
            }
            if serviceNew.isEmpty {
                serviceNew.insert(ServiceEditChurch.init(type: TypeClassEditChurch.init(id: AddService.instance.serviceID, name: AddService.instance.nameServiceTextField.text), gearedToward: AddService.instance.audienceTextField.text, serviceDescription: AddService.instance.descriptionTextField.text, schedules: serviceSchedules), at: 0)
            }else {
                serviceNew.append(ServiceEditChurch.init(type: TypeClassEditChurch.init(id: AddService.instance.serviceID, name: AddService.instance.nameServiceTextField.text), gearedToward: AddService.instance.audienceTextField.text, serviceDescription: AddService.instance.descriptionTextField.text, schedules: serviceSchedules))
            }
            self.view.makeToast("Servicio agregado correctamente", duration: 3.0, position: .top)
            //servicesCollectionView.reloadData()
        }
        view.isUserInteractionEnabled = true
        view.alpha = 1
        actionSave()
    }
    
    func didPressAdServicemButton(_ sender: UIButton) {
        let day = [1, 2, 3, 4, 5, 6, 7]
        var daysActive: [Bool] {
            returnBooleanWeekArray(s: AddService.instance.daysTextField.text ?? " ")
        }
        if AddService.instance.daysTextField.text != ""  && AddService.instance.timeTextField.text != "" && AddService.instance.nameServiceTextField.text != "" && AddService.instance.descriptionTextField.text != "" && AddService.instance.audienceTextField.text != "" {
            
            for (days, daysActive) in zip(day, daysActive) {
                guard let getDays = DaysInt.init(rawValue: days) else {return}
                if serviceDay.isEmpty {
                    serviceDay.insert(DayEditChurch.init(id: days, name: getDays.daysString, checked: daysActive), at: 0)
                }else {
                    serviceDay.append(DayEditChurch.init(id: days, name: getDays.daysString, checked: daysActive))
                }
            }
            
            guard let hoursStringArray = AddService.instance.timeTextField.text?.components(separatedBy: " ") else {return}
            var getHoraryData: String {
                if AddService.instance.timeTextField.text != "" {
                    if hoursStringArray.count < 4{
                        return hoursStringArray[1]
                    }else {
                        return hoursStringArray[3]
                    }
                }
                return ""
            }
            if serviceSchedules.isEmpty {
                if AddService.instance.hourStruct.isEmpty == false {
                    serviceSchedules.insert(AttentionEditChurch.init(days: serviceDay, hourStart: hoursStringArray[0], hourEnd: getHoraryData), at: 0)
                }
            }else {
                if AddService.instance.hourStruct.isEmpty == false {
                    serviceSchedules.append(AttentionEditChurch.init(days: serviceDay, hourStart: hoursStringArray[0], hourEnd: getHoraryData))
                }
            }
            if serviceNew.isEmpty {
                serviceNew.insert(ServiceEditChurch.init(type: TypeClassEditChurch.init(id: AddService.instance.serviceID, name: AddService.instance.nameServiceTextField.text), gearedToward: AddService.instance.audienceTextField.text, serviceDescription: AddService.instance.descriptionTextField.text, schedules: serviceSchedules), at: 0)
            }else {
                serviceNew.append(ServiceEditChurch.init(type: TypeClassEditChurch.init(id: AddService.instance.serviceID, name: AddService.instance.nameServiceTextField.text), gearedToward: AddService.instance.audienceTextField.text, serviceDescription: AddService.instance.descriptionTextField.text, schedules: serviceSchedules))
            }
            self.view.makeToast("Servicio agregado correctamente", duration: 3.0, position: .top)
            servicesCollectionView.reloadData()
        }
    }
}

extension MiIglesia_InfoIglesia: AddMassesModalButtonDelegate{

    func didPressReadyMassesButton(_ sender: UIButton, hourTxt: String, daysTxt: [Bool]) {
        
        let day = [1, 2, 3, 4, 5, 6, 7]
        massesDayNew.removeAll()
        for (days, daysTxt) in zip(day, daysTxt) {
            guard let getDays = DaysInt.init(rawValue: days) else {return}
            if massesDayNew.isEmpty {
                massesDayNew.insert(DayEditChurch.init(id: days, name: getDays.daysString, checked: daysTxt), at: 0)
            }else{
                massesDayNew.append(DayEditChurch.init(id: days, name: getDays.daysString, checked: daysTxt))
            }
        }
        if masesNuew.isEmpty {
            masesNuew.insert(MassEditChurch.init(days: massesDayNew.unique(map: {$0.id}), hourStart: hourTxt, hourEnd: "00:00"), at: 0)
        }else {
            masesNuew.append(MassEditChurch.init(days: massesDayNew.unique(map: {$0.id}), hourStart: hourTxt, hourEnd: "00:00"))
        }
        
        view.isUserInteractionEnabled = true
        view.alpha = 1
        actionSave()
    }
    
    func didPressAdMassesButton(_ sender: UIButton, hourTxt: String, daysTxt: String) {
        //inactivo, boton oculto. es exactamente lo mismo de arriba pero sin guardar
    }
    
    func returnBooleanWeekArray(s:String)  -> [Bool]{
        switch s{
        case "lunes  martes" : return [false, true, true, false, false, false, false]
        case "lunes  miércoles": return [false, true, true, true, false, false, false]
        case "lunes  jueves": return [false, true, true, true, true, false, false]
        case "lunes  viernes" : return [false, true, true, true, true, true, false]
        case "lunes  sábado": return [false, true, true, true, true, true, true]
        case "lunes  domingo": return [true, true, true, true, true, true, true]
        case "martes  miércoles": return [false, false, true, true, false, false, false]
        case "martes  jueves": return [false, false, true, true, true, false, false]
        case "martes  viernes": return [false, false, true, true, true, true, false]
        case "martes  sábado": return [false, false, true, true, true, true, true]
        case "martes  domingo": return [true, false, true, true, true, true, true]
        case "Martes  lunes": return [true, true, true, true, true, true, true]
        case "miércoles  jueves": return [false, false, false, true, true, false, false]
        case "miércoles  viernes":  return [false, false, false, true, true, true, false]
        case "miércoles  sábado": return [false, false, false, true, true, true, true]
        case "miércoles  domingo": return [true, false, false, true, true, true, true]
        case "miércoles  lunes": return [true, true, false, true, true, true, true]
        case "miércoles  martes": return [true, true, true, true, true, true, true]
        case "jueves  viernes": return [false, false, false, false, true, true, false]
        case "jueves  sábado": return [false, false, false, false, true, true, true]
        case "jueves  domingo": return [true, false, false, false, true, true, true]
        case "jueves  lunes": return [true, true, false, false, true, true, true]
        case "jueves  martes": return [true, true, true, false, true, true, true]
        case "jueves  miércoles": return [true, true, true, true, true, true, true]
        case "viernes  sábado": return [false, false, false, false, false, true, true]
        case "viernes  domingo": return [true, false, false, false, false, true, true]
        case "viernes  lunes": return [true, true, false, false, false, true, true]
        case "viernes  martes": return [true, true, true, false, false, true, true]
        case "viernes  miércoles": return [true, true, true, true, false, true, true]
        case "viernes  jueves": return [true, true, true, true, true, true, true]
        case "sábado  domingo": return [true, false, false, false, false, false, true]
        case "sábado  lunes": return [true, true, false, false, false, false, true]
        case "sábado  martes": return [true, true, true, false, false, false, true]
        case "sábado  miércoles": return [true, true, true, true, false, false, true]
        case "sábado  jueves": return [true, true, true, true, true, false, true]
        case "sábado  viernes": return [true, true, true, true, true, true, true]
        case "domingo  lunes": return [true, true, false, false, false, false, false]
        case "domingo  martes": return [true, true, true, false, false, false, false]
        case "domingo  miércoles": return [true, true, true, true, false, false, false]
        case "domingo  jueves": return [true, true, true, true, true, false, false]
        case "domingo  viernes": return [true, true, true, true, true, true, false]
        case "domingo  sábado": return [true, true, true, true, true, true, true]
        default:
            return [true, true, true, true, true, true, true]
        }
    }
}

extension MiIglesia_InfoIglesia: AddSocialModalButtonDelegate {
    func didPressReadySocialButton(_ sender: UIButton) {
        print("NA")
    }
    func didPressAddSocialmButton(_ sender: UIButton) {
        print("NA")
    }
    
    func pressAddSocial(sender: UIButton, socialTxt: String, socialIndex: Int) {
        print("press add social")
        switch socialIndex {
        case 0:
            faceNew = socialTxt
        case 1:
            twittNew = socialTxt
        case 2:
            instaNew = socialTxt
        case 3:
            streamNew = socialTxt
        case 4:
            webNew = socialTxt
        default:
            break
        }
        self.view.makeToast("Red social agregada correctamente", duration: 3.0, position: .top)
        socialTableView.isHidden = false
        socialTableView.reloadData()
    }
    
    func pressReadySocial(sender: UIButton, socialTxt: String, socialIndex: Int) {
        switch socialIndex {
        case 0:
            faceNew = socialTxt
        case 1:
            twittNew = socialTxt
        case 2:
            instaNew = socialTxt
        case 3:
            streamNew = socialTxt
        case 4:
            webNew = socialTxt
        default:
            break
        }
        view.isUserInteractionEnabled = true
        view.alpha = 1
        actionSave()
    }
}

extension MiIglesia_InfoIglesia: UIViewControllerTransitioningDelegate {
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = false
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.initContent()
            
            if self.isPrincipal == 0 {
                self.isTappedFav = false
                self.imgFav.alpha = 0
                self.btnPrincipal.isHidden = false
            }else if self.isPrincipal == 1{
                self.self.imgFav.image = UIImage(named: "unfav", in: Bundle(for: MiIglesia_InfoIglesia.self), compatibleWith: nil)
                self.btnPrincipal.isHidden = true
                self.isTappedFav = false
                self.imgFav.isUserInteractionEnabled = true
            }else if self.isPrincipal == 2{
                self.imgFav.image = UIImage(named: "fav", in: Bundle(for: MiIglesia_InfoIglesia.self), compatibleWith: nil)
                self.btnPrincipal.isHidden = true
                self.isTappedFav = true
                self.imgFav.isUserInteractionEnabled = true
            }else if self.isPrincipal == 3 {
                self.imgFav.alpha = 0
                self.btnPrincipal.isHidden = true
            }
        }
        return transition
    }
}
//2260
