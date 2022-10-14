//
//  SocialSearchProtocols.swift
//  EncuentroCatolicoPrayers
//
//  Created by Pablo Luis Velazquez Zamudio on 25/01/22.
//

import Foundation
import UIKit

// MARK: ROUTER -
protocol SocialSearchRouterProtocol: AnyObject {
    
}

// MARK: PRESENTER -
protocol SocialSearchPresenterProtocol: AnyObject {
    func requestSearch(searchText: String)
    func onSuccessRequestSearch(data: SerachResponse, reponse: HTTPURLResponse)
    func onFailRequestSearch(error: Error)
    
    func requestFollowUF(method: String, entityId: Int, entityType: Int) 
    func onSuccessRequestFollowUF(data: FollowResponse, response: HTTPURLResponse)
    func onFailRequestFollowUF(error: Error)
    
}

// MARK: INTERACTOR -
protocol SocialSearchInteractorProtocol: AnyObject {
    var presenter: SocialSearchPresenterProtocol? { get set }
    func getSearch(searchText: String)
    func followAndFollowUF(method: String, entityId: Int, entityType: Int)
    
}

// MARK: VIEW -
protocol SocialSearchViewProtocol: AnyObject {
    var presenter: SocialSearchPresenterProtocol? { get set }
    func successSearch(data: SerachResponse)
    func failSearch(message: String)
    
    func successFollowUF(data: FollowResponse)     
    func failFollowUF(message: String)
    
}
