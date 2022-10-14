//
//  ReactionsModalProtocols.swift
//  zeus-ios-sdk-new-social-network
//
//  Created Miguel Angel Vicario Flores on 17/09/20.
//  Copyright © 2020 Gabriel Briseño. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import Foundation

//MARK: Wireframe -
protocol ReactionsModalWireframeProtocol: class {

}
//MARK: Presenter -
protocol ReactionsModalPresenterProtocol: class {
    
    //MARK: - PostsReactions
    func getPostsReactions(postId: Int)
    func didFinishGettingPostsReactions(reactions: PostReactions)
    func didFinishGettingPostsWithErrors(error: SocialNetworkErrors)
}

//MARK: Interactor -
protocol ReactionsModalInteractorProtocol: class {
    
    var presenter: ReactionsModalPresenterProtocol?  { get set }
    
    //MARK: - PostsReactions
    func getPostsReactions(postId: Int)
}

//MARK: View -
protocol ReactionsModalViewProtocol: class {
    
    var presenter: ReactionsModalPresenterProtocol?  { get set }
    
    //MARK: - PostsReactions
    func didFinishGettingPostsReactions(reactions: PostReactions)
    func didFinishGettingPostsWithErrors(error: SocialNetworkErrors)
}
