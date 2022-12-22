//
//  EditionPromisseViewController.swift
//  EncuentroCatolicoProfile
//
//  Created by Jorge Cruz on 23/03/21.
//

import UIKit

extension Date {
    
    /// Returns a Date with the specified amount of components added to the one it is called with
    func add(years: Int = 0, months: Int = 0, days: Int = 0, hours: Int = 0, minutes: Int = 0, seconds: Int = 0) -> Date? {
        let components = DateComponents(year: years, month: months, day: days, hour: hours, minute: minutes, second: seconds)
        return Calendar.current.date(byAdding: components, to: self)
    }
    
    /// Returns a Date with the specified amount of components subtracted from the one it is called with
    func subtract(years: Int = 0, months: Int = 0, days: Int = 0, hours: Int = 0, minutes: Int = 0, seconds: Int = 0) -> Date? {
        return add(years: -years, months: -months, days: -days, hours: -hours, minutes: -minutes, seconds: -seconds)
    }
}


class EditionPromisseViewController: UIViewController {
    
    var presenter: EditionPromissePresenter?
    private var saintsModel: [SaintsModel]?
    private var timeIntervalModel : [TimerPromiseModel]?
    private var imageSaintsModel : [ImageSaintsModel]?
    private var promissePost = PromiseModel()
   
    
    var catalogSaintsPickerView = UIPickerView()
    var timeIntervalPickerView = UIPickerView()
    lazy var nabnarCustom: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 30
        view.layer.shadowRadius = 7
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowOpacity = 1
        view.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.6998565051)
        view.backgroundColor = #colorLiteral(red: 0.003921568627, green: 0.1254901961, blue: 0.4078431373, alpha: 1)
        
        let title = UILabel(frame: .zero)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        title.textColor = .white
        title.text = "Crear promesa"
        title.textAlignment = .center
        view.addSubview(title)
        view.addSubview(backButton)
        NSLayoutConstraint.activate([
            title.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            title.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -30),
            title.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -15),
            backButton.centerYAnchor.constraint(equalTo: title.centerYAnchor),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            backButton.heightAnchor.constraint(equalToConstant: 50),
            backButton.widthAnchor.constraint(equalToConstant: 50)
        ])
        return view
    }()
    lazy var scrollContentView: UIScrollView = {
        let scrollview = UIScrollView(frame: .zero)
        scrollview.alwaysBounceVertical = true
        scrollview.backgroundColor = .clear
        scrollview.translatesAutoresizingMaskIntoConstraints = false
        return scrollview
    }()
    
    lazy var floawLayout: UPCarouselFlowLayout = {
        let floawLayout = UPCarouselFlowLayout()
        floawLayout.itemSize = CGSize(width: UIScreen.main.bounds.size.width - 160.0, height: UIScreen.main.bounds.size.height * 0.3)
        floawLayout.scrollDirection = .horizontal
        floawLayout.sideItemScale = 0.8
        floawLayout.sideItemAlpha = 1.0
        floawLayout.spacingMode = .fixed(spacing: 5.0)
        return floawLayout
    }()
    
    lazy var walkThroughCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        collectionView.backgroundColor = .clear
        collectionView.alwaysBounceHorizontal = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.collectionViewLayout = UICollectionViewFlowLayout.init()
        return collectionView
    }()
    
    lazy var contentView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var contentCollectionView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var promisseLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Promesa a cumplir"
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.textColor = #colorLiteral(red: 0.003921568627, green: 0.1254901961, blue: 0.4078431373, alpha: 1)
        label.numberOfLines = 1
        label.textAlignment = .left
        return label
    }()
    lazy var promisseTextInput : UITextField = {
        let texField = UITextField(frame: .zero)
        texField.translatesAutoresizingMaskIntoConstraints = false
        texField.setBottomBorder()
        texField.textColor = .darkGray
        return texField
    }()
    
    lazy var promisseToLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "¿A quién se lo prometes?"
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.textColor = #colorLiteral(red: 0.003921568627, green: 0.1254901961, blue: 0.4078431373, alpha: 1)
        label.numberOfLines = 1
        label.textAlignment = .left
        return label
    }()
    lazy var promisseToTextInput : UITextField = {
        let texField = UITextField(frame: .zero)
        texField.translatesAutoresizingMaskIntoConstraints = false
        texField.setBottomBorder()
        texField.textColor = .darkGray
        return texField
    }()
    
    lazy var promisseTimeLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "¿Por cuánto tiempo lo prometes?"
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.textColor = #colorLiteral(red: 0.003921568627, green: 0.1254901961, blue: 0.4078431373, alpha: 1)
        label.numberOfLines = 1
        label.textAlignment = .left
        return label
    }()
    lazy var promisseTimeTextInput : UITextField = {
        let texField = UITextField(frame: .zero)
        texField.translatesAutoresizingMaskIntoConstraints = false
        texField.setBottomBorder()
        texField.textColor = .darkGray
        return texField
    }()
    
    lazy var doneButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = #colorLiteral(red: 0.003921568627, green: 0.1254901961, blue: 0.4078431373, alpha: 1)
        button.tintColor = .white
        button.setTitle("Prometer", for: .normal)
        button.layer.cornerRadius = 10
        return button
    }()
    lazy var backButton : UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 13.0, *) {
            button.setImage(UIImage(named: "iconRetunr",in: Bundle.local, with: nil), for: .normal)
        } else {
            // Fallback on earlier versions
        }
        button.imageEdgeInsets = UIEdgeInsets(top: 8, left: 5, bottom: 8, right: 8)
        return button
    }()
    fileprivate var currentPage: Int = 0 {
        didSet {
            if((imageSaintsModel?.count ?? 0) < currentPage){
                promissePost.imageSaint = imageSaintsModel?[currentPage].imageCode
            }
            //AQUI GUARDAMOS EN EL COREDATA OTRO CAMPO QUE SE LLAME ID EN BASE A ESO VAMOS A MOSTRAR EN LA PANTALLA "MIS PROMESAS" LA IMAGEN QUE SELECCIONÓ EL USUARIO
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupComponents()
        setupComponentsConstraint()
        presenter?.getCatalogs()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("VC ECProfile - EditionPromisseVC ")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
}

///Methods from controller
extension EditionPromisseViewController{
    
    private func hideKeyboardWhenTappedAround(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            scrollContentView.contentOffset.y = keyboardHeight - self.view.safeAreaInsets.bottom
        }
    }
    
    @objc private func keyboardDidHide(notification: NSNotification) {
        scrollContentView.contentOffset.y = 0
    }
    
    @objc func popViewController(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func notifyFromSaveInformation(){
        promissePost.dateStarted = Date()
        promissePost.profileID = UserDefaults.standard.value(forKey: "email") as? String ?? ""
        promissePost.promisseDescription = promisseTextInput.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        presenter?.validatePromisseForm(promiseModel: promissePost)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func dismissPicker(_ sender: UIBarButtonItem){
        switch sender.tag {
        case 0:
            if(promissePost.promisseTo == ""){
                promisseToTextInput.text = saintsModel?[0].name
                promissePost.promisseTo = saintsModel?[0].name ?? ""
                promissePost.promisseToIdentifier = saintsModel?[0].id
            }
            break
        case 1:
            if(promissePost.periodInterval == ""){
                promisseTimeTextInput.text = timeIntervalModel?[0].timeToPromise
                promissePost.periodInterval = timeIntervalModel?[0].timeToPromise ?? ""
                promissePost.dateEnd = Date().add(days: timeIntervalModel?[0].timeOnDays ?? 0)
            }
        default:
            break
        }
        dismissKeyboard()
    }
}

///Methods protocol presenter
extension EditionPromisseViewController: PromissePresenterToUIViewControllerProtocol{
    func refreshImageSaints(response: [ImageSaintsModel]) {
        imageSaintsModel = response
        walkThroughCollectionView.reloadData()
    }
    
    func refreshTimePromise(response: [TimerPromiseModel]) {
        timeIntervalModel = response
        DispatchQueue.main.async {
            self.timeIntervalPickerView.reloadAllComponents()
        }
    }
    
    
    func refreshSaints(response: [SaintsModel]) {
        saintsModel = response
        DispatchQueue.main.async {
            self.catalogSaintsPickerView.reloadAllComponents()
        }
    }
    
    func displayCustomAlert(pharraphers:NSAttributedString, image: String) {
        let promisseAlertView = PromisseAlertView(frame: UIScreen.main.bounds)
        promisseAlertView.translatesAutoresizingMaskIntoConstraints = false
        promisseAlertView.delegate = self
        self.view.addSubview(promisseAlertView)
        promisseAlertView.initCustom(context: self, pharraphers: pharraphers, image: image)
        promisseAlertView.displayAnimation()
    }
}

///Methods protocol controller
extension EditionPromisseViewController: PromisseUIViewControllerProtocol{
    
    func setupComponents(){
        
        hideKeyboardWhenTappedAround()
        
        self.view.backgroundColor = .white
        self.view.addSubview(nabnarCustom)
        self.view.addSubview(scrollContentView)
        
        walkThroughCollectionView.collectionViewLayout = floawLayout
        walkThroughCollectionView.register(UINib.init(nibName: "WalkThroughCollectionViewCell", bundle: Bundle.local), forCellWithReuseIdentifier: "walkThroughIdentifierß")
        walkThroughCollectionView.delegate = self
        walkThroughCollectionView.dataSource = self
        
        crearPromisseWithPicker(components: [promisseToTextInput,promisseTimeTextInput], pickers: [catalogSaintsPickerView,timeIntervalPickerView])
        backButton.addTarget(self, action: #selector(self.popViewController), for: .touchUpInside)
        doneButton.addTarget(self, action: #selector(self.notifyFromSaveInformation), for: .touchUpInside)
        
        scrollContentView.addSubview(contentView)
        scrollContentView.addSubview(contentCollectionView)
        contentCollectionView.addSubview(walkThroughCollectionView)
        contentView.addSubview(promisseLabel)
        contentView.addSubview(promisseTextInput)
        contentView.addSubview(promisseToLabel)
        contentView.addSubview(promisseToTextInput)
        contentView.addSubview(promisseTimeLabel)
        contentView.addSubview(promisseTimeTextInput)
        contentView.addSubview(doneButton)
    }
    
    func setupComponentsConstraint(){
        NSLayoutConstraint.activate([
            nabnarCustom.topAnchor.constraint(equalTo: self.view.topAnchor),
            nabnarCustom.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            nabnarCustom.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,constant: 30),
            nabnarCustom.heightAnchor.constraint(equalToConstant: 90),
            
            scrollContentView.topAnchor.constraint(equalTo: nabnarCustom.bottomAnchor),
            scrollContentView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            scrollContentView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            scrollContentView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            
            contentCollectionView.topAnchor.constraint(equalTo: scrollContentView.topAnchor,constant: 40),
            contentCollectionView.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor,constant: 20),
            contentCollectionView.trailingAnchor.constraint(equalTo: scrollContentView.trailingAnchor,constant: -20),
            contentCollectionView.centerXAnchor.constraint(equalTo: scrollContentView.centerXAnchor),
            contentCollectionView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.35, constant: 0),
            
            walkThroughCollectionView.topAnchor.constraint(equalTo: contentCollectionView.topAnchor),
            walkThroughCollectionView.leadingAnchor.constraint(equalTo: contentCollectionView.leadingAnchor),
            walkThroughCollectionView.trailingAnchor.constraint(equalTo: contentCollectionView.trailingAnchor),
            walkThroughCollectionView.bottomAnchor.constraint(equalTo: contentCollectionView.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: contentCollectionView.bottomAnchor,constant: 40),
            contentView.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor,constant: 20),
            contentView.trailingAnchor.constraint(equalTo: scrollContentView.trailingAnchor,constant: -20),
            contentView.centerXAnchor.constraint(equalTo: scrollContentView.centerXAnchor),
            
            promisseLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            promisseLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            promisseLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            promisseTextInput.topAnchor.constraint(equalTo: promisseLabel.bottomAnchor,constant: 5),
            promisseTextInput.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            promisseTextInput.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            promisseTextInput.heightAnchor.constraint(equalToConstant: 35),
            
            promisseToLabel.topAnchor.constraint(equalTo: promisseTextInput.bottomAnchor,constant: 15),
            promisseToLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            promisseToLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            promisseToTextInput.topAnchor.constraint(equalTo: promisseToLabel.bottomAnchor,constant: 5),
            promisseToTextInput.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            promisseToTextInput.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            promisseToTextInput.heightAnchor.constraint(equalToConstant: 35),
            
            promisseTimeLabel.topAnchor.constraint(equalTo: promisseToTextInput.bottomAnchor,constant: 15),
            promisseTimeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            promisseTimeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            promisseTimeTextInput.topAnchor.constraint(equalTo: promisseTimeLabel.bottomAnchor,constant: 5),
            promisseTimeTextInput.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            promisseTimeTextInput.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            promisseTimeTextInput.heightAnchor.constraint(equalToConstant: 35),
            
            doneButton.topAnchor.constraint(equalTo: promisseTimeTextInput.bottomAnchor, constant: 30),
            doneButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            doneButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            doneButton.heightAnchor.constraint(equalToConstant: 48),
            doneButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            
            contentView.bottomAnchor.constraint(equalTo: scrollContentView.bottomAnchor, constant: 20)
        ])
    }
    
    func crearPromisseWithPicker(components: [UITextField],pickers: [UIPickerView]) {
        
        for (idx,com) in components.enumerated(){
            pickers[idx].delegate = self
            pickers[idx].dataSource = self
            pickers[idx].tag = idx
            let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 100.0, height: 44.0))
            let botonAceptar = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(self.dismissPicker(_:)))
            botonAceptar.tag = idx
            toolbar.setItems([botonAceptar], animated: true)
            
            com.inputAccessoryView = toolbar
            com.inputView = pickers[idx]
            com.tag = idx
        }
    }
}

///Methods alert
extension EditionPromisseViewController: PromisseAlertViewProtocol{
    func dissmisAlert() {
        self.navigationController?.popViewController(animated: true)
    }
}

///Methods collection
extension EditionPromisseViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageSaintsModel?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = walkThroughCollectionView.dequeueReusableCell(withReuseIdentifier: "walkThroughIdentifierß", for: indexPath) as! WalkThroughCollectionViewCell
        cell.imgvWalkthrough.image  = UIImage(named:imageSaintsModel?[indexPath.row].imageCode ?? "", in: Bundle.local, compatibleWith: nil)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("itm selected == \(indexPath.row)")
    }
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let layout = self.walkThroughCollectionView.collectionViewLayout as! UPCarouselFlowLayout
        let pageSide = (layout.scrollDirection == .horizontal) ? self.pageSize.width : self.pageSize.height
        let offset = (layout.scrollDirection == .horizontal) ? scrollView.contentOffset.x : scrollView.contentOffset.y
        currentPage = Int(floor((offset - pageSide / 2) / pageSide) + 1)
    }
    
    fileprivate var pageSize: CGSize {
        let layout = self.walkThroughCollectionView.collectionViewLayout as! UPCarouselFlowLayout
        var pageSize = layout.itemSize
        if layout.scrollDirection == .horizontal {
            pageSize.width += layout.minimumLineSpacing
        } else {
            pageSize.height += layout.minimumLineSpacing
        }
        return pageSize
    }
}

///Methods uipicker
extension EditionPromisseViewController: UIPickerViewDelegate,UIPickerViewDataSource{
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerView.tag == 0 ? saintsModel?[row].name : timeIntervalModel?[row].timeToPromise
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerView.tag == 0 ? (saintsModel?.count ?? 0) : (timeIntervalModel?.count ?? 0)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 0:
            promisseToTextInput.text = saintsModel?[row].name
            promissePost.promisseTo = saintsModel?[row].name ?? ""
            promissePost.promisseToIdentifier = saintsModel?[row].id
            break
        case 1:
            promisseTimeTextInput.text = timeIntervalModel?[row].timeToPromise
            promissePost.periodInterval = timeIntervalModel?[row].timeToPromise ?? ""
            promissePost.dateEnd = Date().add(days: timeIntervalModel?[row].timeOnDays ?? 0)
        default:
            break
        }
    }
}

