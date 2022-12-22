//
//  IntentionsCommunitiesView.swift
//  EncuentroCatolicoServices
//
//  Created by Pablo Luis Velazquez Zamudio on 08/09/21.
//

import UIKit

class IntentionsCommunitiesView: UIViewController, IntentionsCommunitiesViewProtocol {
    
// MARK: PROTOCOL VAR -
    var presenter: IntentionsCommunitiesPresenterProtocol?
    
// MARK: VARIABLES LOCALES -
    var pickerIntentions: UIPickerView!
    var pickerDates: UIDatePicker!
    var arrayIntentions = ["Catálogo de intenciones",
                           "Por el cumpleaños de",
                           "Por el aniversario de matrimonio de",
                           "Por el favor concedido a",
                           "Por el logro de",
                           "Por la salud de",
                           "Por la pronta recuperación de",
                           "Por el eterno descanso de",
                           "Por el aniversario luctuoso de",
                           "Por una intención especial de",
                           "Por las necesidades de"]
    
// MARK: @IBOUTLETS -
    @IBOutlet weak var contentNavBar: UIView!
    @IBOutlet weak var customNavBar: UIView!
    @IBOutlet weak var navBarTitle: UILabel!
    @IBOutlet weak var backIcon: UIImageView!
    @IBOutlet weak var mainScroll: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var lblMainTitle: UILabel!
    @IBOutlet weak var firstCard: UIView!
    @IBOutlet weak var lblTitleFirstCard: UILabel!
    @IBOutlet weak var addressField: UITextField!
    @IBOutlet weak var lineaViewFirstCard: UIView!
    
    @IBOutlet weak var secondCard: UIView!
    @IBOutlet weak var lblSeleccionaFecha: UILabel!
    @IBOutlet weak var dateField: UITextField!
    @IBOutlet weak var lineViewSecondCard: UIView!
    @IBOutlet weak var lblIntentions: UILabel!
    @IBOutlet weak var intentionsField: UITextField!
    @IBOutlet weak var lineView2Second: UIView!
    @IBOutlet weak var lblDestiny: UILabel!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var lineView3Second: UIView!
    
    @IBOutlet weak var thirdCard: UIView!
    @IBOutlet weak var lblTitleThirdCard: UILabel!
    @IBOutlet weak var btnDonations: UIButton!
    @IBOutlet weak var btnSend: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    
// MARK: LIFE VIEW FUNCTIONS -
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupFieldPickers()
        setupGestures()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("VC ECServices - IntentionsCommunitiesVC")

    }
    
    private func setupUI() {
        customNavBar.layer.cornerRadius = 20
        customNavBar.ShadowNavBar()
        firstCard.layer.cornerRadius = 10
        firstCard.ShadowCard()
        secondCard.layer.cornerRadius = 10
        secondCard.ShadowCard()
        thirdCard.layer.cornerRadius = 10   
        thirdCard.ShadowCard()
        btnCancel.borderButtonColor(color: UIColor.init(red: 25/255, green: 42/255, blue: 115/255, alpha: 1))
        btnSend.layer.cornerRadius = 8
        
    }
    
    private func setupGestures() {
        let tapBackIcon = UITapGestureRecognizer(target: self, action: #selector(TapBack))
        backIcon.addGestureRecognizer(tapBackIcon)
        
    }
    
    private func setupFieldPickers() {
        pickerIntentions = UIPickerView()
        setupPickerField(pickerIntentions, customTexfield: intentionsField)
       
        pickerDates = UIDatePicker()
        setupDatePickerField(pickerDates, customTexfield: dateField)
        
    }
    
    private func setupPickerField(_ picker: UIPickerView, customTexfield: UITextField) {
        picker.frame = CGRect(x: 0, y: 200, width: view.frame.width, height: 200)
        picker.tag = 1
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

        customTexfield.inputView = picker
        customTexfield.inputAccessoryView = toolBar
        picker.delegate = self
        picker.dataSource = self
        customTexfield.delegate = self
    }
    
    private func setupDatePickerField(_ picker: UIDatePicker, customTexfield: UITextField) {
        picker.frame = CGRect(x: 0, y: 200, width: view.frame.width, height: 200)
        picker.tag = 1
        picker.datePickerMode = .date
        picker.addTarget(self, action: #selector(self.datePickerValueChanged(_:)), for: .valueChanged)
        if #available(iOS 13.4, *) {
            picker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
            print("not suppor to this iOS version to show picker date")
        }
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()

        let doneButton = UIBarButtonItem(title: "Aceptar", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.acceptPickerDate))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancelar", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.cancelPickerDate))

        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.items?.forEach({ (button) in
            button.tintColor = UIColor.init(red: 25/255, green: 42/255, blue: 115/255, alpha: 1)
        })
        
        toolBar.isUserInteractionEnabled = true

        customTexfield.inputView = picker
        customTexfield.inputAccessoryView = toolBar
        customTexfield.delegate = self
       
    }
    
// MARK: @IBACTIONS -
    @IBAction func sendAction(_ sender: Any) {
    }
    
    @IBAction func cancelAction(_ sender: Any) {
    }
    
// MARK: - @OBJC FUNC -
    @objc func acceptPicker() {
        self.view.endEditing(true)
    }
    
    @objc func cancelPicker() {
        intentionsField.text = ""
        self.view.endEditing(true)
    }
    
    @objc func acceptPickerDate() {
        self.view.endEditing(true)
    }
    
    @objc func cancelPickerDate() {
        dateField.text = ""
        self.view.endEditing(true)
    }
    
    @objc func datePickerValueChanged(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "dd MMMM yyyy"//"yyyy-MM-dd"
        let dateTime: String = formatter.string(from: sender.date)
                
        dateFormatter.dateStyle = DateFormatter.Style.short
        dateFormatter.timeStyle = DateFormatter.Style.short
                
        dateField.text = dateTime
        print(dateTime)
    }
    
    @objc func TapBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension IntentionsCommunitiesView: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arrayIntentions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return arrayIntentions[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        intentionsField.text = arrayIntentions[row]
    }
    
}

extension IntentionsCommunitiesView: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == dateField {
            let dateForamtter2 = DateFormatter()
            let currentDay = Date()
            let formatter2: DateFormatter = DateFormatter()
            formatter2.dateFormat = "dd MMMM yyyy"
            let dateCurrent2 : String = formatter2.string(from: currentDay)
            
            dateField.text = dateCurrent2
            
        }else if textField == intentionsField {
            pickerIntentions.selectRow(0, inComponent: 0, animated: true)
            intentionsField.text = arrayIntentions[0]
        }
    }
}
