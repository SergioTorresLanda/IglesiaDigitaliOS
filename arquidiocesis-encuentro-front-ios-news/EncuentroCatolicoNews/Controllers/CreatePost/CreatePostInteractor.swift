//
//  CreatePostInteractor.swift
//  zeus-ios-sdk-new-social-network
//
//  Created Diego Martinez on 01/09/20.
//  Copyright © 2020 Gabriel Briseño. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit
import Alamofire
import RealmSwift

public struct MakePost: Codable {
    let asParam: String
    let organization_id: Int
    let content: String
    let feeling: Int?
    let multimedia: [MediaResult]
    let location: LocationResult?
    let status: String
    let FIIDEMPLEADO: Int
    
    
    enum CodingKeys: String, CodingKey {
        case asParam = "as"
        case organization_id, content, feeling, multimedia, location, status, FIIDEMPLEADO
    }
}

public struct NewMakePost: Codable{
    let asParam: Int
    let groupId: Int
    let multimedia: [NewMediaResult]
    let content: String
    let userId: Int
    let scope: Int
    
    enum CodingKeys: String, CodingKey{
        case asParam = "as"
        case groupId, multimedia, content, userId, scope
    }
}

public struct EditMakePost: Codable{
    let userId: Int
    let statusId: Int
    let content: String
    let multimediaRemoved: [MediaResult]
    let multimedia: [MediaResult]
}

public struct NewMediaResult: Codable{
    let fileKey: String
    let format: String
}

public struct MediaResult: Codable {
    let id: Int
    let mimeType: String
    let url: String
}

public struct LocationResult: Codable {
    let idLocation: String
    let nameLocation: String
    let direction: String
    let lat: Double
    let lng: Double
    let imgLocation: String
}

struct RelationsData: Codable {
    var message: String?
    var requestId: String?
    var result: [ResultsRelations]?
}

struct ResultsRelations: Codable {
    var id: Int?
    var image:String?
    var name: String?
    var type: Int?
}

struct ResultEditComment: Codable {
    var message: String?
    var requestId: String?
}

public class CreatePostInteractor: CreatePostInteractorProtocol {
    func newmakePost(content: String, location: LocationsResult?, feeling: FeelingsResult?, media: [MediaData], organizationId: Int?, asParam: Int, editPost: Bool, scope: Int){
        let SNId = UserDefaults.standard.integer(forKey: "SNId")
        let groupNotifier = DispatchGroup()
        var mediaArray = [MediaResult]()
        var newMediaArray = [NewMediaResult]()
        
        var locationResult: LocationResult?
        var mediaNewResult = [PrefirmadaResponse]()
        
        groupNotifier.enter()
        getMedia(media: media) { (mediaResult) in
            mediaArray = mediaResult
            groupNotifier.leave()
            
        }
        
        if let location = location, let image = location.image {
            groupNotifier.enter()
            self.getLocationImage(image: image) { (locationURL) in
                locationResult = LocationResult(idLocation: location.id,
                                                nameLocation: location.name,
                                                direction: location.direction,
                                                lat: location.coordinates.latitude,
                                                lng: location.coordinates.longitude,
                                                imgLocation: locationURL)
                groupNotifier.leave()
            }
        }
        
        groupNotifier.notify(queue: .main) {
            //POST
            // Aqui debo de agregar el grup id
            // Agregar scoop Cuando es un usuario normal se manda en 1 -->
            // Cuando es comunidad el scoop se manda en 2 -->
            // Cuado es una iglesia se manda en 3
            
            
            let newParams = NewMakePost(asParam: asParam, groupId: organizationId ?? 0, multimedia: self.arrMultimedia, content: content, userId: SNId, scope: scope)
            
            let strUrl = "\(APIType.shared.SN())/posts"
            let request = self.snService.postRequestRS(strUrl: strUrl, method: .commentsAll, param: newParams)
            
            self.snService.newmakeRequest(request: request) { (data, error) in

                if let error = error {
                    self.presenter?.didFinishMakingPostWithErrors(error: error)
                }else{
                    do {
                        let json = try? JSONSerialization.jsonObject(with: data!, options: .fragmentsAllowed) as? [String: Any]
                        guard let message = json?["message"] as? String, message == "Post created Successfully" else { return }
                        self.presenter?.didFinishMakingPost()
                    }catch{
                        self.presenter?.didFinishMakingPostWithErrors(error: SocialNetworkErrors.ResponseError)
                    }
                }

            }
        }
    }
    
    func editMakePost(content: String, media: [MediaData], organizationID: Int, statusId: Int, editPost: Bool, postId: Int) {
        print("manda a llamar servico de editar ")
        let SNId = UserDefaults.standard.integer(forKey: "SNId")
        //\(APIType.shared.SN())/posts
        let params = EditMakePost(userId: SNId, statusId: statusId, content: content, multimediaRemoved: [], multimedia: [])
        
        /*
         let request = self.snService.getRequestWP(method: .publicationsMake, params: params)
         self.snService.makeRequest(request: request) { (data, error) in
         */
        let srtUrl = "\(APIType.shared.SN())/posts/\(postId)"
        let request = self.snService.putRequestRS(strUrl: srtUrl, metod: .profile, param: params)
        self.snService.makeRequest(request: request) { (data, error) in
            if let error = error {
                print(error, error.localizedDescription)
                self.presenter?.didFinishMakingPostWithErrors(error: error)
            }else{
                do{
                    let json = try JSONSerialization.jsonObject(with: data!, options: .fragmentsAllowed) as? [String: Any]
                    self.presenter?.didFinishMakingPost()
                    
                }catch{
                    self.presenter?.didFinishMakingPostWithErrors(error: SocialNetworkErrors.ResponseError)
                }
            }
        }
        
        
        
    }
    

    weak var presenter: CreatePostPresenterProtocol?
    
    //MARK: - Properties
    private var snService = SocialNetworkService()
    
    //MARK: - Post
    func makePost(content: String, location: LocationsResult?, feeling: FeelingsResult?, media: [MediaData], organizationId: Int,
                  asParam: String) {
        let groupNotifier = DispatchGroup()
        var mediaArray = [MediaResult]()
        var locationResult: LocationResult?
        
        groupNotifier.enter()
        getMedia(media: media) { (mediaResult) in
            mediaArray = mediaResult
            groupNotifier.leave()
        }
        
        if let location = location, let image = location.image {
            groupNotifier.enter()
            self.getLocationImage(image: image) { (locationURL) in
                locationResult = LocationResult(idLocation: location.id,
                                                nameLocation: location.name,
                                                direction: location.direction,
                                                lat: location.coordinates.latitude,
                                                lng: location.coordinates.longitude,
                                                imgLocation: locationURL)
                groupNotifier.leave()
            }
        }
        

        groupNotifier.notify(queue: .main) {
            let params = MakePost(asParam: asParam,
                                  organization_id: organizationId,
                                  content: content,
                                  feeling: feeling?.id,
                                  multimedia: mediaArray,
                                  location: locationResult,
                                  status: "Public",
                                  FIIDEMPLEADO: SocialNetworkConstant.shared.userId)
            
            let request = self.snService.getRequestWP(method: .publicationsMake, params: params)
            self.snService.makeRequest(request: request) { (data, error) in
                if let error = error {
                    self.presenter?.didFinishMakingPostWithErrors(error: error)
                } else {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data!, options: .fragmentsAllowed) as? [String: Any]
                        guard let message = json?["message"] as? String, message == "Created Post" else { return }
                        self.presenter?.didFinishMakingPost()
                    } catch {
                        self.presenter?.didFinishMakingPostWithErrors(error: SocialNetworkErrors.ResponseError)
                    }
                }
            }
        }
    }
    var arrMultimedia: [NewMediaResult] = [NewMediaResult]()
    
    private func getMedia(media: [MediaData], completion: @escaping ((_ mediaResult: [MediaResult]) -> Void)) {
        var mediaResult = [MediaResult]()
        let groupNotifier = DispatchGroup()
        if !media.isEmpty{
            if media.first?.image.accessibilityIdentifier == "Image"{
                groupNotifier.enter()
                StorageService.generateUrlPrefirmada(accessId: "Image", media: media) { [weak self] (PrefirmadaResponse, RespArr) in
                    guard let self = self else {return}
                    if let RespArr = RespArr {
                        self.arrMultimedia = RespArr
                        groupNotifier.leave()
                    }
                }
            }else {
                groupNotifier.enter()
                StorageService.generateUrlPrefirmada(accessId: "Video", media: media) { [weak self] (PrefirmadaResponse, RespArr) in
                    guard let self = self else {return}
                    if let RespArr = RespArr {
                        self.arrMultimedia = RespArr
                    }
                    groupNotifier.leave()
                }
            }
        }
        
        groupNotifier.notify(queue: .main) {
            completion(mediaResult)
        }
    }
    
    private func getLocationImage(image: UIImage, completion: @escaping ((_ url: String) -> Void)) {
        var locationImage = String()
        
        let groupNotifier = DispatchGroup()
        groupNotifier.enter()
        StorageService.uploadImage(image) { (url) in
            if let url = url {
                locationImage = url
            }
            
            groupNotifier.leave()
        }
        
        groupNotifier.notify(queue: .main) {
            completion(locationImage)
        }
    }
    
    func getRelations(SNId: Int) {
        guard let apiURL = URL(string: "\(APIType.shared.SN())/user/\(SNId)/relations") else { return }
        var request = URLRequest(url: apiURL)
        
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let tksession = UserDefaults.standard.string(forKey: "idToken")
        request.setValue("Bearer \( tksession ?? "")", forHTTPHeaderField: "Authorization")
        
        let work = URLSession.shared.dataTask(with: request) { data, response, error in
            print("->  respuesta Status Code: ", response as Any)
            print("->  error: ", error as Any)

            do{
                if data != nil {
                    let contentRepsonse: RelationsData = try JSONDecoder().decode(RelationsData.self, from: data!)
                    print(contentRepsonse)
                    self.presenter?.onSuccessGetRelations(data: contentRepsonse, response: (response as! HTTPURLResponse))
                }
                
            }catch{
                print("Error to download data", error, error.localizedDescription)
                self.presenter?.onFailGetRelation(error: error)
            }
        }
        
        work.resume()
        
    }
    
}

extension CreatePostInteractor {
    func editComment(idComment: Int, commentContent: String) {
        guard let apiURL = URL(string: "\(APIType.shared.SN())/comments/\(idComment)") else { return }
        var request = URLRequest(url: apiURL)
        let SNId = UserDefaults.standard.integer(forKey: "SNId")
        
        let params : [String : Any] = [
            "userId" : SNId,
            "content" : commentContent
        ]
        
        let body = try! JSONSerialization.data(withJSONObject: params)
        
        request.httpBody = body
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let tksession = UserDefaults.standard.string(forKey: "idToken")
        request.setValue("Bearer \( tksession ?? "")", forHTTPHeaderField: "Authorization")
        
        let work = URLSession.shared.dataTask(with: request) { data, response, error in
            print("->  respuesta Status Code: ", response as Any)
            print("->  error: ", error as Any)

            do{
                guard let allData = data else { return }
                let contentResponse = try JSONDecoder().decode(ResultEditComment.self, from: allData)
                self.presenter?.onSuccessEditComment(data: contentResponse, response: (response as! HTTPURLResponse))
                
            }catch{
                print("Edit comment error", error, error.localizedDescription)
                self.presenter?.onFailEditComment(error: error)
            }
        }
        work.resume()
    }
    
}
