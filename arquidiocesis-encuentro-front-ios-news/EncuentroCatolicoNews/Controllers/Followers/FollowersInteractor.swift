//
//  FollowersInteractor.swift
//  EncuentroCatolicoNews
//
//  Created by Billy on 26/01/22.
//  
//

import Foundation

enum EntitiesType: String{
    case User
    case Church
    case Community
    
    var intValue: Int{
        switch self {
        case .User:
            return 1
        case .Church:
            return 2
        case .Community:
            return 3
        }
    }
}

class FollowersInteractor: FollowersInteractorInputProtocol {
    // MARK: Properties
    weak var presenter: FollowersInteractorOutputProtocol?
    var remoteDatamanager: FollowersRemoteDataManagerInputProtocol?

    func followPerson(follower: Followers) {
        remoteDatamanager?.followProfile(follower: follower)
    }
    
    func unfollowPerson(follower: Followers) {
        remoteDatamanager?.unfollowProfile(follower: follower)
    }
    
    func getFollowers() {
        remoteDatamanager?.getFollowers()
    }
    
    func getFollowed() {
        remoteDatamanager?.getFollowed()
    }
}

extension FollowersInteractor: FollowersRemoteDataManagerOutputProtocol {
    func followAndUnFollowSuccess() {
        presenter?.followAndUnFollowSuccess()
    }
    
    func followAndUnFollowError(with error: SocialNetworkErrors) {
        presenter?.followAndUnFollowError(with: error)
    }
    
    func getFollowersResponse(with response: ResponseFollowers?) {
        var arrFollowers: [Followers] = []
        guard let response = response else {
            presenter?.getArrFollowers(followers: arrFollowers)
            return
        }

        for users in response.result.Follows{
            let follower = Followers(image: users.image, name: users.name, isFollow: knowIfIFollow(status: users.relationshipStatus), userId: users.id, entityId: users.relationshipId, entityType: EntitiesType(rawValue: users.type)?.intValue ?? 1)
            arrFollowers.append(follower)
        }
        
        presenter?.getArrFollowers(followers: arrFollowers)
    }
    
    func getFollowedResponse(with response: ResponseFollowers?, hasMore: Bool) {
        var arrFollowers: [Followers] = []
        guard let response = response else {
            presenter?.getArrFolloweds(followeds: arrFollowers, hasMore:hasMore)
            return
        }

        for users in response.result.Follows{
            let follower = Followers(image: users.image, name: users.name, isFollow: knowIfIFollow(status: users.relationshipStatus), userId: users.id, entityId: users.relationshipId, entityType: EntitiesType(rawValue: users.type)?.intValue ?? 1)
            arrFollowers.append(follower)
        }
        
        presenter?.getArrFolloweds(followeds: arrFollowers, hasMore:hasMore)
    }
    
    func knowIfIFollow(status: Int) -> Bool{
        return status == 1 || status == 3
    }
}
