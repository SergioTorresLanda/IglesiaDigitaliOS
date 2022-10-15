//
//  IntentionsInteractor.swift
//  EncuentroCatolicoServices
//
//  Created Desarrollo on 27/04/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//
//import EncuentroCatolicoChurch
import UIKit

class IntentionsInteractor: IntentionsInteractorProtocol {
    
    
    weak var presenter: IntentionsPresenterProtocol?
    #warning("cambiar url por mi iglesia")
    func requestlocations() {
        let idUser = UserDefaults.standard.integer(forKey: "id")
        guard let endpoint: URL = URL(string: "\(APIType.shared.User())/users/\(idUser)/locations?category=CHURCH") else {
            print("Error formando url")
            self.presenter?.getResponse(errores: ServerErrors.ErrorServidor, data: nil)
            return
        }
        
        var request = URLRequest(url: endpoint)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let tksession = UserDefaults.standard.string(forKey: "idToken")
        request.setValue("Bearer \( tksession ?? "")", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        
        let tarea = URLSession.shared.dataTask(with: request) { data, response, error in
            //print("->  respuesta Status Code: ", response as Any)
            //print("->  error: ", error as Any)
            if error != nil {
                print("Hubo un error")
                return
            }
            
            if (response as! HTTPURLResponse).statusCode == 200 {
                
                do {
                    let options = try JSONDecoder().decode(PriestChurches.self.self, from: data!)
                    self.presenter?.getResponse(errores: ServerErrors.OK, data: options)
                } catch {
                    self.presenter?.getResponse(errores: ServerErrors.ErrorInterno, data: nil)
                }
            } else {
                APIType.shared.refreshToken()
                self.presenter?.getResponse(errores: ServerErrors.ErrorServidor, data: nil)
            }
        }
        tarea.resume()
        
    }
    
    func requestSearchBar(name: String) {
            let encodingName = name.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            guard let endpoint: URL = URL(string: "\(APIType.shared.User())/locations?name=\(encodingName)" ) else {
                print("Error formando url")
                self.presenter?.responseSearchBar(errores: ServerErrors.ErrorServidor, result: [])
                return
            }
            
            var request = URLRequest(url: endpoint)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let tksession = UserDefaults.standard.string(forKey: "idToken")
        request.setValue("Bearer \( tksession ?? "")", forHTTPHeaderField: "Authorization")
            request.httpMethod = "GET"
            
            let tarea = URLSession.shared.dataTask(with: request) { data, response, error in
                
                //print("->  respuesta Status Code: ", response as Any)
                //print("->  error: ", error as Any)
               
                if error != nil {
                    print("Hubo un error")
                    return
                }
                
                if (response as! HTTPURLResponse).statusCode == 200 {
                    
                    do {
                        let options = try JSONDecoder().decode([Assigned].self, from: data!)
                        self.presenter?.responseSearchBar(errores: ServerErrors.OK, result: options)
                    } catch {
                        self.presenter?.responseSearchBar(errores: ServerErrors.ErrorInterno, result: [])
                    }
                } else {
                    APIType.shared.refreshToken()
                    self.presenter?.responseSearchBar(errores: ServerErrors.ErrorServidor, result: [])
                }
            }
            tarea.resume()
            
        }
}


