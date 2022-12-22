//
//  NewAddMassesView.swift
//  EncuentroCatolicoChurch
//
//  Created by Pablo Luis Velazquez Zamudio on 17/03/22.
//

import UIKit

class NewAddMassesView: UIViewController {
    
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
        btnReady.layer.cornerRadius = 8
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
        delegate?.didPressReadyMassesButton(sender, hourTxt: hourTextField.text ?? "", daysTxt: daysTextfield.text ?? "")
        hourTextField.text = ""
        daysTextfield.text = ""
        shadowView.alpha = 0
        self.dismiss(animated: true, completion: nil)
    }
    
// MARK: @OBJC FUNCTIONS -
    @objc func doneClick() {
        self.view.endEditing(true)
    }
    
    @objc func TapShadoView() {
        shadowView.alpha = 0
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension NewAddMassesView: UITextFieldDelegate {
    
}
