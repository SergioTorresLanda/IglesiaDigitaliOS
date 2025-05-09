//
//  LibraryAndResourcesInteractor.swift
//  EncuentroCatolicoVirtualLibrary
//
//  Created Desarrollo on 15/04/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class LibraryAndResourcesInteractor: LibraryAndResourcesInteractorProtocol {

    weak var presenter: LibraryAndResourcesPresenterProtocol?
    
    func requestContentDetail(contentID: Int) {
        guard let endpoint: URL = URL(string: "https://xmbcqr3wvd.execute-api.us-east-1.amazonaws.com/develop/library/\(contentID)") else {
            print("Error formando url")
            self.presenter?.getResponse(errores: ServerErrors.ErrorServidor, data: nil)
            return
        }
        
        var request = URLRequest(url: endpoint)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let tksession = UserDefaults.standard.string(forKey: "idToken")
        request.setValue("Bearer \( tksession ?? "")", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        
        let tarea = URLSession.shared.dataTask(with: request) { data, response, error in
            //print("->>  data: ", data)
            //print("->>  response: ", response)
            //print("->>  error: ", error)
            guard let allData = data else { return }
            if error != nil {
                print("Hubo un error 001")
                return
            }
            
            if (response as! HTTPURLResponse).statusCode == 200 {
                let contentResponse: ContentDetail? = try? JSONDecoder().decode(ContentDetail.self, from: allData)
                self.presenter?.getResponse(errores: ServerErrors.OK, data: contentResponse)
            } else {
                APIType.shared.refreshToken()
                self.presenter?.getResponse(errores: ServerErrors.ErrorServidor, data: nil)
            }
        }
        tarea.resume()
        
    }
}
