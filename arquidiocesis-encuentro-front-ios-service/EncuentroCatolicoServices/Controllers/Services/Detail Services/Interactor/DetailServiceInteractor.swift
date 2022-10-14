//
//  DetailServiceInteractor.swift
//  Encuentro 
//
//  Created by Miguel Eduardo Valdez Tellez on 04/21/2021.
//  Copyright © 2021 Linko. All rights reserved.
//

import Foundation

class DetailServiceInteractor: DetailServiceInteractorInputProtocol {
    
    weak var presenter: DetailServiceInteractorOutputProtocol?
    
    init() {}
    
    func saveBlessService(familyName: String, email: String, phone: String, description: String, zipcode: String, neighborhood: String, longitude: Double, latitude: Double, location_id: Int, service_id: Int) {
        let dictionary = CreateServicesBlessModel.init(familyName: familyName, email: email, phone: phone, address: AddressBless.init(addressDescription: description, zipcode: zipcode, neighborhood: neighborhood, longitude: longitude, latitude: latitude), locationID: location_id, serviceID: service_id)
        let userId = UserDefaults.standard.integer(forKey: "id")
        guard let endpoint: URL = URL(string: "\(APIType.shared.User())/" + "services" ) else {
            print("Error formando url")
            self.presenter?.responsePostServiceBless(errores: ServerErrors.ErrorServidor, data: nil)
            return
        }
        var request = URLRequest(url: endpoint)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(String(userId), forHTTPHeaderField: "X-User-Id")
        let tksession = UserDefaults.standard.string(forKey: "idToken")
        request.setValue("Bearer \( tksession ?? "")", forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        guard let body = try? encoder.encode(dictionary) else { return  }
        request.httpBody = body
        let tarea = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if error != nil {
                print("Hubo un error")
                return
            }
            
            if (response as! HTTPURLResponse).statusCode == 201 {
                self.presenter?.responsePostServiceBless(errores: ServerErrors.OK, data: nil)
            }else{
                APIType.shared.refreshToken()
                self.presenter?.responsePostServiceBless(errores: ServerErrors.ErrorInterno, data: nil)
            }
        }
        tarea.resume()
    }
    
    func saveComuService(personName: String, email: String, phone: String, expanation: String, zipcode: String, neighborhood: String, longitude: Double, latitude: Double, location_id: Int, service_id: Int) {
        let dictionary = CreateServicesComuModel.init(personName: personName, email: email, phone: phone, explanation: expanation, serviceID: service_id, locationID: location_id, address: AddressComu.init(addressDescription: expanation, zipcode: String(zipcode), neighborhood: neighborhood, longitude: longitude, latitude: latitude))
        let userId = UserDefaults.standard.integer(forKey: "id")
        guard let endpoint: URL = URL(string: "\(APIType.shared.User())/" + "services" ) else {
            print("Error formando url")
            self.presenter?.responsePostServiceComu(errores: ServerErrors.ErrorServidor, data: nil)
            return
        }
        var request = URLRequest(url: endpoint)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(String(userId), forHTTPHeaderField: "X-User-Id")
        let tksession = UserDefaults.standard.string(forKey: "idToken")
        request.setValue("Bearer \( tksession ?? "")", forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        guard let body = try? encoder.encode(dictionary) else { return  }
        request.httpBody = body
        let tarea = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if error != nil {
                print("Hubo un error")
                return
            }
            
            if (response as! HTTPURLResponse).statusCode == 201 {
                self.presenter?.responsePostServiceComu(errores: ServerErrors.OK, data: nil)
            }else{
                APIType.shared.refreshToken()
                self.presenter?.responsePostServiceComu(errores: ServerErrors.ErrorInterno, data: nil)
            }
        }
        tarea.resume()
        
    }
    
    func getSuburb(zipCode: String) {
        guard let apiURL: URL = URL(string: "\(APIType.shared.User())/catalog/neighborhoods?zip_code=\(zipCode)") else { return }
        
        var request = URLRequest(url: apiURL)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let tksession = UserDefaults.standard.string(forKey: "idToken")
        request.setValue("Bearer \( tksession ?? "")", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        
        let tarea = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if error != nil {
                print("Hubo un error")
                return
            }
            
            do {
                
                if data != nil {
                    let contentResponse : DetailServiceEntity = try JSONDecoder().decode(DetailServiceEntity.self, from: data!)
                    print(contentResponse)
                    self.presenter?.getResponse(responseCode: response as! HTTPURLResponse, responseData: contentResponse)
                }
                
            }catch{
                APIType.shared.refreshToken()
                print("Error to download suburbs", error.localizedDescription)
            }
            
        }
        
        tarea.resume()
        
    }
    
}
