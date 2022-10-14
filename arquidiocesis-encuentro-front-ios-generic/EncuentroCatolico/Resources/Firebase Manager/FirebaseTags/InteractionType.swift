//
//  FirebaseInteractionType.swift
//  EncuentroCatolico
//
//  Created by Juan Martell on 13/10/22.
//

import Foundation
public enum InteractionType {
    /// Click handler
    case click(_ state: StateInteractionEvent, _ element: String)
    /// UISwitch handler
    case `switch`(_ value: Bool, _ element: String)
    /// Box checks handler
    case check(_ value: Bool, _ element: String)
    /// Present element in screen
    case impression(_ element: String)
    /// TapGesture handler
    case tap(_ state: StateInteractionEvent, _ element: String)
    /// SliderButton handler
    case swipe(_ element : String)
    
    /// Tracking type
    var type: String {
        switch self {
        case .click(let state, _):
            return "click\(state.rawValue)"
        case .switch(let value, _):
            return "switch\(value ? StateInteractionEvent.on.rawValue : StateInteractionEvent.off.rawValue)"
        case .check(let value, _):
            return "check\(value ? StateInteractionEvent.on.rawValue : StateInteractionEvent.off.rawValue)"
        case .impression:
            return "impression"
        case .tap(let state, _):
            return "tap\(state.rawValue)"
        case .swipe:
            return "swipe"
        }
    }
    
    /// Tracking element
    var element: String {
        switch self {
        case .click(_, let element):
            return element
        case .switch(_, let element):
            return element
        case .check(_, let element):
            return element
        case .impression(let element):
            return element
        case .tap(_, let element):
            return element
        case .swipe(let element):
            return element
        }
    }
}
