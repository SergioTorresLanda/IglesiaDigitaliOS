//
//  DayPicker.swift
//  EncuentroCatolicoChurch
//
//  Created by Jorge Garcia on 20/08/21.
//

import UIKit

class DayPicker: NSObject, UIPickerViewDelegate, UIPickerViewDataSource {

  // Reference from https://stackoverflow.com/questions/40878547/is-it-possible-to-have-uidatepicker-work-with-start-and-end-time
  
  var didSelectDates: ((_ start: Date, _ end: Date) -> Void)?
  
  private lazy var pickerView: UIPickerView = {
    let pickerView = UIPickerView()
    pickerView.delegate = self
    pickerView.dataSource = self
    return pickerView
  }()
  
  private var startDays = [Date]()
    private var endDays = [Date]()
  
  
  let dayFormatter = DateFormatter()
  let timeFormatter = DateFormatter()
  
  var inputView: UIView {
    return pickerView
  }
  
  func setup() {
    dayFormatter.dateFormat = "EEEE"
    dayFormatter.locale = Locale(identifier: "es_MX")
    timeFormatter.timeStyle = .short
    startDays = setDays()
    endDays = setDays()
  
  }
  
  // MARK: - UIPickerViewDelegate & DateSource
  
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 2
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    switch component {
    case 0:
      return startDays.count
    case 1:
      return endDays.count
    default:
      return 0
    }
  }
  
  func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
    var label: UILabel
    
    if let view = view as? UILabel {
      label = view
    } else {
      label = UILabel()
    }
    
    label.textColor = .black
    label.textAlignment = .center
    label.font = UIFont.systemFont(ofSize: 15)
    
    var text = ""
    
    switch component {
    case 0:
      text = getDayString(from: startDays[row])
    case 1:
        text = getDayString(from: startDays[row])
    default:
      break
    }
    
    label.text = text
    
    return label
  }
  
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    
   
    let startTimeIndex = pickerView.selectedRow(inComponent: 0)
    let endTimeIndex = pickerView.selectedRow(inComponent: 1)
    
    guard startDays.indices.contains(startTimeIndex),
          endDays.indices.contains(endTimeIndex)
            else { return }

    let startDay = startDays[startTimeIndex]
    let endDay = endDays[endTimeIndex]
    
    didSelectDates?(startDay, endDay)
  }
  
  // MARK: - Private helpers
  
  private func getDays(of date: Date) -> [Date] {
    var dates = [Date]()
    
    let calendar = Calendar.current
    
    // first date
    var currentDate = date
    
    // adding 30 days to current date
    let oneMonthFromNow = calendar.date(byAdding: .day, value: 30, to: currentDate)
    
    // last date
    let endDate = oneMonthFromNow
    
    while currentDate <= endDate! {
      dates.append(currentDate)
      currentDate = calendar.date(byAdding: .day, value: 1, to: currentDate)!
    }
    
    return dates
  }
  
  private func setDays() -> [Date] {
    let today = Date()
    return getDays(of: today)
  }
  
  private func setStartDays() -> [Date] {
    let today = Date()
    return getDays(of: today)
  }
  
  private func setEndDays() -> [Date] {
    let today = Date()
    return getDays(of: today)
  }
  
  private func getDayString(from: Date) -> String {
    return dayFormatter.string(from: from)
  }
  
}

extension Date {

  static func buildDayRangeString(startDate: Date, endDate: Date) -> String {
    
    let dayFormatter = DateFormatter()
    dayFormatter.dateFormat = "EEEE, MMM d, yyyy"
    dayFormatter.locale = Locale(identifier: "es_MX")
    let startDayFormatter = DateFormatter()
    startDayFormatter.dateFormat = "EEEE"
    startDayFormatter.locale = Locale(identifier: "es_MX")
    let endDayFormatter = DateFormatter()
    endDayFormatter.dateFormat = "EEEE"
    endDayFormatter.locale = Locale(identifier: "es_MX")
    return String(format: "%@  %@",
                 
                  startDayFormatter.string(from: startDate),
                  endDayFormatter.string(from: endDate))
  }
}
