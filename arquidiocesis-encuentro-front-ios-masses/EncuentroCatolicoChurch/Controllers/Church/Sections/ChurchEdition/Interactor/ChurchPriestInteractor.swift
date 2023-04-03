//
//  ChurchPriestInteractor.swift
//  ChurchPriest_framework
//
//  Created by Ulises Atonatiuh González Hernández on 11/02/21.
//

import Foundation

class ChurchPriestInteractor: ChurchPriestInteractorInputProtocol {
    
    var presenter: ChurchPriestInteractorOutputProtocol?
    
    func requestChurchDataUpdate(id: Int, _ data: ChurchEditionRequest) {
        var result: ChurchEditionResponse?
        
        let dispatchqueque = OperationQueue()
        dispatchqueque.qualityOfService = .background
        
        let operationUpdate = BlockOperation()
        
        operationUpdate.addExecutionBlock {
            let group = DispatchGroup()
            group.enter()
            
            CallUpdateChurch(id: id).execute {
                response in
                result = response
                group.leave()
            } onError: {
                [weak self]
                (error, message) in
                dispatchqueque.cancelAllOperations()
                self?.presenter?.isErrorService(msg: message)
            }
            group.wait()
        }
        
        DispatchQueue.global().async {
            [weak self] in
            dispatchqueque.addOperations([operationUpdate],
                                         waitUntilFinished: true)
            self?.presenter?.updateChurchResponse(response: result)
        }
    }
   
    func getPriestDetail(idPriest: String, idChurch: String) {
        
        var detailHours: ChurchDetail?
//        var detailPriest: ModelPriestResponse?
        var servicesCatalog: Array<ServiceCatalogItem>?
        var massesCatalog: Array<MassesCatalogItem>?
       
        let dispatchqueque = OperationQueue()
        dispatchqueque.qualityOfService = .background
        
        //let operationDetail = BlockOperation()
        let operationHours = BlockOperation()
        let operationServicesCatalog = BlockOperation()
        let operationMassesCatalog = BlockOperation()
        
//        operationDetail.addExecutionBlock {
//            let group = DispatchGroup()
//            group.enter()
//
//            CallDetailPriest.init().execute {
//                (result) in
//                let a = result
//                 detailPriest = a
//                group.leave()
//            } onError: {
//                [weak self]
//                (erro, msg) in
//
//                dispatchqueque.cancelAllOperations()
//                self?.presenter?.isErrorService(msg: msg)
//            }
//
//            group.wait()
//        }
        
        operationHours.addExecutionBlock {
            let group = DispatchGroup()
            group.enter()
            
            CallDetailHours.init().execute {
                (result) in
                let a = result
                detailHours = a
                group.leave()
            } onError: {
                [weak self]
                (error, msg) in
                dispatchqueque.cancelAllOperations()
                self?.presenter?.isErrorService(msg: msg)
            }

            group.wait()
            
        }
        
        operationServicesCatalog.addExecutionBlock {
            let group = DispatchGroup()
            group.enter()
            
            CallServicesCatalog().execute {
                result in
                servicesCatalog = result
                group.leave()
            } onError: {
                [weak self]
                (error, message) in
                dispatchqueque.cancelAllOperations()
                self?.presenter?.isErrorService(msg: message)
            }

            group.wait()
        }
        
        operationMassesCatalog.addExecutionBlock {
            let group = DispatchGroup()
            group.enter()
            
            CallMassesCatalog().execute {
                result in
                massesCatalog = result
                group.leave()
            } onError: {
                [weak self]
                (error, message) in
                dispatchqueque.cancelAllOperations()
                self?.presenter?.isErrorService(msg: message)
            }

            group.wait()
        }
        
        DispatchQueue.global().async {
            [weak self] in
            dispatchqueque.addOperations([operationHours,
                                          operationServicesCatalog,
                                          operationMassesCatalog],
                                         waitUntilFinished: true)
            self?.presenter?.isSuccessServiceInteractor(churchDetail: detailHours,
                                                        servicesCatalog: servicesCatalog,
                                                        massesCatalog: massesCatalog)
        }
    }
    
    
    //Call
    
    struct CallDetailPriest: ResponseDispatcher {
        typealias ResponseType = ModelPriestResponse
        var parameters: [String : Any]?
        var urlOptional: String?
        
        var data: RequestType {
            return RequestType(path: "/priests/1", method: .get, params: nil, url: nil)
        }
        
    }
    
    
    
    struct CallDetailHours: ResponseDispatcher {
        typealias ResponseType = ChurchDetail
        var parameters: [String : Any]?
        var urlOptional: String?
        
        var data: RequestType {
            return RequestType(path: "/churches/1", method: .get, params: nil, url: nil)
        }
    }
    
    struct CallServicesCatalog: ResponseDispatcher {
        typealias ResponseType = Array<ServiceCatalogItem>
        var parameters: [String : Any]?
        var urlOptional: String?
        
        var data: RequestType {
            return RequestType(path: "/catalogs/services", method: .get, params: nil, url: nil)
        }
    }
    
    struct CallMassesCatalog: ResponseDispatcher {
        typealias ResponseType = Array<MassesCatalogItem>
        var parameters: [String : Any]?
        var urlOptional: String?
        
        var data: RequestType {
            return RequestType(path: "/catalogs/masses", method: .get, params: nil, url: nil)
        }
    }
    
    struct CallUpdateChurch: ResponseDispatcher {
        typealias ResponseType = ChurchEditionResponse
        var parameters: [String : Any]?
        var urlOptional: String?
        var id: String
        
        var data: RequestType {
            return RequestType(path: "/churches/\(id)", method: .patch, params: nil, url: nil)
        }
        
        init(id: Int) {
            self.id = id.description
        }
    }
    
}
