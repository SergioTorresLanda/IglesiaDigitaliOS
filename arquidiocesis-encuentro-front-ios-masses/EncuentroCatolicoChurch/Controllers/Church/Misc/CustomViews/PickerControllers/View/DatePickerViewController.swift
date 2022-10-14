//
//  DatePickerViewController.swift
//  PriestMyChurches
//
//  Created by Edgar Hernandez Solis on 13/02/21.
//

import UIKit

class DatePickerViewController: BaseViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var datePicker: UIDatePicker!
    
    //MARK: - IBActions
    @IBAction func closeAction() {
        dismiss(animated: true) {
            [weak self] in
            self?.delegate?.closeAction(pickerType: PickerType.date)
        }
    }
    
    @IBAction func acceptAction() {
        let selectedDate = datePicker.date
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "HH:mm"
        selectedText = dateFormater.string(from: selectedDate)
        
        dismiss(animated: true) {
            [weak self] in
            if let selectedText = self?.selectedText {
                self?.delegate?.acceptAction(pickerType: PickerType.date, selectedText: selectedText)
            }
        }
    }
    
    //MARK: - Local variables
    weak var delegate: PickerControllerDelegate?
    var selectedText: String = ""
    
    //MARK: - IBOutlets
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .clear
        
        datePicker.datePickerMode = UIDatePicker.Mode.time
        datePicker.locale = Locale(identifier: Locale.preferredLanguages.first ?? Locale.current.identifier)
    }
    

    static func getInstance() -> DatePickerViewController? {
        
        var datePickerController: DatePickerViewController?
        let storyBoard = UIStoryboard(name: "PickerController", bundle: Bundle(for: DatePickerViewController.self))
        if let controller = storyBoard.instantiateViewController(withIdentifier: "DatePickerViewController") as? DatePickerViewController {
            datePickerController = controller
        }
        
        return datePickerController
    }
    
    func presentPicker(in controller: UIViewController) {
        modalPresentationStyle = .overCurrentContext
        modalTransitionStyle = .crossDissolve
        DispatchQueue.main.async {
            controller.present(self, animated: true)
        }
    }

}
