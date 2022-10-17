//
//  NewDetailServiceInteractor.swift
//  EncuentroCatolicoServices
//
//  Created by Pablo Luis Velazquez Zamudio on 27/07/21.
//

import Foundation
import UIKit

class NewDetailServiceInteractor: NewDetailServiceInteractorProtocol {
    
    var presenter: NewDetailServicePresenterProtocol?
    let defaults = UserDefaults.standard
    
    func getServiceDetail(idService: String) {
        guard let apiURL = URL(string: "\(APIType.shared.User())/services/\(idService)") else { return }
        var request = URLRequest(url: apiURL)
        let idUser = defaults.integer(forKey: "id")
        request.httpMethod = "GET"
        let tksession = UserDefaults.standard.string(forKey: "idToken")
        request.setValue("Bearer \( tksession ?? "")", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("\(idUser)", forHTTPHeaderField: "X-User-Id")
        
        let work = URLSession.shared.dataTask(with: request) { (data, response, error) in
            print("-->  respuesta Status Code: ", response as Any)
            print("-->  error: ", error as Any)
            do{
                if data != nil {
                    let responseData: DetailService = try JSONDecoder().decode(DetailService.self, from: data!)
                    self.presenter?.passResponseRequestDetail(contentResponse: responseData, responseCode: response as! HTTPURLResponse)
                    
                }
                
            }catch{
                APIType.shared.refreshToken()
                print("Error try download services list", error.localizedDescription, error)
            }
            
        }
        
        work.resume()

    }
    
    func patchStatusService(status: String, idService: String, typeService: String, comment: String) {
        guard let apiURL = URL(string: "\(APIType.shared.User())/services/\(idService)") else { return }
        var request = URLRequest(url: apiURL)
        
        var bodyParams : [String : String] = [
            "status" : status
        ]
        
        if typeService == "COMMENT" {
            bodyParams = [
                "comments" : comment
            ]
        }
        
        let body = try! JSONSerialization.data(withJSONObject: bodyParams)
        let idUser = defaults.integer(forKey: "id")
        request.httpMethod = "PATCH"
        request.httpBody = body
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let tksession = UserDefaults.standard.string(forKey: "idToken")
        request.setValue("Bearer \( tksession ?? "")", forHTTPHeaderField: "Authorization")
        request.setValue("\(idUser)", forHTTPHeaderField: "X-User-Id")
        
        let work = URLSession.shared.dataTask(with: request) { (data, response, error) in
            print("-->  respuesta Status Code: ", response as Any)
            print("-->  error: ", error as Any)
            self.presenter?.responsePatchService(responseCode: response as! HTTPURLResponse, typePatch: typeService)
            
        }
        work.resume()
    }
    
}
