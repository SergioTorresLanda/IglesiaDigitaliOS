//
//  DateExtension.swift
//  zeus-ios-sdk-new-social-network
//
//  Created by Miguel Angel Vicario Flores on 17/12/20.
//  Copyright © 2020 Gabriel Briseño. All rights reserved.
//

import Foundation

public extension Date {
    func formatRelativeString() -> String {
        let date = Date(timeIntervalSince1970: self.timeIntervalSince1970 / 1000)
        let dateFormatter = DateFormatter()
        let calendar = Calendar(identifier: .gregorian)
        dateFormatter.locale = Locale(identifier: "es_MX")
        
        if calendar.isDateInToday(date) {
            dateFormatter.dateFormat = "HH:mm a"
        } else if calendar.isDateInYesterday(date) {
            dateFormatter.dateFormat = "'Ayer, 'HH:mm a"
        } else if calendar.compare(Date(), to: date, toGranularity: .weekOfYear) == .orderedSame {
            let weekdayIndex = calendar.dateComponents([.weekday], from: date).weekday ?? 0
            let weekday = dateFormatter.weekdaySymbols[weekdayIndex - 1]
            return weekday.capitalized
        } else {
            dateFormatter.dateFormat = "dd MMMM"
            let dateString = dateFormatter.string(from: date)
            let dateArray = dateString.components(separatedBy: " ")
            let day: String = dateArray[0]
            let month: String = dateArray[1]
            
            return  day + " " + month.capitalized
        }
        
        return dateFormatter.string(from: date)
    }
    
    func isFromCurrentDate() -> Bool {
        let date = Date(timeIntervalSince1970: self.timeIntervalSince1970 / 1000)
        let calendar = Calendar(identifier: .gregorian)
        
        return calendar.isDateInToday(date)
    }
}
