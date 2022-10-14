//
//  CommunitiesMainViewPresenter.swift
//  EncuentroCatolicoChurch
//
//  Created by Jorge Garcia on 09/08/21.
//

import Foundation

class CommunitiesMainViewPresenter: CommunitiesMainViewPresenterProtocol, CommunitiesMainViewInteractorOutputProtocol {
    
    
    var view: CommunitiesMainViewProtocol?
    var interactor: CommunitiesMainViewInteractorInputProtocol?
    var wireFrame: CommunitiesMainViewWireFrameProtocol?
    
    func goToProfile() {
        if let view = view {
            wireFrame?.presentProfile(formView: view)
        }
    }
    
    func goToAddCommunities() {
        if let view = view {
            wireFrame?.presetnAddCommunities(formView: view)
        }
    }
    func comunityDataResponse(description: CommunityTypeModel) {
        
    }
    func communityDataResponse(response: CommunityDetailModel) {
        view?.communityDataSuccess(response: response)
    }
    
    func communityDeatlerror(msg: String) {
        view?.communityDataerror(message: msg)
    }
    
    func chourhDetail(id: Int) {
        interactor?.getChourchDetail(id: id)
    }
    
    func communityActivities(id: Int) {
        interactor?.getcommunityActivities(id: id)
    }
    
    func communityActivitiesResponse(response: CommunityGetActivities) {
        view?.communityActivitiesSucces(response: response)
    }
    
    func communityActivitiesError(msg: String) {
        view?.communityActivitiesError(message: msg)
    }
    func saveFinishRegister(id: Int, description: String, charisma: String, address: String, longitude: Double, latitude: Double, email: String, phone: String, website: String, instagram: String, twitter: String, facebook: String, streaming: String, service: [ServiceHourFinReg], activity: [ActivityFinReg], linkCom: [LinkedCommunity]) {
        interactor?.putFinishRegister(id: id, description: description, charisma: charisma, address: address, longitude: longitude, latitude: latitude, email: email, phone: phone, website: website, instagram: instagram, twitter: twitter, facebook: facebook, streaming: streaming, service: service, activity: activity, linkCom: linkCom)
    }
    
    func saveEditRegister(id: Int, typeId: Int, description: String, charisma: String, address: String, longitude: Double, latitude: Double, email: String, phone: String, website: String, instagram: String, twitter: String, facebook: String, streaming: String, service: [ServiceHourEditProfile], activity: [ActivityEditProfile]) {
        interactor?.putEditRegister(id: id, typeId: typeId, description: description, charisma: charisma, address: address, longitude: longitude, latitude: latitude, email: email, phone: phone, website: website, instagram: instagram, twitter: twitter, facebook: facebook, streaming: streaming, service: service, activity: activity)
    }
    func responsePutCommunity(errores: ServerErrors, data: String?) {
        switch errores {
        case .ErrorInterno:
            view?.errorsaveData()
        case .ErrorServidor:
            view?.errorsaveData()
        case .OK:
            view?.succesSaveData()
        }
    }
    func sendImage(elemntID: Int, type: String, fileName: String, content: String) {
        interactor?.postImage(elemntID: elemntID, type: type, fileName: fileName, content: content)
    }
    func responsePostImageCommunity(errores: ServerErrors, data: String?) {
        switch errores {
        case .ErrorInterno:
            break
        case .ErrorServidor:
            break
        case .OK:
            break
        }
    }
    
    func uploadImgBase64(elementID: Int, tytpe: String, filename: String, contentBase64: String) {
        interactor?.postImgBase64(elementID: elementID, type: tytpe, filename: filename, contentBase64: contentBase64)
    }
    
    func transportResponseUploadImg(responseCode: HTTPURLResponse, contentREsponse: UploadImageData) {
        DispatchQueue.main.async {
            if responseCode.statusCode == 200 || responseCode.statusCode == 201 {
                self.view?.succesUploadImg(data: contentREsponse)
            }else{
                self.view?.failUploadImg()
            }
        }
    }
    
    func addFavorite(id: Int, locationId: Int, isPrincipal: Bool) {
        interactor?.requestAddFavorite(id: id, locationId: locationId, isPrincipal: isPrincipal)
    }
    
    func removeFavorite(id: Int, locationId: Int, isPrincipal: Bool) {
        interactor?.requestRemoveFavorite(id: id, locationId: locationId, isPrincipal: isPrincipal)
    }
    
    func responseFavorite(errores: ServerErrors, data: String?) {
        switch errores {
        case .ErrorInterno:
            view?.errorAddFavorite()
        case .ErrorServidor:
            view?.errorAddFavorite()
        case .OK:
            view?.successAddFavorite()
        }
    }
    
    func communityComments(id: Int) {
        interactor?.getComuunityComments(id: id)
    }
    
    func communityCommentsResponse(response: Comments) {
        view?.communityComentsSucess(response: response)
    }
    
    func communityCommentsError(msg: String) {
        view?.communityComentsError(message: msg)
    }
    
    func getServiceCatalog() {
        interactor?.requestServiceCatalog()
    }
    
    func responseGetServiceCatalog(data: ServiceCatalogModel) {
        view?.serviceCatalogSuccess(response: data)
    }
    
    func errorGetServiceCatalog(msg: String) {
        view?.serviceCatalogError()
    }
    
}
