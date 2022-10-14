//
//  CommunitiesMainViewProtocol.swift
//  EncuentroCatolicoChurch
//
//  Created by Jorge Garcia on 09/08/21.
//

import Foundation

protocol CommunitiesMainViewProtocol: AnyObject {
    var presenter: CommunitiesMainViewPresenterProtocol? { get set }
    func communityDataSuccess(response: CommunityDetailModel)
    func communityDataerror(message: String)
    func communityActivitiesSucces(response: CommunityGetActivities)
    func communityActivitiesError(message: String)
    func succesUploadImg(data: UploadImageData)
    func failUploadImg()
    func succesSaveData()
    func errorsaveData()
    func successAddFavorite()
    func errorAddFavorite()
    func communityComentsSucess(response: Comments)
    func communityComentsError(message: String)
    func serviceCatalogSuccess(response: ServiceCatalogModel)
    func serviceCatalogError()
}

protocol CommunitiesMainViewWireFrameProtocol: AnyObject {
    static func presentCommunitiesMainVieModule(fromView vc: AnyObject, myChourch: Bool, id: Int, isEditProfile: Bool, isFavorite: Bool, isPrincipal: Bool)
    func presetnAddCommunities(formView: AnyObject)
    func presentProfile(formView: AnyObject)
}

protocol CommunitiesMainViewPresenterProtocol: AnyObject {
    var view: CommunitiesMainViewProtocol? { get set }
    var interactor: CommunitiesMainViewInteractorInputProtocol? { get set }
    var wireFrame: CommunitiesMainViewWireFrameProtocol? { get set }
    
    func goToAddCommunities()
    func goToProfile()
    func chourhDetail(id: Int)
    func communityActivities(id: Int)
    func sendImage(elemntID: Int, type: String, fileName: String, content: String)
    func saveFinishRegister(id: Int, description: String, charisma: String, address: String, longitude: Double, latitude: Double, email: String, phone: String, website: String, instagram: String, twitter: String, facebook: String, streaming: String, service: [ServiceHourFinReg], activity: [ActivityFinReg], linkCom: [LinkedCommunity])
    func saveEditRegister(id: Int, typeId: Int, description: String, charisma: String, address: String, longitude: Double, latitude: Double, email: String, phone: String, website: String, instagram: String, twitter: String, facebook: String, streaming: String, service: [ServiceHourEditProfile], activity: [ActivityEditProfile])
    func uploadImgBase64(elementID: Int, tytpe: String, filename: String, contentBase64: String)
    func addFavorite(id: Int, locationId: Int, isPrincipal: Bool)
    func removeFavorite(id: Int, locationId: Int, isPrincipal: Bool)
    func communityComments(id: Int)
    func getServiceCatalog()
    
}

protocol CommunitiesMainViewInteractorOutputProtocol: AnyObject {
    func comunityDataResponse(description: CommunityTypeModel)
    func communityDataResponse(response: CommunityDetailModel)
    func communityDeatlerror(msg: String)
    func communityActivitiesResponse(response: CommunityGetActivities)
    func communityActivitiesError(msg: String)
    func responsePutCommunity(errores: ServerErrors, data: String?)
    func responsePostImageCommunity(errores: ServerErrors, data: String?)
    func transportResponseUploadImg(responseCode: HTTPURLResponse, contentREsponse: UploadImageData)
    func responseFavorite(errores: ServerErrors, data: String?)
    func communityCommentsResponse(response: Comments)
    func communityCommentsError(msg: String)
    func responseGetServiceCatalog(data: ServiceCatalogModel)
    func errorGetServiceCatalog(msg: String)
    
}

protocol CommunitiesMainViewInteractorInputProtocol: AnyObject {
    var presenter: CommunitiesMainViewInteractorOutputProtocol? { get set }
    func getChourchDetail(id: Int)
    func getcommunityActivities(id: Int)
    func getComuunityComments(id: Int)
    func putFinishRegister(id: Int, description: String, charisma: String, address: String, longitude: Double, latitude: Double, email: String, phone: String, website: String, instagram: String, twitter: String, facebook: String, streaming: String, service: [ServiceHourFinReg], activity: [ActivityFinReg], linkCom: [LinkedCommunity])
    func putEditRegister(id: Int, typeId: Int, description: String, charisma: String, address: String, longitude: Double, latitude: Double, email: String, phone: String, website: String, instagram: String, twitter: String, facebook: String, streaming: String, service: [ServiceHourEditProfile], activity: [ActivityEditProfile])
    func postImage(elemntID: Int, type: String, fileName: String, content: String)
    func postImgBase64(elementID: Int, type: String, filename: String, contentBase64: String)
    func requestAddFavorite(id: Int, locationId: Int, isPrincipal: Bool)
    func requestRemoveFavorite(id: Int, locationId: Int, isPrincipal: Bool)
    func requestServiceCatalog()
}
