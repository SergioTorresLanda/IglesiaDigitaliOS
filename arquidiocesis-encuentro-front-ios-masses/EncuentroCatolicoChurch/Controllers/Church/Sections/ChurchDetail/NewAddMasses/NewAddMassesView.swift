//
//  NewAddMassesView.swift
//  EncuentroCatolicoChurch
//
//  Created by Pablo Luis Velazquez Zamudio on 17/03/22.
//

import UIKit
import EncuentroCatolicoVirtualLibrary

class NewAddMassesView: UIViewController {
    
    @IBOutlet weak var hourPV: UIPickerView!
    
    @IBOutlet weak var LuV: UIView!
    @IBOutlet weak var SaV: UIView!
    @IBOutlet weak var DoV: UIView!
    @IBOutlet weak var ViV: UIView!
    @IBOutlet weak var JuV: UIView!
    @IBOutlet weak var MiV: UIView!
    @IBOutlet weak var MaV: UIView!
    
    @IBOutlet weak var juLbl: UILabel!
    @IBOutlet weak var luLbl: UILabel!
    
    @IBOutlet weak var doLbl: UILabel!
    @IBOutlet weak var saLbl: UILabel!
    @IBOutlet weak var viLbl: UILabel!
    @IBOutlet weak var miLbl: UILabel!
    @IBOutlet weak var maLbl: UILabel!
    var alertFields : AcceptAlert?

    var azulito=UIColor(named: "eMainGold",in: Bundle(for: NewAddMassesView.self), compatibleWith: nil)

    var luBool=false
    var maBool=false
    var miBool=false
    var juBool=false
    var viBool=false
    var saBool=false
    var doBool=false
    var openHour="00:01"
    let arrOpen=["00:00","00:30","01:00","01:30","02:00","02:30","03:00","03:30","04:00","04:30","05:00","05:30","06:00","06:30","07:00","07:30","08:00","08:30","09:00","09:30","10:00","10:30","11:00","11:30","12:00","12:30","13:00","13:30","14:00","14:30","15:00","15:30","16:00","16:30","17:00","17:30","18:00","18:30","19:00","19:30","20:00","20:30","21:00","21:30","22:00","22:30","23:00","23:30"]
    // MARK: STATIC -
   static let instanceNew = NewAddMassesView()
    
// MARK: LOCAL VAR -
    private lazy var sdTimePicker: TimePicker = {
        let picker = TimePicker()
        picker.setup()
        picker.didSelectDates = { [weak self] (startDate, endDate) in
            let text = Date.buildTimeRangeString(startDate: startDate, endDate: endDate)
            self?.hourTextField.text = text
        }
        return picker
    }()
    
    private lazy var sdDayPicker: DayPicker = {
        let picker = DayPicker()
        picker.setup()
        picker.didSelectDates = { [weak self] (startDate, endDate) in
            let text = Date.buildDayRangeString(startDate: startDate, endDate: endDate)
            self?.daysTextfield.text = text
        }
        return picker
    }()
    public weak var delegate: AddMassesModalButtonDelegate?
    
// MARK: @IBOUTETS -
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var cardMasses: UIView!
    @IBOutlet weak var lblHour: UILabel!
    @IBOutlet weak var daysTextfield: UITextField!
    @IBOutlet weak var hourTextField: UITextField!
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var btnReady: UIButton!
    
// MARK: LIFE CYCLE VIEW FUNCTIONS -
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupPicker()
        setupGetures()
        addTapGestures()
        formatoDaysViews()
        hourPV.delegate=self
        hourPV.dataSource=self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("VC ECChurch - ChurchDetail - NewAddMassesView ")
    }

// MARK: SETUP FUNCTIONS -
    private func setupUI() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            UIView.animate(withDuration: 0.3) {
                self.shadowView.alpha = 0.4
            }
        }
        cardMasses.layer.cornerRadius = 10
        btnReady.layer.cornerRadius = 20
        btnAdd.setTitle("", for: .normal)
    }
    
    private func setupGetures() {
        let tapShadowView = UITapGestureRecognizer(target: self, action: #selector(TapShadoView))
        shadowView.addGestureRecognizer(tapShadowView)
    }

    func setupPicker() {
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.init(named: "eMainBlue")
        toolBar.sizeToFit()
        let donePickerButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.doneClick))
        toolBar.setItems([donePickerButton], animated: false)
        hourTextField.inputView = sdTimePicker.inputView
        daysTextfield.inputView = sdDayPicker.inputView
        hourTextField.delegate = self
        daysTextfield.delegate = self
        hourTextField.inputAccessoryView = toolBar
        daysTextfield.inputAccessoryView = toolBar
    }

// MARK: @IBACTIONS -
    @IBAction func addAction(_ sender: UIButton) {
        delegate?.didPressAdMassesButton(sender, hourTxt: hourTextField.text ?? "", daysTxt: daysTextfield.text ?? "")
        hourTextField.text = ""
        daysTextfield.text = ""
    }
    
    @IBAction func readyAction(_ sender: UIButton) {
        if !luBool && !maBool && !miBool && !juBool && !viBool && !saBool && !doBool{
            showCanonAlert(title: "Datos faltantes", msg: "Activa por lo menos un día a la semana para guardar un horario de misa." )
            return
        }
        var dias:[Bool] = []
            dias.append(doBool)
            dias.append(luBool)
            dias.append(maBool)
            dias.append(miBool)
            dias.append(juBool)
            dias.append(viBool)
            dias.append(saBool)
        delegate?.didPressReadyMassesButton(sender, hourTxt: openHour, daysTxt: dias)
        //hourTextField.text = ""
        //daysTextfield.text = ""
        shadowView.alpha = 0
        self.dismiss(animated: true, completion: nil)
    }
    
    func showCanonAlert(title:String, msg:String){
        DispatchQueue.main.async {
            self.alertFields = AcceptAlert.showAlert(titulo: title, mensaje: msg)
            self.alertFields!.view.backgroundColor = .clear
            self.present(self.alertFields!, animated: true)
        }
    }
// MARK: @OBJC FUNCTIONS -
    @objc func doneClick() {
        self.view.endEditing(true)
    }
    
    @objc func TapShadoView() {
        shadowView.alpha = 0
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func TFLu(gesture: UIGestureRecognizer) {
        luBool = !luBool
        formatoDaysActive(txt: luLbl, view: LuV, bool: luBool)
    }
    @objc func TFMa(gesture: UIGestureRecognizer) {
        maBool = !maBool
        formatoDaysActive(txt: maLbl, view: MaV, bool: maBool)
    }
    @objc func TFMi(gesture: UIGestureRecognizer) {
        miBool = !miBool
        formatoDaysActive(txt: miLbl, view: MiV, bool: miBool)
    }
    @objc func TFJu(gesture: UIGestureRecognizer) {
        juBool = !juBool
        formatoDaysActive(txt: juLbl, view: JuV, bool: juBool)
    }
    @objc func TFVi(gesture: UIGestureRecognizer) {
        viBool = !viBool
        formatoDaysActive(txt: viLbl, view: ViV, bool: viBool)
    }
    @objc func TFSa(gesture: UIGestureRecognizer) {
        saBool = !saBool
        formatoDaysActive(txt: saLbl, view: SaV, bool: saBool)
    }
    @objc func TFDo(gesture: UIGestureRecognizer) {
        doBool = !doBool
        formatoDaysActive(txt: doLbl, view: DoV, bool: doBool)
    }
    
    func formatoDaysActive(txt:UILabel, view:UIView, bool:Bool){
        if bool {
            txt.textColor=azulito
            view.layer.shadowColor = azulito?.cgColor
        }else{
            txt.textColor = .gray
            view.layer.shadowColor = UIColor.gray.cgColor
        }
    }
    
    func addTapGestures(){
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(NewAddMassesView.TFLu))
        LuV.addGestureRecognizer(tap1)
        
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(NewAddMassesView.TFMa))
        MaV.addGestureRecognizer(tap2)
        
        let tap3 = UITapGestureRecognizer(target: self, action: #selector(NewAddMassesView.TFMi))
        MiV.addGestureRecognizer(tap3)
        
        let tap4 = UITapGestureRecognizer(target: self, action: #selector(NewAddMassesView.TFJu))
        JuV.addGestureRecognizer(tap4)
        
        let tap5 = UITapGestureRecognizer(target: self, action: #selector(NewAddMassesView.TFVi))
        ViV.addGestureRecognizer(tap5)
        
        let tap6 = UITapGestureRecognizer(target: self, action: #selector(NewAddMassesView.TFSa))
        SaV.addGestureRecognizer(tap6)
        
        let tap7 = UITapGestureRecognizer(target: self, action: #selector(NewAddMassesView.TFDo))
        DoV.addGestureRecognizer(tap7)
    }
    
    func formatoDaysViews(){
        LuV.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        MaV.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        MiV.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        JuV.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        ViV.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        SaV.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        DoV.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        
        LuV.layer.cornerRadius = 5
        MaV.layer.cornerRadius = 5
        MiV.layer.cornerRadius = 5
        JuV.layer.cornerRadius = 5
        ViV.layer.cornerRadius = 5
        SaV.layer.cornerRadius = 5
        DoV.layer.cornerRadius = 5

        LuV.layer.shadowRadius = 4
        MaV.layer.shadowRadius = 4
        MiV.layer.shadowRadius = 4
        JuV.layer.shadowRadius = 4
        ViV.layer.shadowRadius = 4
        SaV.layer.shadowRadius = 4
        DoV.layer.shadowRadius = 4
        
        LuV.layer.shadowOpacity = 0.5
        MaV.layer.shadowOpacity = 0.5
        MiV.layer.shadowOpacity = 0.5
        JuV.layer.shadowOpacity = 0.5
        ViV.layer.shadowOpacity = 0.5
        SaV.layer.shadowOpacity = 0.5
        DoV.layer.shadowOpacity = 0.5
        
        LuV.layer.shadowColor = UIColor.gray.cgColor
        MaV.layer.shadowColor = UIColor.gray.cgColor
        MiV.layer.shadowColor = UIColor.gray.cgColor
        JuV.layer.shadowColor = UIColor.gray.cgColor
        ViV.layer.shadowColor = UIColor.gray.cgColor
        SaV.layer.shadowColor = UIColor.gray.cgColor
        DoV.layer.shadowColor = UIColor.gray.cgColor
        
        LuV.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner, .layerMinXMinYCorner, .layerMaxXMinYCorner]
        MaV.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner, .layerMinXMinYCorner, .layerMaxXMinYCorner]
        MiV.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner, .layerMinXMinYCorner, .layerMaxXMinYCorner]
        JuV.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner, .layerMinXMinYCorner, .layerMaxXMinYCorner]
        ViV.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner, .layerMinXMinYCorner, .layerMaxXMinYCorner]
        SaV.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner, .layerMinXMinYCorner, .layerMaxXMinYCorner]
        DoV.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner, .layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
}

extension NewAddMassesView: UITextFieldDelegate {
    
}

extension NewAddMassesView: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var count = 0
        count = arrOpen.count
        return count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    
        return arrOpen[row]
    }
  
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        openHour=arrOpen[row]
    }
    
}
