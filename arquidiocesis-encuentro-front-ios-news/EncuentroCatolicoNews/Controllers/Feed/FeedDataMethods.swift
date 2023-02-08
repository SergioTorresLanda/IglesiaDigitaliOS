//
//  FeedDataMethods.swift
//  zeus-ios-sdk-new-social-network
//
//  Created by Miguel Angel Vicario Flores on 07/09/20.
//  Copyright © 2020 Gabriel Briseño. All rights reserved.
//

import UIKit

//MARK: - FeedDataMethods
extension Home_RedSocial {
    
   @objc public func showNewPost(_ sender: UIButton) {
//       presenter?.showNewPost()
    }
    
    @objc public func showEditPost(_ sender: UIButton, editPost: Bool, post: PublicationRealm){
        // GGG2
        presenter?.showEditPost(post: post, editPost: editPost)
    }
    
    @objc public func actionSelectedOption(_ sender: UIButton, strSelected: String, post: PublicationRealm){
        presenter?.showActionsSelected(post: post, strSelected: strSelected)
    }
}
