//
//  TagEvents.swift
//  EncuentroCatolico
//
//  Created by Juan Martell on 13/10/22.
//

import Foundation
import FirebaseAnalytics

public enum TagEvents {
    
    /// Provider
    case firebase
    
    /**
     Tracking event
     
     - Parameters:
     - event: Instance from GSSATraceable.
     - operationQueue: Queue where the tracking will be executed.
     */
    public func tracking(event: Traceable,
                         operationQueue: DispatchQueue = .main) {
        operationQueue.async {            switch self {
            case .firebase:
                Analytics.logEvent(event.name, parameters: event.parameters)
            }
        }
    }
    
    /**
     Tracking multiple events
     
     - Parameters:
     - event: Array of Instance from GSSATraceable.
     - operationQueue: Queue where the tracking will be executed.
     */
    public func traking(events: [Traceable],
                        operationQueue: DispatchQueue = .main) {
        operationQueue.async {
            switch self {
            case .firebase:
                events.forEach {
                    Analytics.logEvent($0.name, parameters: $0.parameters)
                }
            }
        }
    }
}
