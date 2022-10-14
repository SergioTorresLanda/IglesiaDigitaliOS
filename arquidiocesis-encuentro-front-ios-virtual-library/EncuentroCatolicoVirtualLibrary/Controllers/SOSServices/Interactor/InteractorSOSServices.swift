//
//  InteractorSOSServices.swift
//  SOSLinko
//
//  Created by Ulises Atonatiuh González Hernández on 21/03/21.
//

import Foundation
enum StatusSOS: String {
    case ACCEPTED = "ACCEPTED"
    case REJECTED = "REJECTED"
    case IN_PROGRESS = "IN_PROGRESS"
    case CANCELED = "CANCELED"
    case COMPLETED = "COMPLETED"
}
class InteractorSOSServices: SOSInterctorInputServiciosProtocol {
   
    
    var presenter: SOSInterctorOutputServiciosProtocol?
    private let dataManager: LocationsRemoteDataManager
    
    
    init(dataManager: LocationsRemoteDataManager = LocationsRemoteDataManager()) {
        self.dataManager = dataManager
    }
    
    func requestInteractorData(id: UInt, status: StatusSOS) {
        CallGetData.init(id: Int(id), status: status.rawValue).execute { [weak self](result) in
            self?.presenter?.responseInteractorData(result: result)
        } onError: { [weak self](error, msg) in
            self?.presenter?.isErrorServer(msg: msg)
        }

    }
    
    func requestInteractorStatus(id: Int) {
        CallGetstatus.init(id: id).execute { [weak self](resutl) in
            self?.presenter?.responseInteractorStatus(status: resutl.activeSOS ?? false)
        } onError: { [weak self](error, msg) in
            self?.presenter?.isErrorServer(msg: msg)
        }

    }
    
    func requestInteractorChangestatus(id: Int, status: Bool) {
        let request = ModelChangeStatusSwitchRequest(activeSOS: status)
        let dataDiccionary: [String: Any] =  request.todiccionary ?? [:]
       
        CallChangeStatus.init(id: id, params: dataDiccionary).execute { [weak self](result) in
            self?.presenter?.responseInteractorStatus(status: true)
        } onError: { [weak self](err, msg) in
            self?.presenter?.responseInteractorStatus(status: true)
        }

      

    }
    
    func requestInteractorServiceStatus(idService: Int, status: String) {
        let request = ModelChangeStatusRequest(activeSOS: status)
        let dataDiccionary: [String: Any] =  request.todiccionary ?? [:]
        
        CallChangeStatusService.init(id: idService, params: dataDiccionary).execute { [weak self](result) in
            self?.presenter?.responseChangeServiceStatus()
        } onError: { [weak self](error, msg) in
            self?.presenter?.responseChangeServiceStatus()
        }
        
    }
    
   
    
    struct CallChangeStatusService: ResponseDispatcher {
        typealias ResponseType = [StatusModel]
        var parameters: [String : Any]?
        var urlOptional: String?
        var id: String? = "50"
        var status: String? = "Accepted"
        
        var data: RequestType {
            return RequestType(path: "services/" + self.id! , method: .patch, params: self.parameters!, url: nil)
        }
        
        init(id: Int, params:[String: Any]) {
            self.id = String(id)
            self.parameters = params
            
        }
    }
    
    struct CallGetData: ResponseDispatcher {
        typealias ResponseType = [StatusModel]
        var parameters: [String : Any]?
        var urlOptional: String?
        var id: String? = "50"
        var status: String? = "Accepted"
        
        var data: RequestType {
            return RequestType(path: "services?priestId=5&status" , method: .get, params: nil, url: nil)
        }
        
        init(id: Int, status: String) {
            self.id = String(id)
            self.status = status
            
        }
    }
    
    
    struct CallChangeStatus: ResponseDispatcher {
        typealias ResponseType = SosStatusModel
        var parameters: [String : Any]?
        var urlOptional: String?
        var id: String?
        
        var data: RequestType {
            return RequestType(path: "priests/" + self.id! + "?type=SOS", method: .patch, params: parameters!, url: nil)
        }
        
        init(id: Int, params: [String: Any]) {
            self.id = String(id)
            self.parameters = params
        }
    }
    
    struct CallGetstatus: ResponseDispatcher {
        typealias ResponseType = SosStatusModel
        var parameters: [String : Any]?
        var urlOptional: String?
        var id: String? = "1"
        
        var data: RequestType {
            return RequestType(path: "priests/" + self.id! + "?type=SOS" , method: .get, params: nil, url: nil)
        }
        
        init(id: Int) {
            self.id = String(id)
        }
    }
    
    struct postSos: ResponseDispatcher {
        typealias ResponseType = SosStatusModel
        var parameters: [String : Any]?
        var urlOptional: String?
        var id: String? = "1"
        
        var data: RequestType {
            return RequestType(path: "/services", method: .post, params: parameters, url: nil)
        }
        init(id: Int) {
            self.id = String(id)
        }
    }
   
    
}
