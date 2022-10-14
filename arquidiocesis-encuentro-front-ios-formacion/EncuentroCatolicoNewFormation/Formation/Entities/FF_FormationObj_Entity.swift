//
//  FF_FormationObj_Entity.swift
//  EncuentroCatolicoNewFormation
//
//  Created by Daniel Isaac Mora Osorio on 07/05/21.
//

import Foundation

class FF_FormationObj_Entity: Codable {
    var news: [FF_Formation_Entity]
    var featured: [FF_Formation_Entity]
    
    enum CodingKeys: String, CodingKey {
        case news = "news"
        case featured = "featured"
    }
}

class FF_CatalogObj_Entity: Codable{
    var data: [FF_Catalog_Entity]
    
    
    enum CodingKeys: String, CodingKey{
        case data = "data"
        
    }
}
