//
//  ChurchService.swift
//  encuentro
//
//  Created by Edgar Hernandez Solis on 06/02/21.
//  Copyright © 2021 Linko. All rights reserved.
//

import Foundation
import UIKit

struct ChurchService: Codable {
    var id: UInt
    var name: String
    var icon: String
    var schedules: Array<ChurchSchedule>
    
    static let service_1 = ChurchService(id: 0,
                                name: "Bautizos",
                                icon: "devotions_icon_dummy_4",
                                schedules: [ChurchSchedule.scheduleMonday,
                                            ChurchSchedule.scheduleThuesday,
                                            ChurchSchedule.scheduleWednesday,
                                            ChurchSchedule.scheduleThursday,
                                            ChurchSchedule.scheduleFriday])
    static let service_2 = ChurchService(id: 1,
                                  name: "Matrimonio",
                                  icon: "devotions_icon_dummy_5",
                                  schedules: [ChurchSchedule.scheduleSaturday,
                                              ChurchSchedule.scheduleSunday])
    static let service_3 = ChurchService(id: 2,
                                  name: "Catecismo",
                                  icon: "devotions_icon_dummy_6",
                                  schedules: [ChurchSchedule.scheduleFriday,
                                              ChurchSchedule.scheduleSaturday,
                                              ChurchSchedule.scheduleSunday])
    static let service_4 = ChurchService(id: 3,
                                  name: "Unción de los enfermos",
                                  icon: "devotions_icon_dummy_2",
                                  schedules: [ChurchSchedule.scheduleMonday,
                                              ChurchSchedule.scheduleThuesday,
                                              ChurchSchedule.scheduleWednesday,
                                              ChurchSchedule.scheduleThursday,
                                              ChurchSchedule.scheduleFriday,
                                              ChurchSchedule.scheduleSaturday,
                                              ChurchSchedule.scheduleSunday])
    static let service_5 = ChurchService(id: 4,
                                  name: "Eucaristía a domicilio",
                                  icon: "devotions_icon_dummy_3",
                                  schedules: [ChurchSchedule.scheduleMonday,
                                              ChurchSchedule.scheduleThuesday,
                                              ChurchSchedule.scheduleWednesday,
                                              ChurchSchedule.scheduleThursday,
                                              ChurchSchedule.scheduleFriday])
    static let service_6 = ChurchService(id: 5,
                                  name: "Confirmación",
                                  icon: "devotions_icon_dummy_1",
                                  schedules: [ChurchSchedule.scheduleMonday,
                                              ChurchSchedule.scheduleThuesday,
                                              ChurchSchedule.scheduleWednesday,
                                              ChurchSchedule.scheduleThursday,
                                              ChurchSchedule.scheduleFriday])
    static let service_7 = ChurchService(id: 6,
                                  name: "Misas",
                                  icon: "devotions_icon_dummy_7",
                                  schedules: [ChurchSchedule.scheduleSunday])
    
//    static let service_8 = ChurchService(id: 7,
//                                         name: "Confirmación",
//                                         icon: UIImage(named: "devotions_icon_dummy_6"),
//                                         schedules: [ChurchSchedule.scheduleFriday,
//                                                     ChurchSchedule.scheduleSaturday,
//                                                     ChurchSchedule.scheduleSunday])
    
    static let service_9 = ChurchService(id: 8,
                                         name: "Primera comunión",
                                         icon: "devotions_icon_dummy_4",
                                         schedules: [ChurchSchedule.scheduleFriday,
                                                     ChurchSchedule.scheduleSaturday,
                                                     ChurchSchedule.scheduleSunday])
    
    static let service_10 = ChurchService(id: 9,
                                        name: "Reconciliación",
                                        icon: "devotions_icon_dummy_5",
                                        schedules: [ChurchSchedule.scheduleSaturday,
                                                    ChurchSchedule.scheduleSunday])
    
    static let service_11 = ChurchService(id: 10,
                                          name: "Presentación 3 años",
                                          icon: "devotions_icon_dummy_4",
                                          schedules: [ChurchSchedule.scheduleMonday,
                                                      ChurchSchedule.scheduleThuesday,
                                                      ChurchSchedule.scheduleWednesday,
                                                      ChurchSchedule.scheduleThursday,
                                                      ChurchSchedule.scheduleFriday])
    
    static let service_12 = ChurchService(id: 11,
                                          name: "Acción de gracias por XV años",
                                          icon: "devotions_icon_dummy_4",
                                          schedules: [ChurchSchedule.scheduleMonday,
                                                      ChurchSchedule.scheduleThuesday,
                                                      ChurchSchedule.scheduleWednesday,
                                                      ChurchSchedule.scheduleThursday,
                                                      ChurchSchedule.scheduleFriday])
    
    static let service_13 = ChurchService(id: 12,
                                name: "Pláticas pre-bautismales",
                                icon: "devotions_icon_dummy_4",
                                schedules: [ChurchSchedule.scheduleMonday,
                                            ChurchSchedule.scheduleThuesday,
                                            ChurchSchedule.scheduleWednesday,
                                            ChurchSchedule.scheduleThursday,
                                            ChurchSchedule.scheduleFriday])
    
    static let service_14 = ChurchService(id: 13,
                                  name: "Pláticas pre-matrimoniales",
                                  icon: "devotions_icon_dummy_5",
                                  schedules: [ChurchSchedule.scheduleSaturday,
                                              ChurchSchedule.scheduleSunday])

    
    static let service_15 = ChurchService(id: 14,
                                          name: "Confesiones",
                                          icon: "devotions_icon_dummy_7",
                                          schedules: [ChurchSchedule.scheduleSunday])
    
    static let service_16 = ChurchService(id: 15,
                                          name: "Exequias",
                                          icon: "devotions_icon_dummy_7",
                                          schedules: [ChurchSchedule.scheduleSunday])
   
    
    static let service_17 = ChurchService(id: 16,
                                          name: "Intenciones particulares",
                                          icon: "devotions_icon_dummy_6",
                                          schedules: [ChurchSchedule.scheduleFriday,
                                                      ChurchSchedule.scheduleSaturday,
                                                      ChurchSchedule.scheduleSunday])
    
    static let service_18 = ChurchService(id: 17,
                                          name: "Platicas pre-sacramentales",
                                          icon: "devotions_icon_dummy_6",
                                          schedules: [ChurchSchedule.scheduleFriday,
                                                      ChurchSchedule.scheduleSaturday,
                                                      ChurchSchedule.scheduleSunday])

    
    static let service_19 = ChurchService(id: 18,
                                          name: "Graduaciones",
                                          icon: "devotions_icon_dummy_7",
                                          schedules: [ChurchSchedule.scheduleSunday])
    
    static let service_20 = ChurchService(id: 19,
                                          name: "Aniversarios",
                                          icon: "devotions_icon_dummy_7",
                                          schedules: [ChurchSchedule.scheduleSunday])
    
    
    static func getDumyServices() -> Array<ChurchService> {
        
        
        var services: Array<ChurchService> = Array()
        
        services.append(ChurchService.service_1)
        services.append(ChurchService.service_2)
        services.append(ChurchService.service_3)
        services.append(ChurchService.service_4)
        services.append(ChurchService.service_5)
        services.append(ChurchService.service_6)
        services.append(ChurchService.service_7)
//        services.append(ChurchService.service_8)
        services.append(ChurchService.service_9)
        services.append(ChurchService.service_10)
        services.append(ChurchService.service_11)
        services.append(ChurchService.service_12)
        services.append(ChurchService.service_13)
        services.append(ChurchService.service_14)
        services.append(ChurchService.service_15)
        services.append(ChurchService.service_16)
        services.append(ChurchService.service_17)
        services.append(ChurchService.service_18)
        services.append(ChurchService.service_19)
        services.append(ChurchService.service_20)
        
        return services
    }
    
    static func getFrecuentServices() -> Array<ChurchService> {
        
        
        var services: Array<ChurchService> = Array()
        
        services.append(ChurchService.service_7)
        services.append(ChurchService.service_2)
        services.append(ChurchService.service_3)
        services.append(ChurchService.service_4)
        services.append(ChurchService.service_5)
        services.append(ChurchService.service_6)
        
        return services
    }
    
    static func getServiceByChurch()  -> Array<ChurchService> {
        return [ChurchService.service_6,
                ChurchService.service_2,
                ChurchService.service_12,
                ChurchService.service_1,
                ChurchService.service_15,
                ChurchService.service_16,
                ChurchService.service_17,
                ChurchService.service_18]
    }
}
