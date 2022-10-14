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
    
    func followServiceSuccess()
    func followServiceError(with error: SocialNetworkErrors)
    
    func loadFollowers(followers: [Followers])
    func loadFollowed(followeds: [Followers])
}

protocol FollowersWireFrameProtocol: AnyObject {
    static func createFollowersModule() -> UIViewController
}

protocol FollowersPresenterProtocol: AnyObject {
    var view: FollowersViewProtocol? { get set }
    var interactor: FollowersInteractorInputProtocol? { get set }
    var wireFrame: FollowersWireFrameProtocol? { get set }
    
    func viewDidLoad()
    func followAndUnFollowedService(follower: Followers)
}

protocol FollowersInteractorOutputProtocol: AnyObject {
    func followAndUnFollowSuccess()
    func followAndUnFollowError(with error: SocialNetworkErrors)
    
    func getArrFollowers(followers: [Followers])
    func getArrFolloweds(followeds: [Followers])
    
}

protocol FollowersInteractorInputProtocol: AnyObject {
    var presenter: FollowersInteractorOutputProtocol? { get set }
    var remoteDatamanager: FollowersRemoteDataManagerInputProtocol? { get set }
    
    func followPerson(follower: Followers)
    func unfollowPerson(follower: Followers)
    func getFollowers()
    func getFollowed()
}

protocol FollowersRemoteDataManagerInputProtocol: AnyObject {
    var remoteRequestHandler: FollowersRemoteDataManagerOutputProtocol? { get set }
    var snService: SocialNetworkService {get set}
    
    func followProfile(follower: Followers)
    func unfollowProfile(follower: Followers)
    func getFollowers()
    func getFollowed()
}

protocol FollowersRemoteDataManagerOutputProtocol: AnyObject {
    func followAndUnFollowSuccess()
    func followAndUnFollowError(with error: SocialNetworkErrors)
    func getFollowersResponse(with response: ResponseFollowers?)
    func getFollowedResponse(with response: ResponseFollowers?)
}
