//
//  CommmentsProtocols.swift
//  EncuentroCatolicoChurch
//
//  Created by Pablo Luis Velazquez Zamudio on 31/08/21.
//

import UIKit

// MARK: ROUTER -
protocol CommentsRouterProtocol: AnyObject {
    
}

// MARK: PRESENTER -
protocol CommentsPresneterProtocol: AnyObject {
    func requestListComments(queryParams: String)
    func transportResponseCommentsList(contentData: Comments)
    func errorTransportCommentList(responseCode: HTTPURLResponse)
    func makePostComment(locationID: Int, rating: Int, comment: String)
    func transportSuccesPostComment()
    func transportErrorPostCommnet(response: HTTPURLResponse)
    func makePutComment(locationID: Int, rating: Int, comment: String, reviewID: Int, type: String)
    func succesUpdateComment()
    func failUpdateComment()
    
}

// MARK: INTERACTOR -
protocol CommentsInteractorProtocol: AnyObject {
    var presenter: CommentsPresneterProtocol? { get set }
    func getCommentsList(queryParam: String)
    func postCommentRating(locationID: Int, rating: Int, comment: String)
    func putCommentRating(locationID: Int, rating: Int, comment: String, reviewID: Int, type: String)
}

// MARK: VIEW -
protocol CommentsViewProtocol: AnyObject {
    var presenter: CommentsPresneterProtocol? { get set }
    func successRequestComments(data: Comments)
    func failRequestComments()
    func successPostComment()
    func failPostComment()
    func successPutComment()
    func failPutCmment()
    
}


