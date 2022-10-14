//
//  ErrorEncuentro.swift
//  encuentro
//
//  Created by Ahmed Castro on 10/3/20.
//  Copyright © 2020 Linko. All rights reserved.
//

import Foundation
import Alamofire

enum ErrorEncuentro: Error {
    case serializacion(key: CodingKey?, type: Any.Type?, context: DecodingError.Context?, mensaje: String)
    case internet(codigo: Int)
    case tiempoAgotado(codigo: Int)
    case general(mensaje: String, codigo: Int)
    case ocpError
    case desconocido(codigo: Int)
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
    
    init?(respuesta: AFDownloadResponse<Data>) {
        if let error = respuesta.error as NSError? {
            let listaDeErrores = [NSURLErrorNotConnectedToInternet, NSURLErrorCannotConnectToHost, NSURLErrorNetworkConnectionLost, NSURLErrorTimedOut]
            if listaDeErrores.contains(error.code) && error.domain == NSURLErrorDomain {
                self = .internet(codigo: respuesta.response?.statusCode ?? 0)
                return
            }
        }
        
        if let error = respuesta.error {
            self = .tiempoAgotado(codigo: error.responseCode ?? 0)
            return
        }
        
        if let codigo = respuesta.response?.statusCode {
            
            var mensaje: String?
            
            switch respuesta.result {
            case .success(let datos):
                mensaje = String(data: datos, encoding: String.Encoding.utf8)
            case .failure(let error):
                mensaje = error.errorDescription
            }
            
            switch codigo {
            case let codigoError where codigoError >= 200 && codigoError < 300:
                return nil
            case let codigoError where codigoError >= 300 && codigoError < 400:
                self = .general(mensaje: (mensaje ?? "Error interno"), codigo: codigo)
            case let codigoError where codigoError >= 400 && codigoError < 500:
                self = .general(mensaje: (mensaje ?? "Error interno"), codigo: codigo)
            case 503:
//                var mensaje = "Hubo un error de conexión, por favor intenta nuevamente."
                if respuesta.request?.method == HTTPMethod.post,
                    let url = respuesta.request?.url?.absoluteString {
                    if url.contains("compras") ||
                        url.contains("ventas") ||
                        url.contains("retiros") ||
                        url.contains("instrucciones") {
                        mensaje = "Hubo un error de conexión, por favor revisa tus confirmaciones de instrucción en tu correo electrónico antes de intentar nuevamente."
                    }
                }
                
            
                self = .ocpError
            case 504:
                self = .tiempoAgotado(codigo: codigo)
            case let codigoError where codigoError >= 500:
                self = .general(mensaje: (mensaje ?? "Error interno"), codigo: codigo)
            default:
                self = .general(mensaje: (mensaje ?? "Error interno"), codigo: codigo)
            }
            
            return
        }
        
        return nil
    }
    
    init?(respuesta: AFDataResponse<Data?>) {
        
        if let error = respuesta.error as NSError? {
            let listaDeErrores = [NSURLErrorNotConnectedToInternet, NSURLErrorCannotConnectToHost, NSURLErrorNetworkConnectionLost, NSURLErrorTimedOut]
            if listaDeErrores.contains(error.code) && error.domain == NSURLErrorDomain {
                self = .internet(codigo: respuesta.response?.statusCode ?? 0)
                return
            }
        }
        
        if let error = respuesta.error {
            self = .tiempoAgotado(codigo: error.responseCode ?? 0)
            return
        }
        
        if let codigo = respuesta.response?.statusCode {
            
            var mensaje: String?
            if let datos = respuesta.data {
                mensaje = String(data: datos, encoding: String.Encoding.utf8)
            }
            switch codigo {
            case let codigoError where codigoError >= 200 && codigoError < 300:
                return nil
            case let codigoError where codigoError >= 300 && codigoError < 400:
                self = .general(mensaje: (mensaje ?? "Error interno"), codigo: codigo)
            case let codigoError where codigoError >= 400 && codigoError < 500:
                self = .general(mensaje: (mensaje ?? "Error interno"), codigo: codigo)
            case 503:
//                var mensaje = "Hubo un error de conexión, por favor intenta nuevamente."
                if respuesta.request?.method == HTTPMethod.post,
                    let url = respuesta.request?.url?.absoluteString {
                    if url.contains("compras") ||
                        url.contains("ventas") ||
                        url.contains("retiros") ||
                        url.contains("instrucciones") {
                        mensaje = "Hubo un error de conexión, por favor revisa tus confirmaciones de instrucción en tu correo electrónico antes de intentar nuevamente."
                    }
                }
                
        
                self = .ocpError
            case 504:
                self = .tiempoAgotado(codigo: codigo)
            case let codigoError where codigoError >= 500:
                self = .general(mensaje: (mensaje ?? "Error interno"), codigo: codigo)
            default:
                self = .general(mensaje: (mensaje ?? "Error interno"), codigo: codigo)
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
        case .desconocido:
            return 0
        case .tiempoAgotado(let codigo):
            return codigo
        case .ocpError:
            return 503
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
        case .desconocido:
            return "Error desconocido"
        case .tiempoAgotado:
            return "Intente más tarde"
        case .ocpError:
            return "Hubo un error de conexión, por favor intenta nuevamente."
        }
        
    }
    
}
