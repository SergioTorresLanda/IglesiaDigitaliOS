import Foundation
import UIKit
import EncuentroCatolicoVirtualLibrary
import Toast_Swift
import Firebase

class Home_Perfil: UIViewController {
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
    @IBOutlet weak var btnDelete: UIButton!
    
    static let sinleton = Home_Perfil()
// MARK: NEW GLOBAL VAR -
    var testStyle = "Religioso"
    var pickerLifeStyle: UIPickerView!
    var pickerServiceCong: UIPickerView!
    var pickerTopics: UIPickerView!
    var pickerPrefix: UIPickerView!
    var lifeStyleList : [String] = []
    var serviceCongList : [String] = []
    var serviceListID: [Int] = []
    var topicsList : [String] = []
    var selectedRow = 0
    var selectedRowServ = 0
    let transition = SlideTransition()
    var selectedAcitity = ""
    var isCongregation = false
    var arrayChurches : [String] = []
    var arrayImgchurches : [String] = []
    var arrayChurchesId : [Int] = []
    var nameService = [String]()
    var idService = [Int]()
    var mapChurchService : [Int:Int] = [:]
    var arrayServicesG : [Service] = []
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
    var alertFields : AcceptAlert?
    var typeService="iglesia"
    let screenName="OS_Home_Perfil"
    let screenClass="OS_Home_Perfil"
    
    static let singleton = Home_Perfil()
    let imgDefault = "https://firebasestorage.googleapis.com/v0/b/emerwise-479d1.appspot.com/o/randomAssets%2Fspirit.webp?alt=media&token=dd020c20-d8ec-45f6-a8a2-3783c0234012"
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
        return collection
    }()
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.frame.size = contentViewSize
        return view
    }()
    
     lazy var navBarImageView: UIImageView = setupNavBarImageView()
     lazy var titleLabel: UILabel = setupLabel("Perfil", font: .boldSystemFont(ofSize: 18.0), color: .white)
     lazy var toolButton: UIButton = setupToolButton()
     var changeImageButton: UIButton = {
            let button = UIButton(frame: .zero)
            button.setImage(UIImage(named: "profile_icon", in: Bundle(for: ProfileInfoRouter.self), compatibleWith: nil), for: .normal)
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()

     lazy var userImageView: UIImageView = setupUserImageView()
     lazy var nameLabel: UILabel = setupLabel("", font: .boldSystemFont(ofSize: 20.0), color: UIColor(red: 25 / 255, green: 42 / 255, blue: 115 / 255, alpha: 1.0))
    
     lazy var nameTextField: LineLabelTextField = setupTexfield(placeholder: "Nombre(s)")
     lazy var lastnameTextField: LineLabelTextField = setupTexfield(placeholder: "Apellido paterno")
     lazy var motherLastnameTextField: LineLabelTextField = setupTexfield(placeholder: "Apellido materno")
     lazy var phoneTextField: LineLabelTextField = setupTexfield(placeholder: "55 5555-5555", textLabel: "Número de celular")
     lazy var emailTextField: LineLabelTextField = setupTexfield(placeholder: "juanromero@mail.com", textLabel: "Email")
     lazy var lifeStateTextField: LineLabelTextField = setupTexfield(placeholder: "Selecciona", textLabel: "Estado de vida")
     lazy var serviceLabel: UILabel = setupLabel("¿Prestas algún servicio a la iglesia ya sea voluntario o remunerado?", font: .systemFont(ofSize: 13.0), color: UIColor(red: 160 / 255, green: 160 / 255, blue: 160 / 255, alpha: 1.0))
     lazy var radioButtonYes = setupRadioButton("Si")
     lazy var radioButtonNo = setupRadioButton("No")
     lazy var infoLabel: UILabel = setupLabelTwo("Inforrmación de Perfil", font: .boldSystemFont(ofSize: 16.0), color: UIColor(red: 25 / 255, green: 42 / 255, blue: 115 / 255, alpha: 1.0))
     lazy var profileUserInfoView = ProfileUserInfoViewController(nibName: "ProfileUserInfoViewController", bundle: Bundle.local)
     lazy var topicsTextField: LineLabelTextField = setupTexfield(placeholder: "Selecciona", textLabel: "Temas de Interés")
     lazy var saveButton: UIButton = setupSaveButton()
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
    func showLoading() {
        let imageView = UIImageView(frame: CGRect(x: 75, y: 25, width: 140, height: 60))
        imageView.image = UIImage(named: "logoEncuentro", in: Bundle.local, compatibleWith: nil)
        loadingAlert.view.addSubview(imageView)
        present(loadingAlert, animated: true, completion: nil)
    }
    func hideLoading() {
        loadingAlert.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let singleton = Home_Perfil.sinleton
        singleton.isPresentPriestAlert = false
        setupDelegates()
        setupUI()
        HideUpTopic()
        topicsTextField.delegate = self
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyBoard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        //presenter?.viewDidLoad() //esto va en el viewWillAppear para que se carguen los datos cada vez que surje la vista
        setupRadioBtnCollection()
       
        NotificationCenter.default.addObserver(self, selector: #selector(receiveProfileInfo(notification:)), name: Notification.Name("showUserINFO"), object: nil)
    }
    
    override func viewDidLayoutSubviews() {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("VC ECProfile - ProfileInfoVC ")
        for i in 0...arrayIsActive.count - 1{
            print(i)
            arrayIsActive[i] = false
        }
        //reset lists
        topicsList=[]
        arrayDictionariesTopics=[]
        nameTopics=[]
        lifeStyleList=[]
        codesLifeStatus=[]
        serviceCongList=[]
        serviceListID=[]
        AllServicesData=[]
        resetLists()
        
        showLoading()
        presenter?.viewDidLoad()
        let singleton = Home_Perfil.sinleton
        if singleton.isPresentPriestAlert == true {
            print("Mustra la alerta")
            singleton.isPresentPriestAlert = false
            let view = NewOnboardingRouter.createModule(typeOnboarding: "Priest")
            view.modalPresentationStyle = .overFullScreen
            self.present(view, animated: true, completion: nil)
        }
    }
    
// MARK: SETUP FUNC -
    private func setupUI() {
        oldConstant = mainContentHeight.constant
        customNavBar.ShadowNavBar()
        customNavBar.layer.cornerRadius = 20
        btnSave.layer.cornerRadius = 25
        userImg.image = UIImage(named: "userImage", in: Bundle.local, compatibleWith: nil)
        userImg.layer.cornerRadius = userImg.bounds.width / 2
        churchCollection.isHidden = true
        fieldsCollection[6].addTarget(self, action: #selector(TextBoxOn(_:)),for: .editingDidBegin)
        churchRespField.addTarget(self, action: #selector(TextBoxOnResp), for: .editingDidBegin)
        setupFieldPickers()
    }
    
     func setupFieldPickers() {
        pickerLifeStyle = UIPickerView()
        setupPickerField(pickerLifeStyle, tagPiker: 3, pos: 5)
        pickerServiceCong = UIPickerView()
        setupPickerField(pickerServiceCong, tagPiker: 4, pos: 8)
        pickerTopics = UIPickerView()
        setupPickerField(pickerTopics, tagPiker: 5, pos: 7)
        pickerPrefix = UIPickerView()
        setupPickerFieldPrefix(pickerPrefix)
    }
    
     func setupRadioBtnCollection() {
        radioBtnCollection.register(UINib(nibName: "RadioBtnCollectionViewCell", bundle: Bundle.local), forCellWithReuseIdentifier: "CELLRADIO")
        radioBtnCollection.delegate = self
        radioBtnCollection.dataSource = self
    }
    
    @IBAction func actionBtnDelete(_ sender: UIButton) {
        let correo = fieldsCollection[4].text ?? ""
        guard correo.isValidEmailSP() else{
            showCanonAlert(title: "Atención", msg: "Favor de validar su correo y guardar cambios.")
            //showAlert(str: "Favor de validar su correo y guardar cambios.")
            return
        }
        
        let alert = UIAlertController(title: "Aviso", message: "Al eliminar tu cuenta, se borrará tu usuario y no tendrás mas acceso a la la información, servicios, publicaciones realizados desde la misma.", preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel)
        let deleteAction = UIAlertAction(title: "Eliminar", style: .destructive) {
            [weak self] _ in
            guard let self = self else {return}
            self.presenter?.deleteAccount(email: correo)
            self.showLoading()
            }
        alert.addAction(cancelAction)
        alert.addAction(deleteAction)
        
        present(alert, animated: true)
    }
    func isSuccesDelete(result: Bool) {
        DispatchQueue.main.async {
            self.hideLoading()
            if result == true {
                let alert = UIAlertController(title: "Aviso", message: "La cuenta fue eliminada con éxito", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "Aceptar", style: .cancel){
                    [weak self] _ in
                    guard let self = self else {return}
                    UserDefaults.standard.removeObject(forKey: "nombre")
                    UserDefaults.standard.removeObject(forKey: "id")
                    
                    self.view.window?.rootViewController?.dismiss(animated: true) {
                        NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: "newLogOut"),
                                                                     object: nil, userInfo: nil))
                    }
                    
                    NotificationCenter.default.removeObserver(self, name: Notification.Name(rawValue: "newLogOut"), object: nil)
                    }
                alert.addAction(cancelAction)
                self.present(alert, animated: true)
            }else {
                self.showCanonAlert(title:"Error", msg: "No fue posible eliminar tu cuenta, intenta más tarde.")
            }
        }
    }
    
    func showAlert(str: String){
        let alerta = UIAlertController(title: "Aviso", message: str, preferredStyle: .alert)
        alerta.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: nil))
        self.present(alerta, animated: true, completion: nil)
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
            print("ACCEPT PIcKer 0")
            isLaico = true
            switchResponsable.isOn = true
            isCongregation = true
            lblStateResp.text = "No"
            switchResponsable.isOn = false
            btnSave.setTitle("Guardar", for: .normal)
            churchCollection.isHidden = true
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
            print("ACCEPT PIcKer 1")
            isLaico = false
            //churchCollection.isHidden = false
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
            prefixField.text = "Selecciona"
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
            print("ACCEPT PIcKer 2")
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
            prefixField.text = "Selecciona"
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
            print("ACCEPT PIcKer 3")
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
            prefixField.text = "Selecciona"
            lblYouCan.isHidden = true
            let height = activityCollection.collectionViewLayout.collectionViewContentSize.height
            heightTopicColection.constant = height
            self.view.layoutIfNeeded()
            hideOrShowPrefix(isShow: false)
            showLoading()
            presenter?.requestPrefixes(code: selectedCode)
         
        case 100:
            print("ACCEPT PIcKer 100")
            break
            
        case 101:
            print("ACCEPT PIcKer 101")
            selectTopicLogic()
            
        default:
            print("ACCEPT PIcKer def")
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
        self.view.endEditing(true)
        print("TEXT BOX ON")
        if arrayChurches.count==10{
            showCanonAlert(title: "¡Atención!", msg: "Puedes seleccionar un máximo de 10 iglesias")
            return
        }
        if isCongregation == false {
            lifeStatusSingleton="Laico"
            let view = ProfileMapWireFrame.createModuleMap(mapType: lifeStatusSingleton)
            view.modalPresentationStyle = .overFullScreen
            view.transitioningDelegate = self
            self.present(view, animated: true, completion: nil)
        }else{
            let view = CongregationRouter.createModule()
            view.modalPresentationStyle = .overFullScreen
            view.transitioningDelegate = self
            self.present(view, animated: true, completion: nil)
            indexFlow = 1
        }
    }
    
    @objc func TextBoxOnResp(_ texfield: UITextField) {
        print("TEXT BOX ON RESP")
        isLaico = true
        indexFlow = 0
        churchRespField.text = ""
        self.view.endEditing(true)
        lifeStatusSingleton="Laico"
        let view = ProfileMapWireFrame.createModuleMap(mapType: lifeStatusSingleton)
        view.modalPresentationStyle = .overFullScreen
        view.transitioningDelegate = self
        self.present(view, animated: true, completion: nil)
    }
    
    @objc func deleteChurchCard(sender: UIButton) {
        print(sender.tag)
        //let s2 = Home_Perfil.singleton
        arrayChurches.remove(at: sender.tag)
        arrayImgchurches.remove(at: sender.tag)
        let id=arrayChurchesId[sender.tag]
        arrayChurchesId.remove(at: sender.tag)
        let sPerfil = Home_Perfil.singleton
        sPerfil.mapChurchService.removeValue(forKey: id)
        //sPerfil.A
        print("quitar tarjeta")
        print("COUNT:: ARRAYCHURCHES")
        print(String(arrayChurchesId.count))
        print(String(sPerfil.mapChurchService.count))
        churchCollection.reloadData()
        if arrayChurches.count == 0 {
            churchCollection.isHidden = true
        }
        
        let singleton = Perfil_Mapa.singleton
        singleton.idChurch = nil
        fieldsCollection[6].text = ""
        
        let height = churchCollection.collectionViewLayout.collectionViewContentSize.height
        heightChurchCollection.constant = height
        self.view.layoutIfNeeded()

    }
    
    @objc private func hideKeyBoard() {
        view.endEditing(true)
    }
    
    @objc  func radioSelected(_ radio: RadioButton) {
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
        resetCardLists()
        if arrayIsActive[index] == true {
            print("ARRAY IS ACTIVE")
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
            print("ARRAY NOT ACTIVE")

            for i in 0...arrayIsActive.count - 1{
                print(i)
                arrayIsActive[i] = false
            }
            arrayIsActive[index] = true
            switch index {
            case 0://Iglesia
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
                fieldsCollection[6].placeholder = "Agregar iglesia en la que prestas el servicio"
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
                
            case 1://Comunidad
                let singleton = Perfil_Mapa.singleton
                singleton.idChurch = nil
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
                prefixField.text = "Selecciona"
                miniContentSwitch.isHidden = true
                serachStack.isHidden = true
                lineasViewCollection[6].isHidden = true
                miniContentCongregation.isHidden = true
                lblYouCan.isHidden = true
                cardLaico.isHidden = false
                cardLaico2.isHidden = false
                hideOrShowPrefix(isShow: true)
                serviceProvider = "COMMUNITY"
                                
            default://NO
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
    
    func resetCardLists(){
        let s = Home_Perfil.singleton
        arrayChurches=[]
        arrayChurchesId=[]
        arrayImgchurches=[]
        nameService=[]
        idService=[]
        s.mapChurchService=[:]
        churchCollection.reloadData()
    }
    
    func resetLists(){
        let s = Home_Perfil.singleton
        arrayChurches=[]
        arrayChurchesId=[]
        arrayImgchurches=[]
        nameService=[]
        idService=[]
        s.mapChurchService=[:]
    }
    
// MARK: GENERAL FUNCS -
     func saveChanges() {
         print("SAVE CHANGESS")
        let singleton = Perfil_Mapa.singleton
        let sPerfil = Home_Perfil.singleton
        let singleton3 = CongregationsView.singleton
        
        var loca: [Locations] = []
        let loca1 = Locations(id: singleton.idChurch)
        loca.append(loca1)
        
        var services: [Service] = []
        
        //Si es comunidad, tener seleccionado un servicio.
         if serviceProvider == "COMMUNITY" && sPerfil.selectedServiceID == 0 {
                showCanonAlert(title: "¡Atención!", msg: "Selecciona el servicio que prestas.")
                return
            }
        print("::::;;COUNTS::::::")
        //let resta = singleton2.arrayChurchesId.count-singleton2.mapChurchService.count
         let resta = arrayChurchesId.count-sPerfil.mapChurchService.count
         print(String(sPerfil.mapChurchService.count))
        print(String(arrayChurchesId.count))
        //Si es iglesia, para cada iglesia debe tener asignado un servicio
        if serviceProvider == "CHURCH" && resta > 0 {
            showCanonAlert(title: "¡Atención!", msg: "Falta seleccionar el servicio que prestas en "+String(resta)+" iglesia(s)")
            return
        }
        //singleton2.
        arrayChurchesId.forEach({ id in
            /*let s = Service(location_id: singleton.idChurch, service_id: singleton2.selectedServiceID)*/
            let s = Service(location_id: id, service_id: sPerfil.mapChurchService[id])
            print(s)
            services.append(s)
            print("se agrego iglesia")
            print(id)
        })
        
        var congregationA: [Congregation] = []
        let cong1 = Congregation(id: singleton3.selectedID)
        congregationA.append(cong1)
        
        let prefixObject = Prefix(id: selectedPrefixID)
         print(":::PREFIXX:::")
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
        case "Laico (a)":
            stateId = 4
        case "Religioso (a)":
            stateId = 5
        case "Diácono (Transitorio o permanente)":
            stateId = 6
        case "Sacerdote":
            stateId = 7
        default:
            break
        }
        let life: Status = Status(id: stateId, name: fieldsCollection[5].text ?? "")
        let validPrayer = fieldsCollection[5].text
        print("VALID PRAYER::  " + validPrayer!)
        switch validPrayer {
        case "Sacerdote":
            hideLoading()
            if(topicArray.isEmpty){
                showCanonAlert(title: "Atención", msg: "Selecciona al menos un tema de interés")
                return
            }
            if(prefixObject.id==0){
                showCanonAlert(title: "Atención", msg: "Selecciona un prefijo")
                return
            }
            //var prePP: PreProfilePriest = PreProfilePriest(prefix: prefixObject, interest_topics: topicArray)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                let view = ProfileInfoRouter.createModuleTwo()
                self.navigationController?.pushViewController(view, animated: true)
            })
                
        case "Religioso (a)":
            //showLoading()
            var idChurchReligioso = singleton.idChurch
            if churchRespField.text == "" {
                idChurchReligioso = 0
            }
            
            if cong1.id == 0 {
                print("CONFIG ID 0 ::  ")
                var registerReligioso: ProfileCongregation = ProfileCongregation(username: fieldsCollection[4].text ?? "", id: idGlobal, name: fieldsCollection[0].text ?? "", first_surname:  fieldsCollection[1].text ?? "", second_surname: fieldsCollection[2].text ?? "", phone_number: fieldsCollection[3].text ?? "", location_id: idChurchReligioso, email: fieldsCollection[4].text ?? "", life_status: life, prefix: prefixObject, interest_topics: topicArray, pastoral_work: fieldsCollection[9].text, profile: isResponsable)
                
                if selectedPrefixID == 0 {
                    registerReligioso = ProfileCongregation(username: fieldsCollection[4].text ?? "", id: idGlobal, name: fieldsCollection[0].text ?? "", first_surname:  fieldsCollection[1].text ?? "", second_surname: fieldsCollection[2].text ?? "", phone_number: fieldsCollection[3].text ?? "", location_id: idChurchReligioso, email: fieldsCollection[4].text ?? "", life_status: life, interest_topics: topicArray, pastoral_work: fieldsCollection[9].text, profile: isResponsable)
                }
                
                print(registerReligioso)
                presenter?.postLaicoReligioso(request: registerReligioso)
                
            }else{
                print("CONFIG ID NO 0 ::  ")
                var registerReli: ProfileCongregation = ProfileCongregation(username: fieldsCollection[4].text ?? "", id: idGlobal, name: fieldsCollection[0].text ?? "", first_surname:  fieldsCollection[1].text ?? "", second_surname: fieldsCollection[2].text ?? "", phone_number: fieldsCollection[3].text ?? "", location_id: idChurchReligioso, email: fieldsCollection[4].text ?? "", life_status: life, prefix: prefixObject, interest_topics: topicArray, congregation: cong1, pastoral_work: fieldsCollection[9].text, profile: isResponsable)
                
                if selectedPrefixID == 0 {
                    registerReli = ProfileCongregation(username: fieldsCollection[4].text ?? "", id: idGlobal, name: fieldsCollection[0].text ?? "", first_surname:  fieldsCollection[1].text ?? "", second_surname: fieldsCollection[2].text ?? "", phone_number: fieldsCollection[3].text ?? "", location_id: idChurchReligioso, email: fieldsCollection[4].text ?? "", life_status: life, interest_topics: topicArray, congregation: cong1, pastoral_work: fieldsCollection[9].text, profile: isResponsable)
                }
               
                print(registerReli)
                presenter?.postLaicoReligioso(request: registerReli)
            }
                    
        case "Laico (a)":
            
            var idChurchLaico = singleton.idChurch
            if churchRespField.text == "" {
                idChurchLaico = 0
            }
           // showLoading()
            var registerNewLaico = ProfileState(username: fieldsCollection[4].text ?? "", id: idGlobal, name: fieldsCollection[0].text ?? "", first_surname: fieldsCollection[1].text ?? "", second_surname: fieldsCollection[2].text ?? "", phone_number: fieldsCollection[3].text ?? "", email: fieldsCollection[4].text ?? "")
            //revisar serviceprovider
            print("::::::::SERVICE PROVIDER::::: "+serviceProvider)
            switch serviceProvider {
            case "CHURCH":
                registerNewLaico = ProfileState(username: fieldsCollection[4].text ?? "", id: idGlobal, name: fieldsCollection[0].text ?? "", first_surname: fieldsCollection[1].text ?? "", second_surname: fieldsCollection[2].text ?? "", phone_number: fieldsCollection[3].text ?? "", email: fieldsCollection[4].text ?? "", service_provider: serviceProvider, location_id: idChurchLaico, is_admin: false, life_status: life, interest_topics: topicArray, services_provided: services)
                
            case "COMMUNITY":
                if(!churchRespField.hasText){
                    showCanonAlert(title: "Atención", msg: "Selecciona la comunidad a la que prestas el servicio.")
                    return
                }
                registerNewLaico = ProfileState(username: fieldsCollection[4].text ?? "", id: idGlobal, name: fieldsCollection[0].text ?? "", first_surname: fieldsCollection[1].text ?? "", second_surname: fieldsCollection[2].text ?? "", phone_number: fieldsCollection[3].text ?? "", email: fieldsCollection[4].text ?? "", service_provider: serviceProvider, location_id: idChurchLaico, is_admin: isAdmin, life_status: life, interest_topics: topicArray, services_provided: services)
                
            case "NO":
                registerNewLaico = ProfileState(username: fieldsCollection[4].text ?? "", id: idGlobal, name: fieldsCollection[0].text ?? "", first_surname: fieldsCollection[1].text ?? "", second_surname: fieldsCollection[2].text ?? "", phone_number: fieldsCollection[3].text ?? "", email: fieldsCollection[4].text ?? "", service_provider: serviceProvider, life_status: life, interest_topics: topicArray)
        
            default:
                break
            }
            
            print(registerNewLaico)
            presenter?.postState(request: registerNewLaico)
            //presenter?.postLaicoReligioso(request: registerNewLaico)
            
        case "Diácono (Transitorio o permanente)":
            //showLoading()
            var registerDiacono: ProfileDiacono = ProfileDiacono(username: fieldsCollection[4].text ?? "", id: idGlobal, name: fieldsCollection[0].text ?? "", first_surname: fieldsCollection[1].text ?? "", second_surname: fieldsCollection[2].text ?? "", phone_number: fieldsCollection[3].text ?? "" , email: fieldsCollection[4].text ?? "", life_status: life, prefix: prefixObject, interest_topics: topicArray , locations: loca)
            if selectedPrefixID == 0 {
                registerDiacono = ProfileDiacono(username: fieldsCollection[4].text ?? "", id: idGlobal, name: fieldsCollection[0].text ?? "", first_surname: fieldsCollection[1].text ?? "", second_surname: fieldsCollection[2].text ?? "", phone_number: fieldsCollection[3].text ?? "" , email: fieldsCollection[4].text ?? "", life_status: life, interest_topics: topicArray , locations: loca)
            }
            if fieldsCollection[6].text == "" {
                showCanonAlert(title:"Error", msg: "Selecciona una iglesia.")
            }else{
                presenter?.postDiacono(request: registerDiacono)
            }
            
        case "Soltero", "Casado", "Viudo":
            //showLoading()
            let registerState: ProfileState = ProfileState(username: fieldsCollection[4].text ?? "", id: idGlobal, name: fieldsCollection[0].text ?? "", first_surname: fieldsCollection[1].text ?? "", second_surname: fieldsCollection[2].text ?? "", phone_number: fieldsCollection[3].text ?? "", email: fieldsCollection[4].text ?? "", life_status: life, interest_topics: topicArray, services_provided: services)
            print(registerState)
            presenter?.postState(request: registerState)
            
            break
            
        default:
            showCanonAlert(title:"Error", msg: "Llena correctamente los datos.")
        }
    }
    
    func showCanonAlert(title:String, msg:String){
        hideLoading()
        print("SHOW CANON ALERT")
        print(msg)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            self.alertFields = AcceptAlert.showAlert(titulo: title, mensaje: msg)
            self.alertFields!.view.backgroundColor = .clear
            self.present(self.alertFields!, animated: true)
         })
    }
    
    func successLaicoReligioso() {
        showCanonAlert(title:"Éxito", msg: "Datos guardados correctamente.")
    }
    
    func failLaicoReligioso() {
        showCanonAlert(title:"Error",msg: "Hubo un error, póngase en contacto con el administrador.")
    }
    
    func successDiacano() {
        showCanonAlert(title:"Éxito", msg: "Datos guardados correctamente.")
    }
    
    func failDiacano() {
        showCanonAlert(title:"Error", msg: "Hubo un error, póngase en contacto con el administrador.")
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
            showCanonAlert(title:"Atención", msg: "La actividad ya se encuetra agregada.")
        }else{
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
    
    // MARK: Private Methods
    
    func showCongregations(congregation: CongregationsResponse) {
        congregationIdArray = congregation
        //print(congregation)
    }
    
// MARK: NEW @IBACTIONS -
    @IBAction func changeState(_ sender: Any) {
        if switchState.isOn  {
            serachStack.isHidden = false
            lineasViewCollection[6].isHidden = false
            lblState.text = "Sí"
        }else{
            serachStack.isHidden = true
            lineasViewCollection[6].isHidden = true
            lblState.text = "No"
            churchCollection.isHidden = true
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
                self.showLoading()
            }
             self.presenter?.uploadImageBase64(elementID: idUser, type: "PROFILE", filename: "test-picture\(replaced).png", contentBase64: convertImageToBase64String2(img: image))
            
        }
    }
    
    @IBAction func gearAction(_ sender: Any) {
        presenter?.showConfigController()
    }
    
    @IBAction func saveAction(_ sender: Any) {
        showLoading()
        saveChanges()
        lblUserName.text = "\(fieldsCollection[0].text ?? "") \(fieldsCollection[1].text ?? "") \(fieldsCollection[2].text ?? "")"
    }
    
    @IBAction func searchResponsableChurch(_ sender: Any) {
        isLaico = true
        indexFlow = 0
        churchRespField.text = ""
        lifeStatusSingleton = "LaicoCom"
      
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
    }
    
    @IBAction func donacionesAction(_ sender: Any) {
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
                self.showLoading()
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
    
    @objc  func didSaveAction() {
        print("DID SAVE ACTION")
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
        case "Laico (a)":
            stateId = 4
        case "Religioso (a)":
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
            print("DID SAVE ACTION SACERDOTE")
            //let view = ProfileInfoRouter.createModuleTwo()
            //navigationController?.pushViewController(view, animated: true)
        case "Díacono(Transitorio o permanente)", "Religioso (a)":
            let registerDiacono: ProfileDiacono = ProfileDiacono(username: fieldsCollection[4].text ?? "", id: idGlobal, name: fieldsCollection[0].text ?? "", first_surname: fieldsCollection[1].text ?? "", second_surname: fieldsCollection[2].text ?? "", phone_number: fieldsCollection[3].text ?? "" , email: fieldsCollection[4].text ?? "", life_status: life, interest_topics: topicArray , locations: loca)
            print(registerDiacono)
           // presenter?.postDiacono(request: registerDiacono)
            break
            
        case "Laico (a)":
            let registerDiacono: ProfileDiacono = ProfileDiacono(username: fieldsCollection[4].text ?? "", id: idGlobal, name: fieldsCollection[0].text ?? "", first_surname: fieldsCollection[1].text ?? "", second_surname: fieldsCollection[2].text ?? "", phone_number: fieldsCollection[3].text ?? "" , email: fieldsCollection[4].text ?? "", life_status: life, interest_topics: topicArray , locations: loca, services_provided: services)
            print("REGISTER FROM DidSaveAction")
            print(registerDiacono)
           // presenter?.postDiacono(request: registerDiacono)
            break
            
        case "Soltero", "Casado", "Viudo":
            let registerState: ProfileState = ProfileState(username: fieldsCollection[4].text ?? "", id: idGlobal, name: fieldsCollection[0].text ?? "", first_surname: fieldsCollection[1].text ?? "", second_surname: fieldsCollection[2].text ?? "", phone_number: fieldsCollection[3].text ?? "", email: fieldsCollection[4].text ?? "", life_status: life, interest_topics: topicArray, services_provided: services)
            print(registerState)
            
            break
        default:
            showCanonAlert(title:"Error",msg: "Llena correctamente los datos.")
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
        print("Sacerdote Action")
        presenter?.showSoySacerdotecontroller(navegationController: navigationController!)
    }
    
     func createPicker(texfield: UITextField, tag: Int, with selector: Selector) {
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
    
     func hidePartial() {
        self.up?.isActive = false
        self.down?.isActive = true
        self.bottom?.isActive = false
        self.view.layoutSubviews()
        self.view.layoutIfNeeded()
    }
    
     func ShowUpTopic() {
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
