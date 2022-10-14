//
//  CommentsPresenter.swift
//  EncuentroCatolicoChurch
//
//  Created by Pablo Luis Velazquez Zamudio on 31/08/21.
//

import Foundation
import UIKit

class CommentsPresenter: CommentsPresneterProtocol {
    weak private var view: CommentsViewProtocol?
    var interactor : CommentsInteractorProtocol?
    private let router : CommentsRouterProtocol?
    
    init(interface: CommentsViewProtocol, interactor: CommentsInteractorProtocol, router: CommentsRouterProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }
    
    func requestListComments(queryParams: String) {
        interactor?.getCommentsList(queryParam: queryParams)
    }
    
    func transportResponseCommentsList(contentData: Comments) {
        DispatchQueue.main.async {
            self.view?.successRequestComments(data: contentData)
        }
       
    }
    
    func errorTransportCommentList(responseCode: HTTPURLResponse) {
        DispatchQueue.main.async {
            self.view?.failRequestComments()
        }
       
    }
    
    func makePostComment(locationID: Int, rating: Int, comment: String) {
        interactor?.postCommentRating(locationID: locationID, rating: rating, comment: comment)
    }
    
    func transportSuccesPostComment() {
        DispatchQueue.main.async {
            self.view?.successPostComment()
        }
    }
    
    func transportErrorPostCommnet(response: HTTPURLResponse) {
        DispatchQueue.main.async {
            self.view?.failPostComment()
        }
    }
    
    func makePutComment(locationID: Int, rating: Int, comment: String, reviewID: Int, type: String) {
        self.interactor?.putCommentRating(locationID: locationID, rating: rating, comment: comment, reviewID: reviewID, type: type)
    }
    
    func succesUpdateComment() {
        self.view?.successPutComment()
    }
    
    func failUpdateComment() {
        self.view?.failPutCmment()
    }
    
}
