//
//  RSCommentsProtocols.swift
//  EncuentroCatolicoNews
//
//  Created by Billy on 25/11/21.
//

import Foundation

//MARK: Wireframe -

protocol RSCommentsWireframeProtocol{
//    func showEditComment(comments: CmComments, editComment: Bool)
}

/*
 protocol FeedWireframeProtocol: class {
     
     //MARK: - ShowPostDetail
     func showPostDetail(navController: UINavigationController?, post: PublicationRealm)
     
     //MARK: - ShowComments
 //    func showComments(postId: Int)
     
     //MARK: - ShowNewPost
       func showNewPost()
     
     //MARK: - ShowEditPost
 //    func showEditPost(postId: Int, content: String, nombreGrupo: String, imagenGrupo: String)
     func showEditPost(post: PublicationRealm, editPost: Bool)
     func showNewEditPost(post: Posts, editPost: Bool)
     
     //MARK: - ShowComments
     func showActionsSelected(post: PublicationRealm, strSelected: String)
 }
 */

// MARK: View -

protocol RSCommentsViewProtocols {
    var presenter: RSCommentsPresenterProtocol? { get set }
    
    func didFinishGettingComments(isFromPage: Bool, comments: [CmComments])
    func didFinishGettingCommentsWithErrors(error: SocialNetworkErrors)
    func didFinishAddPostCommnet(isReload: Bool)
    func successGetRelations(data: RelationsData)
    func failGetRelations(mesage: String)
    func successDeleteComment(type: String)
    func failDeleteComment(message: String)

}


// MARK: - Presenter

protocol RSCommentsPresenterProtocol{
    func getComments(isFromPage: Bool, isRefresh: Bool, post: Posts?)
    func makeCommentToComment(postId: Int, commentId: Int?, userId: Int, content: String, asParam: Int, groupId: Int, scope: Int)
    func didFinishGettingComments(isFromPage: Bool, comments: [CmComments])
    func didFinishGettingCommentsWithErrors(error: SocialNetworkErrors)
    func didFinishAddPostCommnet(isReload: Bool)
    
    func requestRelations(SNId: Int)
    func onSuccessGetRelations(data: RelationsData, response: HTTPURLResponse)
    func onFailGetRelation(error: Error)
    
    func makeDelteComment(commentId: Int, type: String)
    func onSuccessDeleteComment(response: HTTPURLResponse, type: String)
    func onFailDelteComment(error: Error) 
}

//MARK: Interactor -

protocol RSCommentInteractorProtocol{
    var presenter: RSCommentsPresenterProtocol? {get set}
    
    func getComments(isFromPage: Bool, isRefresh: Bool, post: Posts?)
    func makeCommentToComment(postId: Int, commentId: Int?, userId: Int, content: String, asParam: Int, groupId: Int, scope: Int)
    func didFinishGettingComments(isFromPage: Bool, comments: [CmComments])
    func didFinishGettingCommentsWithErrors(error: SocialNetworkErrors)
    func didFinishAddPostCommnet(isReload: Bool)
    
    func getRelations(SNId: Int)
    
    func deleteComment(idComment: Int, type: String)
}
