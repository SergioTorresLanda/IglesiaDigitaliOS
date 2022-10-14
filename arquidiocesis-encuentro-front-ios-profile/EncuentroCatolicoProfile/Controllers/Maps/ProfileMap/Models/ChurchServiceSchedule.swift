//
//  ChurchServiceSchedule.swift
//  encuentro
//
//  Created by Edgar Hernandez Solis on 06/02/21.
//  Copyright © 2021 Linko. All rights reserved.
//

import Foundation

struct ChurchSchedule: Codable {
    var day: String
    var openHour: String
    var closeHour: String
    
    static let scheduleMonday = ChurchSchedule(day: "Lunes",
                                        openHour: "07:00 AM",
                                        closeHour: "07:00 PM")
    static let scheduleThuesday = ChurchSchedule(day: "Martes",
                                          openHour: "07:00 AM",
                                          closeHour: "10:00 PM")
    static let scheduleWednesday = ChurchSchedule(day: "Miercoles",
                                           openHour: "11:00 AM",
                                           closeHour: "12:00 PM")
    static let scheduleThursday = ChurchSchedule(day: "Jueves",
                                          openHour: "05:00 AM",
                                          closeHour: "07:00 PM")
    static let scheduleFriday = ChurchSchedule(day: "Viernes",
                                        openHour: "05:00 AM",
                                        closeHour: "8:00 PM")
    static let scheduleSaturday = ChurchSchedule(day: "Sabado",
                                          openHour: "07:00 AM",
                                          closeHour: "12:00 PM")
    static let scheduleSunday = ChurchSchedule(day: "Domingo",
                                        openHour: "07:00 AM",
                                        closeHour: "04:00 PM")
    
    func getDescription() -> String {
        return openHour + " - " + closeHour
    }
}
