//
//  ChurchDetailInteractor.swift
//  Encuentro
//
//  Created by Edgar Hernandez Solis on 02/12/2021.
//  Copyright © 2021 Linko. All rights reserved.
//

import Foundation
//import EncuentroCatolico

class ChurchDetailInteractor: ChurchDetailInteractorInputProtocol {
    
    weak var presenter: ChurchDetailInteractorOutputProtocol?
    
    init() {}
    
    func saveChurchEdition(locationId: Int, description: String, email: String, phone: String, website: String, instagram: String, twitter: String, facebook: String, streaming: String, bankAcount: String, principal: Int, schedules: [AttentionEditChurch], attention: [AttentionEditChurch], masses: [MassEditChurch], services: [ServiceEditChurch]) {
        var principailIdFinal: Int? {
            if principal == 0 {
                return nil
            }
            return principal
        }
        let dictionary = ChurchEditModel(churchEditModelDescription: description, email: email, phone: phone, stream: streaming, website: website, facebook: facebook, twitter: twitter, intagram: instagram, bankAccount: bankAcount, principal: PrincipalEditChurch.init(id: principailIdFinal), schedules: schedules, attention: attention, masses: masses, services: services)
        
        guard let endpoint: URL = URL(string: "\(APIType.shared.User())/" + "locations/" + String(locationId) ) else {
            print("Error formando url")
            self.presenter?.responsePutEditChurch(errores: ServerErrors.ErrorServidor, data: nil)
            return
        }
        var request = URLRequest(url: endpoint)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let tksession = UserDefaults.standard.string(forKey: "idToken")
        request.setValue("Bearer \( tksession ?? "")", forHTTPHeaderField: "Authorization")
        request.httpMethod = "PUT"
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        guard let body = try? encoder.encode(dictionary) else { return  }
        request.httpBody = body
        let tarea = URLSession.shared.dataTask(with: request) { data, response, error in
            print("->  respuesta Status Code: ", response as Any)
            print("->  error: ", error as Any)

            if error != nil {
                print("Hubo un error")
                return
            }
            
            if (response as! HTTPURLResponse).statusCode == 200 {
                self.presenter?.responsePutEditChurch(errores: ServerErrors.OK, data: nil)
            }else{
                APIType.shared.refreshToken()
                self.presenter?.responsePutEditChurch(errores: ServerErrors.ErrorInterno, data: nil)
            }
        }
        tarea.resume()
        
    }
    
    
    //MARK: Networking
    func requestDetail(id: Int) {
        doGetChourchMain.init(id: String(id)).execute { (result) in
            self.presenter?.responseDetail(result: result)
        } onError: { (error, msg) in
            self.presenter?.errorDetail(msg: msg)
        }
    }
    
    func requestServiceCatalog() {
        doGetServiceCatalog.init().execute { (result) in
            self.presenter?.responseGetServiceCatalog(data: result)
        } onError: { error, msg in
            self.presenter?.errorGetServiceCatalog(msg: msg)
        }

    }
    
    //Fiel
    func requestAddFavorite(id: Int, idPriest: Int, isPrincipal: Int) {
        var isPrincipalBool: Bool {
            if isPrincipal == 0 {
                return true
            } else {
                return false
            }
        }
        let data = ModelAddFavorite(location_id: id, is_principal: isPrincipalBool)
        let dataDiccionary: [String: Any] =  data.todiccionary ?? [:]
        let idInt = UserDefaults.standard.integer(forKey: "id")
        let userId = "\(idInt)"
        guard let endpoint: URL = URL(string: "\(APIType.shared.User())/users/" + userId + "/locations") else {
            print("Error formando url")
            self.presenter?.responseFavorite(errores: ServerErrors.ErrorServidor, data: [])
            return
        }
        var request = URLRequest(url: endpoint)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let tksession = UserDefaults.standard.string(forKey: "idToken")
        request.setValue("Bearer \( tksession ?? "")", forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        guard let body = try? JSONSerialization.data(withJSONObject: dataDiccionary, options: []) else { return  }
        request.httpBody = body
        let tarea = URLSession.shared.dataTask(with: request) { data, response, error in
            print("->  respuesta Status Code: ", response as Any)
            print("->  error: ", error as Any)

            if error != nil {
                print("Hubo un error")
                return
            }
            if (response as! HTTPURLResponse).statusCode == 200 {
                self.presenter?.responseFavorite(errores: ServerErrors.OK, data: [])
            }else{
                APIType.shared.refreshToken()
                self.presenter?.responseFavorite(errores: ServerErrors.ErrorInterno, data: [])
            }
    }
        tarea.resume()
}
    
    func requestRemoveFavorite(id: Int, idPriest: Int, isPrincipal: Int) {
        var isPrincipalBool: Bool {
            if isPrincipal == 0 {
                return true
            } else {
                return false
            }
        }
        let data = ModelRemoveFavorite(location_id: id, is_principal: isPrincipalBool)
        let dataDiccionary: [String: Any] =  data.todiccionary ?? [:]
        let locationId: String = "\(id)"
        let idInt = UserDefaults.standard.integer(forKey: "id")
        let userId = "\(idInt)"
        guard let endpoint: URL = URL(string: "\(APIType.shared.User())/users/" + userId + "/locations/" + locationId ) else {
            print("Error formando url")
            self.presenter?.responseRemoveFavorite(errores: ServerErrors.ErrorServidor, data: [])
            return
        }
        var request = URLRequest(url: endpoint)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let tksession = UserDefaults.standard.string(forKey: "idToken")
        request.setValue("Bearer \( tksession ?? "")", forHTTPHeaderField: "Authorization")
        request.httpMethod = "DELETE"
        guard let body = try? JSONSerialization.data(withJSONObject: dataDiccionary, options: []) else { return  }
        request.httpBody = body
        let tarea = URLSession.shared.dataTask(with: request) { data, response, error in
            print("->  respuesta Status Code: ", response as Any)
            print("->  error: ", error as Any)

            if error != nil {
                print("Hubo un error")
                return
            }
            
            if (response as! HTTPURLResponse).statusCode == 200 {
                self.presenter?.responseRemoveFavorite(errores: ServerErrors.OK, data: [])
            }else{
                APIType.shared.refreshToken()
                self.presenter?.responseRemoveFavorite(errores: ServerErrors.ErrorInterno, data: [])
            }
        }
        tarea.resume()
    }
    
    //Sacerdote
    func requestAddFavoriteSacerdote(idLocation: Int, idPriest: Int) {
        let data = ModelAddFavoriteSacerdote(locationId: idLocation)
        let dataDiccionary: [String: Any] =  data.todiccionary ?? [:]
        
        DoAddFavoriteSacerdote.init(id: String(idPriest), params: dataDiccionary).execute { [weak self](result) in
            self?.presenter?.responseAddChurchSacerdote(msg: "Error")
            print(result)
        } onError: { [weak self](error, msg) in
            if msg == nil || msg == "" {
                self?.presenter?.responseAddChurchSacerdote(msg: nil)
            }else {
                self?.presenter?.responseAddChurchSacerdote(msg: msg)
            }
        }
    }
    
    func requestRemoveChurchSacerdote(idLocation: Int, idPriest: Int) {
        DoRemoveChurchSacerdote.init(idPriest: String(idPriest), locationId: String(idLocation)).execute { [weak self](result) in
            self?.presenter?.responseRemoveChurchSacerdote(msg: "error")
        } onError: { [weak self](error, msg) in
            if msg == nil || msg == "" {
                self?.presenter?.responseRemoveChurchSacerdote(msg: nil)
            }else {
                self?.presenter?.responseRemoveChurchSacerdote(msg: msg)
            }
        }
        
    }
    
    func getCommentsList(queryParam: String) { // 650
        guard let apiURL = URL(string: "\(APIType.shared.User())/locations/\(queryParam)") else { return }
        var request = URLRequest(url: apiURL)
        
        let defaults = UserDefaults.standard
        let idUser = defaults.integer(forKey: "id")
        print("%%%", idUser)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let tksession = UserDefaults.standard.string(forKey: "idToken")
        request.setValue("Bearer \( tksession ?? "")", forHTTPHeaderField: "Authorization")
        request.setValue("\(idUser)", forHTTPHeaderField: "X-User-Id")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            print("->  respuesta Status Code: ", response as Any)
            print("->  error: ", error as Any)

            do {
                
                if (response as! HTTPURLResponse).statusCode == 200 {
                    let contentResponse = try JSONDecoder().decode(Comments.self, from: data!)
                    self.presenter?.transportResponseCommentsList(contentData: contentResponse)
                }else{
                    APIType.shared.refreshToken()
                    self.presenter?.errorTransportCommentList(responseCode: response as! HTTPURLResponse)
                }
                
            }catch{
                print("Download comments list error", error, error.localizedDescription)
            }
        }.resume()
        
    }
    
}


