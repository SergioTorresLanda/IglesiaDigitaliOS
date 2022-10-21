//
//  FF_Formation_Entity.swift
//  EncuentroCatolicoNewFormation
//
//  Created by Daniel Isaac Mora Osorio on 07/05/21.
//

import UIKit

class FF_Formation_Entity: Codable {
    var id: Int
    var image: String
    var title: String
    var subtitle: String
    var tags: String
    var views: Int
    var type: String
    var url: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case image = "image"
        case title = "title"
        case subtitle = "subtitle"
        case tags = "tags"
        case views = "views"
        case type = "type"
        case url =  "url"
    }
    
    func asFormationCell() -> FormationCell{
        print("Titulo::: \(self.title)")
        return FormationCell(
            title: self.title,
            subtitle: self.subtitle,
            whereIs: "",
            zone: "",
            views: "\((self.views > 1 ? "\(self.views) vistas" : (self.views <= 0 ? "Sin vistas" : "\(self.views) vista")))",
            image: self.image,
            tags: self.tags)
        
        printData()
    }
    
    func printData(){
        print("id: \(id)")
        print("image: \(image)")
        print("title: \(title)")
        print("subtitle: \(subtitle)")
        print("tags: \(tags)")
        print("views: \(views)")
        print("type: \(type)")
        print("url: \(url)")
    }
}

class FF_Catalog_Entity: Codable{
    var code: String
    var name: String
    var iconUrl: String
    var iconPressedUrl: String
    
    enum CodingKeys: String, CodingKey{
        case code = "code"
        case name = "name"
        case iconUrl = "icon_url"
        case iconPressedUrl = "icon_pressed_url"
    }
    
}
