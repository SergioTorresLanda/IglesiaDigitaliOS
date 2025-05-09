//
//  LiveInteractor.swift
//  EncuentroCatolicoLive
//
//  Created Diego Martinez on 25/02/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class LiveInteractor: LiveInteractorProtocol {

    weak var presenter: LivePresenterProtocol?
    
    func requestData() {
//        guard let apiURL: URL = URL(string: "\(APIType.shared.User())/streaming") else { return }
        guard let apiURL: URL = URL(string: "\(APIType.shared.User())/streaming") else { return }
        var request = URLRequest(url: apiURL)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let tksession = UserDefaults.standard.string(forKey: "idToken")
        request.setValue("Bearer \( tksession ?? "")", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        
        let tarea = URLSession.shared.dataTask(with: request) { data, response, error in
            
            //print("->  respuesta Status Code: ", response as Any)
            //print("->  error: ", error as Any)

            if error != nil {
                print("Hubo un error 057")
                return
            }
            
            if (response as! HTTPURLResponse).statusCode == 200 {
                guard let allData = data else { return }
                do {
                    let resp = try JSONSerialization.jsonObject(with: allData, options: .allowFragments)
                    let contentResponse : [LiveModel] = try JSONDecoder().decode([LiveModel].self, from: allData)
                    print(resp)
                    self.presenter?.getResponse(data: contentResponse, response: (response as! HTTPURLResponse))
                   
                }catch{
                    print("error", error.localizedDescription)
                }
               
            } else if (response as! HTTPURLResponse).statusCode == 401 {
                APIType.shared.refreshToken()
                print("Error al llamar ep", (response as! HTTPURLResponse).statusCode)
            }
            
            else {
                print("Error al llamar ep", (response as! HTTPURLResponse).statusCode)
            }
        }
        tarea.resume()
    }
    
}
