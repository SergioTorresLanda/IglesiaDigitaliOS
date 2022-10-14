import Foundation
import UIKit
import EncuentroCatolicoVirtualLibrary
import Toast_Swift

enum LifeState: Int {
    case single = 1
    case married = 2
    case widower = 3
    case laic = 4
    case religious = 5
    case diacan = 6
    case priest = 7
}

enum estado: Int {
    case Soltero = 1
    case Casado = 2
    case Viudo = 3
    case Laico = 4
    case Religioso = 5
    case Diacono = 6
    case Sacerdote = 7
}

class ProfileInfoView: UIViewController {
    
    static let sinleton = ProfileInfoView()
// MARK: @IBOUTLETS -
    @IBOutlet weak var customNavBar: UIView!
    @IBOutlet weak var contentTopSection: UIView!
    @IBOutlet weak var btnGear: UIButton!
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var lblMainTitle: UILabel!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var btnChangePhoto: UIButton!
    @IBOutlet weak var mainScroll: UIScrollView!
    @IBOutlet weak var mainContentView: UIView!
    
    @IBOutlet var blueLblCollection: [UILabel]!
    @IBOutlet var fieldsCollection: [UITextField]!
    @IBOutlet var lineasViewCollection: [UIView]!
    
    @IBOutlet weak var miniContentSwitch: UIView!
    @IBOutlet weak var churchCollection: UICollectionView!
    @IBOutlet weak var activityCollection: UICollectionView!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var lblYouCan: UILabel!
    @IBOutlet weak var lblAskService: UILabel!
    @IBOutlet weak var lblState: UILabel!
    @IBOutlet weak var switchState: UISwitch!
    @IBOutlet weak var serachStack: UIStackView!
    @IBOutlet weak var miniContentCongregation: UIView!
    @IBOutlet weak var heightChurchCollection: NSLayoutConstraint!
    @IBOutlet weak var heightTopicColection: NSLayoutConstraint!
    @IBOutlet weak var mainContentHeight: NSLayoutConstraint!
    @IBOutlet weak var heightSwitchView: NSLayoutConstraint!
    @IBOutlet weak var heightCongConstant: NSLayoutConstraint!
    
    // Card Laico consagrado
    @IBOutlet weak var cardLaico: UIView!
    @IBOutlet weak var lblAskResponsable: UILabel!
    @IBOutlet weak var lblStateResp: UILabel!
    @IBOutlet weak var switchResponsable: UISwitch!
    @IBOutlet weak var lblAskChurch: UILabel!
    @IBOutlet weak var churchRespField: UITextField!
    @IBOutlet weak var searchRespBtn: UIButton!
    @IBOutlet weak var cardLaico2: UIView!
    @IBOutlet weak var radioBtnCollection: UICollectionView!
    @IBOutlet weak var lblLaicoAsk: UILabel!
    
    // Prefijo section
    @IBOutlet weak var lblPrefix: UILabel!
    @IBOutlet weak var prefixField: UITextField!
    @IBOutlet weak var prefixView: UIView!
    
    
// MARK: NEW GLOBAL VAR -
    var testStyle = "Religioso"
    var pickerLifeStyle: UIPickerView!
    var pickerServiceCong: UIPickerView!
    var pickerTopics: UIPickerView!
    var pickerPrefix: UIPickerView!
    var lifeStyleList : [String] = []//["Soltero", "Casado", "Viudo", "Laico consagrado", "Religioso", "Diácano(Transitorio o permanente)", "Sacerdote"]
    var serviceCongList : [String] = []
    var serviceListID: [Int] = []
    var topicsList : [String] = []//["Familia", "Catequesis", "Sacramentos", "El papa", "Apsotolado", "Voluntariado", "Oración"]
    var selectedRow = 0
    var selectedRowServ = 0
    let transition = SlideTransition()
    var selectedAcitity = ""
    var isCongregation = false
    var arrayChurches : [String] = []
    var arrayImgchurches : [String] = []
    var arrayDictionariesTopics: [[String:Int]] = []
    var codesLifeStatus: [String] = []
    var selectedCode = ""
    var arrayPrefix: [String] = []
    var arrayPrefixID: [Int] = []
    var selectedPrefixID = 0
    
    var oldConstant : CGFloat = 0
    var oldValueTopic : CGFloat = 0
    var selectedServiceID = 0
    var isPresentPriestAlert = false
    var isLaico = false
    var isResponsable = "COMMUNITY_MEMBER"
    var isAdmin = false
    var indexFlow = 0
    var lifeStatusSingleton = ""
    var arrayRadioBtn = ["Sí, a una iglesia", "Sí, a una comunidad", "No"]
    var arrayIsActive = [false, false, false]
    var serviceProvider = "Unspecified"
    var nameService = [String]()
    
    static let singleton = ProfileInfoView()
    
// MARK: CODE VIEW -
    lazy var contentViewSize = CGSize(width: view.frame.width, height: view.frame.height + 650)
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        scrollView.frame = self.view.frame
        scrollView.contentSize = contentViewSize
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    let topicCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collection = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = UIColor.white
        collection.isScrollEnabled = true
        // collection.contentSize = CGSize(width: 2000 , height: 400)
        return collection
    }()
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.frame.size = contentViewSize
        return view
    }()
    
    private lazy var navBarImageView: UIImageView = setupNavBarImageView()
    private lazy var titleLabel: UILabel = setupLabel("Perfil", font: .boldSystemFont(ofSize: 18.0), color: .white)
    private lazy var toolButton: UIButton = setupToolButton()
    lazy var changeImageButton: UIButton = {
            let button = UIButton(frame: .zero)
            button.setImage(UIImage(named: "profile_icon", in: Bundle(for: ProfileInfoRouter.self), compatibleWith: nil), for: .normal)
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()
//    private lazy var logoutButton: UIButton = setupLogOutButton()
    private lazy var userImageView: UIImageView = setupUserImageView()
    private lazy var nameLabel: UILabel = setupLabel("", font: .boldSystemFont(ofSize: 20.0), color: UIColor(red: 25 / 255, green: 42 / 255, blue: 115 / 255, alpha: 1.0))
    
    private lazy var nameTextField: LineLabelTextField = setupTexfield(placeholder: "Nombre(s)")
    private lazy var lastnameTextField: LineLabelTextField = setupTexfield(placeholder: "Apellido paterno")
    private lazy var motherLastnameTextField: LineLabelTextField = setupTexfield(placeholder: "Apellido materno")
    private lazy var phoneTextField: LineLabelTextField = setupTexfield(placeholder: "55 5555-5555", textLabel: "Número de celular")
    private lazy var emailTextField: LineLabelTextField = setupTexfield(placeholder: "juanromero@mail.com", textLabel: "Email")
    private lazy var lifeStateTextField: LineLabelTextField = setupTexfield(placeholder: "Selecciona", textLabel: "Estado de vida")
    private lazy var serviceLabel: UILabel = setupLabel("¿Prestas algún servicio a la iglesia ya sea voluntario o remunerado?", font: .systemFont(ofSize: 13.0), color: UIColor(red: 160 / 255, green: 160 / 255, blue: 160 / 255, alpha: 1.0))
    private lazy var radioButtonYes = setupRadioButton("Si")
    private lazy var radioButtonNo = setupRadioButton("No")
    private lazy var infoLabel: UILabel = setupLabelTwo("Inforrmación de Perfil", font: .boldSystemFont(ofSize: 16.0), color: UIColor(red: 25 / 255, green: 42 / 255, blue: 115 / 255, alpha: 1.0))
    private lazy var profileUserInfoView = ProfileUserInfoViewController(nibName: "ProfileUserInfoViewController", bundle: Bundle.local)
    private lazy var topicsTextField: LineLabelTextField = setupTexfield(placeholder: "Selecciona", textLabel: "Temas de Interés")
    private lazy var saveButton: UIButton = setupSaveButton()
    let idGlobal = UserDefaults.standard.integer(forKey: "id")
    var topicArray: [Topics] = []
    var presenter: ProfileInfoPresenterProtocol?
    
    var up: NSLayoutConstraint?
    var down: NSLayoutConstraint?
    var bottom: NSLayoutConstraint?
    
    var lifeStatesArray: [StatesContent] = []
    var selectedTopic: StatesContent?
    var topicsArray: [DataContent] = []
    
    var lifeStateSelected: Int = 0
    var selectedLifeState: DataContent?
    var topicSelected: [DataContent] = []
    
    let loadingAlert = UIAlertController(title: "", message: "\n \n \n \n \nCargando...", preferredStyle: .alert)
    var imgChoosed : UIImage!
    
    var congregationArray: CongregationsResponse?
    var congregationIdArray: CongregationsResponse?
    var congregationSeleted: CongregationsResponse?
    var nameTopics: [String] = []
    var AllServicesData: [ProvidedService] = []
    
    let cellId = "cellId"
    
    
// MARK: LIFE CYCLE VIEW FUNCTIONS -
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let singleton = ProfileInfoView.sinleton
        singleton.isPresentPriestAlert = false
       // presenter?.getLifeStates()
        setupDelegates()
        showLoading()
        setupUI()
       // setupViews()
        HideUpTopic()
        topicsTextField.delegate = self
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyBoard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        presenter?.viewDidLoad()
//        self.presenter?.getUserDetailP()
//        self.presenter?.getAllUserDetail()
        setupRadioBtnCollection()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
            self.loadingAlert.dismiss(animated: true, completion: nil)
        })
        NotificationCenter.default.addObserver(self, selector: #selector(receiveProfileInfo(notification:)), name: Notification.Name("showUserINFO"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let singleton = ProfileInfoView.sinleton
        if singleton.isPresentPriestAlert == true {
            print("Mustra la alert")
            singleton.isPresentPriestAlert = false
            let view = NewOnboardingRouter.createModule(typeOnboarding: "Priest")
            view.modalPresentationStyle = .overFullScreen
            self.present(view, animated: true, completion: nil)
            
        }
//        presenter?.viewDidLoad()
//        setupDelegates()
//        setupUI()
       // self.presenter?.getUserDetailP()

    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        presenter?.viewDidLoad()
//        setupDelegates()
//        setupUI()
//       // self.presenter?.getUserDetailP()
//    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//            super.viewDidDisappear(animated)
////            self.dismiss(animated: false, completion: nil)
//
//        }
    
    
// MARK: SETUP FUNC -
    private func setupUI() {
        oldConstant = mainContentHeight.constant
        customNavBar.ShadowNavBar()
        customNavBar.layer.cornerRadius = 20
        btnSave.layer.cornerRadius = 8
        userImg.image = UIImage(named: "userImage", in: Bundle.local, compatibleWith: nil)
        userImg.layer.cornerRadius = userImg.bounds.width / 2
        churchCollection.isHidden = true
        fieldsCollection[6].addTarget(self, action: #selector(TextBoxOn(_:)),for: .editingDidBegin)
        churchRespField.addTarget(self, action: #selector(TextBoxOnResp), for: .editingDidBegin)
        setupFieldPickers()
        
    }
    
    private func setupFieldPickers() {
        pickerLifeStyle = UIPickerView()
        setupPickerField(pickerLifeStyle, tagPiker: 3, pos: 5)
        pickerServiceCong = UIPickerView()
        setupPickerField(pickerServiceCong, tagPiker: 4, pos: 8)
        pickerTopics = UIPickerView()
        setupPickerField(pickerTopics, tagPiker: 5, pos: 7)
        pickerPrefix = UIPickerView()
        setupPickerFieldPrefix(pickerPrefix)
        
    }
    
    private func setupRadioBtnCollection() {
        radioBtnCollection.register(UINib(nibName: "RadioBtnCollectionViewCell", bundle: Bundle.local), forCellWithReuseIdentifier: "CELLRADIO")
        radioBtnCollection.delegate = self
        radioBtnCollection.dataSource = self
    }
    
    private func setupPickerField(_ picker: UIPickerView, tagPiker: Int, pos: Int) {
        picker.frame = CGRect(x: 0, y: 200, width: view.frame.width, height: 200)
        picker.tag = tagPiker
        picker.showsSelectionIndicator = true
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()

        let doneButton = UIBarButtonItem(title: "Aceptar", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.acceptPicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancelar", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.cancelPicker))

        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.items?.forEach({ (button) in
            button.tintColor = UIColor.init(red: 25/255, green: 42/255, blue: 115/255, alpha: 1)
        })
        
        toolBar.isUserInteractionEnabled = true

        fieldsCollection[pos].inputView = picker
        fieldsCollection[pos].inputAccessoryView = toolBar
        picker.delegate = self
        picker.dataSource = self
    }
    
    private func setupPickerFieldPrefix(_ picker: UIPickerView) {
        picker.frame = CGRect(x: 0, y: 200, width: view.frame.width, height: 200)
        picker.showsSelectionIndicator = true
        picker.tag = 6
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()

        let doneButton = UIBarButtonItem(title: "Aceptar", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.acceptPrefix))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancelar", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.cancelPrefix))

        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.items?.forEach({ (button) in
            button.tintColor = UIColor.init(red: 25/255, green: 42/255, blue: 115/255, alpha: 1)
        })
        
        toolBar.isUserInteractionEnabled = true

        prefixField.inputView = picker
        prefixField.inputAccessoryView = toolBar
        picker.delegate = self
        picker.dataSource = self
    }
    
    private func setupDelegates() {
        fieldsCollection.forEach { field in
            field.delegate = self
        }
        churchCollection.register(UINib(nibName: "ChurchesCardViewCell", bundle: Bundle.local), forCellWithReuseIdentifier: "CELLCHURCH")
        churchCollection.register(UINib(nibName: "ChurhesCardCellDiacono", bundle: Bundle.local), forCellWithReuseIdentifier: "CELLDIACANO")
        churchCollection.delegate = self
        churchCollection.dataSource = self
        
        activityCollection.register(ActivitiesCardCollectionViewCell.nib, forCellWithReuseIdentifier: ActivitiesCardCollectionViewCell.reuseIdentifier)
        activityCollection.dataSource = self
        activityCollection.delegate = self
    }
        
// MARK:  NEW @OJC FUNCS -
    @objc func acceptPicker() {
        self.view.endEditing(true)
        
        switch selectedRow {
        case 0:
            isLaico = true
            switchResponsable.isOn = true
            isCongregation = true
            lblStateResp.text = "No"
            switchResponsable.isOn = false
            btnSave.setTitle("Guardar", for: .normal)
            churchCollection.isHidden = false
            radioBtnCollection.isHidden = false
            lblLaicoAsk.isHidden = false
            fieldsCollection[6].text = ""
            fieldsCollection[6].placeholder = "Congregación a la que perteneces"
            selectedPrefixID = 0
            for i in 0...arrayIsActive.count - 1{
                print(i)
                arrayIsActive[i] = false
            }
            radioBtnCollection.reloadData()
           // prefixField.text = "N/A"
            miniContentSwitch.isHidden = true
            serachStack.isHidden = true
            lineasViewCollection[6].isHidden = true
            miniContentCongregation.isHidden = true
            lblYouCan.isHidden = true
            cardLaico.isHidden = true
            cardLaico2.isHidden = true
            hideOrShowPrefix(isShow: true)
            showLoading()
            presenter?.requestPrefixes(code: selectedCode)
            
        case 1:
            isLaico = false
            btnSave.setTitle("Guardar", for: .normal)
            isCongregation = true
            radioBtnCollection.isHidden = true
            lblLaicoAsk.isHidden = true
            lblStateResp.text = "No"
            churchCollection.isHidden = true
            for i in 0...arrayIsActive.count - 1{
                print(i)
                arrayIsActive[i] = false
            }
            radioBtnCollection.reloadData()
            switchResponsable.isOn = false
            fieldsCollection[6].text = ""
            fieldsCollection[6].placeholder = "Congregación a la que perteneces"
            selectedPrefixID = 0
            prefixField.text = "N/A"
            cardLaico.isHidden = false
            cardLaico2.isHidden = false
            miniContentSwitch.isHidden = true
            serachStack.isHidden = false
            lineasViewCollection[6].isHidden = false
            miniContentCongregation.isHidden = false
            lblYouCan.isHidden = true
            showLoading()
            presenter?.requestPrefixes(code: selectedCode)
            hideOrShowPrefix(isShow: false)
        
        case 2:
            
            isLaico = false
            btnSave.setTitle("Guardar", for: .normal)
            churchCollection.isHidden = true
            radioBtnCollection.isHidden = true
            lblLaicoAsk.isHidden = true
            switchState.isOn = false
            for i in 0...arrayIsActive.count - 1{
                print(i)
                arrayIsActive[i] = false
            }
            radioBtnCollection.reloadData()
            lblState.text = "No"
            hideOrShowPrefix(isShow: true)
            isCongregation = false
            fieldsCollection[6].text = ""
            fieldsCollection[6].placeholder = "¿En qué iglesia prestas el servicio?"
            selectedPrefixID = 0
            prefixField.text = "N/A"
            cardLaico.isHidden = true
            cardLaico2.isHidden = true
            serachStack.isHidden = true
            miniContentCongregation.isHidden = true
            miniContentSwitch.isHidden = true
            serachStack.isHidden = false
            lineasViewCollection[6].isHidden = false
            let height = activityCollection.collectionViewLayout.collectionViewContentSize.height
            heightTopicColection.constant = height
            self.view.layoutIfNeeded()
            hideOrShowPrefix(isShow: false)
            showLoading()
            presenter?.requestPrefixes(code: selectedCode)
       
        case 3:
            isLaico = false
            btnSave.setTitle("Continuar", for: .normal)
            isCongregation = true
            radioBtnCollection.isHidden = true
            lblLaicoAsk.isHidden = true
            cardLaico.isHidden = true
            cardLaico2.isHidden = true
            for i in 0...arrayIsActive.count - 1{
                print(i)
                arrayIsActive[i] = false
            }
            radioBtnCollection.reloadData()
            churchCollection.isHidden = true
            miniContentSwitch.isHidden = true
            miniContentCongregation.isHidden = true
            serachStack.isHidden = true
            lineasViewCollection[6].isHidden = true
            selectedPrefixID = 0
            prefixField.text = "N/A"
            lblYouCan.isHidden = true
            let height = activityCollection.collectionViewLayout.collectionViewContentSize.height
            heightTopicColection.constant = height
            self.view.layoutIfNeeded()
            hideOrShowPrefix(isShow: false)
            showLoading()
            presenter?.requestPrefixes(code: selectedCode)
         
        case 100:
            break
            
        case 101:
            selectTopicLogic()
            
        default:
            btnSave.setTitle("Guardar", for: .normal)
            switchState.setOn(false, animated: true)
            lblState.text = "No"
            churchCollection.isHidden = true
            isCongregation = false
            fieldsCollection[6].text = ""
            fieldsCollection[6].placeholder = "¿En qué iglesia prestas el servicio?"
            serachStack.isHidden = true
            miniContentCongregation.isHidden = true
            lineasViewCollection[6].isHidden = true
            miniContentSwitch.isHidden = false // 90
            print(heightSwitchView.constant)
            let height = activityCollection.collectionViewLayout.collectionViewContentSize.height
            heightTopicColection.constant = height
            self.view.layoutIfNeeded()
            lblYouCan.isHidden = false
            
        }
    }
    
    @objc func cancelPicker() {
        fieldsCollection[5].text = ""
        self.view.endEditing(true)
    }
    
    @objc func acceptPrefix() {
        self.view.endEditing(true)
    }
    
    @objc func cancelPrefix() {
        prefixField.text = ""
        self.view.endEditing(true)
    }
    
    @objc func TextBoxOn(_ textField: UITextField) {
        
        if isCongregation == false {
            self.view.endEditing(true)
            let view = ProfileMapWireFrame.createModuleMap(mapType: lifeStatusSingleton)
            view.modalPresentationStyle = .overFullScreen
            view.transitioningDelegate = self
            self.present(view, animated: true, completion: nil)
                        
        }else{
            self.view.endEditing(true)
            let view = CongregationRouter.createModule()
            view.modalPresentationStyle = .overFullScreen
            view.transitioningDelegate = self
            self.present(view, animated: true, completion: nil)
            indexFlow = 1
        }
        
    }
    
    @objc func TextBoxOnResp(_ texfield: UITextField) {
        isLaico = true
        indexFlow = 0
        churchRespField.text = ""
        self.view.endEditing(true)
        let view = ProfileMapWireFrame.createModuleMap(mapType: lifeStatusSingleton)
        view.modalPresentationStyle = .overFullScreen
        view.transitioningDelegate = self
        self.present(view, animated: true, completion: nil)
    }
    
    @objc func deleteChurchCard(sender: UIButton) {
        print(sender.tag)
        
        arrayChurches.remove(at: sender.tag)
        arrayImgchurches.remove(at: sender.tag)
        churchCollection.reloadData()
        if arrayChurches.count == 0 {
            churchCollection.isHidden = true
        }
        
        let singleton = ProfileMapViewController.singleton
        singleton.idChurch = nil
        fieldsCollection[6].text = ""
        
        let height = churchCollection.collectionViewLayout.collectionViewContentSize.height
        heightChurchCollection.constant = height
        self.view.layoutIfNeeded()

    }
    
    @objc private func hideKeyBoard() {
        view.endEditing(true)
    }
    
    @objc private func radioSelected(_ radio: RadioButton) {
        [radioButtonYes, radioButtonNo].forEach({ $0.isSelected = false })
        radio.isSelected = true
        if radioButtonYes.isSelected {
            self.showMap()
        } else if radioButtonNo.isSelected {
            self.hidePartial()
        }
    }
    
    @objc private func receiveProfileInfo(notification: Notification) {
        print("Notificación recibida")
        hideLoading()
        if notification.object != nil {
           // let userInfo = notification.object as! UserRespProfile
            //            txtCelulat.text = userInfo.UserAttributes.phone_number
            //            txtEail.text = userInfo.UserAttributes.email
        }
    }
    
    @objc func selectRadioButton(sender: UIButton) {
        print(sender.tag)
        let index = sender.tag
        
        if arrayIsActive[index] == true {
            for i in 0...arrayIsActive.count - 1{
                print(i)
                arrayIsActive[i] = false
            }
            
            isLaico = false
            lblStateResp.text = "No"
            switchResponsable.isOn = false
            btnSave.setTitle("Guardar", for: .normal)
            churchCollection.isHidden = true
            fieldsCollection[6].text = ""
            fieldsCollection[6].placeholder = "Congregación a la que perteneces"
            selectedPrefixID = 0
            miniContentSwitch.isHidden = true
            serachStack.isHidden = true
            lineasViewCollection[6].isHidden = true
            miniContentSwitch.isHidden = true
            lblYouCan.isHidden = true
            cardLaico.isHidden = true
            cardLaico2.isHidden = true
            
        }else{
            for i in 0...arrayIsActive.count - 1{
                print(i)
                arrayIsActive[i] = false
            }
            arrayIsActive[index] = true
            switch index {
            case 0:
                isLaico = false
                btnSave.setTitle("Guardar", for: .normal)
                churchCollection.isHidden = true
                switchState.isOn = false
                lblState.text = "No"
                serachStack.isHidden = false
                lineasViewCollection[6].isHidden = false
                hideOrShowPrefix(isShow: true)
                isCongregation = false
                fieldsCollection[6].text = ""
                fieldsCollection[6].placeholder = "¿En qué iglesia prestas el servicio?"
                cardLaico.isHidden = true
                cardLaico2.isHidden = true
              //  serachStack.isHidden = true
                miniContentCongregation.isHidden = true
                miniContentSwitch.isHidden = true
//                serachStack.isHidden = true
//                lineasViewCollection[6].isHidden = true
                let height = activityCollection.collectionViewLayout.collectionViewContentSize.height
                heightTopicColection.constant = height
                self.view.layoutIfNeeded()
                serviceProvider = "CHURCH"
                
            case 1:
                isLaico = true
                switchResponsable.isOn = false
                isCongregation = false
                lblStateResp.text = "No"
                switchResponsable.isOn = false
                btnSave.setTitle("Guardar", for: .normal)
                churchCollection.isHidden = true
                fieldsCollection[6].text = ""
                fieldsCollection[6].placeholder = "Congregación a la que perteneces"
                selectedPrefixID = 0
                prefixField.text = "N/A"
                miniContentSwitch.isHidden = true
                serachStack.isHidden = true
                lineasViewCollection[6].isHidden = true
                miniContentCongregation.isHidden = true
                lblYouCan.isHidden = true
                cardLaico.isHidden = false
                cardLaico2.isHidden = false
                hideOrShowPrefix(isShow: true)
                serviceProvider = "COMMUNITY"
                                
            default:
                isLaico = false
                lblStateResp.text = "No"
                switchResponsable.isOn = false
                btnSave.setTitle("Guardar", for: .normal)
                churchCollection.isHidden = true
                fieldsCollection[6].text = ""
                fieldsCollection[6].placeholder = "Congregación a la que perteneces"
                selectedPrefixID = 0
                miniContentSwitch.isHidden = true
                serachStack.isHidden = true
                lineasViewCollection[6].isHidden = true
                miniContentSwitch.isHidden = true
                lblYouCan.isHidden = true
                cardLaico.isHidden = true
                cardLaico2.isHidden = true
                serviceProvider = "NO"
                
            }
        }

        radioBtnCollection.reloadData()
    }
    
// MARK: GENERAL FUNCS -
    private func saveChanges() {
        let singleton = ProfileMapViewController.singleton
        let singleton2 = ProfileInfoView.singleton
        let singleton3 = CongregationsView.singleton
        
        var loca: [Locations] = []
        let loca1 = Locations(id: singleton.idChurch)
        loca.append(loca1)
        
        var services: [Service] = []
        
        if singleton.idChurch != nil {
            print(singleton2.selectedServiceID, serviceListID)
            let services1 = Service(location_id: singleton.idChurch, service_id: singleton2.selectedServiceID)
            services.append(services1)
            
           // let services1 = Service(location_id: singleton.idChurch, service_id: serviceListID[singleton2.selectedServiceID])
           // services.append(services1)
        }
        
        var congregationA: [Congregation] = []
        let cong1 = Congregation(id: singleton3.selectedID)
        congregationA.append(cong1)
        
        let prefixObject = Prefix(id: selectedPrefixID)
        print(prefixObject)
        UserDefaults.standard.set(selectedPrefixID, forKey: "Prefix")
        
        let state = fieldsCollection[5].text ?? ""
        var stateId: Int = 0
        switch state {
        case "Soltero":
            stateId = 1
        case "Casado":
            stateId = 2
        case "Viudo":
            stateId = 3
        case "Laico":
            stateId = 4
        case "Religioso":
            stateId = 5
        case "Diácono (Transitorio o permanente)":
            stateId = 6
        case "Sacerdote":
            stateId = 7
        default:
            break
        }
        let life: Status = Status(id: stateId, name: fieldsCollection[5].text ?? "")
        let validPrayer = self.fieldsCollection[5].text
        
        switch validPrayer {
        case "Sacerdote":
            let view = ProfileInfoRouter.createModuleTwo()
            navigationController?.pushViewController(view, animated: true)
        case "Religioso":
            showLoading()
            var idChurchReligioso = singleton.idChurch
            if churchRespField.text == "" {
                idChurchReligioso = 0
            }
            
            if cong1.id == 0 {
                var registerReligioso: ProfileCongregation = ProfileCongregation(username: fieldsCollection[4].text ?? "", id: idGlobal, name: fieldsCollection[0].text ?? "", first_surname:  fieldsCollection[1].text ?? "", second_surname: fieldsCollection[2].text ?? "", phone_number: fieldsCollection[3].text ?? "", location_id: idChurchReligioso, email: fieldsCollection[4].text ?? "", life_status: life, prefix: prefixObject, interest_topics: topicArray, pastoral_work: fieldsCollection[9].text, profile: isResponsable)
                
                if selectedPrefixID == 0 {
                    registerReligioso = ProfileCongregation(username: fieldsCollection[4].text ?? "", id: idGlobal, name: fieldsCollection[0].text ?? "", first_surname:  fieldsCollection[1].text ?? "", second_surname: fieldsCollection[2].text ?? "", phone_number: fieldsCollection[3].text ?? "", location_id: idChurchReligioso, email: fieldsCollection[4].text ?? "", life_status: life, interest_topics: topicArray, pastoral_work: fieldsCollection[9].text, profile: isResponsable)
                }
                
                print(registerReligioso)
                presenter?.postLaicoReligioso(request: registerReligioso)
                
            }else{
                var registerReli: ProfileCongregation = ProfileCongregation(username: fieldsCollection[4].text ?? "", id: idGlobal, name: fieldsCollection[0].text ?? "", first_surname:  fieldsCollection[1].text ?? "", second_surname: fieldsCollection[2].text ?? "", phone_number: fieldsCollection[3].text ?? "", location_id: idChurchReligioso, email: fieldsCollection[4].text ?? "", life_status: life, prefix: prefixObject, interest_topics: topicArray, congregation: cong1, pastoral_work: fieldsCollection[9].text, profile: isResponsable)
                
                if selectedPrefixID == 0 {
                    registerReli = ProfileCongregation(username: fieldsCollection[4].text ?? "", id: idGlobal, name: fieldsCollection[0].text ?? "", first_surname:  fieldsCollection[1].text ?? "", second_surname: fieldsCollection[2].text ?? "", phone_number: fieldsCollection[3].text ?? "", location_id: idChurchReligioso, email: fieldsCollection[4].text ?? "", life_status: life, interest_topics: topicArray, congregation: cong1, pastoral_work: fieldsCollection[9].text, profile: isResponsable)
                }
               
                print(registerReli)
                presenter?.postLaicoReligioso(request: registerReli)
            }
                    
        case "Laico":
            
            var idChurchLaico = singleton.idChurch
            if churchRespField.text == "" {
                idChurchLaico = 0
            }
            
           // showLoading()
            
            var registerNewLaico = ProfileState(username: fieldsCollection[4].text ?? "", id: idGlobal, name: fieldsCollection[0].text ?? "", first_surname: fieldsCollection[1].text ?? "", second_surname: fieldsCollection[2].text ?? "", phone_number: fieldsCollection[3].text ?? "", email: fieldsCollection[4].text ?? "")
            
            switch serviceProvider {
                
            case "CHURCH":
                registerNewLaico = ProfileState(username: fieldsCollection[4].text ?? "", id: idGlobal, name: fieldsCollection[0].text ?? "", first_surname: fieldsCollection[1].text ?? "", second_surname: fieldsCollection[2].text ?? "", phone_number: fieldsCollection[3].text ?? "", email: fieldsCollection[4].text ?? "", service_provider: serviceProvider, life_status: life, interest_topics: topicArray, services_provided: services)
                
            case "COMMUNITY":
                if selectedPrefixID == 0 {
                    registerNewLaico = ProfileState(username: fieldsCollection[4].text ?? "", id: idGlobal, name: fieldsCollection[0].text ?? "", first_surname: fieldsCollection[1].text ?? "", second_surname: fieldsCollection[2].text ?? "", phone_number: fieldsCollection[3].text ?? "", email: fieldsCollection[4].text ?? "", service_provider: serviceProvider, location_id: idChurchLaico, is_admin: isAdmin, life_status: life, interest_topics: topicArray)
                }else{
                    registerNewLaico = ProfileState(username: fieldsCollection[4].text ?? "", id: idGlobal, name: fieldsCollection[0].text ?? "", first_surname: fieldsCollection[1].text ?? "", second_surname: fieldsCollection[2].text ?? "", phone_number: fieldsCollection[3].text ?? "", email: fieldsCollection[4].text ?? "", service_provider: serviceProvider, location_id: idChurchLaico, is_admin: isAdmin, life_status: life, prefix: prefixObject, interest_topics: topicArray)
                }
                
            case "NO":
                registerNewLaico = ProfileState(username: fieldsCollection[4].text ?? "", id: idGlobal, name: fieldsCollection[0].text ?? "", first_surname: fieldsCollection[1].text ?? "", second_surname: fieldsCollection[2].text ?? "", phone_number: fieldsCollection[3].text ?? "", email: fieldsCollection[4].text ?? "", service_provider: serviceProvider, life_status: life, interest_topics: topicArray)
        
            default:
                break
            }
            
            print(registerNewLaico)
            presenter?.postState(request: registerNewLaico)
            
        case "Diácono (Transitorio o permanente)":
            showLoading()
            var registerDiacono: ProfileDiacono = ProfileDiacono(username: fieldsCollection[4].text ?? "", id: idGlobal, name: fieldsCollection[0].text ?? "", first_surname: fieldsCollection[1].text ?? "", second_surname: fieldsCollection[2].text ?? "", phone_number: fieldsCollection[3].text ?? "" , email: fieldsCollection[4].text ?? "", life_status: life, prefix: prefixObject, interest_topics: topicArray , locations: loca)
            if selectedPrefixID == 0 {
                registerDiacono = ProfileDiacono(username: fieldsCollection[4].text ?? "", id: idGlobal, name: fieldsCollection[0].text ?? "", first_surname: fieldsCollection[1].text ?? "", second_surname: fieldsCollection[2].text ?? "", phone_number: fieldsCollection[3].text ?? "" , email: fieldsCollection[4].text ?? "", life_status: life, interest_topics: topicArray , locations: loca)
            }
         //   print(registerDiacono, fieldsCollection[6].text)
            if fieldsCollection[6].text == "" {
                loadingAlert.dismiss(animated: true, completion: nil)
                let alert = UIAlertController(title: "Aviso", message: "Por favor selecciona una iglesia", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: nil))
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.present(alert, animated: true)
                }
                
            }else{
                presenter?.postDiacono(request: registerDiacono)
            }
            
        case "Soltero", "Casado", "Viudo":
            showLoading()
            let registerState: ProfileState = ProfileState(username: fieldsCollection[4].text ?? "", id: idGlobal, name: fieldsCollection[0].text ?? "", first_surname: fieldsCollection[1].text ?? "", second_surname: fieldsCollection[2].text ?? "", phone_number: fieldsCollection[3].text ?? "", email: fieldsCollection[4].text ?? "", life_status: life, interest_topics: topicArray, services_provided: services)
            print(registerState)
            presenter?.postState(request: registerState)
            
            break
            
        default:
            let alert = UIAlertController(title: "Datos Vacios", message: "Llena corectamente los datos", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
    func successLaicoReligioso() {
        loadingAlert.dismiss(animated: false, completion: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.view.makeToast("Datos Guardados Exitosamente", duration: 3.0, position: .top)
//            let alert = UIAlertController(title: "Datos Guardados", message: "Exitosamente", preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: nil))
//            self.present(alert, animated: true)
        }
    }
    
    func failLaicoReligioso() {
        loadingAlert.dismiss(animated: false, completion: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let alert = UIAlertController(title: "Aviso", message: "Hubo un error por favor intentelo más tarde", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
    func successDiacano() {
        loadingAlert.dismiss(animated: false, completion: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            self.view.makeToast("Datos Guardados Exitosamente", duration: 3.0, position: .top)
//            let alert = UIAlertController(title: "Datos Guardados", message: "Exitosamente", preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: nil))
//            self.present(alert, animated: true)
        }
    }
    
    func failDiacano() {
        loadingAlert.dismiss(animated: false, completion: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            let alert = UIAlertController(title: "Aviso", message: "Hubo un error por favor intentelo más tarde", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
    private func selectTopicLogic() {
        var topicId: Int = 0
        var name = selectedAcitity
        if name == "" {
            name = "Familia"
        }
        switch name {
        case "Familia":
            topicId = 1
        case "Catequesis":
            topicId = 2
        case "Sacramentos":
            topicId = 3
        case "El papa":
            topicId = 4
        case "Apostolado":
            topicId = 5
        case "Voluntariado":
            topicId = 6
        case "Oración":
            topicId = 7
        default:
            break
        }
        let ids = nameTopics.map({$0})
        if ids.contains(name) {
            let alert = UIAlertController(title: "Actividad repetida", message: "La actividad ya se encuetra agregada", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: nil))
            self.present(alert, animated: true)
        }else {
            let topic1 = Topics(id: topicId)
            nameTopics.append(name)
            topicArray.append(topic1)
        }
        view.endEditing(true)
        activityCollection.reloadData()
        let height = activityCollection.collectionViewLayout.collectionViewContentSize.height
        heightTopicColection.constant = height
        self.view.layoutIfNeeded()
        
        switch nameTopics.count {
        
        case 1:
           // mainContentHeight.constant += 60
        print("")
           
        case 4:
           // mainContentHeight.constant += 50
            print("")
        case 7:
           // mainContentHeight.constant += 50
            print("")
            
        default:
            break
        }

        if nameTopics.count != 0 {
            activityCollection.isHidden = false
        }
    }
    
// MARK: CODE VIEW -
    private func setupViews() {
        hideLoading()
        //topicCollectionView.register(ActivitiesCardCollectionViewCellC.self, forCellWithReuseIdentifier: cellId)
        
        self.profileUserInfoView.delegteClose = self
        [navBarImageView, titleLabel, toolButton, userImageView, nameLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        topicCollectionView.register(ActivitiesCardCollectionViewCell.nib, forCellWithReuseIdentifier: ActivitiesCardCollectionViewCell.reuseIdentifier)
        topicCollectionView.dataSource = self
        topicCollectionView.delegate = self
        
        navBarImageView.topAnchor(equalTo: view.topAnchor, constant: -10)
        navBarImageView.widthAnchor(equalTo: view.frame.width + 40)
        navBarImageView.heightAnchor(equalTo: 200)
        navBarImageView.centerXAnchor(equalTo: view.centerXAnchor)
        
        titleLabel.centerXAnchor(equalTo: navBarImageView.centerXAnchor)
        titleLabel.centerYAnchor(equalTo: navBarImageView.centerYAnchor, constant: -20)
        
        toolButton.topAnchor(equalTo: view.safeTopAnchor, constant: 10)
        toolButton.trailingAnchor(equalTo: view.trailingAnchor, constant: -65)
        toolButton.widthAnchor(equalTo: 20)
        toolButton.heightAnchor(equalTo: 20)
        
//        logoutButton.topAnchor(equalTo: view.safeTopAnchor, constant: 10)
//        logoutButton.trailingAnchor(equalTo: view.trailingAnchor, constant: -25)
//        logoutButton.widthAnchor(equalTo: 20)
//        logoutButton.heightAnchor(equalTo: 20)
        
        userImageView.widthAnchor(equalTo: 130)
        userImageView.heightAnchor(equalTo: 130)
        userImageView.centerXAnchor(equalTo: navBarImageView.centerXAnchor)
        userImageView.bottomAnchor(equalTo: navBarImageView.bottomAnchor, constant: 40)
        
        DispatchQueue.main.async {
            self.userImageView.layer.cornerRadius = (self.userImageView.frame.width / 2)
            self.userImageView.layer.masksToBounds = true
        }
        
        nameLabel.widthAnchor(equalTo: view.bounds.width - 20)
        nameLabel.centerXAnchor(equalTo: navBarImageView.centerXAnchor)
        nameLabel.topAnchor(equalTo: userImageView.bottomAnchor, constant: 20)
        
        view.addSubview(scrollView)
        scrollView.topAnchor(equalTo: nameLabel.topAnchor, constant: 50)
        scrollView.leadingAnchor(equalTo: view.leadingAnchor)
        scrollView.trailingAnchor(equalTo: view.trailingAnchor)
        scrollView.bottomAnchor(equalTo: view.safeBottomAnchor)
        scrollView.addSubview(containerView)
        
        [infoLabel,nameTextField, lastnameTextField, motherLastnameTextField, phoneTextField, emailTextField, lifeStateTextField, serviceLabel, radioButtonYes, radioButtonNo, topicsTextField, saveButton,topicCollectionView, changeImageButton].forEach {
            containerView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        view.addSubview(changeImageButton)
                changeImageButton.addTarget(self, action: #selector(changeImage(_ :)), for: .touchUpInside)
        
        changeImageButton.widthAnchor(equalTo: 48)
               changeImageButton.heightAnchor(equalTo: 48)
               changeImageButton.centerYAnchor(equalTo: userImageView.centerYAnchor,constant: 55)
               changeImageButton.centerXAnchor(equalTo: userImageView.centerXAnchor,constant: 35)
        
        DispatchQueue.main.async {
                 self.userImageView.layer.cornerRadius = (self.userImageView.frame.width / 2)
                 self.userImageView.layer.masksToBounds = true
             }
        
        
        infoLabel.topAnchor(equalTo: containerView.topAnchor)
        infoLabel.heightAnchor(equalTo: 45)
        infoLabel.leadingAnchor(equalTo: containerView.leadingAnchor, constant: 20)
        infoLabel.trailingAnchor(equalTo: containerView.trailingAnchor, constant: 20)
        
        nameTextField.topAnchor(equalTo: infoLabel.topAnchor, constant: 45)
        nameTextField.heightAnchor(equalTo: 45)
        nameTextField.leadingAnchor(equalTo: containerView.leadingAnchor, constant: 20)
        nameTextField.trailingAnchor(equalTo: containerView.trailingAnchor, constant: 20)
        
        lastnameTextField.heightAnchor(equalTo: 45)
        lastnameTextField.widthAnchor(equalTo: (containerView.bounds.width / 2) - 30)
        lastnameTextField.topAnchor(equalTo: nameTextField.bottomAnchor, constant: 10)
        lastnameTextField.leadingAnchor(equalTo: containerView.leadingAnchor, constant: 20)
        
        motherLastnameTextField.heightAnchor(equalTo: 45)
        motherLastnameTextField.widthAnchor(equalTo: (containerView.bounds.width / 2) - 30)
        motherLastnameTextField.topAnchor(equalTo: nameTextField.bottomAnchor, constant: 10)
        motherLastnameTextField.trailingAnchor(equalTo: containerView.trailingAnchor, constant: 20)
        
        phoneTextField.topAnchor(equalTo: lastnameTextField.bottomAnchor, constant: 50)
        phoneTextField.heightAnchor(equalTo: 40)
        phoneTextField.leadingAnchor(equalTo: containerView.leadingAnchor, constant: 20)
        phoneTextField.trailingAnchor(equalTo: containerView.trailingAnchor, constant: 20)
        
        emailTextField.topAnchor(equalTo: phoneTextField.bottomAnchor, constant: 50)
        emailTextField.heightAnchor(equalTo: 40)
        emailTextField.leadingAnchor(equalTo: containerView.leadingAnchor, constant: 20)
        emailTextField.trailingAnchor(equalTo: containerView.trailingAnchor, constant: 20)
        
        lifeStateTextField.topAnchor(equalTo: emailTextField.bottomAnchor, constant: 45)
        lifeStateTextField.heightAnchor(equalTo: 40)
        lifeStateTextField.leadingAnchor(equalTo: containerView.leadingAnchor, constant: 20)
        lifeStateTextField.trailingAnchor(equalTo: containerView.trailingAnchor, constant: 20)
        
        
        up = topicsTextField.topAnchor.constraint(equalTo: lifeStateTextField.bottomAnchor, constant: 35)
        up?.isActive = true
        down = topicsTextField.topAnchor.constraint(equalTo: lifeStateTextField.bottomAnchor, constant: 120)
        bottom = topicsTextField.topAnchor.constraint(equalTo: lifeStateTextField.bottomAnchor, constant: 360)
        topicsTextField.heightAnchor(equalTo: 40)
        topicsTextField.leadingAnchor(equalTo: containerView.leadingAnchor, constant: 20)
        topicsTextField.trailingAnchor(equalTo: containerView.trailingAnchor, constant: 20)
        
        topicCollectionView.topAnchor(equalTo: topicsTextField.bottomAnchor, constant: 25)
        topicCollectionView.heightAnchor(equalTo: 140)
        topicCollectionView.widthAnchor(equalTo: 355)
        //        topicCollectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20).isActive = true
        topicCollectionView.leadingAnchor(equalTo: view.leadingAnchor, constant: 20)
        topicCollectionView.trailingAnchor(equalTo: view.trailingAnchor, constant: -20)
        
        
        saveButton.topAnchor(equalTo: topicCollectionView.bottomAnchor, constant: 25)
        saveButton.heightAnchor(equalTo: 48)
        saveButton.widthAnchor(equalTo: 150)
        saveButton.leadingAnchor(equalTo: containerView.leadingAnchor, constant: 20)
        saveButton.trailingAnchor(equalTo: containerView.trailingAnchor, constant: -5)
        
        //        view.backgroundColor = .systemGray
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
    
    // MARK: Private Methods
    
    func showCongregations(congregation: CongregationsResponse) {
        congregationIdArray = congregation
        print(congregation)
    }
    
// MARK: NEW @IBACTIONS -
    @IBAction func changeState(_ sender: Any) {
        if switchState.isOn  {
            serachStack.isHidden = false
            lineasViewCollection[6].isHidden = false
            lblState.text = "Sí"
          //  mainContentHeight.constant += 64
          //  oldValueTopic = mainContentHeight.constant
        }else{
            serachStack.isHidden = true
            lineasViewCollection[6].isHidden = true
            lblState.text = "No"
            if churchCollection.isHidden == true {
           //     mainContentHeight.constant -= 64
            }else{
              //  mainContentHeight.constant -= 289
            }
            
            churchCollection.isHidden = true
           // oldValueTopic = mainContentHeight.constant
        }
    }
    
    @IBAction func changeResponsableSwitch(_ sender: Any) {
        if switchResponsable.isOn {
            lblStateResp.text = "Sí"
           // cardLaico2.isHidden = false
            isResponsable = "COMMUNITY_RESPONSIBLE"
            isAdmin = true
        }else{
            lblStateResp.text = "No"
           // cardLaico2.isHidden = true
            isResponsable = "COMMUNITY_MEMBER"
            isAdmin = false
        }
    }
    
    @IBAction func changePhotoAction(_ sender: Any) {
        
        ImagePickerManager().pickImage(self){ [unowned self] image in
            //  self.userImageView.image = image
            self.imgChoosed = image
            let defaults = UserDefaults.standard
            let idUser = defaults.integer(forKey: "id")
            let imgBase64 = convertImageToBase64String2(img: image)
            let last10 = String(imgBase64.suffix(8))
            print(last10)
            let myString = last10
            let replaced = myString.replacingOccurrences(of: "=", with: "")
            print(replaced)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.present(loadingAlert, animated: true, completion: nil)
            }
             self.presenter?.uploadImageBase64(elementID: idUser, type: "PROFILE", filename: "test-picture\(replaced).png", contentBase64: convertImageToBase64String2(img: image))
            
        }
    }
    
    @IBAction func gearAction(_ sender: Any) {
        presenter?.showConfigController()
    }
    
    @IBAction func saveAction(_ sender: Any) {
        saveChanges()
        lblUserName.text = "\(fieldsCollection[0].text ?? "") \(fieldsCollection[1].text ?? "") \(fieldsCollection[2].text ?? "")"
    }
    
    @IBAction func searchResponsableChurch(_ sender: Any) {
        isLaico = true
        indexFlow = 0
        churchRespField.text = ""
        self.view.endEditing(true)
        if lifeStatusSingleton == "" {
            lifeStatusSingleton = "Laico"
        }
        let view = ProfileMapWireFrame.createModuleMap(mapType: lifeStatusSingleton)
        view.modalPresentationStyle = .overFullScreen
        view.transitioningDelegate = self
        self.present(view, animated: true, completion: nil)
    }
    
        
// MARK: Actions -
    
    @IBAction func configuracionesAction(_ sender: Any) {
        presenter?.configuracionesActionc()
    }
    
    @IBAction func informationAction(_ sender: Any) {
        //        flag = false
        //        withoutPromisseView.isHidden = true
        //        promisseTemporalView.isHidden = true
        //        UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseInOut]) {
        //
        //            self.view.layoutIfNeeded()
        //        } completion: { (isAnimated) in
        //
        //        }
    }
    
    @IBAction func donacionesAction(_ sender: Any) {
        //        flag = true
        //        hideKeyBoard()
        //        UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseInOut]) {
        //            self.view.layoutIfNeeded()
        //        } completion: { (isAnimated) in
        //
        //        }
        //        if(promisses.count == 0){
        //            withoutPromisseView.isHidden = false
        //            promisseTemporalView.isHidden = true
        //        }else{
        //            withoutPromisseView.isHidden = true
        //            promisseTemporalView.isHidden = false
        //        }
    }
    
    @objc func changeImage(_ sender: UIButton) {
           ImagePickerManager().pickImage(self){ [unowned self] image in
             //  self.userImageView.image = image
            self.imgChoosed = image
            let defaults = UserDefaults.standard
            let idUser = defaults.integer(forKey: "id")
            let imgBase64 = convertImageToBase64String2(img: image)
            var last10 = String(imgBase64.suffix(10))
            print(last10)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.present(loadingAlert, animated: true, completion: nil)
            }
            print("\(last10.removeLast(2)).png")
            self.presenter?.uploadImageBase64(elementID: idUser, type: "PROFILE", filename: "test-picture\(last10.removeLast(2)).png", contentBase64: convertImageToBase64String2(img: image))
          
           }
       }
    
    func convertImageToBase64String2(img: UIImage) -> String {
        let imageData: Data? = img.jpegData(compressionQuality: 0.4)
        let imageStr = imageData?.base64EncodedString(options: .lineLength64Characters) ?? ""
        return imageStr
    }
    
    @objc private func didSaveAction() {
        var loca: [Locations] = []
        let loca1 = Locations(id: 1)
        loca.append(loca1)
        
        var services: [Service] = []
        let services1 = Service(location_id: 1, service_id: 2)
        services.append(services1)
        
        let state = lifeStateTextField.text ?? ""
        var stateId: Int = 0
        switch state {
        case "Soltero":
            stateId = 1
        case "Casado":
            stateId = 2
        case "Viudo":
            stateId = 3
        case "Laico":
            stateId = 4
        case "Religioso":
            stateId = 5
        case "Díacono(Transitorio o permanente)":
            stateId = 6
        case "Sacerdote":
            stateId = 7
        default:
            break
        }
        let life: Status = Status(id: stateId, name: lifeStateTextField.text ?? "")
        
        let validPrayer = self.lifeStateTextField.text
        switch validPrayer {
        case "Sacerdote":
            let view = ProfileInfoRouter.createModuleTwo()
            navigationController?.pushViewController(view, animated: true)
        case "Díacono(Transitorio o permanente)", "Religioso":
            let registerDiacono: ProfileDiacono = ProfileDiacono(username: fieldsCollection[4].text ?? "", id: idGlobal, name: fieldsCollection[0].text ?? "", first_surname: fieldsCollection[1].text ?? "", second_surname: fieldsCollection[2].text ?? "", phone_number: fieldsCollection[3].text ?? "" , email: fieldsCollection[4].text ?? "", life_status: life, interest_topics: topicArray , locations: loca)
            print(registerDiacono)
           // presenter?.postDiacono(request: registerDiacono)
            break
            
        case "Laico":
            let registerDiacono: ProfileDiacono = ProfileDiacono(username: fieldsCollection[4].text ?? "", id: idGlobal, name: fieldsCollection[0].text ?? "", first_surname: fieldsCollection[1].text ?? "", second_surname: fieldsCollection[2].text ?? "", phone_number: fieldsCollection[3].text ?? "" , email: fieldsCollection[4].text ?? "", life_status: life, interest_topics: topicArray , locations: loca, services_provided: services)
            print(registerDiacono)
           // presenter?.postDiacono(request: registerDiacono)
            break
            
        case "Soltero", "Casado", "Viudo":
            let registerState: ProfileState = ProfileState(username: fieldsCollection[4].text ?? "", id: idGlobal, name: fieldsCollection[0].text ?? "", first_surname: fieldsCollection[1].text ?? "", second_surname: fieldsCollection[2].text ?? "", phone_number: fieldsCollection[3].text ?? "", email: fieldsCollection[4].text ?? "", life_status: life, interest_topics: topicArray, services_provided: services)
            print(registerState)
            
            break
        default:
            let alert = UIAlertController(title: "Datos Vacios", message: "Llena corectamente los datos", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
    @IBAction func addNewImage(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            imagePicker.allowsEditing = false
            imagePicker.cameraFlashMode = .off
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @IBAction func newPromisseAction(_ sender: Any) {
        presenter?.donacionesAction(navegationController: navigationController!)
    }
    
    @IBAction func sacardoteAction(_ sender: Any) {
        presenter?.showSoySacerdotecontroller(navegationController: navigationController!)
    }
    
    private func createPicker(texfield: UITextField, tag: Int, with selector: Selector) {
        let pickerView = UIPickerView()
        pickerView.tag = tag
        pickerView.delegate = self
        pickerView.dataSource = self
        
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.sizeToFit()
        
        let acceptButton = UIBarButtonItem(title: "Aceptar", style: UIBarButtonItem.Style.done, target: self, action: selector)
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([spaceButton, acceptButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        texfield.inputAccessoryView = toolBar
        texfield.inputView = pickerView
    }
    
    private func HideUpTopic() {
        self.radioButtonNo.isHidden = true
        self.radioButtonYes.isHidden = true
        self.serviceLabel.isHidden = true
        self.up?.isActive = true
        self.down?.isActive = false
        self.bottom?.isActive = false
        self.view.layoutSubviews()
        self.view.layoutIfNeeded()
        
    }
    
    private func hidePartial() {
        self.up?.isActive = false
        self.down?.isActive = true
        self.bottom?.isActive = false
        self.view.layoutSubviews()
        self.view.layoutIfNeeded()
    }
    
    private func ShowUpTopic() {
        self.radioButtonNo.isHidden = false
        self.radioButtonYes.isHidden = false
        self.serviceLabel.isHidden = false
        self.up?.isActive = false
        self.down?.isActive = true
        self.bottom?.isActive = false
        
        
        serviceLabel.widthAnchor(equalTo: (containerView.bounds.width / 2) - 30)
        serviceLabel.topAnchor(equalTo: lifeStateTextField.bottomAnchor, constant: 35)
        serviceLabel.leadingAnchor(equalTo: containerView.leadingAnchor, constant: 20)
        serviceLabel.textAlignment = .left
        
        radioButtonYes.widthAnchor(equalTo: 20)
        radioButtonYes.heightAnchor(equalTo: 20)
        radioButtonYes.topAnchor(equalTo: lifeStateTextField.bottomAnchor, constant: 35)
        radioButtonYes.leadingAnchor(equalTo: serviceLabel.trailingAnchor, constant: 25)
        
        radioButtonNo.widthAnchor(equalTo: 20)
        radioButtonNo.heightAnchor(equalTo: 20)
        radioButtonNo.topAnchor(equalTo: lifeStateTextField.bottomAnchor, constant: 35)
        radioButtonNo.leadingAnchor(equalTo: radioButtonYes.trailingAnchor, constant: 50)
        
        
        topicCollectionView.topAnchor(equalTo: topicsTextField.bottomAnchor, constant: 25)
        topicCollectionView.heightAnchor(equalTo: 140)
        topicCollectionView.widthAnchor(equalTo: 355)
        topicCollectionView.trailingAnchor(equalTo: containerView.trailingAnchor, constant: -20)
        
        
        
        saveButton.topAnchor(equalTo: topicCollectionView.bottomAnchor, constant: 25)
        saveButton.heightAnchor(equalTo: 48)
        saveButton.widthAnchor(equalTo: 150)
        saveButton.leadingAnchor(equalTo: containerView.leadingAnchor, constant: 20)
        saveButton.trailingAnchor(equalTo: containerView.trailingAnchor, constant: -5)
        
        self.view.layoutSubviews()
        self.view.layoutIfNeeded()
    }
    
    private func showMap(){
        
        self.up?.isActive = false
        self.down?.isActive = false
        self.bottom?.isActive = true
        
        addChild(profileUserInfoView)
        containerView.addSubview(profileUserInfoView.view)
        profileUserInfoView.didMove(toParent: self)
        
        profileUserInfoView.view.topAnchor(equalTo: serviceLabel.bottomAnchor, constant: 10)
        profileUserInfoView.view.heightAnchor(equalTo: 250)
        profileUserInfoView.view.leadingAnchor(equalTo: containerView.leadingAnchor, constant: 20)
        profileUserInfoView.view.trailingAnchor(equalTo: containerView.trailingAnchor, constant: 20)
        

        topicCollectionView.topAnchor(equalTo: topicsTextField.bottomAnchor, constant: 25)
        topicCollectionView.heightAnchor(equalTo: 140)
        topicCollectionView.widthAnchor(equalTo: 355)
        topicCollectionView.trailingAnchor(equalTo: containerView.trailingAnchor, constant: -20)
                
        saveButton.topAnchor(equalTo: topicCollectionView.bottomAnchor, constant: 25)
        saveButton.heightAnchor(equalTo: 48)
        saveButton.widthAnchor(equalTo: 150)
        saveButton.leadingAnchor(equalTo: containerView.leadingAnchor, constant: 20)
        saveButton.trailingAnchor(equalTo: containerView.trailingAnchor, constant: -5)
        
        self.view.layoutSubviews()
        self.view.layoutIfNeeded()
        
    }
    
    func hideOrShowPrefix(isShow: Bool) {
        switch  isShow{
        case true:
            lblPrefix.isHidden = true
            prefixField.isHidden = true
            prefixView.isHidden = true
        default:
            lblPrefix.isHidden = false
            prefixField.isHidden = false
            prefixView.isHidden = false
        }
    }
    
}

// MARK: - Actions

extension ProfileInfoView {
    @objc func popView() {
//        let view = MainConfigView(nibName: "MainConfigView", bundle: Bundle(for: MainConfigView.self))
//        if #available(iOS 13.0, *) {
//            view.modalPresentationStyle = .fullScreen
//        } else {
//            // Fallback on earlier versions
//        }
//        navigationController?.pushViewController(view, animated: true)
        presenter?.showConfigController()
    }
    
    @objc func toLogOut(){
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "nombre")
        defaults.removeObject(forKey: "role")
        defaults.removeObject(forKey: "profile")
        presenter?.cerrarSesion()
        self.view.window?.rootViewController?.dismiss(animated: true, completion: {
            NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: "LogOut"),
                                                         object: nil, userInfo: nil))
        })
    }
    
    @objc private func didSelectLifeState() {
        view.endEditing(true)
        //Aqui ocultas view de iglesias!!
        var name = lifeStateTextField.text
        if name == "" {
            name = "Soltero"
            
        }
        
        if name == "Soltero" || name == "Casado" || name == "Viudo" {
            self.ShowUpTopic()
        }else if name == "Sacerdote" {
            saveButton.setTitle("Continuar", for: .normal)
        }else {
            saveButton.setTitle("Guardar", for: .normal)
        }
        
    }
    
    @objc private func didSelectTopics() {
        var topicId: Int = 0
        var name = topicsTextField.text
        if name == "" {
            name = "Familia"
        }
        switch name {
        case "Familia":
            topicId = 1
        case "Catequesis":
            topicId = 2
        case "Sacramentos":
            topicId = 3
        case "El papa":
            topicId = 4
        case "Apostolado":
            topicId = 5
        case "Voluntariado":
            topicId = 6
        case "Oración":
            topicId = 7
        default:
            break
        }
        let ids = nameTopics.map({$0})
        if ids.contains(name ?? "") {
            let alert = UIAlertController(title: "Actividad repetida", message: "La actividad ya se encuetra agregada", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: nil))
            self.present(alert, animated: true)
        }else {
            let topic1 = Topics(id: topicId)
            nameTopics.append(name ?? "")
            topicArray.append(topic1)
        }
        view.endEditing(true)
        topicCollectionView.reloadData()
    }
}
// MARK: - UI

extension ProfileInfoView {
    private func setupNavBarImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "navbar_image", in: Bundle.local, compatibleWith: nil)
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }
    
    private func setupTexfield(placeholder: String = "", textLabel: String = "") -> LineLabelTextField {
        let textField = LineLabelTextField()
        textField.delegate = self
        textField.labelColor = UIColor(red: 25 / 255, green: 42 / 255, blue: 114 / 255, alpha: 1.0)
        textField.font = UIFont(name: "Roboto-Regular", size: 14.0) ?? .systemFont(ofSize: 14, weight: .regular)
        textField.placeholder = placeholder
        textField.textLabel = textLabel
        return textField
    }
    
    private func setupLabel(_ text: String, font: UIFont, color: UIColor) -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = text
        label.font = font
        label.textColor = color
        return label
    }
    
    private func setupLabelTwo(_ text: String, font: UIFont, color: UIColor) -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = text
        label.font = font
        label.textColor = color
        return label
    }
    
    private func setupRadioButton(_ titleText: String) -> RadioButton {
        let radioButton = RadioButton()
        radioButton.isSelected = false
        radioButton.titleText = titleText
        radioButton.deselectedColor = UIColor(red: 160 / 255, green: 160 / 255, blue: 160 / 255, alpha: 1.0)
        radioButton.selectedColor = UIColor(red: 25 / 255, green: 42 / 255, blue: 115 / 255, alpha: 1.0)
        radioButton.addTarget(self, action: #selector(radioSelected(_ :)), for: .touchUpInside)
        return radioButton
    }
    
    private func setupToolButton() -> UIButton {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "tool_image", in: Bundle.local, compatibleWith: nil), for: .normal)
        button.addTarget(self, action: #selector(popView), for: .touchUpInside)
        return button
    }
    
//    private func setupLogOutButton() -> UIButton {
//        let button = UIButton(type: .custom)
//        button.setImage(UIImage(named:"logout", in: Bundle.local, compatibleWith: nil), for: .normal)
//        button.addTarget(self, action: #selector(toLogOut), for: .touchUpInside)
//        return button
//    }
    
    private func setupUserImageView() -> UIImageView {
            let imageView = UIImageView()
            imageView.clipsToBounds = true
            imageView.contentMode = .scaleToFill
            
            if let imageData = UserDefaults.standard.data(forKey: "userImage"), let image = UIImage(data: imageData) {
                imageView.image = image
            } else {
                
               // imageView.image = UIImage(named: "userImage", in: Bundle.local, compatibleWith: nil)
            }
            
            return imageView
        }
    
    private func setupSaveButton() -> UIButton {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 10
        button.backgroundColor = UIColor(red: 19 / 255, green: 39 / 255, blue: 124 / 255, alpha: 1.0)
        button.titleLabel?.font = UIFont(name: "Roboto-Bold", size: 15) ?? .systemFont(ofSize: 15, weight: .bold)
        button.setTitle("Guardar", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(didSaveAction), for: .touchUpInside)
        return button
    }
}

// MARK: UITextFieldDelegate -
extension ProfileInfoView: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        pickerLifeStyle.selectRow(0, inComponent: 0, animated: true)
       // pickerTopics.selectRow(0, inComponent: 0, animated: true)
        pickerServiceCong.selectRow(0, inComponent: 0, animated: true)
        switch textField {
        case fieldsCollection[5]:
            selectedRow = 0
            if fieldsCollection[5].text == "" {
                if lifeStyleList.count != 0 {
                    fieldsCollection[5].text = lifeStyleList[0]
                    //selectedRow = 0
                }
               
            }
            
        case fieldsCollection[7]:
            if fieldsCollection[7].text == "" {
                if topicsList.count != 0 {
                    fieldsCollection[7].text = topicsList[0]
                   // selectedAcitity = topicsList[0]
                    selectedRow = 101
                }
                
            }
            
        case fieldsCollection[8]:
            if fieldsCollection[8].text == "" {
                if serviceCongList.count != 0 {
                    fieldsCollection[8].text = serviceCongList[0]
                }
                
            }
            
        default:
            break
        }
        
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        //        if textField == Constants.Tags.fieldSecurityCode {
        //            securityCodeTextField = textField
        //            datePickerTapped(textField)
        //            return false
        //        }
        
        return true
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension ProfileInfoView: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        let image = info[.originalImage] as! UIImage
        let cameraPhotoURL = HttpRequestSingleton.shareManager.convertImageToBase64String(img: image)
        EditionPromisseDataManager.shareInstance.addNewProfile(profileModel: ProfileModel(email: UserDefaults.standard.value(forKey: "email") as? String ?? "", image: cameraPhotoURL))
        picker.dismiss(animated: true, completion: nil)
    }
}

extension ProfileInfoView: PromisseAlertViewProtocol {
    func dissmisAlert() {
    }
}

extension ProfileInfoView: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        
        case 2:
            return topicsArray.count
            
        case 3:
            return lifeStyleList.count
            
        case 4:
            return serviceCongList.count
            
        case 5:
            return topicsList.count
            
        case 6:
            return arrayPrefix.count
       
        default:
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        
        case 2:
            return topicsArray[row].description
            
        case 3:
            return lifeStyleList[row]
            
        case 4:
            return serviceCongList[row]
            
        case 5 :
            return topicsList[row]
            
        case 6:
            return arrayPrefix[row]
        
        default:
            return "Sin Datos"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        
        case 2:
            //            selectedTopic = topicsArray[row]
            topicsTextField.text = topicsArray[row].description
            
        case 3:
            fieldsCollection[5].text = lifeStyleList[row]
            selectedRow = row
            lifeStatusSingleton = lifeStyleList[row]
            selectedCode = codesLifeStatus[row]
            
        case 4:
            fieldsCollection[8].text = serviceCongList[row]
            selectedRow = 100
            
        case 5:
            fieldsCollection[7].text = topicsList[row]
            selectedAcitity = topicsList[row]
            selectedRow = 101
            
        case 6:
            prefixField.text = arrayPrefix[row]
            selectedPrefixID = arrayPrefixID[row]
            
        default:
            print("Entro el defaul")
            break
            
        }
    }
}

// MARK: RESPONSE SERVICES FUNCTIONS -
extension ProfileInfoView: ProfileInfoViewProtocol {
    func showStatesResponnse() {
        loadingAlert.dismiss(animated: false, completion: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.view.makeToast("Datos Guardados Exitosamente", duration: 3.0, position: .top)
        }
     
    }
    
    func showCongregationResponse() {
        loadingAlert.dismiss(animated: false, completion: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.view.makeToast("Datos Guardados Exitosamente", duration: 3.0, position: .top)
        }
    }
    
    func showSacerdoteResponse() {
        loadingAlert.dismiss(animated: false, completion: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.view.makeToast("Datos Guardados Exitosamente", duration: 3.0, position: .top)
        }
    }
    
    func showDiaconoResponse() {
        loadingAlert.dismiss(animated: false, completion: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            self.view.makeToast("Datos Guardados Exitosamente", duration: 3.0, position: .top)
        }
    }
    
    func showDetalles(detail: DetailProfile) {
        print("çççç", detail)
        // New Code
        lifeStatusSingleton = detail.data?.User?.life_status?.name ?? ""
        lblUserName.text = "\(detail.data?.User?.name ?? "Unspecified") \(detail.data?.User?.first_surname ?? "Unspecified") \(detail.data?.User?.second_surname ?? " ")"
        fieldsCollection[0].text = detail.data?.User?.name
        fieldsCollection[1].text = detail.data?.User?.first_surname
        fieldsCollection[2].text = detail.data?.User?.second_surname
        fieldsCollection[3].text = detail.data?.User?.phone_number
        fieldsCollection[4].text = detail.data?.User?.email
        fieldsCollection[5].text = detail.data?.User?.life_status?.name
        //
        switch detail.data?.User?.life_status?.name {
        case "Soltero", "Casado", "Viudo":
            isCongregation = false
            isLaico = false
            fieldsCollection[6].placeholder = "¿En qué iglesia prestas el servicio?"
            serachStack.isHidden = true
            miniContentCongregation.isHidden = true
            lineasViewCollection[6].isHidden = true
            miniContentSwitch.isHidden = false
            lblYouCan.isHidden = false
            hideOrShowPrefix(isShow: true)
          
            if detail.data?.User?.location_modules?.count != 0 {
                switchState.isOn = true
                lblState.text = "Sí"
                serachStack.isHidden = false
                lineasViewCollection[6].isHidden = false
                arrayChurches.removeAll()
                arrayImgchurches.removeAll()
                
                detail.data?.User?.location_modules?.forEach({ module in
                    arrayChurches.append(module.name ?? "")
                    arrayImgchurches.append("Unspecified")
                })

                churchCollection.reloadData()
                churchCollection.isHidden = false
                let height = churchCollection.collectionViewLayout.collectionViewContentSize.height
                heightChurchCollection.constant = height
                self.view.layoutIfNeeded()
                print(heightChurchCollection.constant)
            }
            
        case "Religioso":
            isCongregation = true
            isLaico = false
            fieldsCollection[6].placeholder = "Congregación a la que perteneces"
            fieldsCollection[6].text = detail.data?.User?.congregation?.name
            miniContentSwitch.isHidden = true
            serachStack.isHidden = false
            cardLaico.isHidden = false
            cardLaico2.isHidden = false
            lineasViewCollection[6].isHidden = false
            miniContentCongregation.isHidden = false
            lblYouCan.isHidden = true
            prefixField.text = detail.data?.User?.prefix?.description ?? "N/A"
            selectedPrefixID = detail.data?.User?.prefix?.id ?? 0
            presenter?.requestPrefixes(code: "RELIGIOUS")
            hideOrShowPrefix(isShow: false)
            
            switch detail.data?.User?.profile {
            case "COMMUNITY_RESPONSIBLE":
                switchResponsable.isOn = true
                lblStateResp.text = "Sí"
                cardLaico2.isHidden = false
            default:
                switchResponsable.isOn = false
                lblStateResp.text = "No"
                cardLaico2.isHidden = true
            }
        
        case "Laico":
            isLaico = true
            cardLaico.isHidden = true
            cardLaico2.isHidden = true
            hideOrShowPrefix(isShow: true)
            radioBtnCollection.isHidden = false
            
            switch detail.data?.User?.is_provider {
            case "CHURCH":
                arrayIsActive[0] = true
                isLaico = false
                btnSave.setTitle("Guardar", for: .normal)
                churchCollection.isHidden = true
                switchState.isOn = false
                lblState.text = "No"
                serachStack.isHidden = false
                lineasViewCollection[6].isHidden = false
                hideOrShowPrefix(isShow: true)
                isCongregation = false
                fieldsCollection[6].placeholder = "¿En qué iglesia prestas el servicio?"
                fieldsCollection[6].text = detail.data?.User?.services_provided?.first?.location_name
                arrayChurches.removeAll()
                arrayImgchurches.removeAll()
                detail.data?.User?.services_provided?.forEach({ item in
                    arrayChurches.append(item.location_name ?? "")
                    arrayImgchurches.append("unspecified")
                    nameService.append(item.service_name ?? "")
                })
                churchCollection.reloadData()
                churchCollection.isHidden = false
                let heightC = churchCollection.collectionViewLayout.collectionViewContentSize.height
                heightChurchCollection.constant = heightC
                self.view.layoutIfNeeded()
                print(heightChurchCollection.constant)
                
                cardLaico.isHidden = true
                cardLaico2.isHidden = true
              //  serachStack.isHidden = true
                miniContentCongregation.isHidden = true
                miniContentSwitch.isHidden = true
//                serachStack.isHidden = true
//                lineasViewCollection[6].isHidden = true
                let height = activityCollection.collectionViewLayout.collectionViewContentSize.height
                heightTopicColection.constant = height
                self.view.layoutIfNeeded()
                serviceProvider = "CHURCH"
                
            case "COMMUNITY":
                arrayIsActive[1] = true
                isLaico = true
                switchResponsable.isOn = false
                isCongregation = false
                lblStateResp.text = "No"
                switchResponsable.isOn = false
                btnSave.setTitle("Guardar", for: .normal)
                churchCollection.isHidden = true
                fieldsCollection[6].placeholder = "Congregación a la que perteneces"
                selectedPrefixID = 0
                prefixField.text = "N/A"
                miniContentSwitch.isHidden = true
                serachStack.isHidden = true
                lineasViewCollection[6].isHidden = true
                miniContentCongregation.isHidden = true
                lblYouCan.isHidden = true
                cardLaico.isHidden = false
                cardLaico2.isHidden = false
                hideOrShowPrefix(isShow: true)
                serviceProvider = "COMMUNITY"
                
            default:
                arrayIsActive[2] = true
            }
            
            radioBtnCollection.reloadData()
            
            switch detail.data?.User?.profile {
            case "COMMUNITY_RESPONSIBLE":
                switchResponsable.isOn = true
                lblStateResp.text = "Sí"
               // cardLaico2.isHidden = false
            default:
                switchResponsable.isOn = false
                lblStateResp.text = "No"
               // cardLaico2.isHidden = true
            }
            
        case "Diácono (Transitorio o permanente)":
//            isLaico = false
//            isCongregation = false
//            fieldsCollection[6].placeholder = "¿En qué iglesia prestas el servicio?"
//            serachStack.isHidden = false
//            miniContentCongregation.isHidden = true
//            lineasViewCollection[6].isHidden = true
//            miniContentSwitch.isHidden = true
//            lblYouCan.isHidden = false
            isCongregation = false
            isLaico = false
            fieldsCollection[6].placeholder = "¿En qué iglesia prestas el servicio?"
            serachStack.isHidden = false
            miniContentCongregation.isHidden = true
            lineasViewCollection[6].isHidden = true
            miniContentSwitch.isHidden = true
            lblYouCan.isHidden = true
            hideOrShowPrefix(isShow: true)
          
            if detail.data?.User?.location_modules?.count != 0 {
                switchState.isOn = true
                lblState.text = "Sí"
                serachStack.isHidden = false
                lineasViewCollection[6].isHidden = false
                fieldsCollection[6].text = detail.data?.User?.location_modules?[0].name ?? ""
                arrayChurches.removeAll()
                arrayImgchurches.removeAll()
                
                detail.data?.User?.location_modules?.forEach({ module in
                    arrayChurches.append(module.name ?? "")
                    arrayImgchurches.append("Unspecified")
                })

                churchCollection.reloadData()
                churchCollection.isHidden = false
                let height = churchCollection.collectionViewLayout.collectionViewContentSize.height
                heightChurchCollection.constant = height
                self.view.layoutIfNeeded()
                print(heightChurchCollection.constant)
            }
            
            selectedPrefixID = detail.data?.User?.prefix?.id ?? 0
            prefixField.text = detail.data?.User?.prefix?.description ?? "N/A"
            presenter?.requestPrefixes(code: "DEACON")
            hideOrShowPrefix(isShow: false)
           
        case "Sacerdote":
            isLaico = false
            isCongregation = false
            miniContentSwitch.isHidden = true
            miniContentCongregation.isHidden = true
            serachStack.isHidden = true
            lineasViewCollection[6].isHidden = true
            lblYouCan.isHidden = true
            prefixField.text = detail.data?.User?.prefix?.description ?? "N/A"
            selectedPrefixID = detail.data?.User?.prefix?.id ?? 0
            presenter?.requestPrefixes(code: "PRIEST")
            hideOrShowPrefix(isShow: false)
            
        default:
            break
        }
         
        if ((detail.data?.User?.interest_topics?.count ?? 0) != 0) {
            detail.data?.User?.interest_topics?.forEach({ topic in
                nameTopics.append("\(topic.name ?? "Unspecified")")
            })
            topicArray = detail.data?.User?.interest_topics ?? topicArray
            activityCollection.isHidden = false
            activityCollection.reloadData()
            let height = activityCollection.collectionViewLayout.collectionViewContentSize.height
            heightTopicColection.constant = height
         
            self.view.layoutIfNeeded()
           
        }else{
           // mainContentHeight.constant += 60
        }
    
    }
    
    func showLifeStates(lifeStates: StatesResponse) {
        print(lifeStates)
        lifeStatesArray = lifeStates.data
        lifeStates.data.forEach { state in
            switch state.name {
            case "Soltero", "Casado", "Viudo":
                print("Dont append")
            default:
                lifeStyleList.append(state.name)
                codesLifeStatus.append(state.code ?? "")
            }
            
        }
        print("(((", codesLifeStatus)
        createPicker(texfield: lifeStateTextField, tag: 1, with: #selector(didSelectLifeState))
    }
    
    func showTopics(topics: TopicsResponse) {
        print(topics)
        topicsArray = topics.data
        topics.data.forEach { topic in
            topicsList.append(topic.description)
            arrayDictionariesTopics.append(["id":topic.id])
            
        }
       // selectedAcitity = topicsList[0]
        createPicker(texfield: topicsTextField, tag: 2, with: #selector(didSelectTopics))
        
    }
    
    func showServices(services: ServiceResponse) {
        print("ççççç")
        print(services)
        
        var servicesData: [ProvidedService] = []
        services.data.forEach { service in
            serviceCongList.append(service.description)
            serviceListID.append(service.id)
        }
        services.data.forEach {
            servicesData.append(ProvidedService(id: $0.id, name: $0.description))
        }
        AllServicesData = servicesData
        profileUserInfoView.options = servicesData
        self.presenter?.getUserDetailP()
        self.presenter?.getAllUserDetail()
    }
    
    func showUserInfo(user: UserRespProfile) {
        //        hideLoading()
        //        lblNombre.text = user.UserAttributes.name + " " + user.UserAttributes.last_name + " " + user.UserAttributes.middle_name
        //        txtEail.text = user.UserAttributes.email
        //        txtCelulat.text = user.UserAttributes.phone_number.replacingOccurrences(of: "+52", with: "")
    }
    
    func showOffice(offices: Array<ActivitiesResponse>) {
    }
    
    func showError(error: String) {
        loadingAlert.dismiss(animated: true, completion: { [self] in
            let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        })
    }
    
    func showRegisterResponse(response: RegisterPriestResponse) {
    }
    
    func mostrarInfo(dtcAlerta: [String: String]?, user: UserRespProfile?) {
        hideLoading()
        loadingAlert.dismiss(animated: true, completion: { [self] in
            if let alerta = dtcAlerta {
                let alertaView = UIAlertController(title: alerta["titulo"], message: alerta["cuerpo"], preferredStyle: .alert)
                alertaView.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: nil))
                self.present(alertaView, animated: true, completion: nil)
            } else {
                //                guard let nombre = user?.UserAttributes.name, let apellido1 = user?.UserAttributes.last_name, let apellido2 = user?.UserAttributes.middle_name else {
                //                    return
                //                }
                //                lblNombre.text = nombre + " " + apellido1 + " " + apellido2
            }
        })
    }
    
    func successPrefix(data: PrefixResponse) {
        arrayPrefix.removeAll()
        arrayPrefixID.removeAll()
        loadingAlert.dismiss(animated: true, completion: nil)
        data.data?.forEach({ prefix in
            arrayPrefix.append(prefix.description ?? "")
            arrayPrefixID.append(prefix.id ?? 0)
        })
        arrayPrefix.append("N/A")
        arrayPrefixID.append(0)
        pickerPrefix.reloadAllComponents()
        
    }
    
    func failPrefix(message: String) {
        loadingAlert.dismiss(animated: true, completion: nil)
    }
    
    // TODO: implement view output methods
    func mostrarMSG(dtcAlerta: [String: String]) {
        let alerta = UIAlertController(title: dtcAlerta["titulo"], message: dtcAlerta["cuerpo"], preferredStyle: .alert)
        alerta.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: nil))
        present(alerta, animated: true, completion: nil)
    }
}

// MARK: CALENDAR -
extension Calendar {
    func numberOfDaysBetween(_ from: Date, and to: Date) -> Int {
        let fromDate = startOfDay(for: from) // <1>
        let toDate = startOfDay(for: to) // <2>
        let numberOfDays = dateComponents([.day], from: fromDate, to: toDate) // <3>
        
        return numberOfDays.day!
    }
}

// MARK: UITEXFIELD -
extension UITextField {
    func setBottomBorder() {
        borderStyle = .none
        layer.backgroundColor = UIColor.white.cgColor
        
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 0.0
    }
}

extension ProfileInfoView: ProtocolProfileUserInfoX {
    func closeAction() {
        self.hidePartial()
        radioButtonNo.isSelected = true
        radioButtonYes.isSelected = false
    }
    
    
}


// MARK: EXTENSION COLLECTION VIEW -
extension ProfileInfoView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, ActivitiesCardDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch collectionView {
        case churchCollection:
            return arrayChurches.count
        case activityCollection:
            return nameTopics.count
            
        case radioBtnCollection:
            return arrayRadioBtn.count
            
        default:
            return 1
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView {
        case churchCollection:
            
            let cellChurch = collectionView.dequeueReusableCell(withReuseIdentifier: "CELLCHURCH", for: indexPath) as! ChurchesCardViewCell
            
            cellChurch.subCardView.ShadowCard()
            cellChurch.subCardView.layer.cornerRadius = 10
            cellChurch.cardView.layer.cornerRadius = 10
            cellChurch.cardView.clipsToBounds = true
            cellChurch.lblAsk.adjustsFontSizeToFitWidth = true
            cellChurch.lblChurchName.adjustsFontSizeToFitWidth = true
            cellChurch.btnDelete.addTarget(self, action: #selector(deleteChurchCard), for: .touchUpInside)
            cellChurch.btnDelete.tag = indexPath.item
            if arrayChurches.count != 0 {
                cellChurch.lblChurchName.text = arrayChurches[indexPath.item]
                cellChurch.churchImg.DownloadStaticImage(arrayImgchurches[indexPath.item])
            }
            
            if nameService.count != 0 {
                if nameService[indexPath.row] != "Unspecified" && nameService[indexPath.row] != "" && nameService.count != 0 {
                    cellChurch.fieldServices.text = nameService[indexPath.row]
                }
            }
            cellChurch.setupPickerField(vc: self, dataNames: serviceCongList, dataId: serviceListID)
            //            cellChurch.fieldServices.text = "Sacristán"
            
            return cellChurch
            
        case radioBtnCollection:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CELLRADIO", for: indexPath) as! RadioBtnCollectionViewCell
            cell.lblName.text = arrayRadioBtn[indexPath.item]
            cell.lblName.adjustsFontSizeToFitWidth = true
            cell.btnRadio.tag = indexPath.item
            cell.btnRadio.addTarget(self, action: #selector(selectRadioButton), for: .touchUpInside)
            cell.btnRadio.setTitle("", for: .normal)
            
            if arrayIsActive[indexPath.item] == true {
                cell.fillCircle.isHidden = false
            }else{
                cell.fillCircle.isHidden = true
            }
            
            return cell
            
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ActivitiesCardCollectionViewCell.reuseIdentifier, for: indexPath)
            let activity = nameTopics[indexPath.item]
            (cell as? ActivitiesCardCollectionViewCell)?.delegate = self
            (cell as? ActivitiesCardCollectionViewCell)?.activitiesNameLabel.text = activity.description
            return cell
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        switch collectionView {
        case radioBtnCollection:
            return 0.2
            
        default:
            return 2.0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        switch collectionView {
        case radioBtnCollection:
            return 0.5
        default:
            return 2.0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch collectionView {
        case churchCollection:
            switch miniContentSwitch.isHidden {
            case true:
                return CGSize(width: churchCollection.frame.width - 20, height: 255)
            
            default:
                return CGSize(width: churchCollection.frame.width - 20, height: 225)
            }
            
        case radioBtnCollection:
            return CGSize(width: 200, height: 40)
            
        default:
            return CGSize(width: 110 , height: 40)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    
    func deleteActivity(index: IndexPath) {
        nameTopics.remove(at: index.item)
        topicArray.remove(at: index.item)
        activityCollection.reloadData()
        let height = activityCollection.collectionViewLayout.collectionViewContentSize.height
        heightTopicColection.constant = height
        self.view.layoutIfNeeded()
        switch nameTopics.count {
        case 3:
            //  mainContentHeight.constant -= 50
            print("")
        case 6:
            // mainContentHeight.constant -= 50
            print("")
        default:
            break
        }
        if nameTopics.count == 0 {
            activityCollection.isHidden = true
            // mainContentHeight.constant -= 50
            
            print(nameTopics)
        }
    }
}


open class HttpRequestSingleton: NSObject {
    public static var shareManager = HttpRequestSingleton()
    
    public func convertImageToBase64String(img: UIImage) -> String {
        let imageData: Data? = img.jpegData(compressionQuality: 0.4)
        let imageStr = imageData?.base64EncodedString(options: .lineLength64Characters) ?? ""
        return imageStr
    }
    
    public func convertBase64StringToImage(imageBase64String: String) -> UIImage {
        var image = UIImage()
        if imageBase64String != "" {
            let dataDecoded: Data = Data(base64Encoded: imageBase64String, options: .ignoreUnknownCharacters)!
            image = UIImage(data: dataDecoded) ?? UIImage()
        } else {
            image = UIImage()
        }
        return image
    }
}

class ImagePickerManager: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var picker = UIImagePickerController();
    var alert = UIAlertController(title: "Escoger imagen", message: nil, preferredStyle: .actionSheet)
    var viewController: UIViewController?
    var pickImageCallback : ((UIImage) -> ())?;
    
    override init(){
        super.init()
        let cameraAction = UIAlertAction(title: "Camara", style: .default){
            UIAlertAction in
            self.openCamera()
        }
        let galleryAction = UIAlertAction(title: "Galeria", style: .default){
            UIAlertAction in
            self.openGallery()
        }
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel){
            UIAlertAction in
        }

        // Add the actions
        picker.delegate = self
        alert.addAction(cameraAction)
        alert.addAction(galleryAction)
        alert.addAction(cancelAction)
    }

    func pickImage(_ viewController: UIViewController, _ callback: @escaping ((UIImage) -> ())) {
        pickImageCallback = callback;
        self.viewController = viewController;

        alert.popoverPresentationController?.sourceView = self.viewController!.view

        viewController.present(alert, animated: true, completion: nil)
    }
    func openCamera(){
        alert.dismiss(animated: true, completion: nil)
        if(UIImagePickerController .isSourceTypeAvailable(.camera)){
            picker.sourceType = .camera
            self.viewController!.present(picker, animated: true, completion: nil)
        } else {
            let alertWarning = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertWarning.addAction(cancelAction)
            viewController?.present(alertWarning, animated: true, completion: nil)
        }
    }
    func openGallery(){
        alert.dismiss(animated: true, completion: nil)
        picker.sourceType = .photoLibrary
        self.viewController!.present(picker, animated: true, completion: nil)
    }

    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        pickImageCallback?(image)
    }

    @objc func imagePickerController(_ picker: UIImagePickerController, pickedImage: UIImage?) {
    }

}

// MARK:
extension ProfileInfoView {
    
    func succesUpload64(responseData: UploadImageData) {
        print("Upload image successfully")
       
        Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { (timer) in
            if self.imgChoosed != nil {
                self.userImg.image = self.imgChoosed
            }else{
                self.userImg.DownloadStaticImage(responseData.url ?? "nil")
            }
           
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.loadingAlert.dismiss(animated: true, completion: nil)
            }
        }       
       
    }
    
    func failUpload64() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.loadingAlert.dismiss(animated: true, completion: nil)
        }
        
    }
    
    func succesGetDetailProfile(responseData: ProfileDetailImg) {

        if responseData.data?.User?.image == nil {
            userImg.image = UIImage(named: "userImage", in: Bundle.local, compatibleWith: nil)
        }else{
            if imgChoosed != nil {
                userImg.image = imgChoosed
            }else{
                
                if responseData.data?.User?.image == "s/n" {
                    userImg.image = UIImage(named: "userImage", in: Bundle.local, compatibleWith: nil)
                }else{
                    userImg.DownloadStaticImage(responseData.data?.User?.image ?? "nil")
                }
            }
        }
    }
    
    func failGetDataProfile() {
    }
    
}

// MARK: TRANSITION DELEGATE -
extension ProfileInfoView: UIViewControllerTransitioningDelegate {
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        transition.isPresenting = false        
            if isLaico == true {
                if isCongregation == true {
                    if indexFlow == 0 {
                        let singleton = ProfileMapViewController.singleton
                        if singleton.nameChurch != "Unspecified" {
                            churchRespField.text = singleton.nameChurch
                        }else{
                            print("Is not a church from laico")
                        }
                    }else{
                        let singleton = CongregationsView.singleton
                        fieldsCollection[6].text = singleton.selectedCong
                    }
                }else{
                    let singleton = ProfileMapViewController.singleton
                    if singleton.nameChurch != "Unspecified" {
                        churchRespField.text = singleton.nameChurch
                    }else{
                        print("Is not a church from laico")
                    }
                }
               
            }else{
                if isCongregation == false {
                    let singleton = ProfileMapViewController.singleton
                    if singleton.nameChurch != "Unspecified" {
                        arrayChurches.removeAll()
                        arrayImgchurches.removeAll()
                        arrayChurches.append(singleton.nameChurch)
                        arrayImgchurches.append(singleton.urlImgChurch)
                        fieldsCollection[6].text = singleton.nameChurch
                        churchCollection.reloadData()
                        churchCollection.isHidden = false
                        let height = churchCollection.collectionViewLayout.collectionViewContentSize.height
                        heightChurchCollection.constant = height
                        self.view.layoutIfNeeded()
                        print(heightChurchCollection.constant)
                      
                    }else{
                        print("Is not a nameChurch  ")
                    }
                    
                }else{
                    print("return from congregation view")
                    let singleton = CongregationsView.singleton
                    fieldsCollection[6].text = singleton.selectedCong
                }
            }
            
        return transition
        
    }
    
}


