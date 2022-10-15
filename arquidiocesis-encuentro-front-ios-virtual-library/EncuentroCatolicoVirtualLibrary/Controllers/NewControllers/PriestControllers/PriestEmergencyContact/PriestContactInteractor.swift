//
//  PriestContactInteractor.swift
//  EncuentroCatolicoVirtualLibrary
//
//  Created by Pablo Luis Velazquez Zamudio on 28/06/21.
//

import UIKit

class PriestContactInteractor: PriestContactInteractorProtocol {
    weak var presenter: PriestContactPresenterProtocol?
    var idServ = 0
    
    func getServiceDetailContact(idService: Int) {
        
        let idUser = UserDefaults.standard.integer(forKey: "id")
        guard let apiURL = URL(string: "\(APIType.shared.User())/sos-services/\(idService)") else { return }
        var request = URLRequest(url: apiURL)
        self.idServ = idService
        
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("\(idUser)", forHTTPHeaderField: "X-User-Id")
        let tksession = UserDefaults.standard.string(forKey: "idToken")
        request.setValue("Bearer \( tksession ?? "")", forHTTPHeaderField: "Authorization")
        
        let tarea = URLSession.shared.dataTask(with: request) { (data, response, error) in
            //print("-->>  data: ", data)
            //print("-->>  response: ", response)
            //print("-->>  error: ", error)
            if error != nil {
                print("Hubo un error")
                return
            }
            
            do {
                
                if data != nil {
                    
                    let contResponse : DetailContact = try JSONDecoder().decode(DetailContact.self, from: data!)
                    self.presenter?.transportResponseContact(responseCode: response as! HTTPURLResponse, data: contResponse)
                   // print("Essta es la respuesta", contResponse)
                }
                
            }catch{
                APIType.shared.refreshToken()
                print("Error al descargar services", error.localizedDescription, error)
            }
            
        }
        tarea.resume()

    }
    
    func patchUpdateService(status: String, flowID: Int) {
        
        let idUser = UserDefaults.standard.integer(forKey: "id")
        print("Este el service:", self.idServ)
        guard let apiURL = URL(string: "\(APIType.shared.User())/sos-services/\(self.idServ)") else { return }
        var request = URLRequest(url: apiURL)
        
        let bodyParams : [String : String] = [
            "status" : status
        ]
        let body = try! JSONSerialization.data(withJSONObject: bodyParams)
        
        request.httpMethod = "PATCH"
        request.httpBody = body
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("\(idUser)", forHTTPHeaderField: "X-User-Id")
        let tksession = UserDefaults.standard.string(forKey: "idToken")
        request.setValue("Bearer \( tksession ?? "")", forHTTPHeaderField: "Authorization")
        
        let tarea = URLSession.shared.dataTask(with: request) { (data, response, error) in
            //print("-->>  data: ", data)
            //print("-->>  response: ", response)
            //print("-->>  error: ", error)
            if error != nil {
                print("Hubo un error")
                return
            }
            
            do {
                
                if data != nil {
                    self.presenter?.getStatusUpdate(responseCode: response as! HTTPURLResponse, status: status, flowID: flowID)

                }
                
            }catch{
                APIType.shared.refreshToken()
                print("Error al descargar services", error.localizedDescription)
            }
            
        }
        tarea.resume()

    }
    
    func putUpdateHour(dateService: String, priestID: Int) {
        print("Este el service2:", self.idServ)
        
        let idUser = UserDefaults.standard.integer(forKey: "id")
        guard let apiURL = URL(string: "\(APIType.shared.User())/sos-services/\(self.idServ)") else { return }
        var request = URLRequest(url: apiURL)
        
        let bodyParams : [String : Any] = [
            "scheduled_date" : dateService,
            "priest" : [
                "id" : priestID
            ]
        ]
        let body = try! JSONSerialization.data(withJSONObject: bodyParams)
        
        request.httpMethod = "PUT"
        request.httpBody = body
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("\(idUser)", forHTTPHeaderField: "X-User-Id")
        let tksession = UserDefaults.standard.string(forKey: "idToken")
        request.setValue("Bearer \( tksession ?? "")", forHTTPHeaderField: "Authorization")
        
        let tarea = URLSession.shared.dataTask(with: request) { (data, response, error) in
            //print("-->>  data: ", data)
            //print("-->>  response: ", response)
            //print("-->>  error: ", error)
            if error != nil {
                print("Hubo un error")
                APIType.shared.refreshToken()
                return
            }
            
            self.presenter?.statusUpdateHour(responseCode: response as! HTTPURLResponse)
                        
        }
        
        tarea.resume()
    }
    
}

