//
//  DetailPostMethods.swift
//  RedSocialFramework
//
//  Created by Miguel Angel Vicario Flores on 22/10/20.
//  Copyright © 2020 Gabriel Briseño. All rights reserved.
//

import UIKit

//MARK: - DetailPostMethods
extension DetailPostViewController {
//    @objc public func showMoreComments(_ sender: UIButton) {
//        presenter?.showComments(postId: post.id, isKBFocused: false)
//    }
    
    @objc public func showAllReactions(_ sender: UIButton) {
        presenter?.showReactions(postId: post.id)
    }
}
