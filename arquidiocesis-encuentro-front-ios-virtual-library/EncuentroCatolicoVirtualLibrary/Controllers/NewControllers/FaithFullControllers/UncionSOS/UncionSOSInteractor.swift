//
//  UncionSOSInteractor.swift
//  EncuentroCatolicoVirtualLibrary
//
//  Created by Pablo Luis Velazquez Zamudio on 16/06/21.
//

import UIKit


class UncionSOSInteractor: UncionInteractorProtocol {
    weak var preenter: UncionPresenterProtocol?
   // 19.443354745949094
    func getListChurches(latitude: String, longitude: String) {
        guard let apiURL = URL(string: "\(APIType.shared.User())/locations?type=SOS&latitude=\(latitude)&longitude=\(longitude)") else { return }
        var request = URLRequest(url: apiURL)
        
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let tksession = UserDefaults.standard.string(forKey: "idToken")
        request.setValue("Bearer \( tksession ?? "")", forHTTPHeaderField: "Authorization")
        
        let tarea = URLSession.shared.dataTask(with: request) { (data, response, error) in
            print("-->>  data: ", data)
            print("-->>  response: ", response)
            print("-->>  error: ", error)
            if error != nil {
                print("Hubo un error")
                return
            }
            
            do {
                
                if data != nil {
                    let contResponse : [ListChurches] = try JSONDecoder().decode([ListChurches].self, from: data!)
                    self.preenter?.transportData(responseStatus: response as! HTTPURLResponse, data: contResponse)
                }
                
                let contentResp = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                print(contentResp) 
                          
            }catch{
                APIType.shared.refreshToken()
                print("Error al descargar locations", error.localizedDescription, error)
            }
            
        }
        
        tarea.resume()
    }
    
    func postService(address: String, latitude: Double, longitude: Double, devoteeID: Int, idService: Int, contactID: Int) {
        
        let defaults = UserDefaults.standard
        let phoneUser = defaults.object(forKey: "phone2")
        let idUser = defaults.integer(forKey: "id")
        print("********", phoneUser)
        guard let apiURL = URL(string: "\(APIType.shared.User())/sos-services") else { return }
        var request = URLRequest(url: apiURL)
        
        let bodyParams : [String : Any] = [
            "funeral_home" : "",
            "address" : [
                "description": address,
                "longitude": longitude,
                "latitude": latitude
            ],
            "longitude" : longitude,
            "latitude" : latitude,
            "devotee" : [
                "devotee_id" : devoteeID,
                "phone" : "\(phoneUser ?? "+52")"
            ],
            "service" : [
                "id" : idService,
                "type" : "SOS"
            ],
            "support_contact" : [
                "contact_id" : contactID
            ]
        ]
        let body = try! JSONSerialization.data(withJSONObject: bodyParams)
        
        request.httpMethod = "POST"
        request.httpBody = body
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("\(idUser)", forHTTPHeaderField: "X-User-Id")
        let tksession = UserDefaults.standard.string(forKey: "idToken")
        request.setValue("Bearer \( tksession ?? "")", forHTTPHeaderField: "Authorization")
        
        let tarea = URLSession.shared.dataTask(with: request) { (data, response, error) in
            print("-->>  data: ", data)
            print("-->>  response: ", response)
            print("-->>  error: ", error)
            if error != nil {
                print("Hubo un error")
                return
            }
            do{
                let contResponse : ServiceResponse = try JSONDecoder().decode(ServiceResponse.self, from: data!)
                self.preenter?.getPostReponse(responseCode: response as! HTTPURLResponse, responseData: contResponse)
                
            }catch{
                APIType.shared.refreshToken()
                print("error al postear data", error)
            }
                        
        }
        
        tarea.resume()
        
    }
    
}

