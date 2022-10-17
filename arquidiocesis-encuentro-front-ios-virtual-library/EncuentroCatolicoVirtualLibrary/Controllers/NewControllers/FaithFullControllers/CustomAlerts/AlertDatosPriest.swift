//
//  AlertDatosPriest.swift
//  EncuentroCatolicoVirtualLibrary
//
//  Created by Pablo Luis Velazquez Zamudio on 30/06/21.
//

import UIKit

open class AlertDatosPriest: UIViewController {
    
    var titulo: String?
    var mensaje: String?
    var completeDateSent = ""
    var namePriest = ""
    var idPriest = 0
    var sendIdPriest = 0
    var picker: UIPickerView!
    var pickerD2: UIDatePicker!
    var arrayPriests : [String] = []
    var arrayId = [Int]()
    static let singleton = AlertDatosPriest()
    
    @IBOutlet weak var datePick: UIDatePicker!
    // MARK: COMPONENTS PICKER DATE & TIME -
    @IBOutlet weak var navBarPicker: UIView!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnDone: UIButton!
    @IBOutlet weak var pickerTimer: UIPickerView!
    @IBOutlet weak var pickerDate: UIPickerView!
    @IBOutlet weak var guideAxisYConstriant: NSLayoutConstraint!
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var lblAlertTitle: UILabel!
    @IBOutlet weak var lblSacerdote: UILabel!
    @IBOutlet weak var lblFechaYHora: UILabel!
    @IBOutlet weak var priestNameField: UITextField!
    @IBOutlet weak var firstLine: UIView!
    @IBOutlet weak var dateHourField: UITextField!
    @IBOutlet weak var secondLine: UIView!
    @IBOutlet weak var btnAccept: UIButton!
    @IBOutlet weak var btnActivatePicker: UIButton!
    
    var pickerDataDate3 : [String] = Array()
    var pickerDataDate = [["01","02","03","04", "05","06","07","08","09","10", "11", "12", "13", "14",  "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27","28","29","30","31",],["Ene", "Feb", "Mar", "Abr", "May", "Jun", "Jul", "Ago", "Sep", "Oct", "Nov", "Dic"]]
   
    
    var pickerDataTimer = [["01","02","03","04", "05","06","07","08","09","10", "11", "12", "13", "14",  "15", "16", "17", "18", "19", "20", "21", "22", "23", "00"]]
    var pickerDateTime2 : [String] = []
    
    var pos = 0
    
    var hr = "01"
    var min = "00"
    var day = "01"
    var month = "Ene"
    var nuMonth = "01"
    var year = "2040"
    var completeDate = ""
    var formattedDateStr = ""
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        getListPriest()
        priestNameField.delegate = self
        priestNameField.returnKeyType = .next
        for i in stride(from: 2040, to: 1939, by: -1) {
            pickerDataDate3.append("\(i)")
        }
        pickerDataDate.append(pickerDataDate3)
        
        for j in stride(from: 0, to: 60, by: +1) {
            if j < 10 {
                pickerDateTime2.append("0\(j)")
            }else{
                pickerDateTime2.append("\(j)")
            }
        }
        
        pickerDataTimer.append(pickerDateTime2)
        
        var dateFormatter : DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MMM-dd HH:mm:ss"
        let date = Date()
        let dateString = dateFormatter.string(from: date)
        print("current date:", dateString)
        print(date)
        let dat = dateString.split(separator: " ")
        let fecha = dat[0].split(separator: "-")
        let hour = dat[1].split(separator: ":")
        print(fecha, hour)        
        
        lblAlertTitle.text = titulo
        alertView.layer.cornerRadius = 12
        btnAccept.layer.cornerRadius = 8
        setupDelegates()
        setupPickerField()
        setupPickerFieldDate()
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { (timer) in
            UIView.animate(withDuration: 0.2) {
                self.shadowView.alpha = 0.25
            }
        }
                
    }
    @IBAction func datePickAction(_ sender: Any) {
        let dateFormatter = DateFormatter()
        
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateTime: String = formatter.string(from: datePick.date)
        
        dateFormatter.dateStyle = DateFormatter.Style.short
        dateFormatter.timeStyle = DateFormatter.Style.short
        
        dateHourField.text = dateTime
    }
    
    func setupDelegates() {
        priestNameField.delegate = self
    
    }
    
    func setupPickerField() {
        picker = UIPickerView(frame: CGRect(x: 0, y: 200, width: view.frame.width, height: 200))
        picker.showsSelectionIndicator = true
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()

        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.donePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.cancelPicker))

        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.items?.forEach({ (button) in
            button.tintColor = UIColor.init(red: 25/255, green: 42/255, blue: 115/255, alpha: 1)
        })
        
        toolBar.isUserInteractionEnabled = true

        priestNameField.inputView = picker
        priestNameField.inputAccessoryView = toolBar
    }
    
    func setupPickerFieldDate() {
        pickerD2 = UIDatePicker(frame: CGRect(x: 0, y: 200, width: view.frame.width, height: 200))
        pickerD2.backgroundColor = .white
        pickerD2.datePickerMode = .dateAndTime
       // pickerD2.addTarget(self, action: #selector(handleDatePicker), for: .)
        pickerD2.addTarget(self, action: #selector(self.datePickerValueChanged(_:)), for: .valueChanged)
        if #available(iOS 13.4, *) {
            pickerD2.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
            print("not suppor to this iOS version to show picker date")
        }
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()

        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.donePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.cancelPicker))

        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.items?.forEach({ (button) in
            button.tintColor = UIColor.init(red: 25/255, green: 42/255, blue: 115/255, alpha: 1)
        })
        
        toolBar.isUserInteractionEnabled = true

        dateHourField.inputView = pickerD2
        dateHourField.inputAccessoryView = toolBar
    }
    
//  MARK: GENERAL FUNCS -
    
    func setupDataPriests(data: NSArray) {
        
        data.forEach { (item) in
            print(item)
            
            if let subData: NSDictionary = item as? NSDictionary {
                
                if let name: String = subData["name"] as? String {
                    print(name)
                    
                    self.arrayPriests.append(name)
                }
                
                if let id: Int = subData["id"] as? Int {
                    self.arrayId.append(id)
                }
            }
            
        }
        
        self.picker.delegate = self
        self.picker.dataSource = self
    
    }
    
// MARK: @OBJC FUNCS -
    
    @objc func donePicker() {
        let singleton = AlertDatosPriest.singleton
        singleton.completeDateSent = dateHourField.text ?? "2021-12-21 :00:00:00"
        singleton.namePriest = priestNameField.text ?? "Allen"
        singleton.sendIdPriest = idPriest
        self.view.endEditing(true)
    }
    
    @objc func cancelPicker() {
        self.view.endEditing(true)
    }
    
    @objc func datePickerValueChanged(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateTime: String = formatter.string(from: sender.date)
        
        dateFormatter.dateStyle = DateFormatter.Style.short
        dateFormatter.timeStyle = DateFormatter.Style.short
        
        dateHourField.text = dateTime
        print(dateTime)
    }
    
    @objc func handleDatePicker() {
        
    }
    
// MARK: @IBACTIONS -
    @IBAction func acceptAction(_ sender: Any) {
        let singleton = AlertYesNo.singleton
        singleton.typeAlert = "PRIEST"
        UIView.animate(withDuration: 0.1) {
            self.shadowView.alpha = 0
        }
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func showPikcker(_ sender: Any) {
        dateHourField.becomeFirstResponder()

    }
    
    @IBAction func cancelAction(_ sender: Any) {
        UIView.animate(withDuration: 1) {
            self.guideAxisYConstriant.constant = -300
        }
    }
    
    @IBAction func listoAction(_ sender: Any) {
        let singleton = AlertDatosPriest.singleton
        singleton.completeDateSent = dateHourField.text ?? "2021-12-21 :00:00:00"
        singleton.namePriest = priestNameField.text ?? "Allen"
        singleton.sendIdPriest = idPriest
        UIView.animate(withDuration: 1) {
            self.guideAxisYConstriant.constant = -300
        }
    }
    
    
    class public func showAlertPriest(titulo: String) -> AlertDatosPriest {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle(for: AlertDatosPriest.self))
        let view = storyboard.instantiateViewController(withIdentifier: "AlertDatosPriest") as! AlertDatosPriest
        view.modalPresentationStyle = .overFullScreen
        view.titulo = titulo
        
        return view
    }    
    
}

extension AlertDatosPriest: UIPickerViewDelegate, UIPickerViewDataSource {
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
        
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arrayPriests.count
    }
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return arrayPriests[row]
        
    }
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        priestNameField.text = arrayPriests[row]
        idPriest = arrayId[row]
        print(idPriest)

    }
    
}

extension AlertDatosPriest: UITextFieldDelegate {
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == priestNameField {
            if self.arrayPriests.count != 0 {
                self.priestNameField.text = self.arrayPriests[0]
                self.idPriest = self.arrayId[0]
            }
        }
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == priestNameField {
            self.view.endEditing(true)
            
        }
        
        return true
    }
    
}

extension AlertDatosPriest {
    
    func getListPriest() {
        guard let apiURL = URL(string: "\(APIType.shared.User())/users?service=SOS") else { return }
        var request = URLRequest(url: apiURL)
        
        let defaults = UserDefaults.standard
        let idUser = defaults.integer(forKey: "id")
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("\(idUser)", forHTTPHeaderField: "X-User-Id")
        let tksession = UserDefaults.standard.string(forKey: "idToken")
        request.setValue("Bearer \( tksession ?? "")", forHTTPHeaderField: "Authorization")
        
        
        let tarea = URLSession.shared.dataTask(with: request) { (data, response, error) in
            //print("->>  data: ", data)
            //print("->>  response: ", response)
            //print("->>  error: ", error)
            if error != nil {
                print("Hubo un error")
                return
            }
            
            if (response as! HTTPURLResponse).statusCode == 200 {
                
                do {
            
                    let contFragments = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                    if let allPriests: NSArray = contFragments as? NSArray {
                        
                        DispatchQueue.main.async {
                            self.setupDataPriests(data: allPriests)
                        }
                    }
                    
                }catch{
                    APIType.shared.refreshToken()
                    print("Error al descargar locations", error.localizedDescription)
                    
                }
            }
        }
        
        tarea.resume()
    }
}
