//
//  DetailIntentionInteractor.swift
//  EncuentroCatolicoServices
//
//  Created by Pablo Luis Velazquez Zamudio on 27/07/21.
//

import Foundation
import UIKit

class DetailIntentionInteractor: DetailIntentionInteractorProtocol {
   weak var presenter: DetailIntentionPresenterProtocol?
    
    func getDetailIntetion(dateStr: String, hour: String) {
        guard let apiURl = URL(string: "\(APIType.shared.User())/services?type=INTENTION&date=\(dateStr)&time=\(hour)") else { return }
        
        var request = URLRequest(url: apiURl)
        
        let defaults = UserDefaults.standard
        let idUser = defaults.integer(forKey: "id")
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let tksession = UserDefaults.standard.string(forKey: "idToken")
        request.setValue("Bearer \( tksession ?? "")", forHTTPHeaderField: "Authorization")
        request.setValue("\(idUser)", forHTTPHeaderField: "X-User-Id")
        request.setValue("PRIEST", forHTTPHeaderField: "X-Role")
        
        let work = URLSession.shared.dataTask(with: request) { data, response, error in
            print("->  respuesta Status Code: ", response as Any)
            print("->  error: ", error as Any)
            do {
                
                if data != nil {
                    let contentResponse: IntentionDetails = try JSONDecoder().decode(IntentionDetails.self, from: data!)
                    self.presenter?.passRequestResponseDetail(contentResponse: contentResponse, responseCode: response as! HTTPURLResponse)
                    print(contentResponse)
                }
                
            }catch{
                APIType.shared.refreshToken()
                print("Error to download list opf intentions", error.localizedDescription, error)
                self.presenter?.fatalErrorResponse()
            }
            
        }
        
        work.resume()
        
    }
    
    func getDetailIntetionPDF(dateStr: String, hour: String) {
        guard let apiURl = URL(string: "\(APIType.shared.User())/services?type=INTENTION&date=\(dateStr)&time=\(hour)&pdf=true") else { return }
        
        var request = URLRequest(url: apiURl)
        
        let defaults = UserDefaults.standard
        let idUser = defaults.integer(forKey: "id")
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("\(idUser)", forHTTPHeaderField: "X-User-Id")
        request.setValue("PRIEST", forHTTPHeaderField: "X-Role")
        let tksession = UserDefaults.standard.string(forKey: "idToken")
        request.setValue("Bearer \( tksession ?? "")", forHTTPHeaderField: "Authorization")
        
        let work = URLSession.shared.dataTask(with: request) { data, response, error in
            print("->  respuesta Status Code: ", response as Any)
            print("->  error: ", error as Any)
            do {
                
                if data != nil {
                    
                    if (response as! HTTPURLResponse).statusCode == 200 {
                        let contentResponse: PDFObject = try JSONDecoder().decode(PDFObject.self, from: data!)
                        self.presenter?.succesGetPDFRequest(data: contentResponse)
                    }else{
                        
                    }
                   
                }
                
            }catch{
                APIType.shared.refreshToken()
                print("Error to download list opf intentions", error.localizedDescription, error)
                self.presenter?.fatalErrorResponse()
            }
            
        }
        
        work.resume()
        
    }

}
