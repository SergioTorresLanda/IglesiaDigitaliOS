//
//  ErrorEncuentro.swift
//  register_Framework
//
//  Created by Miguel Eduardo  Valdez Tellez  on 09/02/21.
//

import Foundation
import Alamofire

enum ErrorEncuentro: Error {
    case serializacion(key: CodingKey?, type: Any.Type?, context: DecodingError.Context?, mensaje: String)
    case internet(code: Int)
    case general(message: String, code: Int)
    case unkown(code: Int)
}

extension ErrorEncuentro {
    
    init?(decodingError: Error) {
        if let error = decodingError as? DecodingError {
            switch error {
            case .dataCorrupted(let context):
                self = .serializacion(key: nil, type: nil, context: context, mensaje: "DataCorrupted: \(decodingError.localizedDescription)")
            case .keyNotFound(let key, let context):
                self = .serializacion(key: key, type: nil, context: context, mensaje: "KeyNotFound: \(decodingError.localizedDescription)")
            case .typeMismatch(let type, let context):
                self = .serializacion(key: nil, type: type, context: context, mensaje: "typeMismatch: \(decodingError.localizedDescription)")
            case .valueNotFound(let type, let context):
                self = .serializacion(key: nil, type: type, context: context, mensaje: "valueNotFound: \(decodingError.localizedDescription)")
            @unknown default:
                self = .serializacion(key: nil, type: nil, context: nil, mensaje: "decoding unknown: \(decodingError.localizedDescription)")
            }
        } else {
            return nil
        }
    }
    
    init?(response: AFDataResponse<Data?>) {
        
        if let error = response.error as NSError? {
            let errorsList = [NSURLErrorNotConnectedToInternet,
                              NSURLErrorCannotConnectToHost,
                              NSURLErrorNetworkConnectionLost,
                              NSURLErrorTimedOut]
            if errorsList.contains(error.code) && error.domain == NSURLErrorDomain {
                self = .internet(code: response.response?.statusCode ?? 0)
                return
            }
        }
        
        if let error = response.error {
            self = .unkown(code: error.responseCode ?? 0)
            return
        }
        
        var message: String = "Ocurrio un error"
        if let data = response.data,
           let dataString = String(data: data, encoding: String.Encoding.utf8) {
            message = dataString
        }
        
        if let code = response.response?.statusCode {
            switch code {
            case let errorCode where errorCode >= 200 && errorCode < 300:
                return nil
            default:
                self = .general(message: message,
                                code: code)
            }
            
            return
        }
        
        return nil
        
    }
    
    var codigoDeError: Int {
        switch self {
        case .internet(let codigo):
            return codigo
        case .general(_, let codigo):
            return codigo
        case .serializacion:
            return 0
        case .unkown(let code):
            return code
        }
    }
    
    var errorDescription: String {
        switch self {
        case .internet:
            return "Revisa tu conexión a internet"
        case .general(let mensaje, _):
            return mensaje
        case .serializacion(let key, let type, let context, let mensaje):
            var descripcion = "Ocurrio un error al recuperar los datos"
            #if !PROD
            descripcion.append("\n\(mensaje)")
            if let key = key {
                descripcion.append("\n\(key.stringValue)")
            }
            if let type = type {
                descripcion.append("\n\(type)")
            }
            if let context = context {
                context.codingPath.forEach { (code) in
                    descripcion.append("\n\(code.stringValue)")
                }
                descripcion.append("\n\(context.debugDescription)")
            }
            #endif
            return descripcion
        case .unkown(let code):
            return "Error desconocido \(code)"
        }
        
    }
    
}

