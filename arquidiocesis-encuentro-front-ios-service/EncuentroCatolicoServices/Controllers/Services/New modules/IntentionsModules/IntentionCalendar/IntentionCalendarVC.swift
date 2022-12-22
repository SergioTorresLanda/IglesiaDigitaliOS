//
//  IntentionCalendarView.swift
//  EncuentroCatolicoServices
//
//  Created by Pablo Luis Velazquez Zamudio on 29/07/21.
//

import UIKit

class IntentionCalendarView: UIViewController, IntentionCalendarViewProtocol {

// MARK: PROTOCOL VAR -
    var presenter: IntentionCalendarPresenterProtocol?
    
// MARK: SINGLETON VAR -
    static let singleton = IntentionCalendarView()
    
// MARK: GLOBAL VAR -
    var selectedDate = "Unspecified"
    var passDate = ""
    
// MARK:  @IBOUTLETS -
    @IBOutlet weak var contentNavBar: UIView!
    @IBOutlet weak var customNavBar: UIView!
    @IBOutlet weak var backIcon: UIImageView!
    @IBOutlet weak var lblTitleNavBar: UILabel!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var lblSelectedDate: UILabel!
    @IBOutlet weak var lineaView: UIView!
    @IBOutlet weak var calendarPicker: UIDatePicker!
    @IBOutlet weak var btnCancelar: UIButton!
    @IBOutlet weak var btnOk: UIButton!
    @IBOutlet weak var spaceView: UIView!
    @IBOutlet weak var shadowView: UIView!
    
// MARK: LIFE CYCLE FUNCS -
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupSettingsPicker()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("VC ECServices - IntentionCalendarVC ")

    }
    
// MARK: SETUP FUNCS -
    private func setupUI() {
        Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { (timer) in
            UIView.animate(withDuration: 0.2) {
                self.shadowView.alpha = 0.35
            }
        }
        customNavBar.layer.cornerRadius = 20
        customNavBar.ShadowNavBar()
        cardView.layer.cornerRadius = 10
        cardView.ShadowCard()
        setupGestures()

    }
    
    private func setupCurrentDate() {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = .init(identifier: "Es_MX")
        dateFormatter.dateFormat = "EEEE, d MMMM" //EEEE, MMM d, yyyy
        lblSelectedDate.text = dateFormatter.string(from: calendarPicker.date).capitalized
        let dateFormatter2 = DateFormatter()
        dateFormatter2.locale = .init(identifier: "Es_MX")
        dateFormatter2.dateFormat = "yyyy-MM-dd"
        selectedDate = dateFormatter2.string(from: calendarPicker.date)
        
    }
    
    private func setupSettingsPicker() {
        // Asi se puede modificar la fecha minima o maxima del picker calendar
        // calendarPicker.minimumDate = Date()
        // calendarPicker.maximumDate = Date()
        calendarPicker.locale = .init(identifier: "es_MX")
        calendarPicker.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
        setupCurrentDate()
    }
    
    private func setupGestures() {
        let tapBack = UITapGestureRecognizer(target: self, action: #selector(TapBack))
        backIcon.addGestureRecognizer(tapBack)
    }
    
// MARK: @OBJC FUNCS -
    @objc func dateChanged(_ sender: UIDatePicker) {
        // Forma para pasar datos entre vistas en VIPER
        //        let view = ScheduleMassTimeRouter.createModule(date: datePicker.date, location: location)
        //        self.navigationController?.pushViewController(view, animated: true)
        print(sender.date)
        let dateFormatter = DateFormatter()
        dateFormatter.locale = .init(identifier: "Es_MX")
        dateFormatter.dateFormat = "EEEE, d MMMM" //EEEE, MMM d, yyyy
        print(dateFormatter.dateFormat = "EEEE, d MMMM")
        lblSelectedDate.text = dateFormatter.string(from: sender.date).capitalized
        let dateFormatter2 = DateFormatter()
        dateFormatter2.locale = .init(identifier: "Es_MX")
        dateFormatter2.dateFormat = "yyyy-MM-dd"
        selectedDate = dateFormatter2.string(from: sender.date)
        
    }
    
    @objc func TapBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
// MARK:  @IBCATIONS -
    @IBAction func cancelarACtion(_ sender: Any) {
        let singleton = IntentionCalendarView.singleton
        singleton.passDate = "Unspecified"
        UIView.animate(withDuration: 0.1) {
            self.shadowView.alpha = 0
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func okAction(_ sender: Any) {
        let singleton = IntentionCalendarView.singleton
        singleton.passDate = selectedDate
        UIView.animate(withDuration: 0.1) {
            self.shadowView.alpha = 0
        }
        self.dismiss(animated: true, completion: nil)
    }
    
}
