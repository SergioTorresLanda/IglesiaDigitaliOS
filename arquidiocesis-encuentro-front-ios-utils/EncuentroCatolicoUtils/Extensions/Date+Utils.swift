//
//  DateExtension.swift
//  EncuentroCatolicoUtils
//
//  Created by Alejandro on 16/10/22.
//

import Foundation

public extension Date {
    //MARK: - Methods
    /**
     A function that returns the number of days between two given dates, by default it compares with the current date (Date())
     - parameter from: A `Date` object used as the first date.
     - parameter to: A `Date` object used as the second date. Default value uses the current date.
     - parameter components: A set of `Calendar.Component`. Default value uses the .minute, .hour & .day components
     - returns: `DateComponents` object with the specified components in `Set<Calendar.Component>`.
     */
    static func getDifferenceBetweenDates(from firstDate: Date, to secondDate: Date = Date(), components: Set<Calendar.Component> = [.minute, .hour, .day]) -> DateComponents {
        var calendar = Calendar.current
        calendar.locale = Locale(identifier: "es_MX")
        return calendar.dateComponents(components, from: firstDate, to: secondDate)
    }
}
