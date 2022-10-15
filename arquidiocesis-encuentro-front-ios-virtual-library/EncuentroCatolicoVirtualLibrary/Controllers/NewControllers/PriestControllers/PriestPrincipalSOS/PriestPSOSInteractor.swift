//
//  PriestPSOSInteractor.swift
//  EncuentroCatolicoVirtualLibrary
//
//  Created by Pablo Luis Velazquez Zamudio on 28/06/21.
//

import UIKit

class PriestPSOSInteractor: PriestPSOSInteractorProtocol {
    weak var presenter: PriestPSOSPresenterProtocol?
    var allData = [ListSrevices]()
    
    func getServicesList(paramStatus: String) {
        guard let apiURL = URL(string: "\(APIType.shared.User())/sos-services?status=\(paramStatus)&type=SOS") else { return }
        var request = URLRequest(url: apiURL)
        let defaults = UserDefaults.standard
        let idUser = defaults.integer(forKey: "id")
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("\(idUser)", forHTTPHeaderField: "X-User-Id")
        request.setValue("PRIEST", forHTTPHeaderField: "X-Role")
        let tksession = UserDefaults.standard.string(forKey: "idToken")
        request.setValue("Bearer \( tksession ?? "")", forHTTPHeaderField: "Authorization")
        print("Este es el id del user:", idUser)
        
        let tarea = URLSession.shared.dataTask(with: request) { (data, response, error) in
            //print("-->>  data: ", data)
            //print("-->>  response: ", response)
            //print("-->>  error: ", error)
            if error != nil {
                print("Hubo un error")
                APIType.shared.refreshToken()
                return
            }
            
            print(response)
            
            do {
                
                if data != nil {
                    
                    let contResponse = try JSONDecoder().decode([ListSrevices].self, from: data!)
                    print("Essta es la respuesta", contResponse)
                    self.presenter?.transportResponseData(statusResponse: response as! HTTPURLResponse, data: contResponse)
                }
                
            }catch{
                print("Error al descargar services", error.localizedDescription, error)
            }
            
            
        }
        tarea.resume()
    }
    
}

