//
//  FirebaseEvent.swift
//  EncuentroCatolico
//
//  Created by Juan Martell on 13/10/22.
//

import UIKit

public final class FirebaseEvent: Traceable {
    
    private var event: Event
    private var dictionary: [String: String] = [:]
    
    public var name: String {
        return self.event.name
    }
    
    public var recordEvent: String?
    
    public lazy var parameters: [String: String] = { [unowned self] in
        self.eventInfo()
        return self.dictionary
    }()
    
    public init(_ event: Event, section: String, flow: String, screen: String) {
        self.event = event
        dictionary["section"] = section
        dictionary["flow"] = flow
        dictionary["screen_name"] = screen
    }
    
    public init(_ event: Event) {
        self.event = event
    }
    
    private func eventInfo() {
        switch event {
        case .interaction(let interaction), .message(let interaction):
            dictionary["type"] = interaction.type
            dictionary["element"] = interaction.element
        case .notification(let pushId, let typeId, let interaction):
            dictionary["type"] = interaction.type
            dictionary["element"] = interaction.element
            dictionary["Id_push"] = pushId
            dictionary["Id_tipo"] = typeId
        case .error(let id):
            dictionary["type"] = "system_error"
            dictionary["id"] = id
        case .promotions(let productId, let bannerId, let interaction):
            dictionary["type"] = interaction.type
            dictionary["element"] = interaction.element
            dictionary["product_id"] = productId
            dictionary["banner_id"] = bannerId
        default:
            break
        }
    }
}

public extension FirebaseEvent {
    @discardableResult
    func set(section: String) -> FirebaseEvent {
        dictionary["section"] = section
        return self
    }
    
    @discardableResult
    func set(flow: String) -> FirebaseEvent {
        dictionary["flow"] = flow
        return self
    }
    
    @discardableResult
    func set(screenName: String) -> FirebaseEvent {
        dictionary["screen_name"] = screenName
        return self
    }
    
    @discardableResult
    func set(category: String) -> FirebaseEvent {
        dictionary["category"] = category
        return self
    }
    
    @discardableResult
    func set(subCategory: String) -> FirebaseEvent {
        dictionary["sub_category"] = subCategory
        return self
    }
    
    @discardableResult
    func set(revenue: String) -> FirebaseEvent {
        dictionary["revenue"] = revenue
        return self
    }
    
    @discardableResult
    func set(term: String) -> FirebaseEvent {
        dictionary["term"] = term
        return self
    }
    
    @discardableResult
    func set(origin: String) -> FirebaseEvent {
        dictionary["origin"] = origin
        return self
    }
    
    @discardableResult
    func set(commerce: String) -> FirebaseEvent {
        dictionary["commerce"] = commerce
        return self
    }
    
    @discardableResult
    func set(product: String) -> FirebaseEvent {
        dictionary["product"] = product
        return self
    }
    
    @discardableResult
    func set(entry: String) -> FirebaseEvent {
        dictionary["entry"] = entry
        return self
    }
    
    @discardableResult
    func set(gender: String) -> FirebaseEvent {
        dictionary["gender"] = gender
        return self
    }
    
    @discardableResult
    func set(age: String) -> FirebaseEvent {
        dictionary["age"] = age
        return self
    }
    
    @discardableResult
    func set(icu: String) -> FirebaseEvent {
        dictionary["icu"] = icu
        return self
    }
    
    @discardableResult
    func set(zipCode: String) -> FirebaseEvent {
        dictionary["cp"] = zipCode
        return self
    }
    
    @discardableResult
    func set(superICU: String) -> FirebaseEvent {
        dictionary["super_icu"] = superICU
        return self
    }
    
    @discardableResult
    func set(civilStatus: String) -> FirebaseEvent {
        dictionary["civil_status"] = civilStatus
        return self
    }
    
    @discardableResult
    func set(location: String) -> FirebaseEvent {
        dictionary["user_locations"] = location
        return self
    }
    
    @discardableResult
    func set(paramaters: [String: String]) -> FirebaseEvent {
        self.dictionary.merge(paramaters) { (_, new) in new }
        return self
    }
}
