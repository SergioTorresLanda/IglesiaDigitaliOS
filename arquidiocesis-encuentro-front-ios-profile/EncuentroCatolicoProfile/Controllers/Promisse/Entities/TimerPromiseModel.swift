//
//  ReasonModel.swift
//  EncuentroCatolicoProfile
//
//  Created by Jorge Cruz on 23/03/21.
//

import UIKit

struct TimerPromiseModel: Codable {
    
    var timeToPromise: String?
    var timeOnDays: Int?
    
    init(timeToPromise:String, timeOnDays: Int) {
        self.timeToPromise = timeToPromise
        self.timeOnDays = timeOnDays
    }
    
    enum CodingKeys: String, CodingKey {
        case timeToPromise = "timeToPromise"
        case timeOnDays = "timeOnDays"
    }
}
