//
//  FeedTVCInteractor.swift
//  zeus-ios-sdk-new-social-network
//
//  Created by Miguel Angel Vicario Flores on 28/09/20.
//  Copyright © 2020 Gabriel Briseño. All rights reserved.
//

import UIKit
import Alamofire
import RealmSwift

public struct ReactPublication: Codable {
    let post_id: Int
    let reaction_id: Int
    let FIIDEMPLEADO: Int
    let asParam: String
    
    enum CodingKeys: String, CodingKey {
        case post_id, reaction_id, FIIDEMPLEADO
        case asParam = "as"
    }
}

extension FeedTVC {
    
    public func makeReaction(postId: Int, reactionId: Int) {
        let snService = SocialNetworkService()
        let params = ReactPublication(post_id: postId,
                                      reaction_id: 23,
                                      FIIDEMPLEADO: SocialNetworkConstant.shared.userId,
                                      asParam: "Person")
        
        let request = snService.getRequestWP(method: .reactPublication, params: params)
        snService.makeRequest(request: request) { (data, error) in
            if error == nil {
                do {
                     let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any]
                     if let message = json?["message"] as? String,
                        let data = json?["data"] as? [String: Any],
                        let reactionsCount = data["countReact"] as? Int {
                         
                         let realm = try Realm()
                         let post = self.post
                         
                         self.reactionsCountLabel.text = String(reactionsCount)
                         
                         if message == "Created Reaction" || message == "Reaction changed" {
                             if let reaction = data["reaction"] as? [String: Any],
                                let id = reaction["id"] as? Int, let img = reaction["img"] as? String,
                                let color = reaction["color"] as? String, let type = reaction["type"] as? String,
                                let active = reaction["active"] as? Bool {
                                 
                                 let myReaction = MyReactionRealm()
                                 myReaction.id = id
                                 myReaction.img = img
                                 myReaction.color = color
                                 myReaction.type = type
                                 myReaction.active = active

                                 try realm.write {
                                     post?.countReact = reactionsCount
                                     post?.myReaction = myReaction
                                     realm.add(post!, update: .modified)
                                 }
                                 
//                                 self.reactionLabel.textColor = UIColor(hex: color)
//                                 self.reactionLabel.text = type
                                 
                                 self.reactionImageContainerView.isHidden = false
                                 if let url = URL(string: img) {
                                    self.reactionImage.sd_setImage(with: url, placeholderImage: nil, options: .refreshCached, context: nil)
                                 }
                             }
                             
                         } else {
                             
                             try realm.write {
                                 post?.countReact = reactionsCount
                                 post?.myReaction = nil
                                 realm.add(post!, update: .modified)
                             }
                             
//                             self.reactionImageContainerView.isHidden = true
//                             self.reactionImage.image = nil
                             
//                             self.reactionLabel.textColor = UIColor(red: 0.48, green: 0.56, blue: 0.65, alpha: 1.00)
//                             self.reactionLabel.text = "Me enorgullece"
                         }
                     }
                } catch (let error) {
                     print(error)
                }
            }
        }
    }
    
}
