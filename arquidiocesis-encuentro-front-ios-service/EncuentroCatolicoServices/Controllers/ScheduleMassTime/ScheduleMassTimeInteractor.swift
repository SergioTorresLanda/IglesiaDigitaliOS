//
//  ScheduleMassTimeInteractor.swift
//  EncuentroCatolicoServices
//
//  Created Desarrollo on 28/04/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class ScheduleMassTimeInteractor: ScheduleMassTimeInteractorProtocol {

    weak var presenter: ScheduleMassTimePresenterProtocol?
    let userID = UserDefaults.standard.integer(forKey: "id")
    func sendService(date: String, hour: String, description: String, location: Int, service_id: Int) {
        let model = ServicesRequest(dedicated_to: description,
                                    mass_date: date,
                                    mass_schedule: hour,
                                    location_id: location,
                                    service_id: service_id)
        guard let endpoint = URL(string: "\(APIType.shared.User())/services"),
            let data = try? JSONEncoder().encode(model)
            else {
            print("Error formando url")
            self.presenter?.getResponse(errores: ServerErrors.ErrorServidor, data: nil)
            return
        }
        var request = URLRequest(url: endpoint)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let tksession = UserDefaults.standard.string(forKey: "idToken")
        request.setValue("Bearer \( tksession ?? "")", forHTTPHeaderField: "Authorization")
        request.setValue(String(userID), forHTTPHeaderField: "X-User-Id")
        request.httpMethod = "POST"
        request.httpBody = data
        let tarea = URLSession.shared.dataTask(with: request) { data, response, error in
            print("-->>  Services class: ", String(describing: type(of: self)))
            print("->  respuesta Status Code: ", response as Any)
            print("->  error: ", error as Any)
            let responseServer = try! JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary
            print("->✅  responseServer: ", responseServer as Any)

            if error != nil {
                print("Hubo un error")
                return
            }
            if (response as! HTTPURLResponse).statusCode == 201 {
                do {
                    let options = try JSONDecoder().decode(ServicesResponse.self, from: data!)
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
    
    func getCatalog() {
        
        guard let apiURL = URL(string: "\(APIType.shared.User())/catalog/services?type=INTENTION") else { return }
        var request = URLRequest(url: apiURL)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let tksession = UserDefaults.standard.string(forKey: "idToken")
        request.setValue("Bearer \( tksession ?? "")", forHTTPHeaderField: "Authorization")
        request.setValue(String(userID), forHTTPHeaderField: "X-User-Id")
        
        let work = URLSession.shared.dataTask(with: request) { data, response, error in
            
            print("-->>  Services class: ", String(describing: type(of: self)))
            print("->  respuesta Status Code: ", response as Any)
            print("->  error: ", error as Any)
            let responseServer = try! JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary
            print("->✅  responseServer: ", responseServer as Any)

            if error != nil {
                print("Hubo un error")
                return
            }
            
            print(response)
            
            if (response as! HTTPURLResponse).statusCode == 201 || (response as! HTTPURLResponse).statusCode == 200 {
               
                do {
                    let options = try JSONDecoder().decode([CatalogIntentions].self, from: data!)
                    self.presenter?.succesGetCatalog(data: options)
                } catch {
                    self.presenter?.failGetCatalgo()
                }
            } else {
                APIType.shared.refreshToken()
                self.presenter?.failGetCatalgo()
            }
        }
        
        work.resume()
        
    }
    
    func getListIntetions(locationID: String, dateStr: String) {
        guard let apiURl = URL(string: "\(APIType.shared.User())/locations/\(locationID)?type=MASSES&date=\(dateStr)") else { return }
        var request = URLRequest(url: apiURl)
        
        let defaults = UserDefaults.standard
        let idUser = defaults.integer(forKey: "id")
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let tksession = UserDefaults.standard.string(forKey: "idToken")
        request.setValue("Bearer \( tksession ?? "")", forHTTPHeaderField: "Authorization")
        request.setValue("\(idUser)", forHTTPHeaderField: "X-User-Id")
        //request.setValue("Priest", forHTTPHeaderField: "X-Role")
        
        let work = URLSession.shared.dataTask(with: request) { data, response, error in
            print("-->>  Services class: ", String(describing: type(of: self)))
            print("->  respuesta Status Code: ", response as Any)
            print("->  error: ", error as Any)
            let responseServer = try! JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary
            print("->✅  responseServer: ", responseServer as Any)
            do {
                
                if (response as! HTTPURLResponse).statusCode == 200 || (response as! HTTPURLResponse).statusCode == 201 {
                    if data != nil {
                        let contentResponse: [ListIntentions2] = try JSONDecoder().decode([ListIntentions2].self, from: data!)
                        print(contentResponse, "/////")
                        self.presenter?.successGetHours(data: contentResponse)
                    }
                    
                }else{
                    APIType.shared.refreshToken()
                    self.presenter?.failGetHours()
                }
                
            }catch{
                print("Error to download list opf intentions", error.localizedDescription, error)
                self.presenter?.failGetHours()
                
            }
            
        }
        
        work.resume()
        
    }
    
}
