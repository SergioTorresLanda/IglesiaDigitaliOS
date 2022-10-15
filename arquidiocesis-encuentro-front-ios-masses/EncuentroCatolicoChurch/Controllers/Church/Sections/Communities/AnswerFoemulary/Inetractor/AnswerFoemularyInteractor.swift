//
//  AnswerFoemularyInteractor.swift
//  EncuentroCatolicoChurch
//
//  Created by Jorge Garcia on 03/08/21.
//

import Foundation

class AnswerFoemularyInteractor: AnswerFoemularyInteractorInputProtocol {
    
    var presenter: AnswerFoemularyInteractorOutputProtocol?
    
    func getCommunityType() {
        doGetCatalog.init().execute { (result) in
            self.presenter?.communityTypeResponse(response: result)
        } onError: { (error, msg) in
            self.presenter?.communityTupeError(msg: msg)
        }
    }
    
    func postCommunity(name: String, address: String, long: Double, lat: Double, email: String, phone: String, type: Int) {
        let dictionary : [String:Any] = [
            "name" : name,
            "type_id" : type,
            "address" : address,
            "longitude" : long,
            "latitude" : lat,
            "email" : email,
            "phone" : phone
        ]//CommunityTypeModel.init(name: name, address: address, longitude: long, latitude: lat, email: email, phone: phone, type: type)
        guard let endpoint: URL = URL(string: "\(APIType.shared.User())/locations") else {
            print("Error formando url")
            self.presenter?.responseAddCommunity(errores: ServerErrors.ErrorServidor, data: nil)
            return
        }
        let defaults = UserDefaults.standard
        let idUser = defaults.integer(forKey: "id")
        var request = URLRequest(url: endpoint)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let tksession = UserDefaults.standard.string(forKey: "idToken")
        request.setValue("Bearer \( tksession ?? "")", forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        request.setValue("\(idUser)", forHTTPHeaderField: "X-User-Id")
        guard let body = try? JSONSerialization.data(withJSONObject: dictionary, options: []) else { return  }
        request.httpBody = body
        let tarea = URLSession.shared.dataTask(with: request) { data, response, error in
          //  print("-->>  Services class: ", String(describing: type(of: self)))
            print("->  respuesta Status Code: ", response as Any)
            print("->  error: ", error as Any)
            let responseServer = try! JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary
            print("->✅  responseServer: ", responseServer as Any)

            if error != nil {
                print("Hubo un error")
                return
            }
            print(response)
            if (response as! HTTPURLResponse).statusCode == 201 {
                self.presenter?.responseAddCommunity(errores: ServerErrors.OK, data: nil)
            }else{
                APIType.shared.refreshToken()
                self.presenter?.responseAddCommunity(errores: ServerErrors.ErrorInterno, data: nil)
            }
        }
        tarea.resume()
    }
}


struct doGetCatalog: ResponseDispatcher {
    
    typealias ResponseType = CommunityTypeCatalog
    var urlOptional: String?
    var parameters: [String : Any]?
    
    var data: RequestType {
        return RequestType(path: "/catalog/community-types/" , method: .get, params: nil, url:Endpoints.urlGlobalApp)
    }
}


