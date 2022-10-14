//
//  PriestDetailInteractor.swift
//  EncuentroCatolicoVirtualLibrary
//
//  Created by Pablo Luis Velazquez Zamudio on 29/06/21.
//

import UIKit

class PriestDetailInteractor: PriestDetailInteractorProtocol {
    
    var presenter: PriestDetailPresenterPRotocol?
    
    func getServiceDetail(idService: Int) {
        
        guard let apiURL = URL(string: "\(APIType.shared.User())/sos-services/\(idService)") else { return }
        var request = URLRequest(url: apiURL)
        let defaults = UserDefaults.standard
        let idUser = defaults.integer(forKey: "id")
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("\(idUser)", forHTTPHeaderField: "X-User-Id")
        let tksession = UserDefaults.standard.string(forKey: "idToken")
        request.setValue("Bearer \( tksession ?? "")", forHTTPHeaderField: "Authorization")
        
        let tarea = URLSession.shared.dataTask(with: request) { (data, response, error) in
            print(response)
            if error != nil {
                print("Hubo un error")
                return
            }
            
            do {
                
                if data != nil {
                    let contResponse : PriestDetail = try JSONDecoder().decode(PriestDetail.self, from: data!)
                    self.presenter?.TransportaData(responseCode: response as! HTTPURLResponse, data: contResponse)
                   // print("Essta es la respuesta", contResponse)
                }
                
            }catch{
                APIType.shared.refreshToken()
                print("Error al descargar services", error.localizedDescription, error)
            }
            
        }
        tarea.resume()

    }
   
    
}
