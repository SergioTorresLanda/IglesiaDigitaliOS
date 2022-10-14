//
//  InteractorBibliotecaRecursos.swift
//  EncuentroCatolicoVirtualLibrary
//
//  Created by Ulises Atonatiuh González Hernández on 14/04/21.
//

import Foundation


class BibliotecaRecursosInteractor: BibliotecaRecursosInputInteractorProtocol {
    
    var presenter: BibliotecaRecursosOutputInteractorProtocol?
    func requestInteractorDataHome() {
        CallHome.init().execute { [weak self](result) in
            self?.presenter?.responseInteractorDataHome(result: result)
        } onError: { [weak self](error, msg) in
            self?.presenter?.isErrorServer(msg: msg)
        }

    }
    
    func requestInteractorDataSeacrh(text: String) {
        CallSearchBarLibrary.init(text: text).execute { [weak self](result) in
            self?.presenter?.responseInteractorDataSearch(result: result)
        } onError: { [weak self](error, msg) in
            self?.presenter?.isErrorServer(msg: msg)
        }

    }
    
  
    
   
   
}




struct CallHome: ResponseDispatcher {
    typealias ResponseType = LibraryResourcesResponse
    var parameters: [String : Any]?
    var urlOptional: String?
    var id: String? = "1"
    
    var data: RequestType {
        return RequestType(path: "/develop/library/home", method: .get, params: nil, url: Endpoints.urlLibrary)
    }
   
}

//
struct CallSearchBarLibrary: ResponseDispatcher {
    typealias ResponseType = [LibrarySearchResponse]
    var parameters: [String : Any]?
    var urlOptional: String?
    var text: String? = "Do"
    
    var data: RequestType {
        return RequestType(path: "/develop/library?tag=" + self.text!, method: .get, params: nil, url: Endpoints.urlLibrary)
    }
    init(text: String) {
        self.text = text
    }
}
