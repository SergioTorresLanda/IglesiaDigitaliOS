//
//  CongregationsInteractor.swift
//  EncuentroCatolicoProfile
//
//  Created by Pablo Luis Velazquez Zamudio on 11/09/21.
//

import Foundation
import UIKit

class CongregationsInteractor: CongregationsInteractorProtocol {
    var presenter: CongregationsPresenterProtocol?
    
    func getCongregations() {
        guard let apiURL = URL(string: "\(APIType.shared.User())/catalog/congregations") else { return }
        var request = URLRequest(url: apiURL)
        
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let tksession = UserDefaults.standard.string(forKey: "idToken")
        request.setValue("Bearer \( tksession ?? "")", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            print("-->>  Services class: ", String(describing: type(of: self)))
            print("->  respuesta Status Code: ", response as Any)
            print("->  error: ", error as Any)
            let responseServer = try! JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary
            print("->✅  responseServer: ", responseServer as Any)

            do {
                if (response as! HTTPURLResponse).statusCode == 200 {
                    let contentResponse = try JSONDecoder().decode(CongregationsList.self, from: data!)
                    self.presenter?.transportSuccesDataResponse(data: contentResponse)
                }else{
                    self.presenter?.transportFailDataResponse()
                    APIType.shared.refreshToken()
                }
                
            }catch{
                print("Download congregations error", error, error.localizedDescription)
            }
        }.resume()
        
    }
    
}
