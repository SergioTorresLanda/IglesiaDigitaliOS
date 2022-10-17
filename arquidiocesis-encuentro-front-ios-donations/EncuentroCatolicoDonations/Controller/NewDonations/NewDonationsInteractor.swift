//
//  NewDonationsInteractor.swift
//  EncuentroCatolicoDonations
//
//  Created by Pablo Luis Velazquez Zamudio on 21/02/22.
//

import Foundation

class NewDontaionsInteractor: NewDontaionsInteractorProtocol {
    
   weak var presenter: NewDontaionsPresneterProtocol?
    let  tksession = UserDefaults.standard.string(forKey: "idToken")
    let api = APIType.shared.User()
    
    func getChurchList(category: String) {
        let defaults = UserDefaults.standard
        let idUser = defaults.integer(forKey: "id")
        guard let apiURL = URL(string: "\(api)/users/\(idUser)/locations?category=\(category)") else { return }
        var request = URLRequest(url: apiURL)
        
        request.setValue("Bearer \( tksession ?? "")", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        
        let work = URLSession.shared.dataTask(with: request) { data, response, error in

            print("-->  respuesta Status Code: ", response as Any)
            print("-->  error: ", error as Any)
            
            do {
                guard let allData = data else { return }
                let contentResponse = try JSONDecoder().decode(ChurchesDontaions.self, from: allData)
                self.presenter?.onSuccessChurchList(data: contentResponse, responseCode: (response as! HTTPURLResponse))
                
            }catch{
                print("Get list church error", error.localizedDescription, error)
                self.presenter?.onFailChurchList(error: error)
            }
        }
            work.resume()
    }
    
    func getSuggestedChurchList() {
        guard let apiURL = URL(string: "\(api)/suggestions") else { return }
        var request = URLRequest(url: apiURL)
        
        request.setValue("Bearer \( tksession ?? "")", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        
        let work = URLSession.shared.dataTask(with: request) { data, response, error in
            print("-->>  data: ", data)
            print("-->>  response: ", response)
            print("-->>  error: ", error)
            do {
                guard let allData = data else { return }
                let contentResponse = try JSONDecoder().decode([ChurchesSuggested].self, from: allData)
                self.presenter?.onSuccessSuggestedList(data: contentResponse, responseCode: (response as! HTTPURLResponse))
            }catch{
                print("Get list suggested church error", error.localizedDescription, error)
                self.presenter?.onFailSuggestedList(error: error)
            }
        }
            work.resume()
    }
}

// MARK: BILLING SERVICES -
extension NewDontaionsInteractor {
    func saveBillingData(method: String, taxId: Int, businessName: String, rfc: String, address: String, neighborhood: String, zipCode: String, municipality: String, email: String, automaticBilling: Bool) {
        
        var urlStr = ""
        switch method {
        case "POST":
            urlStr = "\(api)/me/tax-data"
            
        case "PUT":
            urlStr = "\(api)/me/tax-data/\(taxId)"
            
        default:
            break
        }
        
        guard let apiURL = URL(string: urlStr) else { return }
        var request = URLRequest(url: apiURL)
        
        let params : [String:Any] = [
            
            "business_name" : businessName,
            "rfc": rfc,
            "address": address,
            "neighborhood": neighborhood,
            "zipcode": zipCode,
            "municipality": municipality,
            "email": email,
            "automatic_invoicing": automaticBilling
            
        ]
        
        let body = try! JSONSerialization.data(withJSONObject: params)
        request.setValue("Bearer \( tksession ?? "")", forHTTPHeaderField: "Authorization")
        request.httpBody = body
        request.httpMethod = method
        
        let work = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if error != nil {
                print("Hubo un error")
                return
            }
            
            self.presenter?.onSuccessSaveData(responseCode: (response as! HTTPURLResponse), method: method)
        }
        work.resume()
        
    }
    
    func getBillingData() {
        
        guard let apiURL = URL(string: "\(api)/me/tax-data") else { return }
        var request = URLRequest(url: apiURL)
        
        request.setValue("Bearer \( tksession ?? "")", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        
        let work = URLSession.shared.dataTask(with: request) { data, response, error in
            do {
                guard let allData = data else { return }
                let contentResponse = try JSONDecoder().decode([BillingData].self, from: allData)
                self.presenter?.onSuccessGetBillingData(data: contentResponse, reponseCode: (response as! HTTPURLResponse))
            }catch{
                print("Download billing data error", error.localizedDescription, error)
                self.presenter?.onFailGetBillingData(error: error)
            }
        }
        work.resume()
        
    }
}
