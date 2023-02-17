//
//  FollowersPresenter.swift
//  EncuentroCatolicoNews
//
//  Created by Billy on 26/01/22.
//  
//

import Foundation

class FollowersPresenter  {
    
    // MARK: Properties
    weak var view: FollowersViewProtocol?
    var interactor: FollowersInteractorInputProtocol?
    var wireFrame: FollowersWireFrameProtocol?
    
}

extension FollowersPresenter: FollowersPresenterProtocol {
    func getFollowers(snId:Int){
        interactor?.getFollowers(snId:snId)
    }
    func getFollowed(snId:Int){
        interactor?.getFollowed(snId:snId)
    }
    
    func getNewPostsF(isFromPage: Bool, isRefresh: Bool) {
        interactor?.getNewPostsF(isFromPage: isFromPage, isRefresh: isRefresh)
    }
    
    func followAndUnFollowedService(follower: Followers) {
        print("FOLLOW AND UNFOLLOW SERVICE 1")
        if follower.isFollow{
            print("Is FOLLOW")
            interactor?.followAndFollowUF(method: "DELETE", entityId: follower.entityId, entityType: follower.entityType)
            //interactor?.unfollowPerson(follower: follower)
        }else{
            print("NO FOLLOW")
            interactor?.followAndFollowUF(method: "POST", entityId: follower.entityId, entityType: follower.entityType)
            //followPerson(follower: follower)
        }
    }
    
    func followAndUnFollowedService2(follower: Followers) {
        print("FOLLOW AND UNFOLLOW SERVICE 2")
        if follower.isFollow{
            print("No FOLLOW para follow")//este es el caso
            interactor?.followAndFollowUF(method: "POST", entityId: follower.userId, entityType: follower.entityType)
        }else{
            print(" FOLLOW para no follow ")
            interactor?.followAndFollowUF(method: "DELETE", entityId: follower.userId, entityType: follower.entityType)
        }
    }

}

extension FollowersPresenter: FollowersInteractorOutputProtocol {
    func followAndUnFollowSuccess(fuf:Bool) {
        view?.followServiceSuccess(fuf:fuf)
    }
    
    func followAndUnFollowError(with error: SocialNetworkErrors){
        print("ES EL ERROR")
        print(error)
        view?.followServiceError(with: error)
    }
    
    func getArrFollowers(followers: [Followers], hasMore:Bool) {
        view?.loadFollowers(followers: followers, hasMore:hasMore)
    }
    
    func getArrFolloweds(followeds: [Followers], hasMore:Bool) {
        view?.loadFollowed(followeds: followeds, hasMore:hasMore)
    }
    
    func didFinishGettingPostsF(isFromPage: Bool, posts: [Posts]) {
        view?.didFinishGettingPostsF(isFromPage: isFromPage, posts: posts)
    }
}
