//
//  DetailTVCInteractor.swift
//  zeus-ios-sdk-new-social-network
//
//  Created by Miguel Angel Vicario Flores on 30/09/20.
//  Copyright © 2020 Gabriel Briseño. All rights reserved.
//

import UIKit
import Alamofire
import RealmSwift
import SDWebImage

extension DetailPostTVC {
    
    public func makeComment(postId: Int, reactionId: Int) {
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
                         
                         
                         if message == "Created Reaction" || message == "Reaction changed" {
                             if let reaction = data["reaction"] as? [String: Any],
                                let id = reaction["id"] as? Int, let img = reaction["img"] as? String,
                                let color = reaction["color"] as? String, let type = reaction["type"] as? String {
                                 
                                 let myReaction = MyReactionRealm()
                                 myReaction.id = id
                                 myReaction.img = img
                                 myReaction.color = color
                                 myReaction.type = type

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
                                self.reactionLabel.textColor = UIColor(red: 0.10, green: 0.16, blue: 0.45, alpha: 1.00)
                                self.reactionImage.image = UIImage(named: "orar", in: Bundle.local, compatibleWith: nil)
                                self.reactionImage2.image = UIImage(named: "orar", in: Bundle.local, compatibleWith: nil)
                                self.loading.stopAnimating()
                                self.loading.isHidden = true
                                self.reactionButton.isUserInteractionEnabled = true
                             }
                             
                         } else {
                             
                             try realm.write {
                                 post?.countReact = reactionsCount
                                 post?.myReaction = nil
                                 realm.add(post!, update: .modified)
                             }
                             
//                             self.reactionLabel.textColor = UIColor(red: 0.60, green: 0.60, blue: 0.60, alpha: 1.00)
//                             self.reactionLabel.text = "Me enorgullece"
                             
//                             self.reactionImage.image = nil
                            self.reactionsCountLabel.text = String(reactionsCount)
                            self.reactionsCountLabel.textColor = UIColor.lightGray
                            self.reactionLabel.textColor = UIColor.lightGray
                            self.reactionImage.image = UIImage(named: "reactionG", in: Bundle.local, compatibleWith: nil)
                            self.reactionImage2.image = UIImage(named: "reactionG", in: Bundle.local, compatibleWith: nil)
                            self.loading.stopAnimating()
                            self.loading.isHidden = true
                            self.reactionButton.isUserInteractionEnabled = true
                         }
                     }
                } catch (let error) {
                     print(error)
                    self.loading.stopAnimating()
                    self.loading.isHidden = true
                    self.reactionButton.isUserInteractionEnabled = true
                }
            }
        }
    }
    
}
