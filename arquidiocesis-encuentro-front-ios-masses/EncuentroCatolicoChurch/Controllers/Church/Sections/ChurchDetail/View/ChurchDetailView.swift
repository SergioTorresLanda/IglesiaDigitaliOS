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
//import EncuentroCatolicoProfile

struct NewMassesData {
    var daysStr: String?
    var hour: String
}

class ChurchDetailViewController: BaseViewController {
    
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
    var socialData = [String?]()
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
    
    var arrayNewObject = [NewMassesData]()
    var globalArray: Any?
    
    @IBOutlet weak var btnRealPhone: UIButton!
    @IBOutlet weak var socialTableView: UITableView!
    @IBOutlet weak var addSocialButton: UIButton!
    @IBOutlet weak var addMassesButton: UIButton!
    @IBOutlet weak var addServicesButton: UIButton!
    
    @IBOutlet weak var btnRealMail: UIButton!
    @IBOutlet var imgFav: UIImageView!
    //MARK: - IBOutlets
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
    //    @IBOutlet weak var btnEdit: UIButton!
    @IBOutlet weak var btnMailInfo: UIButton!
    @IBOutlet weak var lblPhoneNumber: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var stackLblMail: UIStackView!
    @IBOutlet weak var stackLblPhone: UIStackView!
    
    let loadingAlert = UIAlertController(title: "", message: "\n \n \n \n \nCargando...", preferredStyle: .alert)
    
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
        
        //  defaults.removeObject(forKey: "SHOWTUTORIAL")
        
        if let count = navigationController?.viewControllers.count {
            navigationController?.viewControllers[0..<(count-1)].removeAll(where: {$0 is ChurchDetailViewController})
        }
        
        initView()
        validateProfile()
        setupUI()
        setupGestures()
        churchNameLabel.sizeToFit()
        massCollectionView.isHidden = true
        servicesCollectionView.isHidden = true
        churchNameLabel.adjustsFontSizeToFitWidth = true
        
        if showTutorial == false {
            if isPrincipal == 0 {
                // self.imgFav.image = UIImage(named: "botonInActivo", in: Bundle(for: ChurchDetailViewController.self), compatibleWith: nil)
                self.isTappedFav = false
                imgFav.alpha = 0
                btnPrincipal.isHidden = false
                //  self.imgFav.isUserInteractionEnabled = true
            }else if isPrincipal == 1{
                self.imgFav.image = UIImage(named: "unfav", in: Bundle(for: ChurchDetailViewController.self), compatibleWith: nil)
                btnPrincipal.isHidden = true
                self.isTappedFav = false
                self.imgFav.isUserInteractionEnabled = true
            }else if isPrincipal == 2{
                self.imgFav.image = UIImage(named: "fav", in: Bundle(for: ChurchDetailViewController.self), compatibleWith: nil)
                btnPrincipal.isHidden = true
                self.isTappedFav = true
                self.imgFav.isUserInteractionEnabled = true
            }else if isPrincipal == 3 {
                //self.imgFav.image = UIImage(named: "botonActivo", in: Bundle(for: ChurchDetailViewController.self), compatibleWith: nil)
                imgFav.alpha = 0
                btnPrincipal.isHidden = true
                //rself.imgFav.isUserInteractionEnabled = false
            }
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
    
    @IBAction func goToMapsActions() {
        
        guard let latitud =  church?.latitude else {return}
        guard let longitude =  church?.longitude else {return}
        
        let coordinates = CLLocationCoordinate2D(latitude: CLLocationDegrees(CGFloat(latitud)), longitude: CLLocationDegrees(CGFloat(longitude)))
        
        let mapsAlert = UIAlertController(title: "Encuentro", message: "Selecciona una opción", preferredStyle: .actionSheet)
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
        
        //            let waze = UIAlertAction(title: "Waze", style: .default) {
        //                _ in
        //
        //                let mapsUrl = URL(string:"https://www.waze.com/ul?ll=\(coordinates.latitude),\(coordinates.longitude)&navigate=yes&zoom=17")!
        //
        //                if (UIApplication.shared.canOpenURL(URL(string:"waze://")!)) {
        //                    UIApplication.shared.open(mapsUrl, options: [:]) {
        //                        _ in
        //                    }
        //
        //                }
        //            }
        
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
        commentList.removeAll()
        let view = CommentsRouter.createModule(param: "\(churchId ?? 1)/reviews?page=1&per_page=10", locationID: churchId ?? 1, churchName: churchNameLabel.text ?? "")
        self.navigationController?.pushViewController(view, animated: true)
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
        RegisterFirmulary.instance.lvTitleLabel.text = "Horario"
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
        
        RegisterFirmulary.instance.delegate = self
        RegisterFirmulary.instance.delegateData = self
        let mainViewHeight = view.frame.size.height
        RegisterFirmulary.instance.parentView.frame = CGRect(x: 0, y: mainViewHeight - 800, width: self.view.frame.width, height: RegisterFirmulary.instance.parentView.frame.height)
        self.view.isUserInteractionEnabled = false
        self.view.alpha = 0.5
        flagEdit = true
        validateProfile()
    }
    
    //MARK: - Local variables
    
    @IBAction func makePrincipal(_ sender: Any) {
        if self.isTappedFav {
            self.removeFavoriteFiel()
        } else {
            self.addFavoriteFiel()
        }
    }
    
    @IBAction func addSocialButtonAction(_ sender: Any) {
        goToAddSocial()
        self.stkButtonSave.isHidden = false
        self.btnGoComments.isHidden = true
        
    }
    
    func goToAddSocial() {
        let storyboard = UIStoryboard(name: "AddSocial", bundle: Bundle.local)
        if let newAddSocial: NewAddSocialController = storyboard.instantiateViewController(withIdentifier: "NewAddSocial") as? NewAddSocialController {
            newAddSocial.delegate = self
            newAddSocial.modalPresentationStyle = .overFullScreen
            self.present(newAddSocial, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func addMassesButtonAction(_ sender: Any) {
        self.stkButtonSave.isHidden = false
        self.btnGoComments.isHidden = true
        let storyboard = UIStoryboard(name: "StoryboardAddMasses", bundle: Bundle.local)
    
        if let newAddMasses: NewAddMassesView = storyboard.instantiateViewController(withIdentifier: "NewAddMasses") as? NewAddMassesView {
            //newAddSocial.delegate = self
            newAddMasses.delegate = self
            newAddMasses.modalPresentationStyle = .overFullScreen
            self.present(newAddMasses, animated: true, completion: nil)
        }
//        AddMasses.instance.showAllert()
       // AddMasses.instance.delegate = self
//        let mainViewHeight = view.frame.size.height
//        AddMasses.instance.parentView.frame = CGRect(x: 0, y: mainViewHeight - 300, width: self.view.frame.width, height: AddMasses.instance.parentView.frame.height)
//        view.isUserInteractionEnabled = false
//        view.alpha = 0.5
    }
    
    @IBAction func addServicesButtonAction(_ sender: Any) {
        self.stkButtonSave.isHidden = false
        self.btnGoComments.isHidden = true
        guard let service = serviceCatalog else {return}
        AddService.instance.showAllertChurch(data: service)
        AddService.instance.delegate = self
        let mainViewHeight = view.frame.size.height
        AddService.instance.parentView.frame = CGRect(x: 0, y: mainViewHeight - 450, width: self.view.frame.width, height: AddService.instance.parentView.frame.height)
        view.isUserInteractionEnabled = false
        view.alpha = 0.5
    }
    //MARK: - View controls
    private func initView() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapImageFav))
        self.imgFav.addGestureRecognizer(tapGestureRecognizer)
        //self.imgFav.isUserInteractionEnabled = true
        self.validatePhoneAndMail()
    }
    
    private func setupUI() {
        customNavBar.layer.cornerRadius = 20
        customNavBar.ShadowNavBar()
        btnGoComments.layer.cornerRadius = 6
        socialShadowCard.layer.cornerRadius = 10
        socialTableView.layer.cornerRadius = 10
        socialShadowCard.ShadowCard()
    }
    
    private func setupGestures() {
        let tapBack = UITapGestureRecognizer(target: self, action: #selector(TapBack))
        backIcon.addGestureRecognizer(tapBack)
    }
    
    @objc func TapBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setupCollectionDelegates() {
        servicesCollectionView.register(ServiceCollectionViewCell.nib,
                                        forCellWithReuseIdentifier: ServiceCollectionViewCell.reuseIdentifier)
        servicesCollectionView.delegate = self
        servicesCollectionView.dataSource = self
        
        massCollectionView.register(ServiceCollectionViewCell.nib,
                                    forCellWithReuseIdentifier: ServiceCollectionViewCell.reuseIdentifier)
        massCollectionView.delegate = self
        massCollectionView.dataSource = self
        
        newChurchMassCollection.register(UINib(nibName: "ServiceCollectionViewCell", bundle: Bundle.local), forCellWithReuseIdentifier: "ServiceCollectionViewCell")
        newChurchMassCollection.delegate = self
        newChurchMassCollection.dataSource = self
        socialTableView.delegate = self
        socialTableView.dataSource = self
        socialTableView.register(SocialTableViewCell.nib, forCellReuseIdentifier: SocialTableViewCell.reuseIdentifier)
        
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
        if self.isTappedFav {
            self.removeFavoriteFiel()
        } else {
            self.addFavoriteFiel()
        }
    }
    
    func updateFavImage() {
        if isPrincipal == 0 {
            DispatchQueue.main.async {
                // self.imgFav.image = UIImage(named: "botonInActivo", in: Bundle(for: ChurchDetailViewController.self), compatibleWith: nil)
                self.btnPrincipal.isHidden = true
                self.isTappedFav = false
            }
        }else{
            DispatchQueue.main.async {
                self.imgFav.image = UIImage(named: "unfav", in: Bundle(for: ChurchDetailViewController.self), compatibleWith: nil)
                self.isTappedFav = false
            }
        }
    }
    func updateDeleteImage() {
        if isPrincipal == 0 {
            DispatchQueue.main.async {
                // self.imgFav.image = UIImage(named: "botonActivo", in: Bundle(for: ChurchDetailViewController.self), compatibleWith: nil)
                self.btnPrincipal.isHidden = true
                self.imgFav.isUserInteractionEnabled = false
            }
        }else{
            DispatchQueue.main.async {
                self.imgFav.image = UIImage(named: "fav", in: Bundle(for: ChurchDetailViewController.self), compatibleWith: nil)
                self.isTappedFav = true
            }
        }
    }
    
    func showLoading() {
        let imageView = UIImageView(frame: CGRect(x: 75, y: 25, width: 140, height: 60))
        imageView.image = UIImage(named: "logoEncuentro", in: Bundle.local, compatibleWith: nil)
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
        if locationComponent != 0 {
            if locationId == churchId && locationComponent == churchId {
                switch profileRole {
                case UserProfileEnum.Sacerdoteadministrador.rawValue, UserProfileEnum.Sacerdotedecano.rawValue:
                    
                    self.stkButtonSave.isHidden = false
                    self.btnGoComments.isHidden = true
                    
                    self.btnEdit.isHidden = false
                    self.imgFav.isHidden = true
                    self.btnCancel.isHidden = false
                    self.btnSave.isHidden = false
                    self.addMassesButton.isHidden = false
                    self.addSocialButton.isHidden = false
                    self.addServicesButton.isHidden = false
                    self.socialContainer.isHidden = false
                    self.churchMassContainer.isHidden = false
                    self.churchServicesContainer.isHidden = false
                    self.lblSectionComments.isHidden = true
                    self.commentsCard.isHidden = true
                    self.commentsTable.isHidden = true
                    
                case UserProfileEnum.fieladministrador.rawValue:
                    if ((locationcomponents?.contains("LOCATION_INFORMATION")) == true){
                        
                        
                        self.stkButtonSave.isHidden = false
                        self.btnGoComments.isHidden = true
                        
                        self.btnEdit.isHidden = false
                        self.imgFav.isHidden = true
                        self.btnCancel.isHidden = false
                        self.btnSave.isHidden = false
                        self.addMassesButton.isHidden = false
                        self.addSocialButton.isHidden = false
                        self.addServicesButton.isHidden = false
                        self.socialContainer.isHidden = false
                        self.churchMassContainer.isHidden = false
                        self.churchServicesContainer.isHidden = false
                        self.lblSectionComments.isHidden = true
                        self.commentsCard.isHidden = true
                        self.commentsTable.isHidden = true
                    }else {
                        self.btnEdit.isHidden = true
                        self.imgFav.isHidden = false
                        self.stkButtonSave.isHidden = true
                        self.btnCancel.isHidden = true
                        self.btnSave.isHidden = true
                        self.btnGoComments.isHidden = false
                        self.addMassesButton.isHidden = true
                        self.addSocialButton.isHidden = true
                        self.addServicesButton.isHidden = true
                    }
                    
                case UserProfileEnum.AdministradorComunidad.rawValue, UserProfileEnum.sacerdote.rawValue, UserProfileEnum.ResponsableComunidad.rawValue, UserProfileEnum.fiel.rawValue, UserProfileEnum.MiembroComunidad.rawValue:
                    self.btnEdit.isHidden = true
                    self.imgFav.isHidden = false
                    self.stkButtonSave.isHidden = true
                    self.btnCancel.isHidden = true
                    self.btnSave.isHidden = true
                    self.btnGoComments.isHidden = false
                    self.addMassesButton.isHidden = true
                    self.addSocialButton.isHidden = true
                    self.addServicesButton.isHidden = true
                default:
                    break
                }
            }
            else if locationComponent == self.churchId {
                switch profileRole {
                case UserProfileEnum.Sacerdoteadministrador.rawValue, UserProfileEnum.Sacerdotedecano.rawValue:
                    self.stkButtonSave.isHidden = false
                    self.btnGoComments.isHidden = true
                    self.btnEdit.isHidden = false
                    self.imgFav.isHidden = true
                    self.btnCancel.isHidden = false
                    self.btnSave.isHidden = false
                    self.addMassesButton.isHidden = false
                    self.addSocialButton.isHidden = false
                    self.addServicesButton.isHidden = false
                    self.socialContainer.isHidden = false
                    self.churchMassContainer.isHidden = false
                    self.churchServicesContainer.isHidden = false
                    self.lblSectionComments.isHidden = true
                    self.commentsCard.isHidden = true
                    self.commentsTable.isHidden = true
                    
                case UserProfileEnum.fieladministrador.rawValue:
                    if ((locationcomponents?.contains{ $0 == "LOCATION_INFORMATION"}) == true){
                        
                        self.stkButtonSave.isHidden = false
                        self.btnGoComments.isHidden = true
                        
                        self.btnEdit.isHidden = false
                        self.imgFav.isHidden = true
                        self.btnCancel.isHidden = false
                        self.btnSave.isHidden = false
                        self.addMassesButton.isHidden = false
                        self.addSocialButton.isHidden = false
                        self.addServicesButton.isHidden = false
                        self.socialContainer.isHidden = false
                        self.churchMassContainer.isHidden = false
                        self.churchServicesContainer.isHidden = false
                        self.lblSectionComments.isHidden = true
                        self.commentsCard.isHidden = true
                        self.commentsTable.isHidden = true
                    }else {
                        self.btnEdit.isHidden = true
                        self.imgFav.isHidden = false
                        self.stkButtonSave.isHidden = true
                        self.btnCancel.isHidden = true
                        self.btnSave.isHidden = true
                        self.btnGoComments.isHidden = false
                        self.addMassesButton.isHidden = true
                        self.addSocialButton.isHidden = true
                        self.addServicesButton.isHidden = true
                    }
                case UserProfileEnum.AdministradorComunidad.rawValue, UserProfileEnum.sacerdote.rawValue, UserProfileEnum.ResponsableComunidad.rawValue, UserProfileEnum.fiel.rawValue, UserProfileEnum.MiembroComunidad.rawValue:
                    self.stkButtonSave.isHidden = true
                    self.btnGoComments.isHidden = false
                    self.btnEdit.isHidden = true
                    self.imgFav.isHidden = false
                    self.stkButtonSave.isHidden = true
                    self.btnCancel.isHidden = true
                    self.btnSave.isHidden = true
                    self.btnGoComments.isHidden = false
                    self.addMassesButton.isHidden = true
                    self.addSocialButton.isHidden = true
                    self.addServicesButton.isHidden = true
                    
                default:
                    break
                    
                }
            }else{
                self.btnEdit.isHidden = true
                self.imgFav.isHidden = false
                self.stkButtonSave.isHidden = true
                self.btnCancel.isHidden = true
                self.btnSave.isHidden = true
                self.btnGoComments.isHidden = false
                self.addMassesButton.isHidden = true
                self.addSocialButton.isHidden = true
                self.addServicesButton.isHidden = true
            }
        }else {
            self.btnEdit.isHidden = true
            self.imgFav.isHidden = false
            self.stkButtonSave.isHidden = true
            self.btnCancel.isHidden = true
            self.btnSave.isHidden = true
            self.btnGoComments.isHidden = false
            self.addMassesButton.isHidden = true
            self.addSocialButton.isHidden = true
            self.addServicesButton.isHidden = true
        }
    }
    
    private func initContent() {
        
        churchHeaderImage.image = UIImage(named: "church-placeholder", in: Bundle(for: ChurchDetailViewController.self), compatibleWith: nil)
        presenter?.getServiceCatalog()
        if let id = churchId {
            showLoading()
            presenter?.getDetail(id: id)
            
        }
    }
    
    private func validatePhoneAndMail() {
        // btnPhoneNumber.setTitle(church?.phone, for: .normal)
        // btnMailInfo.setTitle(church?.email, for: .normal)
        lblPhoneNumber.text = church?.phone
        lblEmail.text = church?.email
        
        if church?.phone == nil {
            stkPhone.isHidden = true
            btnRealPhone.isHidden = true
            btnPhoneNumber.isHidden = true
            stackLblPhone.isHidden = true
            
        }else{
            stkPhone.isHidden = false
            btnRealPhone.isHidden = false
            btnPhoneNumber.isHidden = false
            stackLblPhone.isHidden = false
            
        }
        if church?.email == nil {
            stkMail.isHidden = true
            btnMailInfo.isHidden = true
            btnRealMail.isHidden = true
            stackLblMail.isHidden = true
        }else {
            stkMail.isHidden = false
            btnMailInfo.isHidden = false
            btnRealMail.isHidden = false
            stackLblMail.isHidden = false
        }
    }
    
    private func fillData() {
        
        let url = church?.image_url ?? "https://arquidiocesis-app-mx.s3.amazonaws.com/SEDES/0/image.png"
        if let imageUrl = URL(string: url) {
            churchHeaderImage.af.setImage(withURL: imageUrl)
        }
        
        churchNameLabel.text = church?.name
        churchSubtitleLabel.text = church?.description
        churchAddressLabel.text = church?.address
        churchResponsibleLabel.text = church?.principal?.name ?? "No disponible"
        //        churchLiveTransmissionsLabel.text = church?.stream.url
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
        socialData = [church?.facebook, church?.instagram, church?.twitter, church?.website, church?.stream]
       
        socialTableView.reloadData()
        nameNew = church?.name ?? ""
        descriptionNew = church?.description ?? ""
        addressNew = church?.address ?? ""
        emailNew = church?.email ?? ""
        phoneNew = church?.phone ?? ""
        faceNew = church?.facebook ?? ""
        instaNew = church?.instagram ?? ""
        twittNew = church?.instagram ?? ""
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
        print(church)
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
//                    churchScheduleLabel.text = churchScheduleText != " " ? churchScheduleText : "No disponible"
//                    churchScheduleLabel.adjustsFontSizeToFitWidth = true
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
        churchScheduleLabel.numberOfLines = 0
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
        let atten = church?.attention ?? []
        let att = atten.sorted{ $0.hour_start!.compare($1.hour_start!, options: .numeric) == .orderedAscending}
        for response in att {
//            [{
//                day: "Domingo",
//                schedule: [
//                    hours: "01:00 a 03:00",
//                    hours: "05:00 a 09:00",
//                    hours: "12:00 a 15:00"
//                ]
//            }]
            if church?.attention?.isEmpty == false {
                for respDays in response.days ?? [] {
                    if respDays.checked! {
                        if respDays.name == "Domingo" {
                            sundayActive.append("\(response.hour_start ?? "") a \(response.hour_end ?? "")")
                        }
                        if respDays.name == "Lunes" {
                            mondayActive.append("\(response.hour_start ?? "") a \(response.hour_end ?? "")")
                        }
                        if respDays.name == "Martes" {
                            tuesdayActive.append("\(response.hour_start ?? "") a \(response.hour_end ?? "")")
                        }
                        if respDays.name == "Miércoles" {
                            wednesdayActive.append("\(response.hour_start ?? "") a \(response.hour_end ?? "")")
                        }
                        if respDays.name == "Jueves" {
                            thursdayActive.append("\(response.hour_start ?? "") a \(response.hour_end ?? "")")
                        }
                        if respDays.name == "Viernes" {
                            fridayActive.append("\(response.hour_start ?? "") a \(response.hour_end ?? "")")
                        }
                        if respDays.name == "Sábado" {
                            saturdayActive.append("\(response.hour_start ?? "") a \(response.hour_end ?? "")")
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
        if sundayActive.count > 0{
            var hoursDay = ""
            for sunday in sundayActive{
                hoursDay = "\(hoursDay) \n \(sunday)"
            }
            if churchOfficeScheduleTextt != "No disponible" {
                churchOfficeScheduleTextt = "\(churchOfficeScheduleTextt) \n Domingo : \(hoursDay)"
            } else {
                churchOfficeScheduleTextt = ""
                churchOfficeScheduleTextt = "Domingo : \(hoursDay)"
            }
        }
        if mondayActive.count > 0{
            var hoursDay = ""
            for sunday in mondayActive{
                hoursDay = "\(hoursDay) \n \(sunday)"
            }
            if churchOfficeScheduleTextt != "No disponible" {
                churchOfficeScheduleTextt = "\(churchOfficeScheduleTextt) \n Lunes : \(hoursDay)"
            } else {
                churchOfficeScheduleTextt = ""
                churchOfficeScheduleTextt = "Lunes : \(hoursDay)"
            }
        }
        if tuesdayActive.count > 0{
            var hoursDay = ""
            for sunday in tuesdayActive{
                hoursDay = "\(hoursDay) \n \(sunday)"
            }
            if churchOfficeScheduleTextt != "No disponible" {
                churchOfficeScheduleTextt = "\(churchOfficeScheduleTextt) \n Martes : \(hoursDay)"
            } else {
                churchOfficeScheduleTextt = ""
                churchOfficeScheduleTextt = "Martes : \(hoursDay)"
            }
        }
        if wednesdayActive.count > 0{
            var hoursDay = ""
            for sunday in wednesdayActive{
                hoursDay = "\(hoursDay) \n \(sunday)"
            }
            if churchOfficeScheduleTextt != "No disponible" {
                churchOfficeScheduleTextt = "\(churchOfficeScheduleTextt) \n Miércoles : \(hoursDay)"
            } else {
                churchOfficeScheduleTextt = ""
                churchOfficeScheduleTextt = "Miércoles : \(hoursDay)"
            }
        }
        if thursdayActive.count > 0{
            var hoursDay = ""
            for sunday in thursdayActive{
                hoursDay = "\(hoursDay) \n \(sunday)"
            }
            if churchOfficeScheduleTextt != "No disponible" {
                churchOfficeScheduleTextt = "\(churchOfficeScheduleTextt) \n Jueves : \(hoursDay)"
            } else {
                churchOfficeScheduleTextt = ""
                churchOfficeScheduleTextt = "Jueves : \(hoursDay)"
            }
        }
        if fridayActive.count > 0{
            var hoursDay = ""
            for sunday in fridayActive{
                hoursDay = "\(hoursDay) \n \(sunday)"
            }
            if churchOfficeScheduleTextt != "No disponible" {
                churchOfficeScheduleTextt = "\(churchOfficeScheduleTextt) \n Viernes : \(hoursDay)"
            } else {
                churchOfficeScheduleTextt = ""
                churchOfficeScheduleTextt = "Viernes : \(hoursDay)"
            }
        }
        if saturdayActive.count > 0{
            var hoursDay = ""
            for sunday in saturdayActive{
                hoursDay = "\(hoursDay) \n \(sunday)"
            }
            if churchOfficeScheduleTextt != "No disponible" {
                churchOfficeScheduleTextt = "\(churchOfficeScheduleTextt) \n Sábado : \(hoursDay)"
            } else {
                churchOfficeScheduleTextt = ""
                churchOfficeScheduleTextt = "Sábado : \(hoursDay)"
            }
        }
        churchOfficeScheduleLabel.text = churchOfficeScheduleTextt
        churchOfficeScheduleLabel.textAlignment = NSTextAlignment.justified
        churchOfficeScheduleLabel.numberOfLines = 0
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
                var isAppend = false
                var days = [String]()
                massesDayNew.forEach { item in
                    if item.checked == true {
                        days.append(item.name ?? "")
                    }else{
                        print("Dont append")
                    }
                    
                }
                
                let str = days.joined(separator: ",")
                if strDaysAct.contains(str) {
                    isAppend = false
                }else{
                    strDaysAct.append(days.joined(separator: ","))
                    isAppend = true
                }
                
                if masesNuew.isEmpty {
                  //  if isAppend == true {
                    masesNuew.insert(MassEditChurch.init(days: massesDayNew.unique(map: {$0.id}), hourStart: response.hour_start, hourEnd: response.hour_end), at: 0)
                   // }
                    
                }else {
                 //   if isAppend == true {
                    masesNuew.append(MassEditChurch.init(days: massesDayNew.unique(map: {$0.id}), hourStart: response.hour_start, hourEnd: response.hour_end))
                  //  }
                    
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
    
    
    @IBAction func returnTo(_ sender: Any) {
        if isPrincipal == 0 {
            DispatchQueue.main.async {
                self.presenter?.goToMyChourch()
            }
        }else {
            _ = navigationController?.popViewController(animated: true)
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
        //  print(masesNuew)
        presenter?.putChurchEdition(locationId: churchId ?? 1, description: descriptionNew, email: emailNew, phone: phoneNew, website: webNew, instagram: instaNew, twitter: twittNew, facebook: faceNew, streaming: streamNew, bankAcount: bankNew, principal: pricipalID, schedules: scheduleDay, attention: attentionnew, masses: masesNuew, services: serviceNew)
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
            let myComment = CommentsList(id: data.my_review?.id, review: data.my_review?.review, creation_date: data.my_review?.creation_date, rating: data.my_review?.rating, devotee: data.my_review?.devotee)//CommentsList(id: data.my_review?.id, review: data.my_review?.review, rating: data.my_review?.rating, devotee: data.my_review?.devotee)
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
                // let imgFill = UIImage(named: "Trazado 6941")
                
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
        print(sender.tag)
        masesNuew.remove(at: sender.tag)
        church?.masses?.remove(at: sender.tag)
        arrayNewObject.removeAll()
        globalArray = Array<Array<NewMassesData>>()
        validateSameDaysChurch()
        
        newChurchMassCollection.reloadData()
        
    }
    
    @objc func deleteServices(sender: UIButton) {
        church?.services?.remove(at: sender.tag)
        serviceNew.remove(at: sender.tag)
        servicesCollectionView.reloadData()
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
    }
}
//MARK: - TableView view delegates
extension ChurchDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var countTable = 0
        
        switch tableView {
        case socialTableView:
            
            countTable = social.count
            
            if addSocialButton.isHidden {
                
                if !(social.count > 0 ) {
                    
                    self.lblRedesSociales.isHidden = true
                    self.hSocial.constant = 0
                    self.view.layoutIfNeeded()
                }
            }
            
        case commentsTable:
            countTable = commentList.count
            
        default:
            break
        }
        
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
            //cell.deleteButton.isHidden = true
            showDeleteBtn(btn: cell.deleteButton)
            cell.deleteButton.tag = indexPath.row
            cell.deleteButton.addTarget(self, action: #selector(deleteSocial), for: .touchUpInside)
            hSocial.constant = cell.frame.height * CGFloat(social.count)
            self.view.layoutIfNeeded()
            return cell
            
        default:
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
extension ChurchDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        var numberOfItems = 0
        
        switch collectionView {
        case newChurchMassCollection:
            
            let array = globalArray as? Array<Array<NewMassesData>>
            numberOfItems = array?.count ?? 0//church?.masses?.count ?? 1//7
            if locationId != churchId {
                churchMassContainer.isHidden = church?.masses?.count == 0
            }else if locationComponent != churchId {
                churchMassContainer.isHidden = church?.masses?.count == 0
            }
        case servicesCollectionView:
            numberOfItems = church?.services?.count ?? 0
            if locationId != churchId {
                churchServicesContainer.isHidden = numberOfItems == 0
            } else if locationComponent != churchId {
                churchServicesContainer.isHidden = numberOfItems == 0
            }
        default:
            break
        }
        
        return numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ServiceCollectionViewCell.reuseIdentifier,
                                                      for: indexPath) as! ServiceCollectionViewCell
        (cell as? ServiceCollectionViewCell)?.delegate = self
        switch collectionView {
        case newChurchMassCollection:
            
            cell.deleteBtn.tag = indexPath.item
            cell.deleteBtn.addTarget(self, action: #selector(deleteMasses), for: .touchUpInside)
            showDeleteBtn(btn: cell.deleteBtn)
            let array = globalArray as? Array<Array<NewMassesData>>
            let dataCount = array?.count ?? 0
            
            if dataCount > 2 {
                hMasses.constant = CGFloat(120 * dataCount)
            }else{
                hMasses.constant = CGFloat(110 * dataCount)
            }
            if let churchData = church {
                if let array = globalArray as? Array<Array<NewMassesData>> {
                    (cell as? ServiceCollectionViewCell)?.fill(with: array, index: indexPath.item)
                }
            }
        case servicesCollectionView:
            
            if let churchData = church {
                cell.deleteBtn.tag = indexPath.item
                cell.deleteBtn.addTarget(self, action: #selector(deleteServices), for: .touchUpInside)
                showDeleteBtn(btn: cell.deleteBtn)
                let dataCount = church?.services?.count ?? 0
                if dataCount > 2 {
                    hServices.constant = CGFloat(150 * dataCount)
                }else{
                    hServices.constant = CGFloat(160 * dataCount)
                }
                
                (cell as? ServiceCollectionViewCell)?.isHidden = true
                if church?.services?.isEmpty == false {
                    (cell as? ServiceCollectionViewCell)?.isHidden = false
                    (cell as? ServiceCollectionViewCell)?.fillService(with: churchData, index: indexPath.row)
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

extension ChurchDetailViewController: ChurchDetailViewProtocol {
    
    func serviceCatalogSuccess(response: ServiceCatalogModel) {
        serviceCatalog = response
    }
    
    func serviceCatalogError() {
        DispatchQueue.main.async { [self] in
            let alert = UIAlertController(title: "Error", message: "Error en el servico, intenta de nuevo más tarde", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertAction.Style.default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    
    func saveChurchSucces() {
        DispatchQueue.main.async { [self] in
            let alert = UIAlertController(title: "", message: "Los datos fueron guardados con éxito", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertAction.Style.default, handler: nil))
            flagEdit = false
            validateProfile()
            present(alert, animated: true, completion: nil)
            if let id = churchId {
                showLoading()
                presenter?.getDetail(id: id)
            }
        }
    }
    
    func saveChurchError() {
        DispatchQueue.main.async { [self] in
            let alert = UIAlertController(title: "Error", message: "Error en el servico, intenta de nuevo más tarde", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertAction.Style.default, handler: nil))
            present(alert, animated: true, completion: nil)
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
           // self?.validateSameDaysChurch()
            self?.initView()
            self?.fillData()
            
        }
    }
    
    func validateSameDaysChurch() {
        // print(church?.masses)
        print(masesNuew, "-----------------------------")
        var arrayOfDays = [NewMassesData]()
        var arry = [String]()
        let object = NewMassesData(daysStr: "", hour: "")
            masesNuew.forEach { item in
                var days = [String]()
                var checked = [Bool]()
                arry.append("\(item)")
                item.days?.forEach({ day in
                    checked.append(day.checked ?? false)
                    if day.checked == true {
                        days.append(day.name ?? "")
                    }else{
                        print("Is disable day")
                    }
                })
                
                var strOfDays = ""
                if days.count != 0 && days.count != 1{
                     strOfDays = "\(days.first ?? "") a \(days.last ?? "")"
                    
                    if days.first == "Domingo" && checked[1] == false {
                        strOfDays = "\(days.last ?? "") a \(days.first ?? "")"
                    }else if days.first == "Domingo" && days.last == "Sábado" {
                        strOfDays = "Lunes a Domingo"
                    }
                }else if days.count == 1 {
                    strOfDays = "\(days.first ?? "")"
                }
                
                let newObject = NewMassesData(daysStr: strOfDays, hour: item.hourStart ?? "")
                arrayOfDays.append(newObject)
                
                
            }
        
        print(arrayOfDays)
        let group = Dictionary(grouping: arrayOfDays, by: { $0.daysStr })
        let arrayGrouped = Array(group.values)
        print(arrayGrouped)
        globalArray = arrayGrouped
        
    }
    
}

//MARK: - Service Cell Delegate
extension ChurchDetailViewController: ServiceCellDelegate {
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
extension ChurchDetailViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}

extension ChurchDetailViewController: RefisterFormularyButtonDelegate, RegisterFormDataSendingDelegateProtocol{
    func didPressReadyFormularyButton(_ sender: UIButton) {
        RegisterFirmulary.instance.parentView.removeFromSuperview()
        view.alpha = 1
        view.isUserInteractionEnabled = true
    }
    
    func sendDataFormToComMainViewController(name: String, intitution: String, charism: String, resposable: String, description: String, address: String, lvText: String, lvHour: String, sdText: String, sdHour: String, email: String, phone: String, latitude: Double, longitude: Double) {
        let daylv = [1, 2, 3, 4, 5, 6, 7]
        var daysActiveLv: [Bool] {
            switch lvText{
            case "lunes  martes" : return [false, true, true, false, false, false, false]
            case "lunes  miércoles": return [false, true, true, true, false, false, false]
            case "lunes  jueves": return [true, true, true, true, false, false, false]
            case "lunes  viernes" : return [false, true, true, true, true, true, false]
            case "lunes  sábado": return [true, true, true, true, true, true, false]
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
        let daysd = [1, 2, 3, 4, 5, 6, 7]
        var daysActiveSd: [Bool] {
            switch sdText{
            case "lunes  martes" : return [false, true, true, false, false, false, false]
            case "lunes  miércoles": return [false, true, true, true, false, false, false]
            case "lunes  jueves": return [true, true, true, true, false, false, false]
            case "lunes  viernes" : return [false, true, true, true, true, true, false]
            case "lunes  sábado": return [true, true, true, true, true, true, false]
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
        let hoursStringArray = lvHour.components(separatedBy: " ")
        let hoursSdStringArray = sdHour.components(separatedBy: " ")
        //lvInt = daylv
        if RegisterFirmulary.instance.institutinTextField.text?.isEmpty == false {
            intitutionNew = intitution
        }
        //        if RegisterFirmulary.instance.charismaTextField.text?.isEmpty == false {
        //            charismNew = charism
        //        }
        if RegisterFirmulary.instance.responsableTextField.text?.isEmpty == false {
            nameNew = resposable
            churchNameLabel.text = nameNew
        }
        if RegisterFirmulary.instance.nameTextField.text?.isEmpty == false {
        }
        //        if RegisterFirmulary.instance.descriptionTextField.text?.isEmpty == false {
        //            resposableNew = description
        //            churchResponsibleLabel.text = description
        //        }
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
            var getHoraryData: String {
                if hoursStringArray.count < 4{
                    return hoursStringArray[1]
                }else {
                    return hoursStringArray[3]
                }
            }
            var getHorarySDData: String {
                if hoursSdStringArray.count < 4{
                    return hoursSdStringArray[1]
                }else {
                    return hoursSdStringArray[3]
                }
            }
            
            if isEditProfile == true {
                if scheduleDay.isEmpty {
                    scheduleDay.insert(AttentionEditChurch.init(days: serviceDaylv.unique(map: {$0.id}), hourStart: hoursStringArray[0], hourEnd: getHoraryData), at: 0)
                }else {
                    scheduleDay.append(AttentionEditChurch.init(days: serviceDaylv.unique(map: {$0.id}), hourStart: hoursStringArray[0], hourEnd: getHoraryData))
                }
            }
            if isEditProfile == true {
                if attentionnew.isEmpty {
                    attentionnew.insert(AttentionEditChurch.init(days: serviceDaySd.unique(map: {$0.id}), hourStart: hoursSdStringArray[0], hourEnd: getHorarySDData), at: 0)
                }else {
                    attentionnew.append(AttentionEditChurch.init(days: serviceDaySd.unique(map: {$0.id}), hourStart: hoursSdStringArray[0], hourEnd: getHorarySDData))
                }
            }
            let churchScheduleText = "\(lvText) \(lvHour)"
            churchScheduleLabel.text = churchScheduleText != " " ? churchScheduleText : "No disponible"
            let churchOfficeScheduleText = "\(sdText) \(sdHour)"
            churchOfficeScheduleLabel.text = churchOfficeScheduleText != " " ? churchOfficeScheduleText : "No disponible"
            churchScheduleLabel.adjustsFontSizeToFitWidth = true
            churchOfficeScheduleLabel.adjustsFontSizeToFitWidth = true
        }
    }
}

extension ChurchDetailViewController: SuccessAllertButtonDelegate {
    func didPressYesSuccessAllertButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}

extension ChurchDetailViewController: AddServiceModalButtonDelegate {
    func didPressReadyServiceButton(_ sender: UIButton) {
        let day = [1, 2, 3, 4, 5, 6, 7]
        var daysActive: [Bool] {
            switch AddService.instance.daysTextField.text{
            case "lunes  martes" : return [false, true, true, false, false, false, false]
            case "lunes  miércoles": return [false, true, true, true, false, false, false]
            case "lunes  jueves": return [true, true, true, true, false, false, false]
            case "lunes  viernes" : return [false, true, true, true, true, true, false]
            case "lunes  sábado": return [true, true, true, true, true, true, false]
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
            servicesCollectionView.reloadData()
        }
        view.isUserInteractionEnabled = true
        view.alpha = 1
    }
    
    func didPressAdServicemButton(_ sender: UIButton) {
        let day = [1, 2, 3, 4, 5, 6, 7]
        var daysActive: [Bool] {
            switch AddService.instance.daysTextField.text{
            case "lunes  martes" : return [false, true, true, false, false, false, false]
            case "lunes  miércoles": return [false, true, true, true, false, false, false]
            case "lunes  jueves": return [true, true, true, true, false, false, false]
            case "lunes  viernes" : return [false, true, true, true, true, true, false]
            case "lunes  sábado": return [true, true, true, true, true, true, false]
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

extension ChurchDetailViewController: AddMassesModalButtonDelegate{

    func didPressReadyMassesButton(_ sender: UIButton, hourTxt: String, daysTxt: String) {
        let day = [1, 2, 3, 4, 5, 6, 7]
        var daysActive: [Bool] {
            switch daysTxt {//AddMasses.instance.dyasTextfield.text {
            case "lunes  lunes": return [false, true, false, false, false, false, false]
            case "lunes  martes" : return [false, true, true, false, false, false, false]
            case "lunes  miércoles": return [false, true, true, true, false, false, false]
            case "lunes  jueves": return [false, true, true, true, true, false, false]
            case "lunes  viernes" : return [false, true, true, true, true, true, false]
            case "lunes  sábado": return [false, true, true, true, true, true, true]
            case "lunes  domingo": return [true, true, true, true, true, true, true]
            case "martes  martes": return [false, false, true, false, false, false, false]
            case "martes  miércoles": return [false, false, true, true, false, false, false]
            case "martes  jueves": return [false, false, true, true, true, false, false]
            case "martes  viernes": return [false, false, true, true, true, true, false]
            case "martes  sábado": return [false, false, true, true, true, true, true]
            case "martes  domingo": return [true, false, true, false, false, false, false]
            case "martes  lunes": return [true, true, true, true, true, true, true]
            case "miércoles  miércoles": return [false, false, false, true, false, false, false]
            case "miércoles  jueves": return [false, false, false, true, true, false, false]
            case "miércoles  viernes":  return [false, false, false, true, true, true, false]
            case "miércoles  sábado": return [false, false, false, true, true, true, true]
            case "miércoles  domingo": return [true, false, false, true, true, true, true]
            case "miércoles  lunes": return [true, true, false, true, true, true, true]
            case "miércoles  martes": return [true, true, true, true, true, true, true]
            case "jueves  jueves": return [false, false, false, false, true, false, false]
            case "jueves  viernes": return [false, false, false, false, true, true, false]
            case "jueves  sábado": return [false, false, false, false, true, true, true]
            case "jueves  domingo": return [true, false, false, false, true, false, false]
            case "jueves  lunes": return [true, true, false, false, true, true, true]
            case "jueves  martes": return [true, true, true, false, true, true, true]
            case "jueves  miércoles": return [true, true, true, true, true, true, true]
            case "viernes  viernes": return [false, false, false, false, false, true, false]
            case "viernes  sábado": return [false, false, false, false, false, true, true]
            case "viernes  domingo": return [true, false, false, false, false, true, false]
            case "viernes  lunes": return [true, true, false, false, false, true, true]
            case "viernes  martes": return [true, true, true, false, false, true, true]
            case "viernes  miércoles": return [true, true, true, true, false, true, true]
            case "viernes  jueves": return [true, true, true, true, true, true, true]
            case "sábado  sábado": return [false, false, false, false, false, false, true]
            case "sábado  domingo": return [true, false, false, false, false, false, true]
            case "sábado  lunes": return [true, true, false, false, false, false, true]
            case "sábado  martes": return [true, true, true, false, false, false, true]
            case "sábado  miércoles": return [true, true, true, true, false, false, true]
            case "sábado  jueves": return [true, true, true, true, true, false, true]
            case "sábado  viernes": return [true, true, true, true, true, true, true]
            case "domingo  domingo": return [true, false, false, false, false, false, false]
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
        massesDayNew.removeAll()
        print(masesNuew, masesNuew.count)
       // guard let hoursStringArray = AddMasses.instance.hourTextField.text?.components(separatedBy: " ") else {return}
         let hoursStringArray = hourTxt.components(separatedBy: " ")
        //if AddMasses.instance.hourTextField.text?.isEmpty == false && AddMasses.instance.dyasTextfield.text?.isEmpty
        //AddMasses.instance.dyasTextfield.text?.isEmpty == false {
        if hourTxt.isEmpty == false &&  daysTxt.isEmpty == false {
            for (days, daysActive) in zip(day, daysActive) {
                guard let getDays = DaysInt.init(rawValue: days) else {return}
                if massesDayNew.isEmpty {
                    massesDayNew.insert(DayEditChurch.init(id: days, name: getDays.daysString, checked: daysActive), at: 0)
                }else {
                    massesDayNew.append(DayEditChurch.init(id: days, name: getDays.daysString, checked: daysActive))
                }
            }
            if masesNuew.isEmpty {
                masesNuew.insert(MassEditChurch.init(days: massesDayNew.unique(map: {$0.id}), hourStart: hoursStringArray[0], hourEnd: hoursStringArray[3]), at: 0)
            }else {
                masesNuew.append(MassEditChurch.init(days: massesDayNew.unique(map: {$0.id}), hourStart: hoursStringArray[0], hourEnd: hoursStringArray[3]))
            }
            self.view.makeToast("Misa agregada correctamente", duration: 3.0, position: .top)
        }
        view.isUserInteractionEnabled = true
        view.alpha = 1
        print(masesNuew, masesNuew.count, "ççç")
    }
    
    func didPressAdMassesButton(_ sender: UIButton, hourTxt: String, daysTxt: String) {
        let day = [1, 2, 3, 4, 5, 6, 7]
        var daysActive: [Bool] {
            switch daysTxt{//AddMasses.instance.dyasTextfield.text {
            case "lunes  lunes": return [false, true, false, false, false, false, false]
            case "lunes  martes" : return [false, true, true, false, false, false, false]
            case "lunes  miércoles": return [false, true, true, true, false, false, false]
            case "lunes  jueves": return [false, true, true, true, true, false, false]
            case "lunes  viernes" : return [false, true, true, true, true, true, false]
            case "lunes  sábado": return [false, true, true, true, true, true, true]
            case "lunes  domingo": return [true, true, true, true, true, true, true]
            case "martes  martes": return [false, false, true, false, false, false, false]
            case "martes  miércoles": return [false, false, true, true, false, false, false]
            case "martes  jueves": return [false, false, true, true, true, false, false]
            case "martes  viernes": return [false, false, true, true, true, true, false]
            case "martes  sábado": return [false, false, true, true, true, true, true]
            case "martes  domingo": return [true, false, true, false, false, false, false]
            case "martes  lunes": return [true, true, true, true, true, true, true]
            case "miércoles  miércoles": return [false, false, false, true, false, false, false]
            case "miércoles  jueves": return [false, false, false, true, true, false, false]
            case "miércoles  viernes":  return [false, false, false, true, true, true, false]
            case "miércoles  sábado": return [false, false, false, true, true, true, true]
            case "miércoles  domingo": return [true, false, false, true, true, true, true]
            case "miércoles  lunes": return [true, true, false, true, true, true, true]
            case "miércoles  martes": return [true, true, true, true, true, true, true]
            case "jueves  jueves": return [false, false, false, false, true, false, false]
            case "jueves  viernes": return [false, false, false, false, true, true, false]
            case "jueves  sábado": return [false, false, false, false, true, true, true]
            case "jueves  domingo": return [true, false, false, false, true, false, false]
            case "jueves  lunes": return [true, true, false, false, true, true, true]
            case "jueves  martes": return [true, true, true, false, true, true, true]
            case "jueves  miércoles": return [true, true, true, true, true, true, true]
            case "viernes  viernes": return [false, false, false, false, false, true, false]
            case "viernes  sábado": return [false, false, false, false, false, true, true]
            case "viernes  domingo": return [true, false, false, false, false, true, false]
            case "viernes  lunes": return [true, true, false, false, false, true, true]
            case "viernes  martes": return [true, true, true, false, false, true, true]
            case "viernes  miércoles": return [true, true, true, true, false, true, true]
            case "viernes  jueves": return [true, true, true, true, true, true, true]
            case "sábado  sábado": return [false, false, false, false, false, false, true]
            case "sábado  domingo": return [true, false, false, false, false, false, true]
            case "sábado  lunes": return [true, true, false, false, false, false, true]
            case "sábado  martes": return [true, true, true, false, false, false, true]
            case "sábado  miércoles": return [true, true, true, true, false, false, true]
            case "sábado  jueves": return [true, true, true, true, true, false, true]
            case "sábado  viernes": return [true, true, true, true, true, true, true]
            case "domingo  domingo": return [true, false, false, false, false, false, false]
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
        //guard let hoursStringArray = AddMasses.instance.hourTextField.text?.components(separatedBy: " ") else {return}
        let hoursStringArray = hourTxt.components(separatedBy: " ")
        massesDayNew.removeAll()
        //if AddMasses.instance.hourTextField.text?.isEmpty == false && AddMasses.instance.dyasTextfield.text?.isEmpty
        if hourTxt.isEmpty == false && daysTxt.isEmpty == false {
            for (days, daysActive) in zip(day, daysActive) {
                guard let getDays = DaysInt.init(rawValue: days) else {return}
                if massesDayNew.isEmpty {
                    massesDayNew.insert(DayEditChurch.init(id: days, name: getDays.daysString, checked: daysActive), at: 0)
                }else {
                    massesDayNew.append(DayEditChurch.init(id: days, name: getDays.daysString, checked: daysActive))
                }
            }
            if masesNuew.isEmpty {
                masesNuew.insert(MassEditChurch.init(days: massesDayNew.unique(map: {$0.id}), hourStart: hoursStringArray[0], hourEnd: hoursStringArray[3]), at: 0)
            }else {
                masesNuew.append(MassEditChurch.init(days: massesDayNew.unique(map: {$0.id}), hourStart: hoursStringArray[0], hourEnd: hoursStringArray[3]))
            }
            self.view.makeToast("Misa agregada correctamente", duration: 3.0, position: .top)
        }
    }
}

extension ChurchDetailViewController: AddSocialModalButtonDelegate {
    func pressAddSocial(sender: UIButton, socialTxt: String, socialIndex: Int) {
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
       // socialTableView.reloadData()
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
        
        self.view.makeToast("Red social agregada correctamente", duration: 3.0, position: .top)
        view.isUserInteractionEnabled = true
        view.alpha = 1
        socialTableView.isHidden = false
       // socialTableView.reloadData()
    }
    
// OLD AND USELESS
    func didPressReadySocialButton(_ sender: UIButton) {
//        switch AddSocial.instance.sellectedSocial {
//        case 0:
//            faceNew = AddSocial.instance.socialTextField.text ?? ""
//            socialData[0] = faceNew
//        case 1:
//            twittNew = AddSocial.instance.socialTextField.text ?? ""
//            socialData[1] = twittNew
//        case 2:
//            instaNew = AddSocial.instance.socialTextField.text ?? ""
//            socialData[2] = instaNew
//        case 3:
//            streamNew = AddSocial.instance.socialTextField.text ?? ""
//            socialData[4] = streamNew
//        case 4:
//            webNew = AddSocial.instance.socialTextField.text ?? ""
//            socialData[3] = webNew
//        default:
//            break
//        }
        
    }
    
    func didPressAddSocialmButton(_ sender: UIButton) {
        switch AddSocial.instance.sellectedSocial {
        case 0:
            faceNew = AddSocial.instance.socialTextField.text ?? ""
            socialData[0] = faceNew
        case 1:
            twittNew = AddSocial.instance.socialTextField.text ?? ""
            socialData[1] = twittNew
        case 2:
            instaNew = AddSocial.instance.socialTextField.text ?? ""
            socialData[2] = instaNew
        case 3:
            streamNew = AddSocial.instance.socialTextField.text ?? ""
            socialData[4] = streamNew
        case 4:
            webNew = AddSocial.instance.socialTextField.text ?? ""
            socialData[3] = webNew
        default:
            break
        }
        self.view.makeToast("Red social agregada correctamente", duration: 3.0, position: .top)
        socialTableView.isHidden = false
        socialTableView.reloadData()
    }
    
    
}

extension ChurchDetailViewController: UIViewControllerTransitioningDelegate {
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = false
        
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.initContent()
            
            if self.isPrincipal == 0 {
                // self.imgFav.image = UIImage(named: "botonInActivo", in: Bundle(for: ChurchDetailViewController.self), compatibleWith: nil)
                self.isTappedFav = false
                self.imgFav.alpha = 0
                self.btnPrincipal.isHidden = false
                //  self.imgFav.isUserInteractionEnabled = true
            }else if self.isPrincipal == 1{
                self.self.imgFav.image = UIImage(named: "unfav", in: Bundle(for: ChurchDetailViewController.self), compatibleWith: nil)
                self.btnPrincipal.isHidden = true
                self.isTappedFav = false
                self.imgFav.isUserInteractionEnabled = true
            }else if self.isPrincipal == 2{
                self.imgFav.image = UIImage(named: "fav", in: Bundle(for: ChurchDetailViewController.self), compatibleWith: nil)
                self.btnPrincipal.isHidden = true
                self.isTappedFav = true
                self.imgFav.isUserInteractionEnabled = true
            }else if self.isPrincipal == 3 {
                //self.imgFav.image = UIImage(named: "botonActivo", in: Bundle(for: ChurchDetailViewController.self), compatibleWith: nil)
                self.imgFav.alpha = 0
                self.btnPrincipal.isHidden = true
                //rself.imgFav.isUserInteractionEnabled = false
            }
            
        }
        
        return transition
    }
}

