//
//  Event.swift
//  EncuentroCatolico
//
//  Created by Juan Martell on 13/10/22.
//

import Foundation

public enum Event {
    /// ViewControllers
    case pageView
    /// UI Interactions
    case interaction(_ interaction: InteractionType)
    /// Push Notifications
    case notification(_ pushId: String, _ typeId: String, _ interaction: InteractionType)
    /// Service errors
    case error(_ id: String)
    /// Alerts, Sheets
    case message(_ interaction: InteractionType)
    /// Promotions, Banners
    case promotions(_ productId: String, _ bannerId: String, _ interaction: InteractionType)
    /// Transactions Success
    case success(_ flow: String)
    /// No register event
    case custom(_ name: String)
    
    /// Tacking name
    var name: String {
        switch self {
        case .pageView:
            return "pageview"
        case .interaction:
            return "ui_interaction"
        case .notification:
            return "ui_notificaction"
        case .error:
            return "error_sp"
        case .message:
            return "message"
        case .promotions:
            return "promotions"
        case .success(let flow):
            return "\(flow)_success"
        case.custom(let name):
            return name
        }
    }
}
