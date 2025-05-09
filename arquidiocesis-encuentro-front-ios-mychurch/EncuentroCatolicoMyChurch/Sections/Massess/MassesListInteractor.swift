//
//  MassesListInteractor.swift
//  EncuentroCatolicoMyChurch
//
//  Created Desarrollo on 07/05/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class MassesListInteractor: MassesListInteractorProtocol {

    weak var presenter: MassesListPresenterProtocol?
    
    func requestChurches(name: String){
    
        guard let endpoint: URL = URL(string: "https://xmbcqr3wvd.execute-api.us-east-1.amazonaws.com/develop/locations?name=\(name)") else {
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
            //print("->  respuesta Status Code: ", response as Any)
            //print("->  error: ", error as Any)

            if error != nil {
                print("Hubo un error 041")
                return
            }
            
            if (response as! HTTPURLResponse).statusCode == 200 {
                do {
                    guard let allData = data else { return }
                    let options = try JSONDecoder().decode(ChurchesMasses.self, from: allData)
                    
                    self.presenter?.getResponse(errores: ServerErrors.OK, data: options)
                } catch {
                    self.presenter?.getResponse(errores: ServerErrors.ErrorInterno, data: [])
                }
            } else {
                self.presenter?.getResponse(errores: ServerErrors.ErrorServidor, data: [])
            }
        }
        tarea.resume()
        
    }
}
