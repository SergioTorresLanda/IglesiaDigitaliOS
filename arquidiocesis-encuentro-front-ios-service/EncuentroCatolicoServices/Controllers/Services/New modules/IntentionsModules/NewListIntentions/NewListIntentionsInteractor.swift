//
//  NewListIntentionsInteractor.swift
//  EncuentroCatolicoServices
//
//  Created by Pablo Luis Velazquez Zamudio on 27/07/21.
//

import Foundation
import UIKit

class NewListIntentionsInteractor: NewListIntentionsInteractorProtocol {
    weak var presenter: NewListIntentionsPresenterProtocol?
    
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
            print("-->  respuesta Status Code: ", response as Any)
            print("-->  error: ", error as Any)
            do {
                
                if data != nil {
                    let contentResponse: [ListIntentions] = try JSONDecoder().decode([ListIntentions].self, from: data!)
                    self.presenter?.handleResponseRequest(contentResponse: contentResponse, responseCode: response as! HTTPURLResponse)
                }
                
            }catch{
                APIType.shared.refreshToken()
                print("Error to download list opf intentions", error.localizedDescription, error)
            }
            
        }
        
        work.resume()
        
    }
    
}
