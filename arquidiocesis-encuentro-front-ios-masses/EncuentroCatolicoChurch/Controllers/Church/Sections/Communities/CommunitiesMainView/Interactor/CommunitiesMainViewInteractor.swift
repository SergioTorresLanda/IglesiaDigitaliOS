//
//  CommunitiesMainViewInteractor.swift
//  EncuentroCatolicoChurch
//
//  Created by Jorge Garcia on 09/08/21.
//

import Foundation
//import EncuentroCatolico

class CommunitiesMainViewInteractor: CommunitiesMainViewInteractorInputProtocol {
    
    var presenter: CommunitiesMainViewInteractorOutputProtocol?
    
    func requestServiceCatalog() {
        doGetServiceCatalog.init().execute { (result) in
            self.presenter?.responseGetServiceCatalog(data: result)
        } onError: { error, msg in
            self.presenter?.errorGetServiceCatalog(msg: msg)
        }
    }
    
    func getComuunityComments(id: Int) {
        doGetComments.init(id: String(id)).execute { (result) in
            self.presenter?.communityCommentsResponse(response: result)
        } onError: { (error, msg) in
            self.presenter?.communityCommentsError(msg: msg)
        }
        
    }
    
    func requestAddFavorite(id: Int, locationId: Int, isPrincipal: Bool) {
        let data = ModelAddFavorite(location_id: locationId, is_principal: isPrincipal)
        let dataDiccionary: [String: Any] =  data.todiccionary ?? [:]
        let userId = String(id)
        guard let endpoint: URL = URL(string: "\(APIType.shared.User())/users/" + userId + "/locations") else {
            print("Error formando url")
            self.presenter?.responseFavorite(errores: ServerErrors.ErrorServidor, data: nil)
            return
        }
        var request = URLRequest(url: endpoint)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let tksession = UserDefaults.standard.string(forKey: "idToken")
        request.setValue("Bearer \( tksession ?? "")", forHTTPHeaderField: "Authorization")
        guard let body = try? JSONSerialization.data(withJSONObject: dataDiccionary, options: []) else { return  }
        request.httpBody = body
        let tarea = URLSession.shared.dataTask(with: request) { data, response, error in
            
            print("-->  respuesta Status Code: ", response as Any)
            print("-->  error: ", error as Any)
            
            if error != nil {
                return
            }
            
            if (response as! HTTPURLResponse).statusCode == 200 {
                self.presenter?.responseFavorite(errores: ServerErrors.OK, data: nil)
            }else{
                APIType.shared.refreshToken()
                self.presenter?.responseFavorite(errores: ServerErrors.ErrorInterno, data: nil)
            }
        }
        tarea.resume()
    }
    
    func requestRemoveFavorite(id: Int, locationId: Int, isPrincipal: Bool) {
        let data = ModelRemoveFavorite(location_id: locationId, is_principal: isPrincipal)
        let dataDiccionary: [String: Any] =  data.todiccionary ?? [:]
        let locationId = String(locationId)
        let userId = String(id)
        guard let endpoint: URL = URL(string: "\(APIType.shared.User())/users/" + userId + "/locations/" + locationId ) else {
            print("Error formando url")
            self.presenter?.responseFavorite(errores: ServerErrors.ErrorServidor, data: nil)
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
            print("-->  respuesta Status Code: ", response as Any)
            print("-->  error: ", error as Any)

            if error != nil {
                print("Hubo un error")
                return
            }
            
            if (response as! HTTPURLResponse).statusCode == 200 {
                self.presenter?.responseFavorite(errores: ServerErrors.OK, data: nil)
            }else{
                APIType.shared.refreshToken()
                self.presenter?.responseFavorite(errores: ServerErrors.ErrorInterno, data: nil)
            }
        }
        tarea.resume()
    }
    
    
    func getChourchDetail(id: Int) {
        doGetDetail.init(id: String(id)).execute { (result) in
            self.presenter?.communityDataResponse(response: result)
        } onError: { (error, msg) in
            self.presenter?.communityDeatlerror(msg: msg)
        }
    }
    
    func getcommunityActivities(id: Int) {
        doGetActivities.init(id: String(id)).execute { (result) in
            print(result)
            self.presenter?.communityActivitiesResponse(response: result)
        } onError: { (error, msg) in
            self.presenter?.communityActivitiesError(msg: msg)
        }
    }
    
    func putFinishRegister(id: Int, description: String, charisma: String, address: String, longitude: Double, latitude: Double, email: String, phone: String, website: String, instagram: String, twitter: String, facebook: String, streaming: String, service: [ServiceHourFinReg], activity: [ActivityFinReg], linkCom: [LinkedCommunity]) {
        
        let id = String(id)
        
        let dictionary = CommunityFinishRegister(charisma: charisma, communityFinishRegisterDescription: description, address: address, longitude: longitude, latitude: latitude, email: email, phone: phone, website: website, instagram: instagram, twitter: twitter, facebook: facebook, streamingChannel: streaming, serviceHours: service, activities: activity, linkedCommunities: linkCom)
        
        guard let endpoint: URL = URL(string: "\(APIType.shared.User())/" + "locations/" + id ) else {
            print("Error formando url")
            self.presenter?.responsePutCommunity(errores: ServerErrors.ErrorServidor, data: nil)
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
            print("-->  respuesta Status Code: ", response as Any)
            print("-->  error: ", error as Any)
            if error != nil {
                print("Hubo un error")
                return
            }
            
            if (response as! HTTPURLResponse).statusCode == 200 {
                self.presenter?.responsePutCommunity(errores: ServerErrors.OK, data: nil)
            }else{
                APIType.shared.refreshToken()
                self.presenter?.responsePutCommunity(errores: ServerErrors.ErrorInterno, data: nil)
            }
        }
        tarea.resume()
    }
    
    func putEditRegister(id: Int, typeId: Int, description: String, charisma: String, address: String, longitude: Double, latitude: Double, email: String, phone: String, website: String, instagram: String, twitter: String, facebook: String, streaming: String, service: [ServiceHourEditProfile], activity: [ActivityEditProfile]) {
        
        let id = String(id)
        
        let dictionary = CommunityEditProfile(typeID: typeId, communityEditProfileDescription: description, charisma: charisma, address: address, longitude: longitude, latitude: latitude, email: email, phone: phone, website: website, instagram: instagram, twitter: twitter, facebook: facebook, streamingChannel: streaming, serviceHours: service, activities: activity)
        
        guard let endpoint: URL = URL(string: "\(APIType.shared.User())/" + "locations/" + id ) else {
            print("Error formando url")
            self.presenter?.responsePutCommunity(errores: ServerErrors.ErrorServidor, data: nil)
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
            print("-->  respuesta Status Code: ", response as Any)
            print("-->  error: ", error as Any)

            if error != nil {
                print("Hubo un error")
                return
            }
            
            if (response as! HTTPURLResponse).statusCode == 200 {
                self.presenter?.responsePutCommunity(errores: ServerErrors.OK, data: nil)
            }else{
                APIType.shared.refreshToken()
                self.presenter?.responsePutCommunity(errores: ServerErrors.ErrorInterno, data: nil)
            }
        }
        tarea.resume()
    }
    
    func postImage(elemntID: Int, type: String, fileName: String, content: String) {
        let dictionary = CommunityPostImage.init(elementID: elemntID, type: type, filename: fileName, content: content)
        guard let endpoint: URL = URL(string: "\(APIType.shared.User())/" + "/s3-upload" ) else {
            print("Error formando url")
            self.presenter?.responsePutCommunity(errores: ServerErrors.ErrorServidor, data: nil)
            return
        }
        var request = URLRequest(url: endpoint)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let tksession = UserDefaults.standard.string(forKey: "idToken")
        request.setValue("Bearer \( tksession ?? "")", forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        guard let body = try? JSONSerialization.data(withJSONObject: dictionary, options: []) else { return  }
        request.httpBody = body
        let tarea = URLSession.shared.dataTask(with: request) { data, response, error in
           // print("-->  respuesta Status Code: ", response as Any)
            print("-->  error: ", error as Any)

            if error != nil {
                print("Hubo un error")
                return
            }
            
            if (response as! HTTPURLResponse).statusCode == 200 {
                self.presenter?.responsePostImageCommunity(errores: ServerErrors.OK, data: nil)
            }else{
                APIType.shared.refreshToken()
                self.presenter?.responsePostImageCommunity(errores: ServerErrors.ErrorInterno, data: nil)
            }
        }
        tarea.resume()
    }
    
    func postImgBase64(elementID: Int, type: String, filename: String, contentBase64: String) {
        guard let apiURL = URL(string: "\(APIType.shared.User())/s3-upload") else { return }
        var request = URLRequest(url: apiURL)
        
        let bodyParams : [String : Any] = [
            "element_id" : elementID,
            "type" : type,
            "filename" : filename,
            "content" : contentBase64
        ]
        
        let body = try! JSONSerialization.data(withJSONObject: bodyParams)
        
        request.httpMethod = "POST"
        request.httpBody = body
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let tksession = UserDefaults.standard.string(forKey: "idToken")
        request.setValue("Bearer \( tksession ?? "")", forHTTPHeaderField: "Authorization")
        
        let work = URLSession.shared.dataTask(with: request) { (data, response, error) in
           // print("-->  respuesta Status Code: ", response as Any)
            print("-->  error: ", error as Any)

            if error != nil {
                print("Hubo un error")
                return
            }
            
            do {
                
                if data != nil {
                    let contentResponse = try JSONDecoder().decode(UploadImageData.self, from: data!)
                    self.presenter?.transportResponseUploadImg(responseCode: (response as! HTTPURLResponse), contentREsponse: contentResponse)
                }
                
            }catch{
                APIType.shared.refreshToken()
                print("error al postear imagen", error.localizedDescription)
            }
            
        }
        
        work.resume()
    }
}

struct doGetDetail: ResponseDispatcher {
    
    typealias ResponseType = CommunityDetailModel
    var urlOptional: String?
    var parameters: [String : Any]?
    var id: String = "1"
    
    var data: RequestType {
        return RequestType(path: "/locations/" + id , method: .get, params: nil, url:Endpoints.urlGlobalApp)
    }
    
    init(id: String) {
        self.id = id
    }
}
struct doGetComments: ResponseDispatcher {
    typealias ResponseType = Comments
    var urlOptional: String?
    var parameters: [String : Any]?
    var id: String = "1"
    
    var data: RequestType {
        return RequestType(path: "/locations/" + id + "/reviews", method: .get, params: nil, url:Endpoints.urlGlobalApp)
    }
    
    init(id: String) {
        self.id = id
    }
}
struct doGetActivities: ResponseDispatcher {
    
    typealias ResponseType = CommunityGetActivities
    var urlOptional: String?
    var parameters: [String : Any]?
    var id: String = "1"
    
    var data: RequestType {
        return RequestType(path: "/locations/" + id + "/activities" , method: .get, params: nil, url:Endpoints.urlGlobalApp)
    }
    
    init(id: String) {
        self.id = id
    }
}

