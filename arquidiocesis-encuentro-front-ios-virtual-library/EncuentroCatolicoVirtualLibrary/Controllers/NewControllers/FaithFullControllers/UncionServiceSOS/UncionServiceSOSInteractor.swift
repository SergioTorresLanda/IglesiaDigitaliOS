//
//  UncionServiceSOSInteractor.swift
//  EncuentroCatolicoVirtualLibrary
//
//  Created by Pablo Luis Velazquez Zamudio on 16/06/21.
//

import UIKit

class UncionServiceSOSInteractor: UncionServiceInteractorProtocol {
    weak var preenter: UncionServicePresenterProtocol?
    
    func getServiceDetail(idService: Int) {
        guard let apiURL = URL(string: "\(APIType.shared.User())/sos-services/\(idService)") else { return }
        var request = URLRequest(url: apiURL)
        let defaults = UserDefaults.standard
        let idUser = defaults.integer(forKey: "id")
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("\(idUser)", forHTTPHeaderField: "X-User-Id")
        let tksession = UserDefaults.standard.string(forKey: "idToken")
        request.setValue("Bearer \( tksession ?? "")", forHTTPHeaderField: "Authorization")
        
        let tarea = URLSession.shared.dataTask(with: request) { (data, response, error) in
           
            if error != nil {
                print("Hubo un error 015")
                return
            }
            print("RESpONSE:::xx")
            let responseData = String(data: data!, encoding: String.Encoding.utf8)
            print(responseData)
            do {
                if data != nil {
                    var contResponse : ServiceDetailFaithful = try JSONDecoder().decode(ServiceDetailFaithful.self, from: data!)
                    self.preenter?.trasportResponse(responseCode: response as! HTTPURLResponse, data: contResponse)
                }
                
            }catch{
               
                self.preenter?.trasportResponseFail()
                //EL RECURSO SOLICITADO NO FUE ENCONTRADO
                APIType.shared.refreshToken()
                print("Error al descargar services", error.localizedDescription, error)
            }
        }
        tarea.resume()
        
    }
    
    func patchUpdateServiceCancel(status: String, flowID: Int, idService: Int) {
        let id = UserDefaults.standard.integer(forKey: "id")
        print("Este el service:", idService)
        guard let apiURL = URL(string: "\(APIType.shared.User())/sos-services/\(idService)") else { return }
        var request = URLRequest(url: apiURL)
        
        let bodyParams : [String : String] = [
            "status" : status
        ]
        let body = try! JSONSerialization.data(withJSONObject: bodyParams)
        
        request.httpMethod = "PATCH"
        request.httpBody = body
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("\(id)", forHTTPHeaderField: "X-User-Id")
        let tksession = UserDefaults.standard.string(forKey: "idToken")
        request.setValue("Bearer \( tksession ?? "")", forHTTPHeaderField: "Authorization")
        
        let tarea = URLSession.shared.dataTask(with: request) { (data, response, error) in
            //print("->>  data: ", data)
            //print("->>  response: ", response)
            //print("->>  error: ", error)
            
            if error != nil {
                print("Hubo un error 014")
                return
            }
            
            do {
                
              //  if data != nil {
                    self.preenter?.responseCancelPatch(codeREsponse: response as! HTTPURLResponse)
              //  }
                
            }catch{
                APIType.shared.refreshToken()
                print("Error al descargar services", error.localizedDescription)
            }
            
        }
        tarea.resume()

    }
    
}
