//
//  InteractorAdminModules.swift
//  EncuentroCatolicoProfile
//
//  Created by Ulises Atonatiuh González Hernández on 06/05/21.
//

import Foundation

class InteractorAdminModules: ProtocolosAdminModulesInteractorInput {
    
    func requestModuleData(locationId: Int) {
        GetModulesLocationData.init(locatiosId: String(locationId)).execute{ [weak self](result) in
            self?.presenter?.responseModulesData(result: result)
        } onError: { [weak self](error, msg) in
            self?.presenter?.isError(msg: msg)
        }
    }
    
    func requestChangeModulesLocation(locationId: Int, moduleId: [Int]) {
        var dictionary = [[String : Any]]()
        moduleId.forEach{ id in
            dictionary += [["module_id" : id]]
        }
        let locationId: String = "\(locationId)"
        guard let endpoint: URL = URL(string: "\(APIType.shared.User())/" + "locations/" + locationId +  "/modules" ) else {
            print("Error formando url")
            self.presenter?.responseChangeModules(errores: ServerErrors.ErrorServidor, data: nil)
            return
        }
        var request = URLRequest(url: endpoint)
        let idUser = UserDefaults.standard.integer(forKey: "id")
        request.setValue("\(idUser)", forHTTPHeaderField: "X-User-Id")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let tksession = UserDefaults.standard.string(forKey: "idToken")
        request.setValue("Bearer \( tksession ?? "")", forHTTPHeaderField: "Authorization")
        request.httpMethod = "PUT"
        guard let body = try? JSONSerialization.data(withJSONObject: dictionary, options: []) else { return  }
        request.httpBody = body
        print(body)
        let tarea = URLSession.shared.dataTask(with: request) { data, response, error in
            //print("->  respuesta Status Code: ", response as Any)
            //print("->  error: ", error as Any)

            if error != nil {
                print("Hubo un error 039")
                return
            }
            
            if (response as! HTTPURLResponse).statusCode == 200 {
                self.presenter?.responseChangeModules(errores: ServerErrors.OK, data: nil)
            }else{
                self.presenter?.responseChangeModules(errores: ServerErrors.ErrorInterno, data: nil)
                APIType.shared.refreshToken()
            }
        }
        tarea.resume()
    }
        
    var presenter: ProtocolosAdminModulesInteractorOutput?
    func requestData(id: Int, locationId: Int) {
        GetModulesData.init(id: String(id), locatiosId: String(locationId)).execute{ [weak self](result) in
            self?.presenter?.responseData(result: result)
        } onError: { [weak self](error, msg) in
            self?.presenter?.isError(msg: msg)
        }
        
    }
    func requestchangeModules(id: Int, locationId: Int, moduleId: [Int]) {
        var dictionary = [[String : Any]]()
        moduleId.forEach{ id in
            dictionary += [["module_id" : id]]
        }
        let locationId: String = "\(locationId)"
        let userId = "\(id)"
        guard let endpoint: URL = URL(string: "\(APIType.shared.User())/" + "locations/" + locationId + "/collaborators/" + userId + "/modules" ) else {
            print("Error formando url")
            self.presenter?.responseChangeModules(errores: ServerErrors.ErrorServidor, data: nil)
            return
        }
        var request = URLRequest(url: endpoint)
        let idUser = UserDefaults.standard.integer(forKey: "id")
        request.setValue("\(idUser)", forHTTPHeaderField: "X-User-Id")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let tksession = UserDefaults.standard.string(forKey: "idToken")
        request.setValue("Bearer \( tksession ?? "")", forHTTPHeaderField: "Authorization")
        request.httpMethod = "PUT"
        guard let body = try? JSONSerialization.data(withJSONObject: dictionary, options: []) else { return  }
        request.httpBody = body
        let tarea = URLSession.shared.dataTask(with: request) { data, response, error in
            //print("->  respuesta Status Code: ", response as Any)
            //print("->  error: ", error as Any)
            if error != nil {
                print("Hubo un error 038")
                return
            }
            
            if (response as! HTTPURLResponse).statusCode == 200 {
                self.presenter?.responseChangeModules(errores: ServerErrors.OK, data: nil)
            }else{
                self.presenter?.responseChangeModules(errores: ServerErrors.ErrorInterno, data: nil)
                APIType.shared.refreshToken()
            }
        }
        tarea.resume()
    }
    
    func requestCollaboratorDetail(locationID: Int, userID: Int) {
        guard let apiURL = URL(string: "\(APIType.shared.User())/locations/\(locationID)/collaborators/\(userID)") else { return }
        var request = URLRequest(url: apiURL)
        
        let defaults = UserDefaults.standard
        let idUser = defaults.integer(forKey: "id")
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let tksession = UserDefaults.standard.string(forKey: "idToken")
        request.setValue("Bearer \( tksession ?? "")", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        request.setValue("\(idUser)", forHTTPHeaderField: "X-User-Id")
        
        let work = URLSession.shared.dataTask(with: request) { data, response, error in
            //print("->  respuesta Status Code: ", response as Any)
            //print("->  error: ", error as Any)

            do {
                let contentResponse = try JSONDecoder().decode(DetailAdminEntity.self, from: data!)
                self.presenter?.transportResponse(data: contentResponse, response: response as! HTTPURLResponse)
                
            }catch{
                print("Download detail user error", error.localizedDescription, error)
                APIType.shared.refreshToken()
            }
        }
        work.resume()
        
    }
    
}

extension Dictionary where Key == String, Value == Any {
    
    mutating func append(anotherDict:[String:Any]) {
        for (key, value) in anotherDict {
            self.updateValue(value, forKey: key)
        }
    }
}
