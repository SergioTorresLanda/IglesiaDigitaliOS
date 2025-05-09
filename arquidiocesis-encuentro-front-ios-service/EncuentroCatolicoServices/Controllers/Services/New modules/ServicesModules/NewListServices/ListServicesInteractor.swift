//
//  ListServicesInteractor.swift
//  EncuentroCatolicoServices
//
//  Created by Pablo Luis Velazquez Zamudio on 26/07/21.
//

import UIKit

class ListServiceInteractor: ListServiceInteractorProtocol {
    
    var presenter: ListServicePresenterProtocol?
    
    func getListServices(queryParam: String, xrole: String) {
        guard let apiURL = URL(string: "\(APIType.shared.User())/services\(queryParam)") else { return }
        var request = URLRequest(url: apiURL)
        let defaults = UserDefaults.standard
        let idUser = defaults.integer(forKey: "id")
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let tksession = UserDefaults.standard.string(forKey: "idToken")
        request.setValue("Bearer \( tksession ?? "")", forHTTPHeaderField: "Authorization")
        request.setValue("\(idUser)", forHTTPHeaderField: "X-User-Id")
        request.setValue(xrole, forHTTPHeaderField: "X-Role")
        
        let work = URLSession.shared.dataTask(with: request) { (data, response, error) in
            //print("->  respuesta Status Code: ", response as Any)
            //print("->  error: ", error as Any)
            do{
                if data != nil {
                    let rD = String(data: data!, encoding: String.Encoding.utf8)
                    print("RESPONSEEE:::SERVICESS")
                    print(rD)
                    let responseData: [ListServicesStandard] = try JSONDecoder().decode([ListServicesStandard].self, from: data!)
                    self.presenter?.passResponseRequestList(responseData: responseData, codeResponse: response as! HTTPURLResponse)
                }
            }catch{
                //APIType.shared.refreshToken()
                let arrListSS:[ListServicesStandard]=[]
                self.presenter?.passResponseRequestList(responseData: arrListSS, codeResponse: response as! HTTPURLResponse)
                print("Error try download services list", error.localizedDescription, error)
            }
        }
        
        work.resume()

    }
    
    func deleteService(idService: String) {
        guard let apiURL = URL(string: "\(APIType.shared.User())/services/\(idService)") else { return }
        var request = URLRequest(url: apiURL)
        let defaults = UserDefaults.standard
        let idUser = defaults.integer(forKey: "id")
        request.httpMethod = "DELETE"
        let tksession = UserDefaults.standard.string(forKey: "idToken")
        request.setValue("Bearer \( tksession ?? "")", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("\(idUser)", forHTTPHeaderField: "X-User-Id")
        
        let work = URLSession.shared.dataTask(with: request) { (data, response, error) in
            //print("->  respuesta Status Code: ", response as Any)
            //print("->  error: ", error as Any)
            
            if (response as! HTTPURLResponse).statusCode == 200 {
                self.presenter?.deleteResponse(responseCode: response as! HTTPURLResponse)
            }else{
                APIType.shared.refreshToken()
                self.presenter?.fatalErrorDelete()
            }
//            if error != nil {
//
//            }
            
        }
        
        work.resume()
        
    }
    
}

