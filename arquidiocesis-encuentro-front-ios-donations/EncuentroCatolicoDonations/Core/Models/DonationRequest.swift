//
//  DonationRequest.swift
//  EncuentroCatolicoDonations
//
//  Created by Alejandro on 13/10/22.
//

import Foundation

struct DonationRequest: Encodable {
    //MARK: - Properties
       var amount: String
       var email: String
       var locationId: String
       var name: String
       var operationId: String
       var phoneNumber: String
       var surnames: String
       var rfc: String?
       var businessName: String?
       var address: String?
       var neighborhood: String?
       var municipality: String?
       var zipcode: String?

    //MARK: - CodingKeys
    enum CodingKeys: String, CodingKey {
        case amount
        case email
        case locationId = "location_id"
        case name
        case operationId = "operation_id"
        case phoneNumber = "phone_number"
        case surnames
        case rfc
        case businessName = "business_name"
        case address
        case neighborhood = "neighborhood"
        case municipality
        case zipcode = "zipcode"
    }
    
}
