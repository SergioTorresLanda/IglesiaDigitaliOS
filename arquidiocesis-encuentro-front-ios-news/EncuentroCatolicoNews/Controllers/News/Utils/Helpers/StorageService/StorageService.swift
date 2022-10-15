//
//  StorageService.swift
//  EncuentroCatolicoNews
//
//  Created by Branchbit on 18/03/21.
//

import UIKit
import Firebase
import FirebaseStorage

public struct Prefirmada: Codable {
    let upload_type: String
    let resource_id: Int
    let content: [String]
}

public struct PrefirmadaResponse: Codable{
    let filename: String
    let pre_signed: String
    let filekey: String
    
    enum CodingKeys: String, CodingKey{
        case filename
        case pre_signed
        case filekey
    }
}

public struct UploadImagePrefirmada: Codable{
    let filename: Data
}


public struct StorageService {
    
    public static func generateUrlPrefirmada(accessId: String, media: [MediaData], completation: @escaping ([PrefirmadaResponse]?, [NewMediaResult]?) -> Void) {
        let SNId = UserDefaults.standard.integer(forKey: "SNId")
        var arrMultimedia: [NewMediaResult] = [NewMediaResult]()
        if accessId == "Image"{
            var idx = 0
            var contennt: [String] = []
            var arImgData: [Data?] = []
            for _ in media{
                let multReference = ("iOS/\(SocialNetworkConstant.shared.userId)/\(NSUUID().uuidString)\(idx).\("jpeg")")
                contennt.append(multReference)
                arImgData.append(media[idx].image.jpegData(compressionQuality: 0.75))
                idx += 1
            }
            let params = Prefirmada(upload_type: "PERSONAL", resource_id: SNId, content: contennt)
            
            let strUrl = "\(APIType.shared.User())/s3-credentials"
            let endPoint: URL = URL(string: strUrl)!
            var request = URLRequest(url: endPoint)
            request.timeoutInterval = 3
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            let tksession = UserDefaults.standard.string(forKey: "idToken")
            request.setValue("Bearer \( tksession ?? "")", forHTTPHeaderField: "Authorization")
            request.httpMethod = "POST"
            let data = try? JSONEncoder().encode(params)
            request.httpBody = data
             let response = URLSession.shared.dataTask(with: request) { data, response, error in
                
                 print("->  respuesta Status Code: ", response as Any)
                 print("->  error: ", error as Any)
                 guard let allData = data else { return }
               
                 if error != nil {
                     completation(nil, nil)
                     return
                 }
                 var iTotalImage = 0
                 if (response as! HTTPURLResponse).statusCode == 200 {
                     do {
                         let resp = try JSONSerialization.jsonObject(with: allData, options: .allowFragments)
                         print(resp)
                         let jsonDecoder = JSONDecoder()
                         let responseModel = try jsonDecoder.decode([PrefirmadaResponse].self, from: data ?? Data())
    //                     print(responseModel)
                         
                         for (idxs, url) in responseModel.enumerated(){
                             iTotalImage += 1
                             let requestURL = url.pre_signed
                             let endPointURL: URL = URL(string: requestURL)!
                             var request: URLRequest = URLRequest(url: endPointURL)
                             request.httpMethod = "PUT"
//                             let tksession = UserDefaults.standard.string(forKey: "idToken")
//                             request.setValue("Bearer \( tksession ?? "")", forHTTPHeaderField: "Authorization")
                             request.setValue("image/jpeg", forHTTPHeaderField: "Content-Type")
                             let dtaImage = arImgData[idxs]
                             
                             URLSession.shared.uploadTask(with: request, from: dtaImage, completionHandler: { responseData, response, error in
                                    DispatchQueue.main.async {

                                             guard let responseCode = (response as? HTTPURLResponse)?.statusCode, responseCode == 200  else {
                                                  if let error = error {
                                                         print(error)
                                                      completation(nil, nil)
                                                   }
                                                   return
                                               }
                                        print("Ya mando la imagen!!!!")
                                        if iTotalImage == responseModel.count{
                                            for dtaMultimedia in responseModel{
                                                let file = dtaMultimedia.filename.components(separatedBy: ".")
                                                if file.count > 0{
                                                    let media = NewMediaResult(fileKey: dtaMultimedia.filekey, format: file[1])
                                                    arrMultimedia.append(media)
                                                }
                                                iTotalImage = 0
                                            }
                                        completation(responseModel, arrMultimedia)
                                        }
                                    }
                                 
                             }).resume()
                         }
                         
                     }catch{
                         print("error!!!!", error.localizedDescription)
                         APIType.shared.refreshToken()
                     }
                 } else {
                     print("Error al llamar ep", (response as! HTTPURLResponse).statusCode)
                     APIType.shared.refreshToken()
                 }
             }
            response.resume()
        }else if accessId == "Video"{
            var idx = 0
            var contennt: [String] = []
            var arVidData: [Data?] = []
            
            
//            let videoData = try Data(contentsOf: video, options: .mappedIfSafe)
            for _ in media{
                let multReference = ("iOS/\(SocialNetworkConstant.shared.userId)/\(NSUUID().uuidString)\(idx).\("mp4")")
                contennt.append(multReference)
                if let mediaVid = media[0].videoURL{
                    let videoData = try? Data(contentsOf: mediaVid, options: .mappedIfSafe)
                    arVidData.append(videoData)
                    idx += 1
                }
            }
            
            let params = Prefirmada(upload_type: "PERSONAL", resource_id: SNId, content: contennt)
            let strUrl = "\(APIType.shared.User())/s3-credentials"
            let endPoint: URL = URL(string: strUrl)!
            var request = URLRequest(url: endPoint)
            request.timeoutInterval = 3
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            let tksession = UserDefaults.standard.string(forKey: "idToken")
            request.setValue("Bearer \( tksession ?? "")", forHTTPHeaderField: "Authorization")
            request.httpMethod = "POST"
            let data = try? JSONEncoder().encode(params)
            request.httpBody = data
            let response = URLSession.shared.dataTask(with: request) { data, response, error in
                
                print("->  respuesta Status Code: ", response as Any)
                print("->  error: ", error as Any)
                guard let allData = data else { return }
              
                if error != nil {
                    print("Hubo un error")
                    completation(nil, nil)
                    return
                }
                
                if (response as! HTTPURLResponse).statusCode == 200 {
                    do {
                        let resp = try JSONSerialization.jsonObject(with: allData, options: .allowFragments)
                        print(resp)
                        let jsonDecoder = JSONDecoder()
                        let responseModel = try jsonDecoder.decode([PrefirmadaResponse].self, from: data ?? Data())
                        print("Response MOdel::::: \(responseModel)")
                        var iTotalImage = 0
                        for (idxs, url) in responseModel.enumerated(){
                            iTotalImage += 1
                            let requestURL = url.pre_signed
                            let endPointURL: URL = URL(string: requestURL)!
                            var request: URLRequest = URLRequest(url: endPointURL)
                            request.httpMethod = "PUT"
//                            let tksession = UserDefaults.standard.string(forKey: "idToken")
//                            request.setValue("Bearer \( tksession ?? "")", forHTTPHeaderField: "Authorization")
                            request.setValue("image/mp4", forHTTPHeaderField: "Content-Type")
                            let dtaImage = arVidData[idxs]
                            
                            URLSession.shared.uploadTask(with: request, from: dtaImage, completionHandler: { responseData, response, error in
                                   DispatchQueue.main.async {

                                            guard let responseCode = (response as? HTTPURLResponse)?.statusCode, responseCode == 200  else {
                                                 if let error = error {
                                                        print(error)
                                                     completation(nil, nil)
                                                  }
                                                  return
                                              }
                                       print("Ya mando el video!!!!")
                                       if iTotalImage == responseModel.count{
                                           var arrMultimedia: [NewMediaResult] = [NewMediaResult]()
                                           for dtaMultimedia in responseModel{
                                               let file = dtaMultimedia.filename.components(separatedBy: ".")
                                               if file.count > 0{
                                                   let media = NewMediaResult(fileKey: dtaMultimedia.filekey, format: file[1])
                                                   arrMultimedia.append(media)
                                               }
                                               iTotalImage = 0
                                           }
                                           completation(responseModel, arrMultimedia)
                                       }
                                   }

                            }).resume()
                        }
                    }catch{
                        print("error!!!!", error.localizedDescription)
                    }
                } else {
                    print("Error al llamar ep", (response as! HTTPURLResponse).statusCode)
                }
            }
           response.resume()
        }
    }
    
    public static func uploadImage(_ image: UIImage, completion: @escaping (String?) -> Void) {
        guard let firebase_instance = SocialNetworkConstant.shared.instance else { return completion(nil) }
        
        let storage = Storage.storage(app: firebase_instance)
        let storageRef = storage.reference()
        let multimediaRef = storageRef.child("iOS/\(SocialNetworkConstant.shared.userId)/\(NSUUID().uuidString).\("jpeg")")
        
        guard let imageData = image.jpegData(compressionQuality: 1) else { return completion(nil) }
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg";
 
        multimediaRef.putData(imageData, metadata: metadata, completion: { (metadata, error) in
            if error != nil {
                completion(nil)
            } else {
                multimediaRef.downloadURL(completion: { (url, error) in
                    if error != nil  {
                        completion(nil)
                    } else {
                        completion(url?.absoluteString)
                    }
                })
            }
        })
    }
    
    public static func uploadVideo(_ video: URL, completion: @escaping (String?) -> Void) {
        guard let firebase_instance = SocialNetworkConstant.shared.instance else { return completion(nil) }
        
        let storage = Storage.storage(app: firebase_instance)
        let storageRef = storage.reference()
        let multimediaRef = storageRef.child("iOS/\(SocialNetworkConstant.shared.userId)/\(NSUUID().uuidString).\("mp4")")
        
        do {
            let videoData = try Data(contentsOf: video, options: .mappedIfSafe)
            
            let metadata = StorageMetadata()
            metadata.contentType = "video/mp4";
            
            multimediaRef.putData(videoData, metadata: metadata, completion: { (metadata, error) in
                if error != nil {
                    completion(nil)
                } else {
                    multimediaRef.downloadURL(completion: { (url, error) in
                        if error != nil {
                            completion(nil)
                        } else {
                            completion(url?.absoluteString)
                        }
                    })
                }
            })
            
        } catch {
            completion(nil)
        }
    }
    
}

