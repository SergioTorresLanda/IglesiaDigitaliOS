//
//  FollowersProtocols.swift
//  EncuentroCatolicoNews
//
//  Created by Billy on 26/01/22.
//  
//

import Foundation
import UIKit

protocol FollowersViewProtocol: AnyObject {
    var presenter: FollowersPresenterProtocol? { get set }
    func followServiceSuccess(fuf:Bool)
    func followServiceError(with error: SocialNetworkErrors)
    func loadFollowers(followers: [Followers], hasMore:Bool)
    func loadFollowed(followeds: [Followers], hasMore:Bool)
    func didFinishGettingPostsF(isFromPage: Bool, posts: [Posts])
}

protocol FollowersWireFrameProtocol: AnyObject {
    static func createFollowersModule(user:UserBasic) -> UIViewController
}

protocol FollowersPresenterProtocol: AnyObject {
    var view: FollowersViewProtocol? { get set }
    var interactor: FollowersInteractorInputProtocol? { get set }
    var wireFrame: FollowersWireFrameProtocol? { get set }
    func followAndUnFollowedService(follower: Followers)
    func followAndUnFollowedService2(follower: Followers)
    func getFollowed(snId:Int)
    func getFollowers(snId:Int)
    func getNewPostsF(isFromPage: Bool, isRefresh: Bool)
    func didFinishGettingPostsF(isFromPage: Bool, posts: [Posts])
}

protocol FollowersInteractorOutputProtocol: AnyObject {
    func followAndUnFollowSuccess(fuf:Bool)
    func followAndUnFollowError(with error: SocialNetworkErrors)
    func getArrFollowers(followers: [Followers], hasMore: Bool)
    func getArrFolloweds(followeds: [Followers], hasMore: Bool)
    func didFinishGettingPostsF(isFromPage: Bool, posts: [Posts])
}

protocol FollowersInteractorInputProtocol: AnyObject {
    var presenter: FollowersInteractorOutputProtocol? { get set }
    var remoteDatamanager: FollowersRemoteDataManagerInputProtocol? { get set }
    //func followPerson(follower: Followers)
    //func unfollowPerson(follower: Followers)
    func getFollowers(snId:Int)
    func getFollowed(snId:Int)
    func getNewPostsF(isFromPage: Bool, isRefresh: Bool)
    func followAndFollowUF(method: String, entityId: Int, entityType: Int)
}

protocol FollowersRemoteDataManagerInputProtocol: AnyObject {
    var remoteRequestHandler: FollowersRemoteDataManagerOutputProtocol? { get set }
    var snService: SocialNetworkService {get set}
    func followProfile(follower: Followers)
    func unfollowProfile(follower: Followers)
    func getFollowers(snId:Int)
    func getFollowed(snId:Int)
}

protocol FollowersRemoteDataManagerOutputProtocol: AnyObject {
    func followAndUnFollowSuccess(fuf:Bool)
    func followAndUnFollowError(with error: SocialNetworkErrors)
    func getFollowersResponse(with response: ResponseFollowers?, hasMore:Bool)
    func getFollowedResponse(with response: ResponseFollowers?, hasMore:Bool)
}
