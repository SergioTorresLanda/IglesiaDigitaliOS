//
//  PrincipalInteractorSOS.swift
//  EncuentroCatolicoVirtualLibrary
//
//  Created by Pablo Luis Velazquez Zamudio on 16/06/21.
//

import UIKit

class PrincipalInteractorSOS: PrincipalInteractorProtocol {
    weak var presenter: PrincipalPresenterProtocol?
    
    func requestData() {
        guard let apiURL: URL = URL(string: "\(APIType.shared.User())/catalog/services?status=ACTIVE&type=SOS") else { return }
        
        var request = URLRequest(url: apiURL)
        
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let tksession = UserDefaults.standard.string(forKey: "idToken")
        request.setValue("Bearer \( tksession ?? "")", forHTTPHeaderField: "Authorization")
        
        let tarea = URLSession.shared.dataTask(with: request) { data, response, error in
            //print("->>  data: ", data)
            //print("->>  response: ", response)
            //print("->>  error: ", error)
            if error != nil {
                print("Hubo un error 011")
                return
            }
            
            if (response as! HTTPURLResponse).statusCode == 200 {
                
                do {
                    let resp = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                    let contentResponse : [PModelSOS] = try JSONDecoder().decode([PModelSOS].self, from: data!)
                    self.presenter?.getResponse(data: contentResponse)
                }catch{
                    APIType.shared.refreshToken()
                    print("error", error.localizedDescription)
                }
            } else {
                print("Error al llamar ep", (response as! HTTPURLResponse).statusCode)
            }
        }
        tarea.resume()
    }
    
    let staged = UserDefaults.standard.string(forKey: "stage")
    func getLastSOS(serviceID: Int) {
        //guard let apiURL: URL = URL(string: "\(APIType.shared.User())/services?catalog_service_id=\(serviceID)") else { return }
        var API2=""
        if staged == "Qa" {
             API2 = "https://27zdzowufmqtlz5irszrwraxbu0hkzts.lambda-url.us-east-1.on.aws"
        }else if staged == "Prod" {
            API2 = "\(APIType.shared.User())"
        }
        guard let apiURL: URL = URL(string: "\(API2)/services?catalog_service_id=\(serviceID)") else { return }
        //
        print("LA URL sOs ESS :::")
        //print(apiURL.absoluteString)
        var request = URLRequest(url: apiURL)
        let defaults = UserDefaults.standard
        let idUser = defaults.integer(forKey: "id")
        print("ID USER")
        print(idUser)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        request.setValue("\(idUser)", forHTTPHeaderField: "X-User-Id")
        request.setValue("FIEL", forHTTPHeaderField: "X-Role")
        let tksession = UserDefaults.standard.string(forKey: "idToken")
        print("TK SESSION")
        print(tksession)
        request.setValue("Bearer \( tksession ?? "")", forHTTPHeaderField: "Authorization")
        
        let tarea = URLSession.shared.dataTask(with: request) { data, response, error in
            //print("->>  data: ", data)
            //print("->>  response: ", response)
            //print("->>  error: ", error)
            if error != nil {
                print("Hubo un error 010")
                return
            }
            do {
                if data != nil {
                    print("DATA Xxfftyyt")
                    let responseData = String(data: data!, encoding: String.Encoding.utf8)
                    print(responseData!)
                    //let someDictionaryFromJSON = try JSONSerialization.jsonObject(with: data ?? Data(), options: .allowFragments) as! [String: Any]
                    //print(someDictionaryFromJSON)
                    let contentResponse : LastSosModel = try JSONDecoder().decode(LastSosModel.self, from: data!)
                    print(contentResponse)
                    self.presenter?.onSuccessGetLastSOS(data: contentResponse, response: (response as! HTTPURLResponse))
                }
            }catch{
                APIType.shared.refreshToken()
                print("error", error.localizedDescription)
                self.presenter?.onFailGetLastSOS(error: error)
            }
        }
        tarea.resume()
    }
    
    
}
