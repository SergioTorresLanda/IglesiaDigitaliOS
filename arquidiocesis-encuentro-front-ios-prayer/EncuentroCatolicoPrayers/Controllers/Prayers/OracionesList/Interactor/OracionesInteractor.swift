//
//  OracionesInteractor.swift
//  OracionesModulo
//
//  Created by Ulises Atonatiuh González Hernández on 01/03/21.
//

import Foundation

class OracionesInteractor: InteractorInputOracionesProtocolo {
  
    
    var presenter: InteractorOutputOracionesProtocolo?
    
    func getOracion(name: String) {
        
        CallOraciones.init().execute { [weak self](result) in
           
        self?.presenter?.isSuccessServiceInteractor(data: result)
        } onError: { [weak self](Error, msg) in
            self?.presenter?.isErrorService(msg: msg)
        }

    }
    
    func getOracionSearchBar(type: String) {
        let encodingName = type.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        CallOracionesSearchBar.init(data: encodingName).execute { [weak self](result) in
            self?.presenter?.isSuccessServiceInteractor(data: result)
        } onError: { [weak self](error, msg) in
            self?.presenter?.isErrorService(msg: msg)
        }

    }
    
    
    
    
    
    struct CallOraciones: ResponseDispatcher {
        typealias ResponseType = [DataResponse]
        var parameters: [String : Any]?
        var urlOptional: String?
        
        var data: RequestType {
            return RequestType(path: "devotions", method: .get, params: nil, url: Endpoints.urlGlobalApp)
        }
        
    }
    
    
    struct CallOracionesSearchBar: ResponseDispatcher {
        typealias ResponseType = [DataResponse]
        var parameters: [String : Any]?
        var urlOptional: String?
        var type: String
        var data: RequestType {
            return RequestType(path: "devotions?name=" + self.type, method: .get, params: nil, url: Endpoints.urlGlobalApp)
        }
        
        init(data: String) {
            self.type = data
        }
        
    }
    
    
    
    
}
