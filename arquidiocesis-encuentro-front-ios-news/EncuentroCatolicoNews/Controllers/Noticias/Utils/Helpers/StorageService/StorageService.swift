//
//  StorageService.swift
//  zeus-ios-sdk-new-social-network
//
//  Created by Diego Martinez on 13/10/20.
//  Copyright © 2020 Gabriel Briseño. All rights reserved.
//

import UIKit

public struct StorageService {
    
    public static func uploadImage(_ image: UIImage, completion: @escaping (String?) -> Void) {
        /*guard let firebase_instance = SocialNetworkConstant.shared.instance else { return completion(nil) }
        
        let storage = Storage.storage(app: firebase_instance)
        let storageRef = storage.reference()
        let multimediaRef = storageRef.child("iOS/\(SocialNetworkConstant.shared.userId)/\(NSUUID().uuidString).\("jpeg")")
        
        guard let imageData = image.jpegData(compressionQuality: 0.1) else { return completion(nil) }
        
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
        })*/
    }
    
    public static func uploadVideo(_ video: URL, completion: @escaping (String?) -> Void) {
        /*guard let firebase_instance = SocialNetworkConstant.shared.instance else { return completion(nil) }
        
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
        }*/
    }
    
}
