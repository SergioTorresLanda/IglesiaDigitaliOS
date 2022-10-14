//
//  InteractorSOS.swift
//  SOSLinko
//
//  Created by Ulises Atonatiuh González Hernández on 21/03/21.
//

import Foundation

class InteractorSOS:  SOSInterctorInputProtocol {
    var presenter: SOSInterctorOutputProtocol?
    
    func requestInteractor(id: UInt) {
        
        CallSos.init(id: Int(id)).execute { [weak self](result) in
            self?.presenter?.responseInteractor(result: result)
        } onError: { [weak self](error, msg) in
            self?.presenter?.responseError(msg: msg)
        }

    }
    
    struct CallSos: ResponseDispatcher {
        typealias ResponseType = [SOSFielModel]
        var parameters: [String : Any]?
        var urlOptional: String?
        var id: String? = "1"
        
        var data: RequestType {
            return RequestType(path: "catalog/services?type=SOS" , method: .get, params: nil, url: nil)
        }
        
        init(id: Int) {
            self.id = String(id)
        }
    }
   
    


}
