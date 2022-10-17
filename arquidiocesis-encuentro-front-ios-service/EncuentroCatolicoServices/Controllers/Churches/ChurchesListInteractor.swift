//
//  ChurchesListInteractor.swift
//  EncuentroCatolicoServices
//
//  Created Desarrollo on 23/04/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class ChurchesListInteractor: ChurchesListInteractorProtocol {

    weak var presenter: ChurchesListPresenterProtocol?
    
    func requestChurchLocations(type: String, latitude: Double, longitude: Double){
    
        guard let endpoint: URL = URL(string: "https://xmbcqr3wvd.execute-api.us-east-1.amazonaws.com/develop/locations?type=\(type)&latitude=\(latitude)&longitude=\(longitude)") else {
            print("Error formando url")
            self.presenter?.getResponse(errores: ServerErrors.ErrorServidor, data: [])
            return
        }
        
        var request = URLRequest(url: endpoint)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let tksession = UserDefaults.standard.string(forKey: "idToken")
        request.setValue("Bearer \( tksession ?? "")", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        
        let tarea = URLSession.shared.dataTask(with: request) { data, response, error in
           // print("-->  respuesta Status Code: ", response as Any)
            print("-->  error: ", error as Any)
            if error != nil {
                print("Hubo un error")
                return
            }
            
            if (response as! HTTPURLResponse).statusCode == 200 {
                do {
                    let options = try JSONDecoder().decode(ChurchLocations.self, from: data!)
                    
                    self.presenter?.getResponse(errores: ServerErrors.OK, data: options)
                } catch {
                    self.presenter?.getResponse(errores: ServerErrors.ErrorInterno, data: [])
                }
            } else {
                APIType.shared.refreshToken()
                self.presenter?.getResponse(errores: ServerErrors.ErrorServidor, data: [])
            }
        }
        tarea.resume()
        
    }
    
}
