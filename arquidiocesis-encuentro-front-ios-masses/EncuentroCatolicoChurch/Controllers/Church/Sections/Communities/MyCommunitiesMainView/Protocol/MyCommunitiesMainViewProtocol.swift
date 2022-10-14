//
//  MyCommunitiesMainViewProtocol.swift
//  EncuentroCatolicoChurch
//
//  Created by Jorge Garcia on 12/08/21.
//

import Foundation

protocol MyCommunitiesMainViewProtocol: AnyObject {
    var presenter: MyCommunitiesMainViewPresenterProtocol? { get set }
    func communitySuccess(response: CommunityMainList)
    func communityError(msg: String)
    func serachBarResponse(result: CommunitySearchList)
}

protocol MyCommunitiesMainViewViewWireFrameProtocol: AnyObject {
    static func presentMyCommunitiesMainVieModule(fromView vc: AnyObject, myChourch: Bool)
    
    func pushToCommunitiesDetail(fromView vc: AnyObject, myChourch: Bool, id: Int, isFavorite: Bool, isPrincipal: Bool, isEdit: Bool)
    func pushToMap(fromView vc: AnyObject, isPrincipal: Int, isPrincialBool: Bool?)
   
}

protocol MyCommunitiesMainViewPresenterProtocol: AnyObject {
    var view: MyCommunitiesMainViewProtocol? { get set }
    var interactor: MyCommunitiesMainViewInteractorInputProtocol? { get set }
    var wireFrame: MyCommunitiesMainViewViewWireFrameProtocol? { get set }
    
    func goToCommunityDetail(myChourch: Bool, id: Int, isFavorite: Bool, isPrincipal: Bool, isEdit: Bool)
    func getCommunitiesData(id: Int)
    func searchBarChurch(name: String)
    func goToMaps(isPrincipal: Int, isPrincialBool: Bool)
    
}

protocol MyCommunitiesMainViewInteractorOutputProtocol: AnyObject {
    func communitiesResponse(response: CommunityMainList)
    func communitiesError(msg: String)
    func responseSearchBar(result: CommunitySearchList)
}

protocol MyCommunitiesMainViewInteractorInputProtocol: AnyObject {
    var presenter: MyCommunitiesMainViewInteractorOutputProtocol? { get set }
    func getCommunities(id: Int)
    func requestSearchBar(name: String)
}
