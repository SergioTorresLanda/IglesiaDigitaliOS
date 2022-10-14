//
//  date.swift
//  EncuentroCatolicoVirtualLibrary
//
//  Created by MacBookPro on 10/05/21.
//

import Foundation

extension Date {
    
    static func asNumber() -> Double {
        let double = floor (self.init().timeIntervalSince1970 * 1000)
        return double
    }
    
    func formatRelativeString() -> String {
        let date = Date(timeIntervalSince1970: self.timeIntervalSince1970 / 1000)
        let dateFormatter = DateFormatter()
        let calendar = Calendar(identifier: .gregorian)
        dateFormatter.locale = Locale(identifier: "es_MX")
        if calendar.isDateInToday(date) {
            dateFormatter.dateFormat = "h:mm a"
        } else if calendar.isDateInYesterday(date){
            dateFormatter.dateFormat = "'Ayer, 'h:mm a"
        } else if calendar.compare(Date(), to: date, toGranularity: .weekOfYear) == .orderedSame {
            let weekdayIndex = calendar.dateComponents([.weekday], from: date).weekday ?? 0
            let weekday = dateFormatter.weekdaySymbols[weekdayIndex-1]
            return weekday.capitalized
        } else {
            dateFormatter.timeStyle = .none
            dateFormatter.dateStyle = .short
        }
        
        return dateFormatter.string(from: date)
    }
    
}
