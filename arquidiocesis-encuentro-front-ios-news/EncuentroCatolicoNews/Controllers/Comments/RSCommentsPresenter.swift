//
//  RSCommentsPresenter.swift
//  EncuentroCatolicoNews
//
//  Created by Gibran Galicia on 25/11/21.
//

import Foundation

public class RSCommentsPresenter: RSCommentsPresenterProtocol{
    
    private var view: RSCommentsViewProtocols?
    var interactor: RSCommentInteractorProtocol?
    private let router: RSCommentsWireframeProtocol?
        
    init(interface: RSCommentsViewProtocols, interactor: RSCommentInteractorProtocol?, router: RSCommentsWireframeProtocol){
        self.view = interface
        self.interactor = interactor
        self.router = router
    }
    
    func getComments(isFromPage: Bool, isRefresh: Bool, post: Posts?) {
        interactor?.getComments(isFromPage: isFromPage, isRefresh: isRefresh, post: post)
    }
    
    func makeCommentToComment(postId: Int, commentId: Int?, userId: Int, content: String, asParam: Int, groupId: Int, scope: Int) {
        interactor?.makeCommentToComment(postId: postId, commentId: commentId, userId: userId, content: content, asParam: asParam, groupId: groupId, scope: scope)
    }
    
    func didFinishGettingComments(isFromPage: Bool, comments: [CmComments]) {
        view?.didFinishGettingComments(isFromPage: isFromPage, comments: comments)
    }
    
    func didFinishGettingCommentsWithErrors(error: SocialNetworkErrors) {
        view?.didFinishGettingCommentsWithErrors(error: error)
    }
    
    func didFinishAddPostCommnet(isReload: Bool) {
        view?.didFinishAddPostCommnet(isReload: isReload)
    }
    
    func requestRelations(SNId: Int) {
        interactor?.getRelations(SNId: SNId)
    }
    
    func onSuccessGetRelations(data: RelationsData, response: HTTPURLResponse) {
        DispatchQueue.main.async {
            if response.statusCode == 200{
                self.view?.successGetRelations(data: data)
            }else{
                self.view?.failGetRelations(mesage: "Error code")
            }
        }
    }
    
    func onFailGetRelation(error: Error) {
        DispatchQueue.main.async {
            self.view?.failGetRelations(mesage: error.localizedDescription)
        }
    }
    
    func makeDelteComment(commentId: Int, type: String) {
        interactor?.deleteComment(idComment: commentId, type: type)
    }
    
    func onSuccessDeleteComment(response: HTTPURLResponse, type: String) {
        DispatchQueue.main.async {
            if response.statusCode == 200 {
                self.view?.successDeleteComment(type: type)
            }else{
                self.view?.failDeleteComment(message: "Code error \(response.statusCode)")
            }
        }
    }
    
    func onFailDelteComment(error: Error) {
        DispatchQueue.main.async {
            self.view?.failDeleteComment(message: error.localizedDescription)
        }
    }
}
