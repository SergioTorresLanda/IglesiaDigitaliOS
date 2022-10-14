//
//  SacramentsInteractor.swift
//  EncuentroCatolicoServices
//
//  Created Desarrollo on 30/04/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class SacramentsInteractor: SacramentsInteractorProtocol {

    weak var presenter: SacramentsPresenterProtocol?
    
    func requestSacraments(){
        guard let endpoint: URL = URL(string: "https://xmbcqr3wvd.execute-api.us-east-1.amazonaws.com/develop/catalog/services?type=SACRAMENT") else {
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
            print("  -->>  data: ", data)
            print("  -->>  response: ", response)
            print("  -->>  error: ", error)

            if error != nil {
                print("Hubo un error")
                return
            }
            
            if (response as! HTTPURLResponse).statusCode == 200 {
                
                do {
                    let options = try JSONDecoder().decode(Sacraments.self, from: data!)
                    self.presenter?.getResponse(errores: ServerErrors.OK, data: options)
                } catch {
                    self.presenter?.getResponse(errores: ServerErrors.ErrorInterno, data: [])
                }
            } else {
                self.presenter?.getResponse(errores: ServerErrors.ErrorServidor, data: [])
                APIType.shared.refreshToken()
            }
        }
        tarea.resume()
        
    }
}
