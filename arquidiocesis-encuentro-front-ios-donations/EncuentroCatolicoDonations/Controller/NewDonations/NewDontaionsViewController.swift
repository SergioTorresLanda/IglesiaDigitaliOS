//
//  NewDontaionsViewController.swift
//  EncuentroCatolicoDonations
//
//  Created by Pablo Luis Velazquez Zamudio on 21/02/22.

// FlowID 0 = Es el flujo de el listado de iglesias
// FlowID 1 = Es el flujo de facturacion
// FlowID 2 = Es el flujo donde se selecciona concecpto y monto de donación
// FlowID 3 = Es el flujo del webView

import UIKit
import WebKit
import SwiftSoup
import EncuentroCatolicoProfile
import CryptoSwift
import EncuentroCatolicoUtils
import Alamofire
import Network
import EncuentroCatolicoVirtualLibrary

class NewDontaionsViewController: BaseVC, NewDontaionsViewProtocol {
  
    // MARK: @IBOUTLETS -
    @IBOutlet weak var customNavbar: UIView!
    @IBOutlet weak var lblNavbar: UILabel!
    @IBOutlet weak var backIcon: UIButton!
    @IBOutlet weak var mainScroll: UIScrollView!
    @IBOutlet weak var mainContentView: UIView!
    
    // Profile Content View
    @IBOutlet weak var profileContent: UIView!
    
    // Menu Content View
    @IBOutlet weak var menuContentView: UIView!
    @IBOutlet weak var viewToShadow: UIView!
    @IBOutlet weak var menuCollection: UICollectionView!
    
    // SearchContentView
    @IBOutlet weak var searchContent: UIView!
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var btnSearch: UIButton!
    
    // Main church content view
    @IBOutlet weak var mainChurchContent: UIView!
    @IBOutlet weak var lblMainChurchContent: UILabel!
    @IBOutlet weak var mainChurchComTable: UITableView!
    @IBOutlet weak var heightMainChurchComm: NSLayoutConstraint!
    @IBOutlet weak var contentMainChurchTable: UIView!
    
    // Favorites church view
    @IBOutlet weak var favoriteViewMainContent: UIView!
    @IBOutlet weak var lblFavoriteChurch: UILabel!
    @IBOutlet weak var contentFavoriteTableContent: UIView!
    @IBOutlet weak var favoriteChurchTable: UITableView!
    @IBOutlet weak var heightFavoriteChurch: NSLayoutConstraint!
    
    // Suggestions / help encuentro
    @IBOutlet weak var suggestionsChurchMainView: UIView!
    @IBOutlet weak var lblSuggestionsChurch: UILabel!
    @IBOutlet weak var contentSuggestionsTableView: UIView!
    @IBOutlet weak var suggestionsChurchTable: UITableView!
    @IBOutlet weak var heightSuggestionsChurch: NSLayoutConstraint!
    
    // Detail and Donate stack
    @IBOutlet weak var churchListStack: UIStackView!
    @IBOutlet weak var detailChurchStack: UIStackView!
    
    // Content card detail
    @IBOutlet weak var cardDetailContainerView: UIView!
    @IBOutlet weak var cardDetail: UIView!
    @IBOutlet weak var churchDetailImg: UIImageView!
    @IBOutlet weak var lblChurchNameDetail: UILabel!
    
    // Content concept
    @IBOutlet weak var conceptContainerView: UIView!
    @IBOutlet weak var subContainerConcept: UIView!
    @IBOutlet weak var pullDownButton: UIButton!
    @IBOutlet weak var pullDownBtnMonto: UIButton!
    
    @IBOutlet weak var lblConcept: UILabel!
    @IBOutlet weak var conceptField: UITextField!
    @IBOutlet weak var firstLineView: UIView!
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var amountField: UITextField!
    @IBOutlet weak var secondLineView: UIView!
    @IBOutlet weak var specifyField: UITextField!
    @IBOutlet weak var lineSpecify: UIView!
    @IBOutlet weak var otherAmountField: UITextField!
    @IBOutlet weak var lineOtherAmount: UIView!
    
    //  Radio button container
    @IBOutlet weak var radioButtonContainer: UIView!
    @IBOutlet weak var lblWantCheck: UILabel!
    @IBOutlet weak var radioBtnYesCollection: UICollectionView!
    
    // Stack botones cancelar y aceptar
    @IBOutlet weak var stackBtns: UIStackView!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnContinue: UIButton!
    @IBOutlet weak var containerBtnsAccept: UIView!
    
    // Add tax data view
    @IBOutlet weak var addDataContainerView: UIView!
    @IBOutlet weak var lblData: UILabel!
    @IBOutlet weak var lblDataBillingNew: UILabel!
    
    @IBOutlet weak var addDataView: UIView!
    @IBOutlet weak var addDataBtn: UIButton!
    
    // Formulary tax data
    @IBOutlet weak var formularyTaxContainer: UIView!
    @IBOutlet var lblFormularyCollection: [UILabel]!
    
    @IBOutlet weak var taxSocialReasonField: ECUField!
    @IBOutlet weak var taxRFCField: ECUField!
    @IBOutlet weak var taxAddressField: ECUField!
    @IBOutlet weak var taxColonyField: ECUField!
    @IBOutlet weak var taxCPField: ECUField!
    @IBOutlet weak var taxTownHallField: ECUField!
    @IBOutlet weak var taxEmailField: ECUField!
    
    
    @IBOutlet weak var emptySquare: UIImageView!
    @IBOutlet weak var checkSquare: UIImageView!
    @IBOutlet weak var checkBtn: UIButton!
    @IBOutlet weak var btnSave: UIButton!
    
    @IBOutlet weak var lblContainerView: UIView!
    
    // Timer View
    @IBOutlet weak var firstTimerView: UIView!
    @IBOutlet weak var secondTimerView: UIView!
    @IBOutlet weak var thirdTimerView: UIView!
    @IBOutlet weak var firstTwoPoints: UIButton!
    @IBOutlet weak var secondTwoPoints: UIButton!
    @IBOutlet weak var firstLblTimer: UILabel!
    @IBOutlet weak var secondLblTimer: UILabel!
    @IBOutlet weak var thirdLblTimer: UILabel!
    
    // Loader Timer View
    @IBOutlet weak var loaderTimerView: UIView!
    @IBOutlet weak var loaderLbl: UILabel!
    @IBOutlet weak var loaderImg: UIImageView!
    @IBOutlet weak var webViewContainer: UIView!
    @IBOutlet weak var lblCOffering: UILabel!
    @IBOutlet weak var lblAOffering: UILabel!
    @IBOutlet weak var btnCancelar: UIButton!
    
    var myWebView = WKWebView()
    
    @IBOutlet weak var changeContainerView: UIView!
    @IBOutlet weak var btnChangeData: UIButton!
    @IBOutlet weak var bottomArrowConstraint: NSLayoutConstraint!
    // MARK: PROTOCOL VAR -
    var presenter: NewDontaionsPresneterProtocol?
    lazy var fieldList: [ECUField] = [
        taxSocialReasonField,
        taxRFCField,
        taxAddressField,
        taxColonyField,
        taxCPField,
        taxTownHallField,
        taxEmailField
    ]
    // MARK: LOCAL VAR -
    var menuLine: UIView!
    var menuItems = ["", "Ofrenda", "", "Facturar", ""]
    var menuIcons = ["", "heart.fill", "", "doc.plaintext.fill", ""]
    var itemsRadioBtn = ["Si", "No"]
    var conceptType = ["Selecciona concepto", "Ofrenda", "Diezmo", "Limosna", "Pago de una intención", "pago de un servicio", "Otro"]
    var amountList = ["10", "50", "100", "200", "300", "400", "500", "1000", "Otra"]
    var isActive = [false, true]
    var withBill: Bool {
        isActive[safe: 0] ?? false
    }
    var listFavoritesLocations = [LocationsDontaions]()
    var churchSuggestedList = [ChurchesSuggested]()
    var listMainLocations = [AssignedDonations]()
    var churchSelectedName = ""
    var churchSelectedImg = ""
    var churchSelecrtedId = 0
    let loadingAlert = UIAlertController(title: "", message: "\n \n \n \n \nCargando...", preferredStyle: .alert)
    var automaticBilling = false
    var pickerDontaion = UIPickerView()
    var pickerAmount = UIPickerView()
    var isEditingData = false
    var billingId = 0
    var miliSeconds = 99
    var seconds = 59
    var minutes = 4
    var timeLapse : Timer?
    var flowId = 0
    var billingData = [BillingData]()
    let transition = SlideTransition()
    let defaults = UserDefaults.standard
    var responseData: String?
    let monitor = NWPathMonitor()
    var isInternet=false
    var alertFields : AcceptAlert?
    
    // MARK: LIFE CYCLE VIEW FUNCTIONS -
    func isValidRFC(rfc: String) -> Bool {
        let rfcPatternPm = "^(([A-ZÑ&]{3})([0-9]{2})([0][13578]|[1][02])(([0][1-9]|[12][\\d])|[3][01])([A-Z0-9]{3}))|" +
            "(([A-ZÑ&]{3})([0-9]{2})([0][13456789]|[1][012])(([0][1-9]|[12][\\d])|[3][0])([A-Z0-9]{3}))|" +
            "(([A-ZÑ&]{3})([02468][048]|[13579][26])[0][2]([0][1-9]|[12][\\d])([A-Z0-9]{3}))|" +
            "(([A-ZÑ&]{3})([0-9]{2})[0][2]([0][1-9]|[1][0-9]|[2][0-8])([A-Z0-9]{3}))$"
        
        let rfcPatternPf = "^(([A-ZÑ&]{4})([0-9]{2})([0][13578]|[1][02])(([0][1-9]|[12][\\d])|[3][01])([A-Z0-9]{3}))|" +
            "(([A-ZÑ&]{4})([0-9]{2})([0][13456789]|[1][012])(([0][1-9]|[12][\\d])|[3][0])([A-Z0-9]{3}))|" +
            "(([A-ZÑ&]{4})([02468][048]|[13579][26])[0][2]([0][1-9]|[12][\\d])([A-Z0-9]{3}))|" +
            "(([A-ZÑ&]{4})([0-9]{2})[0][2]([0][1-9]|[1][0-9]|[2][0-8])([A-Z0-9]{3}))$"
        
        let validationPm = NSPredicate(format:"SELF MATCHES %@", rfcPatternPm)
        let validationPf = NSPredicate(format:"SELF MATCHES %@", rfcPatternPf)
        
        return validationPm.evaluate(with: self) || validationPf.evaluate(with: self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInternetObserver()
  
        setupCollections()
        setupUI()
        setupTables()
        setupFieldsDelegate()
        setupGestures()
        setupFields()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("VC ECDonations - NewDonations")
        if isInternet {
            showLoading()
            presenter?.requestChurchList(category: "CHURCH")
            presenter?.requestSuggestedList()
        } else {
            self.alertFields = AcceptAlert.showAlert(titulo: " ¡Atención!", mensaje: "No tienes conexión a internet")
            self.alertFields!.view.backgroundColor = .clear
            self.present(self.alertFields!, animated: true)
        }
    }
    
    // MARK: SETUP FUNCTIONS -
    
    func setupInternetObserver(){
        monitor.pathUpdateHandler = { pathUpdateHandler in
                   if pathUpdateHandler.status == .satisfied {
                       print("Internet connection is on.")
                       self.isInternet=true
                   } else {
                       print("There's no internet connection.")
                       self.isInternet=false
                   }
               }
               let queue = DispatchQueue(label: "Network")
               monitor.start(queue: queue)
    }
    
    private func setupUI() {
        customNavbar.layer.cornerRadius = 20
        customNavbar.ShadowNavBar()
        profileContent.isHidden = true
        btnCancelar.isHidden = true
        backIcon.setTitle("", for: .normal)
        btnSearch.titleLabel?.numberOfLines = 1
        btnSearch.titleLabel?.adjustsFontSizeToFitWidth = true
        contentMainChurchTable.layer.cornerRadius = 10
        contentMainChurchTable.ShadowCard()
        contentFavoriteTableContent.layer.cornerRadius = 10
        contentFavoriteTableContent.ShadowCard()
        contentSuggestionsTableView.layer.cornerRadius = 10
        contentSuggestionsTableView.ShadowCard()
        
        let statixMinX = menuCollection.frame.minX - 20
        var axisX = 61
        axisX += Int(statixMinX)
        menuLine = UIView(frame: CGRect(x: axisX, y: Int(menuCollection.frame.maxY), width: 61, height: 3))
        menuLine.backgroundColor = UIColor.init(red: 1/255, green: 32/255, blue: 104/255, alpha: 1)
        menuLine.layer.cornerRadius = 3
        viewToShadow.addSubview(menuLine)
        
        // Second Sections Objects
        cardDetail.layer.cornerRadius = 10
        churchDetailImg.layer.cornerRadius = 10
        cardDetail.layer.borderWidth = 0.5
        cardDetail.layer.borderColor = UIColor(red: 175/255, green: 175/255, blue: 175/255, alpha: 1).cgColor
        
        btnCancel.layer.cornerRadius = 8
        btnCancel.layer.borderWidth = 0.5
        btnCancel.layer.borderColor = UIColor(red: 25/255, green: 42/255, blue: 115/255, alpha: 1).cgColor
        btnContinue.layer.cornerRadius = 8
        
        // Add tax data view
        addDataView.layer.cornerRadius = 9
        addDataView.ShadowCard()
        
        // Formulary Tax Data
        formularyTaxContainer.layer.cornerRadius = 9
        formularyTaxContainer.ShadowCard()
        btnSave.layer.cornerRadius = 8
        checkBtn.setTitle("", for: .normal)
        
        viewToShadow.ShadowCard()
        
        firstTimerView.layer.cornerRadius = 8
        secondTimerView.layer.cornerRadius = 8
        thirdTimerView.layer.cornerRadius = 8
        
        firstTimerView.ShadowCard()
        secondTimerView.ShadowCard()
        thirdTimerView.ShadowCard()
        firstTwoPoints.setTitle("", for: .normal)
        secondTwoPoints.setTitle("", for: .normal)
        
        btnChangeData.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        
        btnCancelar.layer.cornerRadius = 8
        btnCancelar.layer.borderWidth = 0.5
        btnCancelar.layer.borderColor = UIColor(red: 25/255, green: 42/255, blue: 115/255, alpha: 1).cgColor
    }
    
    private func setupFieldsDelegate() {
        conceptField.delegate = self
        setupPickerField(pickerDontaion)
        
        otherAmountField.delegate = self
        specifyField.delegate = self
        
        amountField.delegate = self
        setupPickerFieldAmount(pickerAmount)
    }
    
    private func setupGestures() {
        let tapSuperview = UITapGestureRecognizer(target: self, action: #selector(TapSuperview))
        self.addDataContainerView.addGestureRecognizer(tapSuperview)
        
        let tapSuperview2 = UITapGestureRecognizer(target: self, action: #selector(TapSuperview2))
        self.detailChurchStack.addGestureRecognizer(tapSuperview2)
    }
    
    func showLoading() {
        let imageView = UIImageView(frame: CGRect(x: 75, y: 25, width: 140, height: 60))
        imageView.image = UIImage(named: "logoEncuentro", in: Bundle.local, compatibleWith: nil)
        loadingAlert.view.addSubview(imageView)
        present(loadingAlert, animated: true, completion: nil)
    }
    
    private func setupWebView() {
        let contentController = WKUserContentController()
        contentController.add(self, name: "sumbitToiOS")
        let config = WKWebViewConfiguration()
        config.userContentController = contentController
        myWebView.navigationDelegate = self
        myWebView = WKWebView(frame: webViewContainer.frame, configuration: config)
        webViewContainer.addSubview(myWebView)
        myWebView.translatesAutoresizingMaskIntoConstraints = false
        
        let leading = myWebView.leadingAnchor.constraint(equalTo: webViewContainer.leadingAnchor)
        let trailing = myWebView.trailingAnchor.constraint(equalTo: webViewContainer.trailingAnchor)
        let top = myWebView.topAnchor.constraint(equalTo: webViewContainer.topAnchor)
        let bottom = myWebView.bottomAnchor.constraint(equalTo: webViewContainer.bottomAnchor)
        
        webViewContainer.addConstraints([leading, top, trailing, bottom])
        guard let url = URL(string: setSecureURL() ?? "") else { return }
        print("URLWEBPAY👹",url)
        myWebView.load(URLRequest(url: url))
        // Sencilla
        //https://qamiofrenda.pamatz.com/pagos/data?amount=1&email=rdpamatz@gmail.com&name=Roman&surnames=Pamatz&phone_number=5516171324&location_id=629&operation_id=68844
        // Con facturacion
        //https://qamiofrenda.pamatz.com/pagos/data?amount=1&email=rdpamatz@gmail.com&name=Roman&surnames=Pamatz&phone_number=5516171324&location_id=629&operation_id=68844&rfc=PPP212121XXX&business_name=TEST&address=Calle,1&neighborhood=colonia&municipality=municipio&zipcode=00000
        // self.webView = WKWebView( frame: self.containerView!.bounds, configuration: config)
        // self.view = self.webView
    }
    
    private func setSecureURL() -> String? {
        var amount = amountField.text?.replacingOccurrences(of: "$", with: "") ?? ""
        let name = defaults.string(forKey: "OnlyName") ?? ""
        let surname = defaults.string(forKey: "LastName2") ?? ""
        let phone = defaults.string(forKey: "phone2") ?? ""
        let email = taxEmailField.text == "" ? defaults.string(forKey: "email") ?? "" : taxEmailField.text
        let rfc = taxRFCField.text
        let address = taxAddressField.text
        let neighborhood = taxColonyField.text
        let zipCode = taxCPField.text
        let municipality = taxTownHallField.text
        let businessName = taxSocialReasonField.text
        
        if amount == "Otra" {
            amount = otherAmountField.text ?? ""
        }
        let valuleAmount = Int(amount ) ?? 0
        
        if  valuleAmount   < 9 {
            let alert = UIAlertController(title: "Aviso", message: "¡Gracias! Desafortunadamente no podemos recibir ofrendas menores a $10 pesos.", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Aceptar", style: .cancel){
                [weak self] _ in
                guard let self = self else {return}
                self.navigationController?.popViewController(animated: true)
            }
            alert.addAction(cancelAction)
            
            self.present(alert, animated: true)
        } else if valuleAmount >= 10000 {
            let alert = UIAlertController(title: "Aviso", message: "No es posible recibir ofrendas superiores a $10,000 pesos. Cualquier duda favor de comunicarte a contacto@miofrenda.mx", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Aceptar", style: .cancel){
                [weak self] _ in
                guard let self = self else {return}
                self.navigationController?.popViewController(animated: true)
            }
            alert.addAction(cancelAction)
            
            self.present(alert, animated: true)
        }
        let donationRequest = withBill ? DonationRequest(amount: amount, email: email, locationId: String(churchSelecrtedId), name: name, operationId: "68844", phoneNumber: phone, surnames: surname, rfc: rfc, businessName: businessName, address: address, neighborhood: neighborhood, municipality: municipality, zipcode: zipCode) : DonationRequest(amount: amount, email: email, locationId: String(churchSelecrtedId), name: name, operationId: "68844", phoneNumber: phone, surnames: surname)
        print("DONACION👹",donationRequest)
        guard let jsonData = try? JSONEncoder().encode(donationRequest),
              let json = String(data: jsonData, encoding: String.Encoding.utf8),
              let resultString = SecurityUtils.encryptForWebView(json)?.base64EncodedString() else {
            print("DONACION 2💀",donationRequest)
            return nil
        }
        
        print("RESULT😵‍💫",resultString)
        if conceptField.text == "Otro"{
            lblCOffering.text = specifyField.text ?? ""
        }else{
            lblCOffering.text = conceptField.text ?? ""
        }
        
        if amountField.text == "Otra"{
            lblAOffering.text = "$" + (otherAmountField.text ?? "") + ".00 M. N."
        }else{
            lblAOffering.text = (amountField.text ?? "") + ".00 M. N."
        }
        
        
        return "\(APIType.shared.myOffer())/pagos/data/v2?data=\(resultString.addingPercentEncoding(withAllowedCharacters: .afURLQueryAllowed)?.replacingOccurrences(of: "/", with: "%2F") ?? "")"
        
        
    }

    private func setupTables() {
        mainChurchComTable.register(UINib(nibName: "MainChurchCommTableCell", bundle: Bundle.local), forCellReuseIdentifier: "CELLCHURCHCOMM")
        mainChurchComTable.delegate = self
        mainChurchComTable.dataSource = self
        
        favoriteChurchTable.register(UINib(nibName: "MainChurchCommTableCell", bundle: Bundle.local), forCellReuseIdentifier: "CELLCHURCHCOMM")
        favoriteChurchTable.delegate = self
        favoriteChurchTable.dataSource = self
        
        suggestionsChurchTable.register(UINib(nibName: "MainChurchCommTableCell", bundle: Bundle.local), forCellReuseIdentifier: "CELLCHURCHCOMM")
        suggestionsChurchTable.delegate = self
        suggestionsChurchTable.dataSource = self
    }
    
    private func setupCollections() {
        menuCollection.register(UINib(nibName: "MenuCollectionCell", bundle: Bundle.local), forCellWithReuseIdentifier: "MENUCELL")
        menuCollection.delegate = self
        menuCollection.dataSource = self
        
        radioBtnYesCollection.register(UINib(nibName: "radioBtnYesCollectionCell", bundle: Bundle.local), forCellWithReuseIdentifier: "RADIOBTNYES")
        radioBtnYesCollection.delegate = self
        radioBtnYesCollection.dataSource = self
    }
    
    private func setupPickerField(_ picker: UIPickerView) {
        picker.frame = CGRect(x: 0, y: 200, width: view.frame.width, height: 200)
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
        
        conceptField.inputView = picker
        conceptField.inputAccessoryView = toolBar
        picker.delegate = self
        picker.dataSource = self
    }
    
    private func setupPickerFieldAmount(_ picker: UIPickerView) {
        picker.frame = CGRect(x: 0, y: 200, width: view.frame.width, height: 200)
        picker.showsSelectionIndicator = true
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Aceptar", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.acceptPickerAmount))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancelar", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.cancelPickerAmount))
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.items?.forEach({ (button) in
            button.tintColor = UIColor.init(red: 25/255, green: 42/255, blue: 115/255, alpha: 1)
        })
        
        toolBar.isUserInteractionEnabled = true
        
        amountField.inputView = picker
        amountField.inputAccessoryView = toolBar
        picker.delegate = self
        picker.dataSource = self
    }

    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default) { action in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(ok)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func startTimer() {
        timeLapse = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(handleTimer), userInfo: nil, repeats: true)
    }
    @IBAction func btnActionCancel(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: @IBACTIONS -
    @IBAction func backAction(_ sender: Any) {
        
        switch flowId {
        case 0, 1:
            self.navigationController?.popViewController(animated: true)
            
        case 2:
            lblContainerView.isHidden = false
            searchContent.isHidden = false
            churchListStack.isHidden = false
            detailChurchStack.isHidden = true
            flowId = 0
            
        case 3:
            webViewContainer.isHidden = true
            profileContent.isHidden = true
            btnCancelar.isHidden = true
            menuContentView.isHidden = false
            lblContainerView.isHidden = false
            searchContent.isHidden = false
            churchListStack.isHidden = false
            flowId = 2
            timeLapse?.invalidate()
            minutes = 4
            seconds = 59
            miliSeconds = 100
            firstLblTimer.text = "05"
            secondLblTimer.text = "00"
            thirdLblTimer.text = "00"
            
        default:
            break
        }
        
    }
    
    @IBAction func searchAction(_ sender: Any) {
        //let view = MapDonationsRouter.createModule()
        let view = ProfileMapWireFrame.createModuleMap(mapType: "Donations")
        view.modalPresentationStyle = .overFullScreen
        view.transitioningDelegate = self
        self.present(view, animated: true, completion: nil)
        // self.navigationController?.pushViewController(view, animated: true)
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        detailChurchStack.isHidden = true
        lblContainerView.isHidden = false
        searchContent.isHidden = false
        churchListStack.isHidden = false
    }
    
    @IBAction func continueAction(_ sender: Any) {
        self.setupWebView()
        if isActive[1] == true {
            if conceptField.text != "" && amountField.text != "" {
                self.setupWebView()
                flowId = 3
                menuContentView.isHidden = true
                lblContainerView.isHidden = true
                searchContent.isHidden = true
                detailChurchStack.isHidden = true
                profileContent.isHidden = false
                btnCancelar.isHidden = false
                // loaderTimerView.isHidden = false
                startTimer()
                webViewContainer.isHidden = false
                //                    self.myWebView.evaluateJavaScript("function showToast() { document.getElementById('tarjeta').value='12342565768976' }") { value, error in
                //                    }
                self.myWebView.evaluateJavaScript("function showToast() { webkit.messageHandlers.callbackHandler.postMessage('Algo de texto') }") { value, error in
                }
                
                self.myWebView.evaluateJavaScript("document.getElementsByTagName('button')[0].style.color='black'") { value, error in
                }
                
                self.myWebView.evaluateJavaScript("document.getElementsByTagName('button')[0].onclick=showToast") { value, error in
                }
                
                
            }else{
                let alert = AcceptAlertDonations.showAlert(message: "Por favor llena todos los campos", btnTitle: "Ok")
                alert.modalPresentationStyle = .overFullScreen
                self.present(alert, animated: true, completion: nil)
            }
            
        }else if isActive[0] == true{
            self.setupWebView()
            if billingData.count == 0 {
                guard self.validateForm() else {
                    return
                }
                
                presenter?.saveBillingData(method: "POST", taxId: 0, businessName: taxSocialReasonField.text, rfc: taxRFCField.text, address: taxAddressField.text, neighborhood: taxColonyField.text, zipCode: taxCPField.text, municipality: taxTownHallField.text, email: taxEmailField.text, automaticBilling: automaticBilling)
            }else{
                if amountField.text != "" && conceptField.text != "" {
                    self.setupWebView()
                    flowId = 3
                    menuContentView.isHidden = true
                    lblContainerView.isHidden = true
                    searchContent.isHidden = true
                    detailChurchStack.isHidden = true
                    profileContent.isHidden = false
                    btnCancelar.isHidden = false
                    // loaderTimerView.isHidden = false
                    webViewContainer.isHidden = false
                    startTimer()
                    self.myWebView.evaluateJavaScript("function showToast() { webkit.messageHandlers.callbackHandler.postMessage('Algo de texto') }") { value, error in
                    }
                    self.myWebView.evaluateJavaScript("document.getElementsByTagName('button')[0].style.color='black'") { value, error in
                    }
                    
                    self.myWebView.evaluateJavaScript("document.getElementsByTagName('button')[0].onclick=showToast") { value, error in
                    }
                    
                    
                }else{
                    let alert = AcceptAlertDonations.showAlert(message: "Por favor llena todos los campos", btnTitle: "Ok")
                    alert.modalPresentationStyle = .overFullScreen
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }else if amountField.text != "" && conceptField.text != "" {
            let alert = AcceptAlertDonations.showAlert(message: "Por favor selecciona una opción de facturación", btnTitle: "Ok")
            alert.modalPresentationStyle = .overFullScreen
            self.present(alert, animated: true, completion: nil)
            
        }else{
            let alert = AcceptAlertDonations.showAlert(message: "Por favor llena todos los campos", btnTitle: "Ok")
            alert.modalPresentationStyle = .overFullScreen
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func addTaxDataAction(_ sender: Any) {
        isEditingData = false
        addDataView.isHidden = true
        formularyTaxContainer.isHidden = false
        btnSave.isHidden = false
    }
    
    @IBAction func saveTaxDataAction(_ sender: Any) {
        guard validateForm() else {
            return
        }
        
        showLoading()
        presenter?.saveBillingData(method: isEditingData ? "PUT" : "POST", taxId: billingData[safe: 0]?.id ?? 0, businessName: taxSocialReasonField.text, rfc: taxRFCField.text, address: taxAddressField.text, neighborhood: taxColonyField.text, zipCode: taxCPField.text, municipality: taxTownHallField.text, email: taxEmailField.text, automaticBilling: automaticBilling)
    }
    
    @IBAction func checkBoxAction(_ sender: Any) {
        if checkSquare.isHidden == true {
            checkSquare.isHidden = false
            automaticBilling = true
        }else{
            checkSquare.isHidden = true
            automaticBilling = false
        }
    }
    
    @IBAction func changeBillingData(_ sender: Any) {
        isEditingData = true
        changeContainerView.isHidden = true
        checkBtn.isEnabled = true
        btnSave.isHidden = false
        
        fieldList.forEach { $0.isInteractionEnabled = true }
        fieldList.first?.becomeFirstResponder()
    }
    
    // MARK: @OBJC FUNC -
    @objc func selectRadioButton(sender: UIButton) {
        print(sender.tag)
        let index = sender.tag
        if isActive[index] == true {
            for i in 0...isActive.count - 1 {
                isActive[i] = false
            }
        }else{
            for i in 0...isActive.count - 1 {
                isActive[i] = false
            }
            
            isActive[index] = true
        }
        
        defer {
            radioBtnYesCollection.reloadData()
        }
        
        switch index {
        case 0:
            if withBill,
               billingData.count == 0 {
                addDataContainerView.isHidden = false
                addDataView.isHidden = true
                lblData.isHidden = true
                lblDataBillingNew.isHidden = false
                formularyTaxContainer.isHidden = false
                return
            }
            
            addDataContainerView.isHidden = true
            addDataView.isHidden = false
            lblData.isHidden = false
            lblDataBillingNew.isHidden = true
            formularyTaxContainer.isHidden = true
        case 1:
            addDataContainerView.isHidden = true
            addDataView.isHidden = false
            formularyTaxContainer.isHidden = true
            
        default:
            break
        }

        
    }
    
    @objc func tapChurchList(sender: UIButton) {
        //        showLoading()
        flowId = 2
        presenter?.requestBillingData()
        switch sender.accessibilityIdentifier {
        case "FAV":
            churchSelectedName = listFavoritesLocations[sender.tag].name ?? ""
            churchSelectedImg = listFavoritesLocations[sender.tag].image_url ?? ""
            churchSelecrtedId = listFavoritesLocations[sender.tag].id ?? 0
            
        case "SUGG":
            churchSelectedName = churchSuggestedList[sender.tag].name ?? ""
            churchSelectedImg = churchSuggestedList[sender.tag].image_url ?? ""
            churchSelecrtedId = churchSuggestedList[sender.tag].id ?? 0
            
        case "MAIN":
            churchSelectedName = listMainLocations[sender.tag].name ?? ""
            churchSelectedImg = listMainLocations[sender.tag].image_url ?? ""
            churchSelecrtedId = listMainLocations[sender.tag].id ?? 0
            
        default:
            break
        }
        
        lblChurchNameDetail.text = churchSelectedName
        churchDetailImg.DownloadImage(churchSelectedImg)
        
        lblContainerView.isHidden = true
        searchContent.isHidden = true
        churchListStack.isHidden = true
        detailChurchStack.isHidden = false
        cardDetailContainerView.isHidden = false
        conceptContainerView.isHidden = false
        radioButtonContainer.isHidden = false
        addDataContainerView.isHidden = true
        containerBtnsAccept.isHidden = false
        
        conceptField.text = ""
        amountField.text = ""
        
    }
    
    @objc func acceptPicker() {
        self.view.endEditing(true)
    }
    
    @objc func cancelPicker() {
        conceptField.text = ""
        specifyField.isHidden = true
        lineSpecify.isHidden = true
        self.view.endEditing(true)
    }
    
    @objc func acceptPickerAmount() {
        self.view.endEditing(true)
    }
    
    @objc func cancelPickerAmount() {
        amountField.text = ""
        self.view.endEditing(true)
    }
    
    @objc func TapSuperview() {
        self.view.endEditing(true)
    }
    
    @objc func TapSuperview2() {
        self.view.endEditing(true)
    }
    
    @objc func handleTimer() {
        
        if minutes == 0{
            timeLapse?.invalidate()
            minutes = 4
            seconds = 59
            miliSeconds = 100
            firstLblTimer.text = "05"
            secondLblTimer.text = "00"
            thirdLblTimer.text = "00"
            let alert = AcceptAlertDonations.showAlert(message: "Se agotó el tiempo de espera para realizar el pago, por favor vuelve a intentarlo", btnTitle: "Entendido")
            alert.delegate = self
            alert.modalPresentationStyle = .overFullScreen
            self.present(alert, animated: true, completion: nil)
        }else{
            if seconds == 0 {
                minutes -= 1
                seconds = 59
            }
            if miliSeconds == 0 {
                seconds -= 1
                miliSeconds = 100
            }
            
            firstLblTimer.text = "0\(minutes)"
            
            if miliSeconds < 10 {
                thirdLblTimer.text = "0\(miliSeconds)"
            }else{
                thirdLblTimer.text = "\(miliSeconds)"
            }
            
            if seconds < 10 {
                secondLblTimer.text = "0\(seconds)"
            }else{
                secondLblTimer.text = "\(seconds)"
            }
            miliSeconds -= 1
        }
        
    }
    
}

// MARK: API SERVICES CHURCH LIST -
extension NewDontaionsViewController {
    func successGetChurches(data: ChurchesDontaions) {
        print(data)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.loadingAlert.dismiss(animated: true, completion: nil)
        }
        listFavoritesLocations = data.locations ?? listFavoritesLocations
        print(listFavoritesLocations, listFavoritesLocations.count)
        if listFavoritesLocations.count == 0 {
            favoriteViewMainContent.isHidden = true
        }else{
            favoriteChurchTable.reloadData()
        }
        
        
        guard let assigned = data.assigned else {
            mainChurchContent.isHidden = true
            
            return }
        listMainLocations.append(assigned)
        mainChurchComTable.reloadData()
        churchListStack.isHidden = false
        
    }
    
    func failGetChurches(message: String) {
        print(message)
    }
}

// MARK: API SERVICES CHURCH SUGGESTED -
extension NewDontaionsViewController {
    func successGetSuggested(data: [ChurchesSuggested]) {
        print(data)
        churchSuggestedList = data
        if churchSuggestedList.count != 0 {
            suggestionsChurchTable.reloadData()
        }else{
            suggestionsChurchMainView.isHidden = true
        }
        churchListStack.isHidden = false
        
    }
    
    func failGetSuggested(message: String) {
        print(message)
        suggestionsChurchMainView.isHidden = true
    }
}

// MARK: API SERVICES BILLING DATA
extension NewDontaionsViewController {
    
    func successGetBillingData(data: [BillingData]) {
        billingData = data
        if flowId == 1 {
            lblData.isHidden = false
            addDataContainerView.isHidden = false
        }
        
        if data.count != 0 {
            let selected = data.first
            
            taxSocialReasonField.textField.text = selected?.business_name ?? ""
            taxRFCField.textField.text = selected?.rfc ?? ""
            taxAddressField.textField.text = selected?.address ?? ""
            taxColonyField.textField.text = selected?.neighborhood ?? ""
            taxCPField.textField.text = selected?.zipcode ?? ""
            taxTownHallField.textField.text = selected?.municipality ?? ""
            taxEmailField.textField.text = selected?.email ?? ""
            
            switch selected?.automatic_invoicing {
            case true:
                isActive = [true, false]
                checkSquare.isHidden = false
                automaticBilling = true
                if flowId == 2 {
                    radioButtonContainer.isHidden = true
                }
                
                
            case false:
                isActive = [false, true]
                checkSquare.isHidden = true
                automaticBilling = false
                if flowId == 2 {
                    radioButtonContainer.isHidden = false
                }
                
                
            default:
                checkSquare.isHidden = true
                automaticBilling = false
                if flowId == 2 {
                    radioButtonContainer.isHidden = false
                }
                
            }
            fieldList.forEach { $0.isInteractionEnabled = false }
            billingId = selected?.id ?? 0
            checkBtn.isEnabled = false
            
            if flowId == 1 {
                addDataView.isHidden = true
                formularyTaxContainer.isHidden = false
                changeContainerView.isHidden = false
                btnSave.isHidden = true
                
            }
            
            radioBtnYesCollection.reloadData()
        }else{
            if flowId == 1 {
                addDataView.isHidden = false
                formularyTaxContainer.isHidden = true
                changeContainerView.isHidden = true
                btnSave.isHidden = true
                checkBtn.isEnabled = true
                
            }else{
                isActive = [false, true]
                radioBtnYesCollection.reloadData()
                checkSquare.isHidden = true
                automaticBilling = false
            }
            
        }
        
        loadingAlert.dismiss(animated: true, completion: nil)
        
    }
    
    func failGetBillingData(message: String) {
        print(message)
    }
    
    func successSaveBillingData(method: String) {
        presenter?.requestBillingData()
    }
    
    func failSaveBillingData(message: String) {
        loadingAlert.dismiss(animated: true, completion: nil)
        print(message)
    }
}

extension NewDontaionsViewController: accpetAlertActionDelegate {
    func didPressAcccept() {
        webViewContainer.isHidden = true
        profileContent.isHidden = true
        btnCancelar.isHidden = true
        menuContentView.isHidden = false
        lblContainerView.isHidden = false
        searchContent.isHidden = false
        churchListStack.isHidden = false
        flowId = 2
        timeLapse?.invalidate()
        minutes = 4
        seconds = 59
        miliSeconds = 100
        firstLblTimer.text = "05"
        secondLblTimer.text = "00"
        thirdLblTimer.text = "00"
    }
    
}

extension NewDontaionsViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        transition.isPresenting = false
        
        //        showLoading()
        flowId = 2
        presenter?.requestBillingData()
        
        churchSelectedName = UserDefaults.standard.string(forKey: "nameChurchDon") ?? ""
        churchSelectedImg = UserDefaults.standard.string(forKey: "imgChurchDon") ?? ""
        churchSelecrtedId = UserDefaults.standard.integer(forKey: "idChurchDon")
        
        lblChurchNameDetail.text = churchSelectedName
        churchDetailImg.DownloadImage(churchSelectedImg)
        
        lblContainerView.isHidden = true
        searchContent.isHidden = true
        churchListStack.isHidden = true
        detailChurchStack.isHidden = false
        cardDetailContainerView.isHidden = false
        conceptContainerView.isHidden = false
        radioButtonContainer.isHidden = false
        addDataContainerView.isHidden = true
        containerBtnsAccept.isHidden = false
        
        conceptField.text = ""
        amountField.text = ""
        
        return transition
        
    }
    
}

extension NewDontaionsViewController: WKScriptMessageHandler{
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if (message.name == "sumbitToiOS") {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0){
                let objResponse = self.parseStringToDataToJson(toData: message.body as! String)
                
                if objResponse?.status == "success" {
                    let alert = UIAlertController(title: "Aviso", message: "¡Muchas gracias! Tu donación ha sido procesada exitosamente.", preferredStyle: .alert)
                    alert.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = UIColor.white
                    let cancelAction = UIAlertAction(title: "Aceptar", style: .cancel){
                        [weak self] _ in
                        guard let self = self else {return}
                        self.navigationController?.popViewController(animated: true)
                        //self.dismiss(animated: true, completion: nil)
                    }
                    alert.addAction(cancelAction)
                    
                    self.present(alert, animated: true)
                    /*let alert = AcceptAlertDonations.showAlert(message: "¡Muchas gracias! Tu ofrenda ha sido procesada exitosamente y tu intención ha sido enviada.", btnTitle: "Entendido")
                    alert.delegate = self
                    alert.modalPresentationStyle = .overFullScreen
                    self.present(alert, animated: true, completion: nil)*/
                }else {
                    let alert = AcceptAlertDonations.showAlert(message: objResponse?.responseDescription?.folding(options: .diacriticInsensitive, locale: .current) ?? "Ocurrio un error, Intente mas tarde", btnTitle: "Entendido")
                    alert.delegate = self
                    alert.modalPresentationStyle = .overFullScreen
                    self.present(alert, animated: true, completion: nil)
                }
                
            }
        }
    }
}

extension NewDontaionsViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        let script = "document.getElementsByTagName('button')[0].onclick=showToast"
        self.myWebView.evaluateJavaScript(script) { value, error in
            if let result = value {
                print("Label is updated with message: \(result)")
            } else if let error = error {
                print("An error occurred: \(error)")
            }
        }
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        decisionHandler(.allow)
        guard let urlAsString = navigationAction.request.url?.absoluteString.lowercased() else {
            return
        }
        
        if urlAsString.range(of: "the url that the button redirects the webpage to") != nil {
            // do something
        }
    }
}

//MARK: - ECUForm
extension NewDontaionsViewController: ECUForm {}

extension NewDontaionsViewController {
    private func setupFields() {
        taxSocialReasonField.shouldChangeCharacters = { !$0.evaluateRegEx(for: ECURegexValidation.notName.rawValue) }
        
        taxSocialReasonField.textField.textContentType = .none
        taxSocialReasonField.textField.returnKeyType = .next
        taxSocialReasonField.textField.keyboardType = .asciiCapable
        taxSocialReasonField.textField.autocapitalizationType = .words
        
        taxSocialReasonField.validations = [
            ECUFieldGenericValidation.required(fieldName: "tu razón social").getValidation()
        ]
        
        taxRFCField.textField.textContentType = .none
        taxRFCField.textField.returnKeyType = .next
        taxRFCField.textField.keyboardType = .namePhonePad
        taxRFCField.textField.autocapitalizationType = .allCharacters
        taxRFCField.onChangeText = {
            self.taxRFCField.textField.text = self.taxRFCField.textField.text?.uppercased()
        }
        
        taxRFCField.validations = [
            ECUFieldGenericValidation.required(fieldName: "tu RFC").getValidation(),
            ECUFieldGenericValidation.isValidRfc.getValidation()
        ]
        
        taxAddressField.textField.textContentType = .addressCityAndState
        taxAddressField.textField.returnKeyType = .next
        taxAddressField.textField.keyboardType = .asciiCapable
        taxAddressField.textField.autocapitalizationType = .words
        
        taxAddressField.validations = [
            ECUFieldGenericValidation.required(fieldName: "tu dirección").getValidation()
        ]
        
        taxColonyField.textField.textContentType = .none
        taxColonyField.textField.returnKeyType = .next
        taxColonyField.textField.keyboardType = .asciiCapable
        taxColonyField.textField.autocapitalizationType = .words
        
        taxColonyField.validations = [
            ECUFieldGenericValidation.required(fieldName: "tu colonia").getValidation()
        ]
        
        taxCPField.textField.textContentType = .none
        taxCPField.textField.returnKeyType = .next
        taxCPField.textField.keyboardType = .numberPad
        
        taxCPField.validations = [
            ECUFieldGenericValidation.required(fieldName: "tu c.p.").getValidation(),
            { ($0?.evaluateRegEx(for: ECURegexValidation.zipCode.rawValue) ?? false) ? nil : "Campo de código postal incorrecto" }
        ]
        
        taxTownHallField.textField.textContentType = .none
        taxTownHallField.textField.returnKeyType = .next
        taxTownHallField.textField.keyboardType = .asciiCapable
        
        taxTownHallField.validations = [
            ECUFieldGenericValidation.required(fieldName: "tu alcaldía").getValidation()
        ]
        
        taxEmailField.textField.textContentType = .emailAddress
        taxEmailField.textField.returnKeyType = .next
        taxEmailField.textField.autocapitalizationType = .none
        taxEmailField.textField.keyboardType = .emailAddress
        
        taxEmailField.validations = [
            ECUFieldGenericValidation.required(fieldName: "un correo válido").getValidation(),
            ECUFieldGenericValidation.isValidEmail.getValidation()
        ]
    }
    
    private func parseStringToDataToJson(toData: String) -> Response? {
        let str = toData.replacingOccurrences(of: "\\", with: "", options: .literal, range: nil)
        let data = Data(str.utf8)
        if let response = try? JSONDecoder().decode(Response.self, from: data) {
            return response
        }
        return nil
    }
}
