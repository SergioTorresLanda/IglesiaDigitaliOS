//
//  CommunitiesMainViewController.swift
//  EncuentroCatolicoChurch
//
//  Created by Jorge Garcia on 09/08/21.
//

import UIKit
import EncuentroCatolicoProfile
import MessageUI
import Foundation
import MapKit
import AlamofireImage

enum DaysInt: Int {
    case domingo = 1
    case lunes = 2
    case martes = 3
    case miercoles = 4
    case jueves = 5
    case viernes = 6
    case sabado = 7
    
    
    var daysString: String {
        get {
            switch self {
            case .domingo:
                return "Domingo"
            case .lunes:
                return "Lunes"
            case .martes:
                return "Martes"
            case .miercoles:
                return "Miércoles"
            case .jueves:
                return "Jueves"
            case .viernes:
                return "Viernes"
            case .sabado:
                return "Sábado"
            }
        }
    }
}

class CommunitiesMainViewController: UIViewController, CommunitiesMainViewProtocol, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var typeId = Int()
    var principalID = Int()
    var serviceCatalog: ServiceCatalogModel?
    var socialIcon = ["facebookIcon", "instagramIcon", "tuitterIcon", "streamIcon", "webIcon"]
    var socialData = [String?]()
    var presenter: CommunitiesMainViewPresenterProtocol?
    let userRole = UserDefaults.standard.string(forKey: "role")
    var comesFromMyChourch = Bool()
    var height : CGFloat!
    var imagePicker = UIImagePickerController()
    let loadingAlert = UIAlertController(title: "", message: "\n \n \n \n \nCargando...", preferredStyle: .alert)
    var latitude: Double? = 0.0
    var longitude: Double? = 0.0
    var phone: String? = ""
    var email: String? = ""
    var id: Int? = 1
    var userId = UserDefaults.standard.integer(forKey: "id")
    let locationId = UserDefaults.standard.integer(forKey: "locationId")
    let profileRole = UserDefaults.standard.string(forKey: "profile")
    let locationComponent = UserDefaults.standard.integer(forKey: "locationModule")
    let communityStatus = UserDefaults.standard.string(forKey: "communityStatus")
    let locationcomponents = UserDefaults.standard.object(forKey: "locationModuleComponents") as? [String]
    let communityLocationID = UserDefaults.standard.integer(forKey: "locationCommunityId")
    var imageContent = String()
    var communityDetail: CommunityDetailModel?
    var communityActivities: CommunityGetActivities?
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
    var instutNew = String()
    var latitudeNew = Double()
    var longitudeNew = Double()
    var webNew = String()
    var instaNew = String()
    var twittNew = String()
    var faceNew = String ()
    var streamNew = String()
    var lvFirstDayNew = String()
    var lvLastDayNew = String()
    var lvFirstHourNew = String()
    var lvLastHourNew = String()
    var serviceEditNew: [ServiceHourEditProfile] = []
    var serviceFinishNew: [ServiceHourFinReg] = []
    var activityEditNew: [ActivityEditProfile] = []
    var activityFinishNew: [ActivityFinReg] = []
    var linkComNew: [LinkedCommunity] = []
    
    var serviceDayEdit: [ServiceHourEditProfile] = []
    var arrayOfArrayServices = [[ServiceHourEditProfile]]()
    var serviceHourEdit: [ScheduleEditPrifile] = []
    var serviceDayFinish: [ServiceHourFinReg] = []
    var serviceHourFinish: [SchedulefinReg] = []
    
    var serviceHourEditlv: [ScheduleEditPrifile] = []
    var serviceHourEditsd: [ScheduleEditPrifile] = []
    var serviceHourFinishlv: [SchedulefinReg] = []
    var serviceHourFinishsd: [SchedulefinReg] = []
    
    var communityComments: Comments?
    var arrayComments: [CommentsList] = []
    
    var sdServiceDays = String()
    var lvServiceDays = String()
    
    var isEditProfile: Bool = false
    var isFavorite: Bool = false
    var isPrincipal: Bool = false
    
    let transition = SlideTransition()
    
    var socialIdentifier: [String] = []
    
    @IBOutlet weak var btnGoTo: UIButton!
    @IBOutlet weak var pricipalComButton: UIButton!
    @IBOutlet weak var socialContainer: UIView!
    @IBOutlet weak var servicesContainer: UIView!
    @IBOutlet weak var chourchNameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var horaryLabel: UILabel!
    @IBOutlet weak var sdHoraryLabel: UILabel!
    @IBOutlet weak var asossationLabel: UILabel!
    @IBOutlet weak var descriptinLabel: UILabel!
    @IBOutlet var parentView: UIView!
    @IBOutlet weak var addCommunitiesTableView: UITableView!
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var aditButton: UIButton!
    @IBOutlet weak var addSocialButton: UIButton!
    @IBOutlet weak var socialTableView: UITableView!
    @IBOutlet weak var addServiceButton: UIButton!
    @IBOutlet weak var serviceTableView: UITableView!
    @IBOutlet weak var addCommonutyButton: UIButton!
    @IBOutlet weak var addCommunityLabel: UILabel!
    @IBOutlet weak var SaveButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var addCommunitiesView: UIView!
    @IBOutlet weak var changeImageButton: UIButton!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var btnGoToComments: UIButton!
    @IBOutlet weak var commentsContainer: UIView!
    @IBOutlet weak var commentsTableView: UITableView!
    @IBOutlet weak var star1: UIImageView!
    @IBOutlet weak var star2: UIImageView!
    @IBOutlet weak var star3: UIImageView!
    @IBOutlet weak var star4: UIImageView!
    @IBOutlet weak var star5: UIImageView!
    @IBOutlet weak var lblNmberComments: UILabel!
    @IBOutlet weak var commetsTableHeight: NSLayoutConstraint!
    @IBOutlet weak var socialTableHeight: NSLayoutConstraint!
    @IBOutlet weak var servicesTableHeight: NSLayoutConstraint!
    @IBOutlet weak var cardSaveCancel: UIView!
    @IBOutlet weak var cardVerOpinion: UIView!
    @IBOutlet weak var customNavBar: UIView!
    @IBOutlet weak var cardSocial: UIView!
    @IBOutlet weak var stkViewCalendar: UIStackView!
    
    @IBOutlet weak var iconCalendar: UIImageView!
    // MARK: LIFE CYCLE VIEW FUNCTIONS -
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        print("VC ECChurch - CommunitiesMV- CommunitiesVC")
        //        self.addCommunitiesCollectionView.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.old, context: nil)
        activityEditNew.removeAll()
        activityFinishNew.removeAll()
        presenter?.communityComments(id: id ?? 1)
        presenter?.chourhDetail(id: id ?? 1)
        presenter?.communityActivities(id: id ?? 1)
        presenter?.getServiceCatalog()
        socialTableView.reloadData()
        serviceTableView.reloadData()
        commentsTableView.reloadData()
        addCommunitiesTableView.reloadData()
        showLoading()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        socialTableView.reloadData()
        serviceTableView.reloadData()
        commentsTableView.reloadData()
        addCommunitiesTableView.reloadData()
        //presenter?.communityComments(id: id ?? 1)
        initView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    private func initView() {
        btnGoTo.layer.cornerRadius = 8
        customNavBar.layer.cornerRadius = 20
        customNavBar.ShadowNavBar()
        cardSocial.layer.cornerRadius = 10
        cardSocial.ShadowCard()
        
        socialTableView.delegate = self
        socialTableView.dataSource = self
        serviceTableView.dataSource = self
        serviceTableView.delegate = self
        addCommunitiesTableView.delegate = self
        addCommunitiesTableView.dataSource = self
        commentsTableView.delegate = self
        commentsTableView.dataSource = self
        if linkComNew.isEmpty {
            addCommunitiesTableView.isHidden = true
        }
        if isPrincipal == false {
            aditButton.isHidden = false
            pricipalComButton.isHidden = true
        }else {
            aditButton.isHidden = true
            pricipalComButton.isHidden = false
        }
        
        socialTableView.register(SocialTableViewCell.nib, forCellReuseIdentifier: SocialTableViewCell.reuseIdentifier)
        serviceTableView.register(ServiceTableViewCell.nib, forCellReuseIdentifier: ServiceTableViewCell.reuseIdentifier)
        serviceTableView.register(UINib(nibName: "HorizontalServiceSection", bundle: Bundle.local), forCellReuseIdentifier: "CELLHORIZONTAL")
        // serviceTableView.register(HorizontalServiceSection.self, forCellReuseIdentifier: "CELLHORIZONTAL")
        addCommunitiesTableView.register(AddCommunitiesTableViewCell.nib, forCellReuseIdentifier: AddCommunitiesTableViewCell.reuseIdentifier)
        socialTableView.separatorStyle = .none
        validateProfile()
    }
    
    private func validateProfile() {
        switch communityStatus {
        case  UserCommunityStatus.pendingApproval.rawValue:
            flagsButtonChanger()
            addSocialButton.isHidden = true
            addServiceButton.isHidden = true
            addCommunitiesView.isHidden = true
            cardSaveCancel.isHidden = true
            addCommunitiesTableView.isHidden = true
            cardVerOpinion.isHidden = false
            stackView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
            scrollView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
            
        case UserCommunityStatus.pendindCompletion.rawValue, UserCommunityStatus.complete.rawValue:
            if communityLocationID != 0 {
                        
                        if  communityLocationID == id {
                            switch profileRole{
                            case UserProfileEnum.ResponsableComunidad.rawValue:
                                changeImageButton.isHidden = false
                                aditButton.isHidden = false
                                pricipalComButton.isHidden = true
                                addSocialButton.isHidden = false
                                addServiceButton.isHidden = false
                                addCommunitiesView.isHidden = true
                                cardSaveCancel.isHidden = false
                                cardVerOpinion.isHidden = true
                                
                            case UserProfileEnum.AdministradorComunidad.rawValue:
                                if ((locationcomponents?.contains("LOCATION_INFORMATION")) == true){
                                    if isPrincipal == true {
                                        if isFavorite == true {
                                            pricipalComButton.setTitle("Quitar comunidad principal", for: .normal)
                                        }else {
                                            pricipalComButton.setTitle("Hacer comunidad principal", for: .normal)
                                        }
                                    }
                                    changeImageButton.isHidden = false
                                    aditButton.isHidden = false
                                    pricipalComButton.isHidden = true
                                    addSocialButton.isHidden = false
                                    addServiceButton.isHidden = false
                                    addCommunitiesView.isHidden = true
                                    cardSaveCancel.isHidden = false
                                    cardVerOpinion.isHidden = true
                                    
                                }else {
                                    flagsButtonChanger()
                                    addSocialButton.isHidden = true
                                    addServiceButton.isHidden = true
                                    addCommunitiesView.isHidden = true
                                    cardSaveCancel.isHidden = true
                                    addCommunitiesTableView.isHidden = true
                                    cardVerOpinion.isHidden = false
                                    stackView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
                                    scrollView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
                                }
                                
                            case UserProfileEnum.sacerdote.rawValue, UserProfileEnum.Sacerdotedecano.rawValue, UserProfileEnum.Sacerdoteadministrador.rawValue, UserProfileEnum.fieladministrador.rawValue, UserProfileEnum.fiel.rawValue:
                                
                                flagsButtonChanger()
                                addSocialButton.isHidden = true
                                addServiceButton.isHidden = true
                                addCommunitiesView.isHidden = true
                                cardSaveCancel.isHidden = true
                                addCommunitiesTableView.isHidden = true
                                cardVerOpinion.isHidden = false
                                stackView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
                                scrollView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
                                
                            default:
                                break
                                
                            }
                        } else if communityLocationID == id {
                            
                            switch profileRole {
                            case  UserProfileEnum.ResponsableComunidad.rawValue:
                                changeImageButton.isHidden = false
                                aditButton.isHidden = false
                                pricipalComButton.isHidden = true
                                addSocialButton.isHidden = false
                                addServiceButton.isHidden = false
                                addCommunitiesView.isHidden = true
                                cardSaveCancel.isHidden = false
                                cardVerOpinion.isHidden = true
                                
                            case UserProfileEnum.AdministradorComunidad.rawValue:
                                if ((locationcomponents?.contains("LOCATION_INFORMATION")) == true){
                                    if isPrincipal == true {
                                        if isFavorite == true {
                                            pricipalComButton.setTitle("Quitar comunidad principal", for: .normal)
                                        }else {
                                            pricipalComButton.setTitle("Hacer comunidad principal", for: .normal)
                                        }
                                    }
                                    changeImageButton.isHidden = false
                                    aditButton.isHidden = false
                                    pricipalComButton.isHidden = true
                                    addSocialButton.isHidden = false
                                    addServiceButton.isHidden = false
                                    addCommunitiesView.isHidden = true
                                    cardSaveCancel.isHidden = false
                                    cardVerOpinion.isHidden = true
                                    
                                }else {
                                    flagsButtonChanger()
                                    addSocialButton.isHidden = true
                                    addServiceButton.isHidden = true
                                    addCommunitiesView.isHidden = true
                                    cardSaveCancel.isHidden = true
                                    addCommunitiesTableView.isHidden = true
                                    cardVerOpinion.isHidden = false
                                    stackView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
                                    scrollView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
                                }
                                
                            case UserProfileEnum.sacerdote.rawValue, UserProfileEnum.Sacerdotedecano.rawValue, UserProfileEnum.Sacerdoteadministrador.rawValue, UserProfileEnum.fieladministrador.rawValue, UserProfileEnum.fiel.rawValue:
                                
                                flagsButtonChanger()
                                addSocialButton.isHidden = true
                                addServiceButton.isHidden = true
                                addCommunitiesView.isHidden = true
                                cardSaveCancel.isHidden = true
                                addCommunitiesTableView.isHidden = true
                                cardVerOpinion.isHidden = false
                                stackView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
                                scrollView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
                                
                            default:
                                break
                                
                            }
                            
                        }else {
                            flagsButtonChanger()
                            addSocialButton.isHidden = true
                            addServiceButton.isHidden = true
                            addCommunitiesView.isHidden = true
                            cardSaveCancel.isHidden = true
                            addCommunitiesTableView.isHidden = true
                            cardVerOpinion.isHidden = false
                            stackView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
                            scrollView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
                            
                        }
                        
                    }else{
                        flagsButtonChanger()
                        addSocialButton.isHidden = true
                        addServiceButton.isHidden = true
                        addCommunitiesView.isHidden = true
                        cardSaveCancel.isHidden = true
                        addCommunitiesTableView.isHidden = true
                        cardVerOpinion.isHidden = false
                        stackView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
                        scrollView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
                        
                    }
        default:
            flagsButtonChanger()
            addSocialButton.isHidden = true
            addServiceButton.isHidden = true
            addCommunitiesView.isHidden = true
            cardSaveCancel.isHidden = true
            addCommunitiesTableView.isHidden = true
            cardVerOpinion.isHidden = false
            stackView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
            scrollView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        }
        
    }
    
    private func flagsButtonChanger(){
        changeImageButton.isHidden = true
        if isPrincipal == false {
            aditButton.isHidden = false
            pricipalComButton.isHidden = true
        }else {
            aditButton.isHidden = true
            pricipalComButton.isHidden = false
        }
        if isPrincipal == true {
            if isFavorite == true {
                pricipalComButton.setTitle("Quitar comunidad principal", for: .normal)
            }else {
                pricipalComButton.setTitle("Hacer comunidad principal", for: .normal)
            }
        }else {
            if isFavorite == true {
                aditButton.setImage(UIImage(named: "fav", in: Bundle.local, compatibleWith: nil), for: .normal)
            }else {
                aditButton.setImage(UIImage(named: "unfav", in: Bundle.local, compatibleWith: nil), for: .normal)
            }
        }
    }
    
    func serviceCatalogSuccess(response: ServiceCatalogModel) {
        serviceCatalog = response
    }
    
    func serviceCatalogError() {
        
    }
    
    func communityDataSuccess(response: CommunityDetailModel) {
        self.communityDetail = response
        
        DispatchQueue.main.async { [self] in
            let localImageUrl = Bundle.local.url(forResource: "emptyImageCom", withExtension: "png")
            let localImageStringUrl: String = localImageUrl?.absoluteString ?? ""
            let url = communityDetail?.imageURL ?? localImageStringUrl
            
            if let imageUrl = URL(string: url) {
                mainImageView.af.setImage(withURL: imageUrl)
            }
            if response.email == nil {
                emailLabel.isHidden = true
            }else if response.phone == nil {
                phoneLabel.isHidden = true
            }
            
            if let name = communityDetail?.name {
                chourchNameLabel.text = name
            }else{
                chourchNameLabel.isHidden = true
            }
            
            if let institute = communityDetail?.instituteOrAssociation {
                asossationLabel.text = institute
            }else{
                asossationLabel.isHidden = true
            }
            
            if let descriptionText = communityDetail?.communityDetailModelDescription {
                descriptinLabel.text = descriptionText
            }else{
                descriptinLabel.isHidden = true
            }
            
            latitude = communityDetail?.latitude
            longitude = communityDetail?.longitude
            socialData.removeAll()
            if let fb = communityDetail?.facebook {
                socialData.append(fb)
                socialIdentifier.append("F")
            }
            if let insta = communityDetail?.instagram {
                socialData.append(insta)
                socialIdentifier.append("I")
            }
            if let twit = communityDetail?.twitter {
                socialData.append(twit)
                socialIdentifier.append("T")
            }
            if let web = communityDetail?.website {
                socialData.append(web)
                socialIdentifier.append("W")
            }
            if let stream = communityDetail?.streamingChannel {
                socialData.append(stream)
                socialIdentifier.append("S")
            }
            print("++++++++", socialData)
            typeId = communityDetail?.type?.id ?? 1
            if communityDetail?.facebook == nil && communityDetail?.instagram == nil && communityDetail?.twitter == nil && communityDetail?.website == nil && communityDetail?.streamingChannel == nil {
                switch profileRole {
                case UserProfileEnum.AdministradorComunidad.rawValue, UserProfileEnum.ResponsableComunidad.rawValue:
                    socialContainer.isHidden = false
                default :
                    socialContainer.isHidden = true
                }
            }
            emailLabel.text = communityDetail?.email
            phoneLabel.text = communityDetail?.phone
            addressLabel.text = communityDetail?.address
            email = communityDetail?.email
            phone = communityDetail?.phone
            socialTableView.reloadData()
            serviceTableView.reloadData()
            if socialData.count == 0 {
                socialTableHeight.constant = 0
                cardSocial.isHidden = true
            }else{
                cardSocial.isHidden = false
            }
            
            nameNew = response.name ?? ""
            intitutionNew = response.instituteOrAssociation ?? ""
            charismNew = response.charisma ?? ""
            resposableNew = response.leader ?? ""
            descriptionNew = response.communityDetailModelDescription ?? ""
            addressNew = response.address ?? ""
            emailNew = response.email ?? ""
            phoneNew = response.phone ?? ""
            faceNew = response.facebook ?? ""
            instaNew = response.instagram ?? ""
            twittNew = response.twitter ?? ""
            webNew = response.website ?? ""
            streamNew = response.streamingChannel ?? ""
            latitudeNew = response.latitude ?? 0.0
            longitudeNew = response.longitude ?? 0.0
            if let count = response.serviceHours?.count, count == 0 {
                
                self.sdHoraryLabel.text = "No hay información"
            }
            for response in response.serviceHours ?? [] {
                for hours in response.schedules ?? [] {
                    serviceHourEditlv.removeAll()
                    serviceHourEditsd.removeAll()
                    serviceHourFinishsd.removeAll()
                    serviceHourFinishlv.removeAll()
                    if isEditProfile == true {
                        if serviceHourEditlv.isEmpty && serviceHourEditsd.isEmpty {
                            if response.day == 0 || response.day == 6 {
                                serviceHourEditsd.insert(ScheduleEditPrifile.init(startHour: hours.hourStart, endHour: hours.hourEnd), at: 0)
                            }else {
                                serviceHourEditlv.insert(ScheduleEditPrifile.init(startHour: hours.hourStart, endHour: hours.hourEnd), at: 0)
                            }
                        }else {
                            if response.day == 0 || response.day == 6 {
                                serviceHourEditsd.append(ScheduleEditPrifile.init(startHour: hours.hourStart, endHour: hours.hourEnd))
                            }else {
                                serviceHourEditlv.append(ScheduleEditPrifile.init(startHour: hours.hourStart, endHour: hours.hourEnd))
                            }
                        }
                    }else {
                        if serviceHourFinishlv.isEmpty && serviceHourFinishsd.isEmpty {
                            if response.day == 0 || response.day == 6 {
                                serviceHourFinishsd.insert(SchedulefinReg.init(startHour: hours.hourStart, endHour: hours.hourEnd), at: 0)
                            }else {
                                serviceHourFinishlv.insert(SchedulefinReg.init(startHour: hours.hourStart, endHour: hours.hourEnd), at: 0)
                            }
                        }else {
                            if response.day == 0 || response.day == 6 {
                                serviceHourFinishsd.append(SchedulefinReg.init(startHour: hours.hourStart, endHour: hours.hourEnd))
                            }else {
                                serviceHourFinishlv.append(SchedulefinReg.init(startHour: hours.hourStart, endHour: hours.hourEnd))
                            }
                        }
                    }
                    if isEditProfile == true {
                        if serviceEditNew.isEmpty {
                            if response.day == 0 || response.day == 6 {
                                serviceEditNew.insert(ServiceHourEditProfile.init(day: response.day, schedule: serviceHourEditsd), at: 0)
                            }else {
                                serviceEditNew.insert(ServiceHourEditProfile.init(day: response.day, schedule: serviceHourEditlv), at: 0)
                            }
                            
                        }else {
                            if response.day == 0 || response.day == 6 {
                                serviceEditNew.append(ServiceHourEditProfile.init(day: response.day, schedule: serviceHourEditsd))
                            }else {
                                serviceEditNew.append(ServiceHourEditProfile.init(day: response.day, schedule: serviceHourEditlv))
                            }
                        }
                    }else {
                        if serviceFinishNew.isEmpty {
                            if response.day == 0 || response.day == 6 {
                                serviceFinishNew.insert(ServiceHourFinReg.init(day: response.day, schedule: serviceHourFinishsd), at: 0)
                            }else {
                                serviceFinishNew.insert(ServiceHourFinReg.init(day: response.day, schedule: serviceHourFinishlv), at: 0)
                            }
                        }else {
                            if response.day == 0 || response.day == 6 {
                                serviceFinishNew.append(ServiceHourFinReg.init(day: response.day, schedule: serviceHourFinishsd))
                            }else {
                                serviceFinishNew.append(ServiceHourFinReg.init(day: response.day, schedule: serviceHourFinishlv))
                            }
                        }
                    }
                    if response.day == 0 || response.day == 6{
                        guard let sdStartHours = hours.hourStart else {return}
                        guard let sdEndtHours = hours.hourEnd else {return}
                        sdHoraryLabel.text = "Sábado a Domingo de \(sdStartHours) a \(sdEndtHours)"
                        
                    }else {
                        guard let lvStartHours = hours.hourStart else {return}
                        guard let lvEndtHours = hours.hourEnd else {return}
                        let getFirstDays = DaysInt.init(rawValue: communityDetail?.serviceHours?.first?.day ?? 1)
                        let getLastDays = DaysInt.init(rawValue: communityDetail?.serviceHours?.last?.day ?? 1)
                        lvFirstDayNew = getFirstDays?.daysString ?? ""
                        lvLastDayNew = getLastDays?.daysString ?? ""
                        lvFirstHourNew = lvStartHours
                        lvLastHourNew = lvEndtHours
                        horaryLabel.text = "\(lvFirstDayNew) a \(lvLastDayNew) de \(lvStartHours) a \(lvEndtHours)"
                    }
                }
            }
            hideLoading()
        }
    }
    
    func communityDataerror(message: String) {
        
    }
    
    func communityActivitiesSucces(response: CommunityGetActivities) {
        communityActivities = response
        
        for response in response {
            serviceDayEdit.removeAll()
            serviceDayFinish.removeAll()
            for days in response.serviceHours ?? [] {
                serviceHourEdit.removeAll()
                serviceHourFinish.removeAll()
                for hours in days.schedules ?? [] {
                    if isEditProfile == true {
                        if serviceHourEdit.isEmpty {
                            if hours.hourStart?.isEmpty == false && hours.hourEnd?.isEmpty == false {
                                serviceHourEdit.insert(ScheduleEditPrifile.init(startHour: hours.hourStart, endHour: hours.hourEnd), at: 0)
                            }
                        }
                    }else {
                        if serviceHourFinish.isEmpty {
                            if hours.hourStart?.isEmpty == false && hours.hourEnd?.isEmpty == false {
                                serviceHourFinish.insert(SchedulefinReg.init(startHour: hours.hourStart, endHour: hours.hourEnd), at: 0)
                            }
                        }
                    }
                }
                if isEditProfile == true {
                    if serviceDayEdit.isEmpty {
                        serviceDayEdit.insert(ServiceHourEditProfile.init(day: days.day, schedule: serviceHourEdit), at: 0)
                    }else {
                        serviceDayEdit.append(ServiceHourEditProfile.init(day: days.day, schedule: serviceHourEdit))
                    }
                    
                }else {
                    if serviceDayFinish.isEmpty {
                        serviceDayFinish.insert(ServiceHourFinReg.init(day: days.day, schedule: serviceHourFinish), at: 0)
                    }else {
                        serviceDayFinish.append(ServiceHourFinReg.init(day: days.day, schedule: serviceHourFinish))
                    }
                }
            }
            print("ç", serviceDayEdit, serviceDayEdit.count)
            arrayOfArrayServices.append(serviceDayEdit)
            if isEditProfile == true {
                if activityEditNew.isEmpty {
                    activityEditNew.insert(ActivityEditProfile.init(name: response.name, gearedToward: response.gearedToward, activityDescription: response.communityGetActivityDescription, serviceHours: serviceDayEdit), at: 0)
                }else {
                    activityEditNew.append(ActivityEditProfile.init(name: response.name, gearedToward: response.gearedToward, activityDescription: response.communityGetActivityDescription, serviceHours: serviceDayEdit))
                }
            }else {
                if activityFinishNew.isEmpty {
                    activityFinishNew.insert(ActivityFinReg.init(name: response.name, gearedToward: response.gearedToward, activityDescription: response.communityGetActivityDescription, serviceHours: serviceDayFinish), at: 0)
                }else {
                    activityFinishNew.append(ActivityFinReg.init(name: response.name, gearedToward: response.gearedToward, activityDescription: response.communityGetActivityDescription, serviceHours: serviceDayFinish))
                }
            }
        }
        DispatchQueue.main.async { [self] in
            if response.isEmpty {
                switch profileRole {
                case UserProfileEnum.AdministradorComunidad.rawValue, UserProfileEnum.ResponsableComunidad.rawValue:
                    servicesContainer.isHidden = false
                default :
                    servicesContainer.isHidden = true
                }
            }
            serviceTableView.reloadData()
        }
    }
    
    func communityActivitiesError(message: String) {
        servicesContainer.isHidden = true
    }
    
    func succesSaveData() {
        DispatchQueue.main.async { [self] in
            //            SuceesAllert.instance.showAllert()
            //            SuceesAllert.instance.delegate = self
            let alert = AlertCommunity.showAlert(communityName: chourchNameLabel.text ?? "")
            alert.modalPresentationStyle = .overFullScreen
            alert.transitioningDelegate = self
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func errorsaveData() {
        DispatchQueue.main.async { [self] in
            let alert = UIAlertController(title: "Error", message: "Error en el servico, intenta de nuevo más tarde", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertAction.Style.default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    
    func successAddFavorite() {
        DispatchQueue.main.async { [self] in
            if isFavorite == true {
                aditButton.setImage(UIImage(named: "fav", in: Bundle.local, compatibleWith: nil), for: .normal)
            }else {
                aditButton.setImage(UIImage(named: "unfav", in: Bundle.local, compatibleWith: nil), for: .normal)
            }
        }
    }
    
    func errorAddFavorite() {
        
    }
    func communityComentsSucess(response: Comments) {
        communityComments = response
        DispatchQueue.main.async { [self] in
            //            if communityComments == nil {
            //                commentsContainer.isHidden = true
            //            }
            
            if response.my_review != nil {
                let myComment = CommentsList(id: response.my_review?.id, review: response.my_review?.review, creation_date: response.my_review?.creation_date, rating: response.my_review?.rating, devotee: response.my_review?.devotee)
                arrayComments.append(myComment)
            }
            
            response.other_reviews?.forEach({ item in
                arrayComments.append(item)
            })
            
            var ratings: [Double] = []
            arrayComments.forEach({ item in
                ratings.append(item.rating ?? 0.0)
            })
            calculateRating(arrayRating: ratings)
            if ratings.count == 1 {
                lblNmberComments.text = "1 comentario"
            }else{
                lblNmberComments.text = "\(ratings.count) comentarios"
            }
            commentsTableView.reloadData()
        }
    }
    
    func communityComentsError(message: String) {
        //        DispatchQueue.main.async { [self] in
        //            commentsContainer.isHidden = true
        //        }
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
            commentsContainer.isHidden = true
        }
    }
    
    @IBAction func principalComButtonAction(_ sender: Any) {
        if isFavorite == true {
            presenter?.removeFavorite(id: userId, locationId: id ?? 1, isPrincipal: true)
            isFavorite = false
            pricipalComButton.setTitle("Hacer comunidad principal", for: .normal)
        }else {
            presenter?.addFavorite(id: userId, locationId: id ?? 1, isPrincipal: true)
            isFavorite = true
            pricipalComButton.setTitle("Quitar comunidad principal", for: .normal)
        }
    }
    @IBAction func addImageActionButton(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = false
            present(imagePicker, animated: true, completion: nil)
        }
    }
    @IBAction func additButtonAction(_ sender: Any) {
        if communityLocationID == id {
            RegisterFirmulary.instance.showAllert()
            RegisterFirmulary.instance.delegate = self
            RegisterFirmulary.instance.delegateData = self
            RegisterFirmulary.instance.nameTextField.text = nameNew
            RegisterFirmulary.instance.descriptionTextField.text = descriptionNew
            RegisterFirmulary.instance.institutinTextField.text = intitutionNew
            RegisterFirmulary.instance.charismaTextField.text = charismNew
            RegisterFirmulary.instance.responsableTextField.text = resposableNew
            RegisterFirmulary.instance.addressTextField.text = addressNew
            if RegisterFirmulary.instance.addressTextField.text != "" {
                RegisterFirmulary.instance.addPinToMap()
            }
            RegisterFirmulary.instance.lvTextField.text = "\(lvFirstDayNew) \(lvLastDayNew)"
            RegisterFirmulary.instance.lvHourTextField.text = "\(lvFirstHourNew.lowercased())   \(lvLastHourNew.lowercased())"
            RegisterFirmulary.instance.sdTextField.text = "sábado  domingo"
            RegisterFirmulary.instance.sdHourTextField.text = "\(communityDetail?.serviceHours?.last?.schedules?.first?.hourStart ?? "")   \(communityDetail?.serviceHours?.last?.schedules?.first?.hourEnd ?? "")"
            RegisterFirmulary.instance.emailTextField.text = emailNew
            RegisterFirmulary.instance.phoneTextField.text = phoneNew
            let mainViewHeight = view.frame.size.height
            RegisterFirmulary.instance.parentView.frame = CGRect(x: 0, y: mainViewHeight - 800, width: self.view.frame.width, height: RegisterFirmulary.instance.parentView.frame.height)
            parentView.isUserInteractionEnabled = false
            parentView.alpha = 0.5
        }else {
            if isFavorite == true {
                if isPrincipal == false {
                    presenter?.removeFavorite(id: userId, locationId: id ?? 1, isPrincipal: false)
                    isFavorite = false
                }else {
                    //                    presenter?.removeFavorite(id: userId, locationId: id ?? 1, isPrincipal: true)
                    //                    isFavorite = false
                }
            }else {
                if isPrincipal == false {
                    presenter?.addFavorite(id: userId, locationId: id ?? 1, isPrincipal: false)
                    isFavorite = true
                }else {
                    //                    presenter?.addFavorite(id: userId, locationId: id ?? 1, isPrincipal: true)
                    //                    isFavorite = true
                }
            }
        }
    }
    @IBAction func callChuirchButonAction(_ sender: Any) {
        makePhoneCall(phoneNumber: phone ?? "")
    }
    @IBAction func sendMail(_ sender: Any) {
        let mailCompose = sendMail()
        if MFMailComposeViewController.canSendMail() {
            self.present(mailCompose, animated: true, completion: nil)
        }else {
        }
    }
    @IBAction func goButtonAction(_ sender: Any) {
        goToMap()
    }
    @IBAction func addSocialButtonAction(_ sender: Any) {
        goToAddSocial()
    }
    
    func goToAddSocial() {
        let storyboard = UIStoryboard(name: "AddSocial", bundle: Bundle.local)
        if let newAddSocial: NewAddSocialController = storyboard.instantiateViewController(withIdentifier: "NewAddSocial") as? NewAddSocialController {
            newAddSocial.delegate = self
            newAddSocial.modalPresentationStyle = .overFullScreen
            self.present(newAddSocial, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func addServiceButtonAction(_ sender: Any) {
        AddService.instance.showAllert()
        AddService.instance.delegate = self
        let mainViewHeight = view.frame.size.height
        AddService.instance.parentView.frame = CGRect(x: 0, y: mainViewHeight - 450, width: self.view.frame.width, height: AddService.instance.parentView.frame.height)
        parentView.isUserInteractionEnabled = false
        parentView.alpha = 0.5
    }
    @IBAction func addCommunityButtonAction(_ sender: Any) {
        AddCommunities.instance.showAllert()
        AddCommunities.instance.delegate = self
        AddCommunities.instance.delegatedata = self
        parentView.isUserInteractionEnabled = false
        parentView.alpha = 0.5
    }
    @IBAction func saveButtonAction(_ sender: Any) {
        if isEditProfile == true {
            presenter?.saveEditRegister(id: id ?? 1, typeId: typeId, description: descriptionNew, charisma: charismNew, address: addressNew, longitude: longitudeNew, latitude: latitudeNew, email: emailNew, phone: phoneNew, website: webNew, instagram: instaNew, twitter: twittNew, facebook: faceNew, streaming: streamNew, service: serviceEditNew, activity: activityEditNew)
        }else {
            if charismNew == "" || descriptionNew == "" || addressNew == "" || latitudeNew == 0 || longitudeNew == 0 || emailNew == "" || phoneNew == ""  {
                DispatchQueue.main.async { [self] in
                    let alert = UIAlertController(title: "Alerta", message: "Faltan datos por llenar", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertAction.Style.default, handler: nil))
                    present(alert, animated: true, completion: nil)
                }
            }else {
                presenter?.saveFinishRegister(id: id ?? 1, description: descriptionNew, charisma: charismNew, address: addressNew, longitude: longitudeNew, latitude: latitudeNew, email: emailNew, phone: phoneNew, website: webNew, instagram: instaNew, twitter: twittNew, facebook: faceNew, streaming: streamNew , service: serviceFinishNew, activity: activityFinishNew, linkCom: linkComNew)
            }
        }
    }
    
    
    @IBAction func cancelButtonAction(_ sender: Any) {
        CancelRegister.instance.showAllert()
        CancelRegister.instance.delegate = self
    }
    @IBAction func backButtonAction(_ sender: Any) {
        //let view = MyChurchesWireFrame.getController()
        // self.navigationController?.popToViewController(view, animated: true)
        //self.navigationController?.pushViewController(view, animated: true)
        // navigationController?.popToViewController(view, animated: true)
        self.navigationController?.popViewController(animated: true)
        // self.view.window?.rootViewController?.navigationController?.popToViewController(view, animated: true)
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
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imagePicker.dismiss(animated: true, completion: nil)
        guard let image = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        //  mainImageView.image = image
        //let defaults = UserDefaults.standard
        //let idUser = defaults.integer(forKey: "id")
        let imgBase64 = convertImageToBase64String(img: image)
        let last10 = String(imgBase64.suffix(8))
        print(last10)
        let myString = last10
        let replaced = myString.replacingOccurrences(of: "=", with: "")
        print(replaced)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.showLoading()
            // self.present(self.loadingAlert, animated: true, completion: nil)
        }
        presenter?.uploadImgBase64(elementID: id ?? 0, tytpe: "LOCATION", filename: "iglesia\(replaced).jpg", contentBase64: imgBase64)
        
    }
    
    @IBAction func goToComments(_ sender: Any) {
        arrayComments.removeAll()
        let view = CommentsRouter.createModule(param: "\(id ?? 1)/reviews", locationID: id ?? 1, churchName: chourchNameLabel.text ?? "")
        self.navigationController?.pushViewController(view, animated: true)
    }
    
    
    func convertImageToBase64String(img: UIImage) -> String {
        let imageData: Data? = img.jpegData(compressionQuality: 0.4)
        let imageStr = imageData?.base64EncodedString(options: .lineLength64Characters) ?? ""
        return imageStr
    }
    
    
    func succesUploadImg(data: UploadImageData) {
        mainImageView.DownloadStaticImage(data.url ?? "")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.loadingAlert.dismiss(animated: true, completion: nil)
        }
    }
    
    func failUploadImg() {
        self.loadingAlert.dismiss(animated: true, completion: nil)
    }
    
    func makePhoneCall(phoneNumber: String) {
        let fixPhoneNumber = phoneNumber.replacingOccurrences(of: "-|\\s+|\\s+|\\s+$", with: "", options: .regularExpression, range: nil)
        guard let phoneURL = URL(string: "tel://" + fixPhoneNumber) else{return}
        UIApplication.shared.open(phoneURL, options: [:], completionHandler: nil)
    }
    
    private func sendMail() -> MFMailComposeViewController {
        let mailComposeVC = MFMailComposeViewController()
        let mailRep = email
        mailComposeVC.mailComposeDelegate = self
        mailComposeVC.setToRecipients(["\(mailRep ?? "")"])
        mailComposeVC.setSubject("Contacto")
        mailComposeVC.setMessageBody("", isHTML: false)
        return mailComposeVC
    }
    
    func goToMap() {
        guard let latitud =  latitude else {return}
        guard let longitude =  longitude else {return}
        
        let coordinates = CLLocationCoordinate2D(latitude: CLLocationDegrees(CGFloat(latitud)), longitude: CLLocationDegrees(CGFloat(longitude)))
        
        let mapsAlert = UIAlertController(title: "Iglesia Digital", message: "Selecciona una opción", preferredStyle: .actionSheet)
        let appleMaps = UIAlertAction(title: "Apple Maps", style: .default) {
            _ in
            let churchMapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinates))
            churchMapItem.name = ""
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
}

//MARK:- TableViewDelegate
extension CommunitiesMainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == socialTableView{
            return socialData.count
        }else if tableView == serviceTableView{
            return communityActivities?.count ?? 0
        }else if tableView == commentsTableView {
            return arrayComments.count
        }else {
            return linkComNew.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == socialTableView {
            print("````", socialData)
            if socialIdentifier.count != 0 {
                cardSocial.alpha = 1
            }
            let cell = socialTableView.dequeueReusableCell(withIdentifier: SocialTableViewCell.reuseIdentifier, for: indexPath) as! SocialTableViewCell
            cell.titleLabel.text = socialData[indexPath.row]
            cell.selectionStyle = .none
            switch profileRole {
            case UserProfileEnum.AdministradorComunidad.rawValue, UserProfileEnum.ResponsableComunidad.rawValue:
                cell.deleteButton.isHidden = false
            default :
                cell.deleteButton.isHidden = true
            }
            switch socialIdentifier[indexPath.row] {
            case "F":
                cell.iconImage.image = UIImage(named: "facebookIcon", in: Bundle(for: CommunitiesMainViewController.self), compatibleWith: nil)
            case "T":
                cell.iconImage.image = UIImage(named: "tuitterIcon", in: Bundle(for: CommunitiesMainViewController.self), compatibleWith: nil)
            case "I":
                cell.iconImage.image = UIImage(named: "instagramIcon", in: Bundle(for: CommunitiesMainViewController.self), compatibleWith: nil)
            case "W":
                cell.iconImage.image = UIImage(named: "webIcon", in: Bundle(for: CommunitiesMainViewController.self), compatibleWith: nil)
            case "S":
                cell.iconImage.image = UIImage(named: "streamIcon", in: Bundle(for: CommunitiesMainViewController.self), compatibleWith: nil)
            default:
                break
            }
            //cell.iconImage.image = UIImage(named: socialIcon[indexPath.row], in: Bundle(for: CommunitiesMainViewController.self), compatibleWith: nil)
            socialTableHeight.constant = cell.frame.height * CGFloat(socialData.count)
            return cell
        }else if tableView == serviceTableView {
            switch communityActivities?[indexPath.row].serviceHours?.count {//indexPath.row {
            case 1:
                let cell = serviceTableView.dequeueReusableCell(withIdentifier: ServiceTableViewCell.reuseIdentifier, for: indexPath) as! ServiceTableViewCell
                cell.backCard.layer.cornerRadius = 10
                cell.backCard.ShadowCard()
                cell.cardView.layer.cornerRadius = 10
                cell.cardView.clipsToBounds = true
                cell.selectionStyle = .none
                cell.titleLabel.text = communityActivities?[indexPath.row].name
                servicesTableHeight.constant = cell.frame.height * CGFloat(communityActivities?.count ?? 0)
                switch profileRole {
                case UserProfileEnum.AdministradorComunidad.rawValue, UserProfileEnum.ResponsableComunidad.rawValue:
                    cell.btnDelete.isHidden = false
                default :
                    cell.btnDelete.isHidden = true
                }
                var serviceDay: String{
                    switch communityActivities?[indexPath.row].serviceHours?[0].day {
                    case 0:
                        return "Domingo"
                    case 1:
                        return "Lunes"
                    case 2:
                        return "Martes"
                    case 3:
                        return "Miercoles"
                    case 4:
                        return "Jueves"
                    case 5:
                        return "Viernes"
                    case 6:
                        return "Sábado"
                    default:
                        return ""
                    }
                }
                cell.lblMainTitle.text = serviceDay
                cell.firstLabel.text = communityActivities?[indexPath.row].gearedToward
                cell.lblSecond.text = communityActivities?[indexPath.row].communityGetActivityDescription
                if communityActivities?[indexPath.row].serviceHours?[0].schedules?.count != 0 {
                    let startHour = communityActivities?[indexPath.row].serviceHours?[0].schedules?[0].hourStart
                    let endHour = communityActivities?[indexPath.row].serviceHours?[0].schedules?[0].hourEnd
                    
                    cell.lblHour.text = "\(startHour ?? "") a \(endHour ?? "")"
                    
                }
                //   cell.descriptionLabel.text = communityActivities?[indexPath.row].communityGetActivityDescription
                //                cell.audienceLabel.text = communityActivities?[indexPath.row - 1].gearedToward
                //                if userRole == "Fiel" {
                //                    cell.deleteButton.isHidden = true
                //                }
                return cell
                
            default:
                
                let cellH = serviceTableView.dequeueReusableCell(withIdentifier: "CELLHORIZONTAL", for: indexPath) as! HorizontalServiceSection
                cellH.initCollectionView(data: communityActivities ?? [], hourServices: communityActivities?[indexPath.row].serviceHours ?? [], indexTable: indexPath)
                cellH.mainTitle.text = communityActivities?[indexPath.row].name
                cellH.delegate = self
                return cellH
                
            }
            
        }else if tableView == addCommunitiesTableView {
            let cell = addCommunitiesTableView.dequeueReusableCell(withIdentifier: AddCommunitiesTableViewCell.reuseIdentifier, for: indexPath) as! AddCommunitiesTableViewCell
            cell.titleLabel.text = linkComNew[indexPath.row].name
            cell.subTitleLabel.text = linkComNew[indexPath.row].leader
            return cell
        }else if tableView == commentsTableView {
            let cell = commentsTableView.dequeueReusableCell(withIdentifier: "CommetsComCell", for: indexPath) as! CmmunityCommentsTableViewCell
            cell.commentsCard.layer.cornerRadius = 10
            cell.commentsCard.ShadowCard()
            
            let url = URL(string: arrayComments[indexPath.row].devotee?.image_url ?? "")
            cell.commentImage?.af.setImage(withURL: url ?? URL(fileURLWithPath: ""))
            cell.titleLabel.text = "\(arrayComments[indexPath.row].devotee?.name ?? "") \(arrayComments[indexPath.row].devotee?.first_surname ?? "") \(arrayComments[indexPath.row].devotee?.second_surname ?? "")"
            cell.commentLabel?.text = arrayComments[indexPath.row].review
            cell.selectionStyle = .none
            cell.commentImage.layer.cornerRadius = cell.commentImage.bounds.width / 2
            let count = arrayComments.count
            commetsTableHeight.constant = CGFloat(124 * count)
            cell.daysLabel.text = timeInterval(timeAgo: arrayComments[indexPath.row].creation_date ?? "")
            
//            let isoDate = arrayComments[indexPath.row].creation_date ?? ""
//            let dateFormatterGet = DateFormatter()
//            dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
//
//            let dateFormatterPrint = DateFormatter()
//            dateFormatterPrint.dateFormat = "MMM dd,yyyy"
//
//            if let date = dateFormatterGet.date(from: isoDate) {
//                print(dateFormatterPrint.string(from: date), "????", dateFormatterGet.string(from: date))
//                cell.daysLabel.text = date.timeAgoDisplay()
//
//            } else {
//                print("There was an error decoding the string", "????")
//            }
            
            let imgFill = UIImage(named: "Trazado 6941", in: Bundle.local, compatibleWith: nil)
            let rating = arrayComments[indexPath.row].rating ?? 0.0
            if #available(iOS 13.0, *) {
                if rating == 0.0 {
                }else if rating <= 1.0 {
                    cell.star1.image = imgFill
                }else if rating  <= 2.0 {
                    cell.star1.image = imgFill
                    cell.star2.image = imgFill
                }else if rating <= 3.0 {
                    cell.star1.image = imgFill
                    cell.star2.image = imgFill
                    cell.star3.image = imgFill
                }else if rating <= 4.0 {
                    cell.star1.image = imgFill
                    cell.star2.image = imgFill
                    cell.star3.image = imgFill
                    cell.star4.image = imgFill
                }else if rating <= 5.0 {
                    cell.star1.image = imgFill
                    cell.star2.image = imgFill
                    cell.star3.image = imgFill
                    cell.star4.image = imgFill
                    cell.star5.image = imgFill
                }
                
            }
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch profileRole {
        case UserProfileEnum.AdministradorComunidad.rawValue, UserProfileEnum.ResponsableComunidad.rawValue, UserProfileEnum.MiembroComunidad.rawValue:
            if tableView == socialTableView {
                let index = indexPath.row
                switch socialIdentifier[index] {
                case "F":
                    faceNew = ""
                    socialData.remove(at: index)
                    socialIdentifier.remove(at: index)
                case "T":
                    twittNew = ""
                    socialData.remove(at: index)
                    socialIdentifier.remove(at: index)
                case "I":
                    instaNew = ""
                    socialData.remove(at: index)
                    socialIdentifier.remove(at: index)
                case "S":
                    streamNew = ""
                    socialData.remove(at: index)
                    socialIdentifier.remove(at: index)
                case "W":
                    webNew = ""
                    socialData.remove(at: index)
                    socialIdentifier.remove(at: index)
                default:
                    break
                }
                socialTableView.reloadData()
                if socialIdentifier.count == 0 {
                    cardSocial.alpha = 0
                }
            }else if tableView == serviceTableView {
                let index = indexPath.item
                communityActivities?.remove(at: index)
                if isEditProfile == true {
                    activityEditNew.remove(at: index)
                }else {
                    activityFinishNew.remove(at: index)
                }
                serviceTableView.reloadData()
            }else {
                
            }
        default:
            break
        }
    }
    
}
//MARK:- SuccessAllertButtonDelegate
extension CommunitiesMainViewController: SuccessAllertButtonDelegate {
    func didPressYesSuccessAllertButton(_ sender: UIButton) {
        SuceesAllert.instance.parentView.removeFromSuperview()
        navigationController?.popViewController(animated: true)
    }
}

//MARK:- Add Community Delegate
extension CommunitiesMainViewController: AddCommunitiesModalButtonDelegate, AddComDataSendingDelegateProtocol {
    func sendDatAddComToComMainViewController(array: [LinkedCommunity]) {
        linkComNew = array
        if linkComNew.isEmpty == false {
            addCommunitiesTableView.isHidden = false
            addCommunitiesTableView.reloadData()
        }
    }
    
    func didPressAddComButton(_ sender: UIButton) {
        self.showToast(message: "Comunidad agregada con éxito", seconds: 1.0)
    }
    
    func didPressReadyRegisterButton(_ sender: UIButton) {
        AddCommunities.instance.parentView.removeFromSuperview()
        parentView.isUserInteractionEnabled = true
        parentView.alpha = 1
    }
}

//MARK:- CancelRegisterAllertButtonDelegate
extension CommunitiesMainViewController: CancelRegisterAllertButtonDelegate {
    func didPressYesCancelRegisterButton(_ sender: UIButton) {
        CancelRegister.instance.parentView.removeFromSuperview()
    }
}

//MARK:- Mail Extension
extension CommunitiesMainViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}
//MARK:- Register Formulary Delegate
extension CommunitiesMainViewController: RefisterFormularyButtonDelegate, RegisterFormDataSendingDelegateProtocol {
    func sendDataFormToComMainViewController(name: String, intitution: String, charism: String, resposable: String, description: String, address: String, lvText: String, lvHour: String, sdText: String, sdHour: String, email: String, phone: String, latitude: Double, longitude: Double) {
        var daylv: [Int] {
            switch lvText {
            case "lunes  martes" : return [1, 2]
            case "lunes  miércoles": return [1, 2, 3]
            case "lunes  jueves": return [1, 2, 3, 4]
            case "lunes  viernes" : return [1, 2, 3, 4, 5]
            case "lunes  sábado": return [1, 2, 3, 4, 5, 6]
            case "lunes  domingo": return [1, 2, 3, 4, 5, 6, 0]
            case "martes  miércoles": return [2, 3]
            case "martes  jueves": return [2, 3, 4]
            case "martes  viernes": return [2, 3, 4, 5]
            case "martes  sábado": return [2, 3, 4, 5, 6]
            case "martes  domingo": return [2, 3, 4, 5, 6, 0]
            case "Martes  lunes": return [1, 2, 3, 4, 5, 6, 0]
            case "miércoles  jueves": return [3, 4]
            case "miércoles  viernes":  return [3, 4, 5]
            case "miércoles  sábado": return [3, 4, 5, 6]
            case "miércoles  domingo": return [3, 4, 5, 6, 0]
            case "miércoles  lunes": return [1, 3, 4, 5, 6, 0]
            case "miércoles  martes": return [1, 2, 3, 4, 5, 6, 0]
            case "jueves  viernes": return [4, 5]
            case "jueves  sábado": return [4, 5, 6]
            case "jueves  domingo": return [4, 5, 6, 0]
            case "jueves  lunes": return [1, 4, 5, 6, 0]
            case "jueves  martes": return [1, 2, 4, 5, 6, 0]
            case "jueves  miércoles": return [1, 2, 3, 4, 5, 6, 0]
            case "viernes  sábado": return [5, 6]
            case "viernes  domingo": return [5, 6, 0]
            case "viernes  lunes": return [1, 5, 6, 0]
            case "viernes  martes": return [1, 2, 5, 6, 0]
            case "viernes  miércoles": return [1, 2, 3, 5, 6, 0]
            case "viernes  jueves": return [1, 2, 3, 4, 5, 6, 0]
            case "sábado  domingo": return [6, 0]
            case "sábado  lunes": return [1, 6, 0]
            case "sábado  martes": return [1, 2, 6, 0]
            case "sábado  miércoles": return [1, 2, 3, 6, 0]
            case "sábado  jueves": return [1, 2, 3, 4, 6, 0]
            case "sábado  viernes": return [1, 2, 3, 4, 5, 6, 0]
            case "domingo  lunes": return [1, 0]
            case "domingo  martes": return [1, 2, 0]
            case "domingo  miércoles": return [1, 2, 3, 0]
            case "domingo  jueves": return [1, 2, 3, 4, 0]
            case "domingo  viernes": return [1, 2, 3, 4, 5, 0]
            case "domingo  sábado": return [1, 2, 3, 4, 5, 6, 0]
            default:
                return [1, 2, 3, 4, 5, 6, 0]
            }
        }
        var daysd: [Int] {
            switch sdText {
            case "Domingo":
                return [0, 6]
            case "Sabado":
                return [0, 6]
            default:
                return [0, 6]
            }
        }
        let hoursStringArray = lvHour.components(separatedBy: " ")
        let hoursSdStringArray = sdHour.components(separatedBy: " ")
        //lvInt = daylv
        if RegisterFirmulary.instance.institutinTextField.text?.isEmpty == false {
            intitutionNew = intitution
        }
        if RegisterFirmulary.instance.charismaTextField.text?.isEmpty == false {
            charismNew = charism
        }
        if RegisterFirmulary.instance.responsableTextField.text?.isEmpty == false {
            resposableNew = resposable
        }
        if RegisterFirmulary.instance.nameTextField.text?.isEmpty == false {
            nameNew = name
            chourchNameLabel.text = nameNew
        }
        if RegisterFirmulary.instance.descriptionTextField.text?.isEmpty == false {
            descriptionNew = description
            descriptinLabel.text = description
        }
        if RegisterFirmulary.instance.emailTextField.text?.isEmpty == false {
            emailNew = email
            emailLabel.text = email
        }
        if RegisterFirmulary.instance.phoneTextField.text?.isEmpty == false {
            phoneNew = phone
            phoneLabel.text = phone
        }
        if RegisterFirmulary.instance.addressTextField.text?.isEmpty == false {
            addressNew = address
            latitudeNew = latitude
            longitudeNew = longitude
            addressLabel.text = address
        }
        
        if RegisterFirmulary.instance.lvHourTextField.text?.isEmpty == false && RegisterFirmulary.instance.sdHourTextField.text?.isEmpty == false && RegisterFirmulary.instance.lvTextField.text?.isEmpty == false && RegisterFirmulary.instance.sdTextField.text?.isEmpty == false {
            serviceHourEditlv.removeAll()
            serviceHourEditsd.removeAll()
            serviceHourFinishlv.removeAll()
            serviceHourFinishsd.removeAll()
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
            if isEditProfile == true{
                if serviceHourEdit.isEmpty {
                    serviceHourEditlv.insert(ScheduleEditPrifile.init(startHour: hoursStringArray[0], endHour: getHoraryData), at: 0)
                    serviceHourEditsd.insert(ScheduleEditPrifile.init(startHour: hoursSdStringArray[0], endHour: getHorarySDData), at: 0)
                }else {
                    serviceHourEditlv.append(ScheduleEditPrifile.init(startHour: hoursStringArray[0], endHour: getHoraryData))
                    serviceHourEditsd.append(ScheduleEditPrifile.init(startHour: hoursSdStringArray[0], endHour: getHorarySDData))
                }
            }else {
                if serviceHourFinish.isEmpty {
                    serviceHourFinishlv.insert(SchedulefinReg.init(startHour: hoursStringArray[0], endHour: getHoraryData), at: 0)
                    serviceHourFinishsd.insert(SchedulefinReg.init(startHour: hoursSdStringArray[0], endHour: getHorarySDData), at: 0)
                }else {
                    serviceHourFinishlv.append(SchedulefinReg.init(startHour: hoursStringArray[0], endHour: getHoraryData))
                    serviceHourFinishsd.append(SchedulefinReg.init(startHour: hoursSdStringArray[0], endHour: getHorarySDData))
                }
            }
            sdHoraryLabel.text = "Sábado a Domingo de \(hoursSdStringArray[0]) a \( getHorarySDData)"
            horaryLabel.text = "\(lvText) de \(hoursStringArray[0]) a \(getHoraryData)"
        }
        if RegisterFirmulary.instance.sdTextField.text?.isEmpty == false && RegisterFirmulary.instance.lvTextField.text?.isEmpty == false {
            serviceEditNew.removeAll()
            serviceFinishNew.removeAll()
            if isEditProfile == true {
                if serviceEditNew.isEmpty {
                    for days in daylv {
                        serviceEditNew.insert(ServiceHourEditProfile.init(day: days, schedule: serviceHourEditlv), at: 0)
                    }
                    for days in daysd {
                        serviceEditNew.insert(ServiceHourEditProfile.init(day: days, schedule: serviceHourEditsd), at: 0)
                    }
                    
                }else {
                    for days in daylv {
                        serviceEditNew.append(ServiceHourEditProfile.init(day: days, schedule: serviceHourEditlv))
                    }
                    for days in daysd {
                        serviceEditNew.append(ServiceHourEditProfile.init(day: days, schedule: serviceHourEditsd))
                    }
                }
            }else {
                if serviceFinishNew.isEmpty {
                    for days in daylv {
                        serviceFinishNew.insert(ServiceHourFinReg.init(day: days, schedule: serviceHourFinishlv), at: 0)
                    }
                    for days in daysd {
                        serviceFinishNew.insert(ServiceHourFinReg.init(day: days, schedule: serviceHourFinishsd), at: 0)
                    }
                }else {
                    for days in daylv {
                        serviceFinishNew.append(ServiceHourFinReg.init(day: days, schedule: serviceHourFinishlv))
                    }
                    for days in daysd {
                        serviceFinishNew.append(ServiceHourFinReg.init(day: days, schedule: serviceHourFinishsd))
                    }
                }
            }
        }
    }
    func didPressReadyFormularyButton(_ sender: UIButton){
        RegisterFirmulary.instance.parentView.removeFromSuperview()
        parentView.isUserInteractionEnabled = true
        parentView.alpha = 1
    }
}

//MARK:- Add Service Delegate
extension CommunitiesMainViewController: AddServiceModalButtonDelegate {
    func didPressReadyServiceButton(_ sender: UIButton) {
        var daysActive: [Int] {
            switch AddService.instance.daysTextField.text{
            case "lunes  martes" : return [1, 2]
            case "lunes  miércoles": return [1, 2, 3]
            case "lunes  jueves": return [1, 2, 3, 4]
            case "lunes  viernes" : return [1, 2, 3, 4, 5]
            case "lunes  sábado": return [1, 2, 3, 4, 5, 6]
            case "lunes  domingo": return [1, 2, 3, 4, 5, 6, 0]
            case "martes  miércoles": return [2, 3]
            case "martes  jueves": return [2, 3, 4]
            case "martes  viernes": return [2, 3, 4, 5]
            case "martes  sábado": return [2, 3, 4, 5, 6]
            case "martes  domingo": return [2, 3, 4, 5, 6, 0]
            case "Martes  lunes": return [1, 2, 3, 4, 5, 6, 0]
            case "miércoles  jueves": return [3, 4]
            case "miércoles  viernes":  return [3, 4, 5]
            case "miércoles  sábado": return [3, 4, 5, 6]
            case "miércoles  domingo": return [3, 4, 5, 6, 0]
            case "miércoles  lunes": return [1, 3, 4, 5, 6, 0]
            case "miércoles  martes": return [1, 2, 3, 4, 5, 6, 0]
            case "jueves  viernes": return [4, 5]
            case "jueves  sábado": return [4, 5, 6]
            case "jueves  domingo": return [4, 5, 6, 0]
            case "jueves  lunes": return [1, 4, 5, 6, 0]
            case "jueves  martes": return [1, 2, 4, 5, 6, 0]
            case "jueves  miércoles": return [1, 2, 3, 4, 5, 6, 0]
            case "viernes  sábado": return [5, 6]
            case "viernes  domingo": return [5, 6, 0]
            case "viernes  lunes": return [1, 5, 6, 0]
            case "viernes  martes": return [1, 2, 5, 6, 0]
            case "viernes  miércoles": return [1, 2, 3, 5, 6, 0]
            case "viernes  jueves": return [1, 2, 3, 4, 5, 6, 0]
            case "sábado  domingo": return [6, 0]
            case "sábado  lunes": return [1, 6, 0]
            case "sábado  martes": return [1, 2, 6, 0]
            case "sábado  miércoles": return [1, 2, 3, 6, 0]
            case "sábado  jueves": return [1, 2, 3, 4, 6, 0]
            case "sábado  viernes": return [1, 2, 3, 4, 5, 6, 0]
            case "domingo  lunes": return [1, 0]
            case "domingo  martes": return [1, 2, 0]
            case "domingo  miércoles": return [1, 2, 3, 0]
            case "domingo  jueves": return [1, 2, 3, 4, 0]
            case "domingo  viernes": return [1, 2, 3, 4, 5, 0]
            case "domingo  sábado": return [1, 2, 3, 4, 5, 6, 0]
            default:
                return [1, 2, 3, 4, 5, 6, 0]
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
        if isEditProfile == true {
            serviceDayEdit.removeAll()
            serviceHourEdit.removeAll()
            if serviceHourEdit.isEmpty {
                if AddService.instance.hourStruct.isEmpty == false {
                    serviceHourEdit.insert(ScheduleEditPrifile.init(startHour:  hoursStringArray[0], endHour:  getHoraryData), at: 0)
                }
            }
            for days in  daysActive {
                if serviceDayEdit.isEmpty {
                    serviceDayEdit.insert(ServiceHourEditProfile.init(day: days, schedule: serviceHourEdit), at: 0)
                }else {
                    serviceDayEdit.append(ServiceHourEditProfile.init(day: days, schedule: serviceHourEdit))
                }
            }
            if activityEditNew.isEmpty {
                activityEditNew.insert(ActivityEditProfile.init(name: AddService.instance.nameServiceTextField.text, gearedToward:  AddService.instance.audienceTextField.text, activityDescription:  AddService.instance.descriptionTextField.text, serviceHours: serviceDayEdit), at: 0)
            }else {
                activityEditNew.append(ActivityEditProfile.init(name:  AddService.instance.nameServiceTextField.text,  gearedToward:  AddService.instance.audienceTextField.text, activityDescription:  AddService.instance.descriptionTextField.text, serviceHours: serviceDayEdit))
            }
        }else {
            serviceDayFinish.removeAll()
            serviceHourFinish.removeAll()
            if serviceHourFinish.isEmpty {
                if AddService.instance.hourStruct.isEmpty == false {
                    serviceHourFinish.insert(SchedulefinReg.init(startHour:  hoursStringArray[0], endHour:  getHoraryData), at: 0)
                }
            }
            for days in  daysActive {
                if serviceDayFinish.isEmpty {
                    serviceDayFinish.insert(ServiceHourFinReg.init(day: days, schedule: serviceHourFinish), at: 0)
                }else {
                    serviceDayFinish.append(ServiceHourFinReg.init(day: days, schedule: serviceHourFinish))
                }
            }
            if activityFinishNew.isEmpty {
                activityFinishNew.insert(ActivityFinReg.init(name:  AddService.instance.nameServiceTextField.text, gearedToward:  AddService.instance.audienceTextField.text, activityDescription:  AddService.instance.descriptionTextField.text, serviceHours: serviceDayFinish), at: 0)
            }else {
                activityFinishNew.append(ActivityFinReg.init(name:  AddService.instance.nameServiceTextField.text, gearedToward:  AddService.instance.audienceTextField.text, activityDescription:  AddService.instance.descriptionTextField.text, serviceHours: serviceDayFinish))
            }
        }
        self.showToast(message: "Servicio agregado correctamente", seconds: 1.0)
        serviceTableView.reloadData()
        parentView.isUserInteractionEnabled = true
        parentView.alpha = 1
    }
    
    func didPressAdServicemButton(_ sender: UIButton) {
        var daysActive: [Int] {
            switch AddService.instance.daysTextField.text{
            case "lunes  martes" : return [1, 2]
            case "lunes  miércoles": return [1, 2, 3]
            case "lunes  jueves": return [1, 2, 3, 4]
            case "lunes  viernes" : return [1, 2, 3, 4, 5]
            case "lunes  sábado": return [1, 2, 3, 4, 5, 6]
            case "lunes  domingo": return [1, 2, 3, 4, 5, 6, 0]
            case "martes  miércoles": return [2, 3]
            case "martes  jueves": return [2, 3, 4]
            case "martes  viernes": return [2, 3, 4, 5]
            case "martes  sábado": return [2, 3, 4, 5, 6]
            case "martes  domingo": return [2, 3, 4, 5, 6, 0]
            case "Martes  lunes": return [1, 2, 3, 4, 5, 6, 0]
            case "miércoles  jueves": return [3, 4]
            case "miércoles  viernes":  return [3, 4, 5]
            case "miércoles  sábado": return [3, 4, 5, 6]
            case "miércoles  domingo": return [3, 4, 5, 6, 0]
            case "miércoles  lunes": return [1, 3, 4, 5, 6, 0]
            case "miércoles  martes": return [1, 2, 3, 4, 5, 6, 0]
            case "jueves  viernes": return [4, 5]
            case "jueves  sábado": return [4, 5, 6]
            case "jueves  domingo": return [4, 5, 6, 0]
            case "jueves  lunes": return [1, 4, 5, 6, 0]
            case "jueves  martes": return [1, 2, 4, 5, 6, 0]
            case "jueves  miércoles": return [1, 2, 3, 4, 5, 6, 0]
            case "viernes  sábado": return [5, 6]
            case "viernes  domingo": return [5, 6, 0]
            case "viernes  lunes": return [1, 5, 6, 0]
            case "viernes  martes": return [1, 2, 5, 6, 0]
            case "viernes  miércoles": return [1, 2, 3, 5, 6, 0]
            case "viernes  jueves": return [1, 2, 3, 4, 5, 6, 0]
            case "sábado  domingo": return [6, 0]
            case "sábado  lunes": return [1, 6, 0]
            case "sábado  martes": return [1, 2, 6, 0]
            case "sábado  miércoles": return [1, 2, 3, 6, 0]
            case "sábado  jueves": return [1, 2, 3, 4, 6, 0]
            case "sábado  viernes": return [1, 2, 3, 4, 5, 6, 0]
            case "domingo  lunes": return [1, 0]
            case "domingo  martes": return [1, 2, 0]
            case "domingo  miércoles": return [1, 2, 3, 0]
            case "domingo  jueves": return [1, 2, 3, 4, 0]
            case "domingo  viernes": return [1, 2, 3, 4, 5, 0]
            case "domingo  sábado": return [1, 2, 3, 4, 5, 6, 0]
            default:
                return [1, 2, 3, 4, 5, 6, 0]
            }
        }
        guard let hoursStringArray = AddService.instance.timeTextField.text?.components(separatedBy: " ") else {return}
        var getHoraryData: String {
            if hoursStringArray.count < 4{
                return hoursStringArray[1]
            }else {
                return hoursStringArray[3]
            }
        }
        if isEditProfile == true {
            serviceDayEdit.removeAll()
            serviceHourEdit.removeAll()
            if serviceHourEdit.isEmpty {
                if AddService.instance.hourStruct.isEmpty == false {
                    serviceHourEdit.insert(ScheduleEditPrifile.init(startHour:  hoursStringArray[0], endHour:  getHoraryData), at: 0)
                }
            }
            for days in  daysActive {
                if serviceDayEdit.isEmpty {
                    serviceDayEdit.insert(ServiceHourEditProfile.init(day: days, schedule: serviceHourEdit), at: 0)
                }else {
                    serviceDayEdit.append(ServiceHourEditProfile.init(day: days, schedule: serviceHourEdit))
                }
            }
            if activityEditNew.isEmpty {
                activityEditNew.insert(ActivityEditProfile.init(name: AddService.instance.nameServiceTextField.text, gearedToward:  AddService.instance.audienceTextField.text, activityDescription:  AddService.instance.descriptionTextField.text, serviceHours: serviceDayEdit), at: 0)
            }else {
                activityEditNew.append(ActivityEditProfile.init(name:  AddService.instance.nameServiceTextField.text,  gearedToward:  AddService.instance.audienceTextField.text, activityDescription:  AddService.instance.descriptionTextField.text, serviceHours: serviceDayEdit))
            }
        }else {
            serviceDayFinish.removeAll()
            serviceHourFinish.removeAll()
            if serviceHourFinish.isEmpty {
                if AddService.instance.hourStruct.isEmpty == false {
                    serviceHourFinish.insert(SchedulefinReg.init(startHour:  hoursStringArray[0], endHour:  getHoraryData), at: 0)
                }
            }
            for days in  daysActive {
                if serviceDayFinish.isEmpty {
                    serviceDayFinish.insert(ServiceHourFinReg.init(day: days, schedule: serviceHourFinish), at: 0)
                }else {
                    serviceDayFinish.append(ServiceHourFinReg.init(day: days, schedule: serviceHourFinish))
                }
            }
            if activityFinishNew.isEmpty {
                activityFinishNew.insert(ActivityFinReg.init(name:  AddService.instance.nameServiceTextField.text, gearedToward:  AddService.instance.audienceTextField.text, activityDescription:  AddService.instance.descriptionTextField.text, serviceHours: serviceDayFinish), at: 0)
            }else {
                activityFinishNew.append(ActivityFinReg.init(name:  AddService.instance.nameServiceTextField.text, gearedToward:  AddService.instance.audienceTextField.text, activityDescription:  AddService.instance.descriptionTextField.text, serviceHours: serviceDayFinish))
            }
        }
        self.showToast(message: "Servicio agregado correctamente", seconds: 1.0)
        serviceTableView.reloadData()
    }
}

//MARK:- Add Social Delegate
extension CommunitiesMainViewController: AddSocialModalButtonDelegate {
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
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.showToast(message: "Red social agregada correctamente", seconds: 1.0)
        }

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
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.showToast(message: "Red social agregada correctamente", seconds: 1.0)
        }
    }
    // OLD AND STUPID
    func didPressReadySocialButton(_ sender: UIButton) {
        switch NewAddSocialController.instance.sellectedSocial {
        case 0:
            faceNew = AddSocial.instance.socialTextField.text ?? ""
        case 1:
            twittNew = AddSocial.instance.socialTextField.text ?? ""
        case 2:
            instaNew = AddSocial.instance.socialTextField.text ?? ""
        case 3:
            streamNew = AddSocial.instance.socialTextField.text ?? ""
        case 4:
            webNew = AddSocial.instance.socialTextField.text ?? ""
        default:
            break
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.showToast(message: "Red social agregada correctamente", seconds: 1.0)
        }
        
        parentView.isUserInteractionEnabled = true
        parentView.alpha = 1
    }
    
    func didPressAddSocialmButton(_ sender: UIButton) {
        switch AddSocial.instance.sellectedSocial {
        case 0:
            faceNew = AddSocial.instance.socialTextField.text ?? ""
        case 1:
            twittNew = AddSocial.instance.socialTextField.text ?? ""
        case 2:
            instaNew = AddSocial.instance.socialTextField.text ?? ""
        case 3:
            streamNew = AddSocial.instance.socialTextField.text ?? ""
        case 4:
            webNew = AddSocial.instance.socialTextField.text ?? ""
        default:
            break
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.showToast(message: "Red social agregada correctamente", seconds: 1.0)
        }
        
    }    
}

extension CommunitiesMainViewController: UIViewControllerTransitioningDelegate {
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = false
        let singleton = AlertCommunity.singleton
        
        if singleton.isLater == true {
            print("do nothing")
        }else{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.presenter?.goToProfile()
            }
        }
        
        return transition
        
    }
}

extension CommunitiesMainViewController: sellectedCellDeleteProtocol {
    func sellectedCell(index: IndexPath, indexInt: Int, indexSection: Int) {
        let indexPath = index.item
        if isEditProfile == true {
            print(arrayOfArrayServices[indexSection].count)
            arrayOfArrayServices[indexSection].remove(at: indexInt)
            print(arrayOfArrayServices[indexSection].count)
            serviceDayEdit = arrayOfArrayServices[indexSection]
            print(serviceDayEdit.count)
//            serviceDayEdit.remove(at: indexInt)
            activityEditNew.remove(at: indexPath)
            activityEditNew.insert(ActivityEditProfile(name: communityActivities?[indexPath].name, gearedToward: communityActivities?[indexPath].gearedToward, activityDescription: communityActivities?[indexPath].communityGetActivityDescription, serviceHours: serviceDayEdit), at: indexPath)
        }else {
            serviceDayFinish.remove(at: indexPath)
            activityFinishNew.remove(at: indexPath)
            activityFinishNew.insert(ActivityFinReg(name: communityActivities?[indexPath].name, gearedToward: communityActivities?[indexPath].gearedToward, activityDescription: communityActivities?[indexPath].communityGetActivityDescription, serviceHours: serviceDayFinish), at: indexPath)
        }
    }
}
