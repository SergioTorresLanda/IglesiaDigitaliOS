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

public struct NewReactPublication: Codable{
//    let post_id: Int
    let reaction_id: Int
    let user_id: Int
    
    enum CodingKeys: String, CodingKey{
//        case post_id = ""
        case reaction_id = "reactionId"
        case user_id =  "userId"
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
                         
//
//                        self.reactionsCountLabel.text = String(reactionsCount)
                         
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
                                
                                
                                if reactionsCount - 1 == 0 {
                                    self.reactionsCountLabel.text = "Tu oración"
                                } else {
                                    self.reactionsCountLabel.text = "Tu oración y " + String(reactionsCount - 1) + " más"
                                }
                                
                                self.reactionsCountLabel.textColor = UIColor(red: 0.10, green: 0.16, blue: 0.45, alpha: 1.00)
                                 
//                                 self.reactionImageContainerView.isHidden = false
                                self.newreactionImage.image = UIImage(named: "orar", in: Bundle.local, compatibleWith: nil)
                                self.loading.stopAnimating()
                                self.loading.isHidden = true
                                self.newreactionButton.isUserInteractionEnabled = true
//                                sender.isUserInteractionEnabled = false
//                                 if let url = URL(string: img) {
//                                    self.reactionImage.sd_setImage(with: url, placeholderImage: nil, options: .refreshCached, context: nil)
//                                 }
                             }
                             
                         } else {
                             
                            self.reactionsCountLabel.text = String(reactionsCount)
                            
                             try realm.write {
                                 post?.countReact = reactionsCount
                                 post?.myReaction = nil
                                 realm.add(post!, update: .modified)
                             }
                             
//                             self.reactionImageContainerView.isHidden = true
//                             self.reactionImage.image = nil
                             
//                             self.reactionLabel.textColor = UIColor(red: 0.48, green: 0.56, blue: 0.65, alpha: 1.00)
//                             self.reactionLabel.text = "Me enorgullece"
                            self.reactionsCountLabel.textColor = UIColor.lightGray
                            self.newreactionImage.image = UIImage(named: "reactionG", in: Bundle.local, compatibleWith: nil)
                            self.loading.stopAnimating()
                            self.loading.isHidden = true
                            self.newreactionButton.isUserInteractionEnabled = true
                         }
                     }
                } catch (let error) {
                     print(error)
                    self.loading.stopAnimating()
                    self.loading.isHidden = true
                    self.newreactionButton.isUserInteractionEnabled = true
                }
            }
        }
    }
    
    public func newMakeReaction(reactionId: Int, userID: Int, strUrl: String){
        let snService = SocialNetworkService()
        
        let params = NewReactPublication(reaction_id: reactionId, user_id: userID)
        let request = snService.postRequestRS(strUrl: strUrl, method: .commentsAll, param: params)
        snService.newmakeRequest(request: request, completion: {(data, error) in
            if error == nil{
                do{
                    let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any]
                    self.newreactionImage.image = UIImage(named: "iconOracion2", in: Bundle.local, compatibleWith: nil)
                    //"\(newPosts[indexPath.row].totalReactions ?? 0)"
                    self.reactionsCountLabel.text = "\((self.newPost?.totalReactions ?? 0) + 1)"
                    self.loading.stopAnimating()
                    self.loading.isHidden = true
                }catch (let error) {
                    self.loading.stopAnimating()
                    self.loading.isHidden = true
                    
                }
            }
        })
    }
    
    public func newMakeDeleteResaction(reactionId: Int, userID: Int, strUrl: String){
        self.newreactionImage.image = UIImage(named: "iconOracion", in: Bundle.local, compatibleWith: nil)
        self.reactionsCountLabel.text = "\((self.newPost?.totalReactions ?? 0) - 1)"
        self.loading.stopAnimating()
        self.loading.isHidden = true
    }
    
}
