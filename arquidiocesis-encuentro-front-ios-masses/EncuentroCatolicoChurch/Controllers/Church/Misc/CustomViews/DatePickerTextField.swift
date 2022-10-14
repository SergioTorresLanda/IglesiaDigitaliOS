//
//  DatePickerTextField.swift
//  MyChurches
//
//  Created by Edgar Hernandez Solis on 11/02/21.
//

import Foundation
import UIKit

class DatePickerTextField: UITextField {
    
    //MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    let datePicker: UIDatePicker = UIDatePicker()
    let dateFormater = DateFormatter()
    var dateFormat: String? = "dd/MM/yyyy"
    
    var minDate: Date?
    var maxDate: Date?
    var minAge: Int = 0
    var maxAge: Int = 100
    var completion: (() -> Void)? = {}
    var selectedDate: Date = Date()
    var excludeWeekends: Bool = false
    
    func initialize() {
        
        if #available(iOS 14, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
        
        self.delegate = self
        self.datePicker.datePickerMode = UIDatePicker.Mode.date
        self.datePicker.locale = Locale(identifier: Locale.preferredLanguages.first ?? Locale.current.identifier)
        self.inputView = self.datePicker
        self.datePicker.addTarget(self, action: #selector(self.pickerValueChanged), for: UIControl.Event.valueChanged)
        
        let calendar: Calendar = Calendar(identifier: .gregorian)
        let currentDate: Date = Date()
        var components: DateComponents = DateComponents()
        components.year = -minAge
        if let tempMinDate: Date = calendar.date(byAdding: components, to: currentDate) {
            self.datePicker.maximumDate = tempMinDate
        }
        
        components.year = -maxAge
        if let tempMaxDate: Date = calendar.date(byAdding: components, to: currentDate) {
            self.datePicker.minimumDate = tempMaxDate
        }
        
        if let date = minDate {
            if excludeWeekends {
                let tempCalendar: Calendar = Calendar(identifier: .gregorian)
                let day = tempCalendar.component(.weekday, from: date)
                var tempDate = date
                if day == 1 {
                    tempDate = Date(timeInterval: 60*60*24*1, since: date)
                } else if day == 7 {
                    tempDate = Date(timeInterval: 60*60*24*(2), since: date)
                }
                self.datePicker.minimumDate = tempDate
            } else {
                self.datePicker.minimumDate = date
            }
        }
        
        if let date = maxDate {
            if excludeWeekends {
                let tempCalendar: Calendar = Calendar(identifier: .gregorian)
                let dia = tempCalendar.component(.weekday, from: date)
                var tempDate = date
                if dia == 1 {
                    tempDate = Date(timeInterval: -60*60*24*1, since: date)
                } else if dia == 7 {
                    tempDate = Date(timeInterval: 60*60*24*(-2), since: date)
                }
                self.datePicker.maximumDate = tempDate
            } else {
                self.datePicker.maximumDate = date
            }
        }
        
    }
    
    @objc func pickerValueChanged(sender: UIDatePicker) {
        if excludeWeekends {
            let tempCalendar: Calendar = Calendar(identifier: .gregorian)
            let day = tempCalendar.component(.weekday, from: sender.date)
            
            if day == 1 {
                self.datePicker.setDate(Date(timeInterval: 60*60*24*1, since: sender.date), animated: true)
            } else if day == 7 {
                self.datePicker.setDate(Date(timeInterval: 60*60*24*(-1), since: sender.date), animated: true)
            }
        }
        
        self.selectedDate = datePicker.date
        dateFormater.dateStyle = DateFormatter.Style.medium
        dateFormater.timeStyle = DateFormatter.Style.none
        dateFormater.dateFormat = self.dateFormat
        self.text = dateFormater.string(from: datePicker.date)
        completion?()
    }
}

extension DatePickerTextField: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if self.text?.isEmpty ?? false {
            self.selectedDate = datePicker.date
            dateFormater.dateStyle = DateFormatter.Style.medium
            dateFormater.timeStyle = DateFormatter.Style.none
            dateFormater.dateFormat = self.dateFormat
            completion?()
            self.text = dateFormater.string(from: datePicker.date)
        } else {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = dateFormat
            
            if let date = dateFormatter.date(from: self.text ?? "") {
                datePicker.date = date
            }
        }
    }

}


class HourPickerTextField: UITextField {
    
    let datePicker: UIDatePicker = UIDatePicker()
    
    func initialize() {
        
        if #available(iOS 14, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
        
        self.datePicker.datePickerMode = UIDatePicker.Mode.time
        self.datePicker.locale = Locale(identifier: Locale.preferredLanguages.first ?? Locale.current.identifier)
        self.inputView = self.datePicker
        self.delegate = self
        self.datePicker.addTarget(self, action: #selector(self.pickerValueChanged), for: UIControl.Event.valueChanged)
    }
    
    @objc func pickerValueChanged(sender: UIDatePicker) {
        let selectedDate = datePicker.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        self.text = dateFormatter.string(from: selectedDate)
    }

}

//MARK: - PickerView delegates
extension HourPickerTextField: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let selectedDate = datePicker.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        self.text = dateFormatter.string(from: selectedDate)
    }
    
}

class DaysPickerTextField: UITextField {
    
    private var pickOptions = Calendar.current.weekdaySymbols
    private let pickerView = UIPickerView()
    
    func initialize() {
        self.pickerView.delegate = self
        self.inputView = self.pickerView
    }
}

//MARK: - PickerView delegates
extension DaysPickerTextField: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickOptions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        let firstComponentRow = pickerView.selectedRow(inComponent: 0)
        let secondComponentRow = pickerView.selectedRow(inComponent: 1)
        
        if firstComponentRow >= 0 && secondComponentRow >= 0 {
            self.text = "\(pickOptions[firstComponentRow])-\(pickOptions[secondComponentRow])"
        }
        
        return pickOptions[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let firstComponentRow = pickerView.selectedRow(inComponent: 0)
        let secondComponentRow = pickerView.selectedRow(inComponent: 1)
        
        if firstComponentRow >= 0 && secondComponentRow >= 0 {
            self.text = "\(pickOptions[firstComponentRow])-\(pickOptions[secondComponentRow])"
        }
    }
     
}
