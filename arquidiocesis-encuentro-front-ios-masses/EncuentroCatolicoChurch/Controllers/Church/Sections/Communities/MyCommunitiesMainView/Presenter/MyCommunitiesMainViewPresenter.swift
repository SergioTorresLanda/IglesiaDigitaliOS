//
//  MyCommunitiesMainViewPresenter.swift
//  EncuentroCatolicoChurch
//
//  Created by Jorge Garcia on 12/08/21.
//

import Foundation

class MyCommunitiesMainViewPresenter: MyCommunitiesMainViewPresenterProtocol, MyCommunitiesMainViewInteractorOutputProtocol {
    
    var view: MyCommunitiesMainViewProtocol?
    
    var interactor: MyCommunitiesMainViewInteractorInputProtocol?
    
    var wireFrame: MyCommunitiesMainViewViewWireFrameProtocol?
    
    func goToCommunityDetail(myChourch: Bool, id: Int, isFavorite: Bool, isPrincipal: Bool, isEdit: Bool) {
        if let view = view {
            wireFrame?.pushToCommunitiesDetail(fromView: view, myChourch: myChourch, id: id, isFavorite: isFavorite, isPrincipal: isPrincipal, isEdit: isEdit)
        }
    }
    
    func communitiesResponse(response: CommunityMainList) {
        view?.communitySuccess(response: response)
    }
    
    func communitiesError(msg: String) {
        view?.communityError(msg: msg)
    }
    
    func getCommunitiesData(id: Int) {
        interactor?.getCommunities(id: id)
    }
    
    func searchBarChurch(name: String) {
        interactor?.requestSearchBar(name: name)
    }
    
    func responseSearchBar(result: CommunitySearchList) {
        view?.serachBarResponse(result: result)
    }
    
    func goToMaps(isPrincipal: Int, isPrincialBool: Bool) {
        if let view = view {
            wireFrame?.pushToMap(fromView: view, isPrincipal: isPrincipal, isPrincialBool: isPrincialBool)
        }
    }
}
