//
//  YoungView_Interactor.swift
//  EncuentroCatolicoNewFormation
//
//  Created by Daniel Isaac Mora Osorio on 08/05/21.
//

import UIKit
import EncuentroCatolicoUtils

protocol FYV_VIPER_PresenterToInteractorProtocol: AnyObject {
    var _presenter: FYV_VIPER_InteractorToPresenterProtocol? {set get}
    func getData(strTypeCatalog: String)
    func getFormationCatalog()
}

class FYV_ProfileInteractor: FYV_VIPER_PresenterToInteractorProtocol {
    var _presenter: FYV_VIPER_InteractorToPresenterProtocol?
    
    public func getFormationsComponets(strTypeCatalog: String) -> Void {
        guard var component = URLComponents(string: "\(APIType.shared.User())/formations") else {
            self._presenter?.onError(msg: "Ocurrió un error inesperado")
            return
        }

        component.queryItems = [
            URLQueryItem(name: "type", value: strTypeCatalog)
        ]
        
        var request = URLRequest(url: component.url!,timeoutInterval: Double.timeout)
        request.httpMethod = "GET"
        let tksession = UserDefaults.standard.string(forKey: "idToken")
        request.setValue("Bearer \( tksession ?? "")", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                self._presenter?.onError(msg: "Ocurrió un error inesperado")
              return
            }
            do{
                print("IG: data \(data)")
                let userResponse = try JSONDecoder().decode([FF_Formation_Entity].self, from: data)
                userResponse.forEach({ print("-|\($0.title)|-") })
                
                print("IG: userResponse \(userResponse)")
                
                self._presenter?.setDataSingle(data: userResponse)
            } catch {
                self._presenter?.onError(msg: "Ocurrió un error inesperado")
            }
        }.resume()
    }
    
    public func getFormationCatalog() -> Void {
        var request = URLRequest(url: URL(string: "\(APITypeUtils.shared.getBasePath())/arquidiocesis/encuentro/v1/catalog/library-themes")!,timeoutInterval: .timeout)
        
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            guard let self = self else {
                return
            }
            
            guard let data = data,
                  let userResponse = try? JSONDecoder().decode(FF_CatalogObj_Entity.self, from: data) else {
                self._presenter?.onError(msg: "Ocurrió un error inesperado")
                return
            }
            
            print("IG: catalog \(userResponse.data)")
            self._presenter?.setDataCatalog(data: userResponse)
        }.resume()
    }
    
    func getData(strTypeCatalog: String){
        getFormationsComponets(strTypeCatalog: strTypeCatalog)
    }
}
