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
    // TODO: implement presenter methods
    func viewDidLoad() {
        interactor?.getFollowed()
        interactor?.getFollowers()
    }
    
    func followAndUnFollowedService(follower: Followers) {
        if follower.isFollow{
            interactor?.followPerson(follower: follower)
        }else{
            interactor?.unfollowPerson(follower: follower)
            
        }
    }
}

extension FollowersPresenter: FollowersInteractorOutputProtocol {
    func followAndUnFollowSuccess() {
        view?.followServiceSuccess()
    }
    
    func followAndUnFollowError(with error: SocialNetworkErrors){
        print("ES EL ERROR")
        print(error)
        view?.followServiceError(with: error)
    }
    
    func getArrFollowers(followers: [Followers]) {
        view?.loadFollowers(followers: followers)
    }
    
    func getArrFolloweds(followeds: [Followers]) {
        view?.loadFollowed(followeds: followeds)
    }
}
