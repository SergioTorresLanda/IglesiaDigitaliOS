//
//  ServicesCallsDetailChurch.swift
//  EncuentroCatolicoChurch
//
//  Created by Ulises Atonatiuh González Hernández on 31/03/21.
//

import Foundation

struct doGetChourchMain: ResponseDispatcher {
    
    typealias ResponseType = ChurchDetail
    var urlOptional: String?
    var parameters: [String : Any]?
    var id: String = "1"
    
    var data: RequestType {
        return RequestType(path: "/locations/" + id , method: .get, params: nil, url:Endpoints.urlGlobalApp)
    }
    
    init(id: String) {
        self.id = id
    }
}

struct doGetServiceCatalog: ResponseDispatcher {
    typealias ResponseType = ServiceCatalogModel
    var urlOptional: String?
    var parameters: [String : Any]?
    var data: RequestType {
        return RequestType(path: "/catalog/services?type=DEFAULT" , method: .get, params: nil, url:Endpoints.urlGlobalApp)
    }
}

struct DoAddFavoriteSacerdote: ResponseDispatcher {
    typealias ResponseType = ModelResponseAddFav
    var parameters: [String : Any]?
     var urlOptional: String?
    var id : String = ""
    
    var data: RequestType {
        return RequestType(path: "/users/" + self.id + "/locations"  , method: .post, params: self.parameters!, url:Endpoints.urlGlobalApp)

          }
          
    init(id: String, params: [String: Any]) {
        self.id = id
        self.parameters = params
       }
}


struct DoRemoveChurchSacerdote: ResponseDispatcher {
    typealias ResponseType = ModelResponseAddFav
    var parameters: [String : Any]?
     var urlOptional: String?
    let idInt = UserDefaults.standard.integer(forKey: "id")
    var id : String = ""
    var locationId: String = ""
    
    var data: RequestType {
        return RequestType(path: "/users/" + self.id + "/locations/" + self.locationId , method: .delete, params: nil, url:Endpoints.urlGlobalApp)
          }
          
    init(idPriest: String, locationId: String) {
        self.id = idPriest
        self.locationId = locationId
       }
}



struct DoAddFavoriteFiel {
    var parameters: [String : Any]?
    var urlOptional: String?
    var id : String = ""
    
    var data: String {
        return "\(APIType.shared.User())/users/\(self.id)/locations/"
    }
    
    init(id: String, params: [String: Any]) {
        let idInt = UserDefaults.standard.integer(forKey: "id")
        self.id = "\(idInt)"
        self.parameters = params
    }
}


struct DoRemoveFavoriteFiel {
    var parameters: [String : Any]?
    var urlOptional: String?
    var id: String = ""
    var locationId: String = ""
    
    var data: String {
        return "\(APIType.shared.User())/users/ \(self.id)/locations/ \(self.locationId)"
    }
    
    init(idPriest: String, locationId: String, params: [String: Any]) {
        let idInt = UserDefaults.standard.integer(forKey: "id")
        self.id = "\(idInt)"
        self.locationId = locationId
        self.parameters = params
    }
}


struct ModelAddFavorite: Encodable {
    let location_id: Int
    let is_principal: Bool
    
    var todiccionary : [String: Any]? {
        return ["location_id": self.location_id, "is_principal": self.is_principal]
    }

}

struct ModelRemoveFavorite: Encodable {
    let location_id: Int
    let is_principal: Bool
    
    var todiccionary : [String: Any]? {
        return ["location_id": self.location_id, "is_principal": self.is_principal]
    }

}


struct ModelAddFavoriteSacerdote: Encodable {
    let locationId: Int
   
    var todiccionary : [String: Any]? {
        return ["locationId": self.locationId]
          }

}


struct ModelResponseAddFav: Codable {
    let message: String?

}

struct ModelResponseRemoveFavorites: Codable {
    let message: String?
}

enum cases{
    case Celebraciones
    case Bendiciones
    case OtrosServicios
}

enum ServerErrors: Error {
    case ErrorInterno
    case ErrorServidor
    case OK
}
