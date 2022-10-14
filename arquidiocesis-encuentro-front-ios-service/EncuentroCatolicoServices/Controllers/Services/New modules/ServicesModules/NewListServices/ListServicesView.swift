//
//  ListServicesView.swift
//  EncuentroCatolicoServices
//
//  Created by Pablo Luis Velazquez Zamudio on 26/07/21.
//

import UIKit
import EncuentroCatolicoVirtualLibrary

class ListServicesView: UIViewController, ListServiceViewProtocol {
    
// MARK: PROTOCOL VAR -
    var presenter: ListServicePresenterProtocol?
    
// MARK: GLOBAL VAR -
    let alertLoader = UIAlertController(title: "", message: "\n \n \n \n \nCargando...", preferredStyle: .alert)
    var arrayServices: [String] = []
    var arryaSolictantes: [String] = []
    var arrayStatus: [String] = []
    var arrayDates: [String] = []
    var arrayList = [ListServicesStandard]()
    var staticArray = [ListServicesStandard]()
    var historicArray = [Any]()
    var state = "List"
    var sameDate = ""
    var sameDateTable = ""
    var loadTable = true
    var pickerStatus: UIPickerView!
    var selectedFilter = "PENDING_CONFIRMATION"
    var statusArray = ["Por confirmar", "Aceptado", "En proceso"]
    var realStatusArray = ["PENDING_CONFIRMATION", "ACCEPTED", "IN_PROGRESS"]
    var pos = 0
    var indexT = 0
    var deleteIndex = 0
    let locationcomponents = UserDefaults.standard.object(forKey: "locationModuleComponents") as? [String]
    
// MARK: @IBOUTELTS -
    @IBOutlet weak var contentNavBar: UIView!
    @IBOutlet weak var customNavbar: UIView!
    @IBOutlet weak var lblNavBarTitle: UILabel!
    @IBOutlet weak var backIcon: UIImageView!
    @IBOutlet weak var lblMainTitle: UILabel!
    @IBOutlet weak var segmentControls: UISegmentedControl!
    @IBOutlet weak var indicatorLine: UIView!
    @IBOutlet weak var mainTable: UITableView!
    @IBOutlet weak var lblServiceStatus: UILabel!
    @IBOutlet weak var statusField: UITextField!
    @IBOutlet weak var arrowDownIcon: UIImageView!
    @IBOutlet weak var lineaViewSF: UIView!
    
// MARK: LIFE CYCLE FUNCS -
    override func viewDidLoad() {
        super.viewDidLoad()
        showLoading()
//        let view = TutorialView.showTutorial()
//        self.present(view, animated: true, completion: nil)
        setupUI()
        setupGestures()
        setupPickerField()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        
        if state == "List" {
            presenter?.callInterGetList(isHistorial: "", role: "Priest")
        }else{
            presenter?.callInterGetList(isHistorial: "?record=true", role: "Priest")
        }
        
    }
    
    
// MARK: - SETUP FUNCS
    private func setupUI() {
        customNavbar.layer.cornerRadius = 20
        customNavbar.ShadowNavBar()
        segmentControls.addUnderlineForSelectedSegment()
        
    }
    
    private func setupDelegates() {
        mainTable.delegate = self
        mainTable.dataSource = self
        mainTable.reloadData()
        statusField.delegate = self
    }
    
    private func setupGestures() {
        let tapBack = UITapGestureRecognizer(target: self, action: #selector(TapBack))
        backIcon.addGestureRecognizer(tapBack)
    }
    
    private func setupPickerField() {
        pickerStatus = UIPickerView(frame: CGRect(x: 0, y: 200, width: view.frame.width, height: 200))
       // picker.tag = tagPiker
        pickerStatus.showsSelectionIndicator = true
        
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

        statusField.inputView = pickerStatus
        statusField.inputAccessoryView = toolBar
        pickerStatus.delegate = self
        pickerStatus.dataSource = self
        
    }
    
    func showLoading() {
        let imageView = UIImageView(frame: CGRect(x: 75, y: 25, width: 140, height: 60))
        imageView.image = UIImage(named: "logoEncuentro", in: Bundle.local, compatibleWith: nil)
        alertLoader.view.addSubview(imageView)
        self.present(alertLoader, animated: false, completion: nil)
    }
    
    func showGenericAcceptAlert(titleAlert: String) {
        let alert = acceptAlertService.showAlert(textAlert: titleAlert)
        self.present(alert, animated: true, completion: nil)
    }
    
// MARK: API SERVICES FUNCTIONS -
    func successRequestList(data: [ListServicesStandard]) {
        print(data)
        arrayList = data
        staticArray = data
        sameDate = ""
        
        if data.count != 0 {
            if state != "List" {
                var dateArray = [ListServicesStandard]()
                
                staticArray.forEach { item in
                    if item.creation_date?.prefix(10) != sameDate.prefix(10) {
                        print("Dont is the same")
                        dateArray.append(item)
                        dateArray.append(item)
                        
                    }else{
                        dateArray.append(item)
                        print("Its the same")
                        
                    }
                    sameDate = item.creation_date ?? "Unspecified"
                }
                
                arrayList = dateArray
                staticArray = dateArray
                
            }
            setupDelegates()
            alertLoader.dismiss(animated: true, completion: nil)
            
        }else{
            setupDelegates()
            alertLoader.dismiss(animated: true, completion: nil)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                let alertAccept = AcceptAlert.showAlert(titulo: "Atención", mensaje: "No tenemos registrado ningún servicion por el momento, consulta más tarde del módulo para dar seguimiento a los servicios")
                self.present(alertAccept, animated: true, completion: nil)
            }
        }
      
    }
    
    func failRequestList() {
        alertLoader.dismiss(animated: true, completion: nil)

    }
    
    func succesDeleteRequest() {
        print("Deleted succesfully")
        showGenericAcceptAlert(titleAlert: "Servicio eliminado correctamente")
        arrayList.remove(at: deleteIndex)
        self.mainTable.reloadData()
    }
    
    func failDeleteRequest() {
        print("Deleted unsuccessfully")
        showGenericAcceptAlert(titleAlert: "No se pudo eliminar el servicio, por favor intente de nuevo")
        
    }
    
    func fatalErroDelteRequest() {
        showGenericAcceptAlert(titleAlert: "Algo salio mal, intente más tarde")
        print("Fatal error")
    }
    
// MARK: @OBJC FUNCS -
    @objc func TapBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func acceptPicker() {
        self.view.endEditing(true)
        self.pickerStatus.selectRow(0, inComponent: 0, animated: true)
        let filteredItems = staticArray.filter { $0.status == selectedFilter }
        arrayList = filteredItems
        self.mainTable.reloadData()
        
    }
    
    @objc func cancelPicker() {
        statusField.text = ""
        arrayList = staticArray
        self.mainTable.reloadData()
        self.view.endEditing(true)
    }
    
// MARK: @IBACTIONS -
    @IBAction func segmentedAction(_ sender: UISegmentedControl) {
        segmentControls.changeUnderlinePosition()
        
        if segmentControls.selectedSegmentIndex == 0 {
            lblServiceStatus.isHidden = true
            statusField.isHidden = true
            arrowDownIcon.isHidden = true
            lineaViewSF.isHidden = true
            statusArray = ["Por confirmar", "Aceptado", "En proceso"]
            realStatusArray = ["PENDING_CONFIRMATION", "ACCEPTED", "IN_PROGRESS"]
            state = "List"
            statusField.text = ""
            arrayList.removeAll()
            staticArray.removeAll()
            mainTable.reloadData()
            presenter?.callInterGetList(isHistorial: "", role: "Priest")
            
        }else{
            //?record=true
            lblServiceStatus.isHidden = false
            statusField.isHidden = false
            arrowDownIcon.isHidden = false
            lineaViewSF.isHidden = false
            statusArray = ["Cancelado", "Concluido", "Por confirmar", "Rechazado", "Aceptado"]
            realStatusArray = ["CANCELLED", "COMPLETED", "PENDING_CONFIRMATION", "REJECTED", "ACCEPTED"]
            state = "History"
            statusField.text = ""
            arrayList.removeAll()
            staticArray.removeAll()
            mainTable.reloadData()
            presenter?.callInterGetList(isHistorial: "?record=true", role: "FIELD")
            
        }
        
    }
    
}

extension ListServicesView: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return statusArray.count
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return statusArray[row]
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        statusField.text = statusArray[row]
        selectedFilter = realStatusArray[row]
        
    }
    
}

extension ListServicesView: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        statusField.text = statusArray[0]
        if state == "List" {
            selectedFilter = "PENDING_CONFIRMATION"
        }else{
            selectedFilter = "CANCELLED"
        }
    }
    
}
