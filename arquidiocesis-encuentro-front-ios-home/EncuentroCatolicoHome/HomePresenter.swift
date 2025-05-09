//
//  HomePresenter.swift
//  EncuentroCatolicoHome
//
//  Created Diego Martinez on 23/02/21.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit
import CryptoSwift

class HomePresenter: HomePresenterProtocol {
    
    weak private var view: HomeViewProtocol?
    var interactor: HomeInteractorProtocol?
    private let router: HomeWireframeProtocol
    private var userHomer : UserRespHome?

    init(interface: HomeViewProtocol, interactor: HomeInteractorProtocol?, router: HomeWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }
    
    func cargarDatosUsuario() {
        print("cargar datos usuario")
        interactor?.cargarDatosPersona()
    }
    
    func obtieneRespuetaUsuario(errores: ErroresServidorHome, user: UserRespHome?) {
        userHomer = user
        DispatchQueue.main.async {
            switch errores {
            case .ErrorInterno:
                break
            case .ErrorServidor:
                break
            case .Ok:
                self.view?.mostrarInfo(dtcAlerta: nil, user: user)
            }
        }
    }
    
    func abrirBancoAppParaApoyar(mount: String) {
        let r4nd0mNumb3r = String().random(digits: 8)
        let buildMasket = buildStringByMask(dataToBuild: [userHomer?.UserAttributes.name ?? "",
                                                          userHomer?.UserAttributes.last_name ?? "",
                                                          mount + ".00",
                                                          "01720172887520",
                                                          "encuentrocatolico"], maskToReplace: "#@#@#@#@#", characterToReplace: "#")
        do {
            let encrypt3tM3ss4g3 = try aesEncrypt(key: "616C1B47BE32D6246105DB2E\(r4nd0mNumb3r)", iv: "1734df9a3c5fba88", message: buildMasket).replacingOccurrences(of:"+", with:"-")
                .replacingOccurrences(of:"/", with:"_")
                .replacingOccurrences(of:"=", with:"")
            let urlStringToPush =  buildURLToDonate(params: [
                                                        URLQueryItem(name: "sendToAcc?data", value: encrypt3tM3ss4g3),
                                                        URLQueryItem(name: "tkn", value: r4nd0mNumb3r)])
            print(urlStringToPush)
            UIApplication.shared.open(URL(string: urlStringToPush) ?? URL(string: "")!, options: [:], completionHandler: nil)
        }catch let error {
            print("Error:", error)
        }
    }
    
    func requestUserDetail() {
        interactor?.getUserDetail()
    }
    
    func responseGetProfile(responseCode: HTTPURLResponse, dataResponse: ProfileDetailImgH) {
        DispatchQueue.main.async {
           if responseCode.statusCode == 200 {
            self.view?.successLoadImg(dataResponse: dataResponse)
            self.view?.validateCommunityStatus(dataResponse: dataResponse)
            }else{
                self.view?.failLoadImg()
            }
        }
    }
    
// MARK: NEW HOME FUNCTIONS -
    func requestHomeData(type: String, date: String) {
        interactor?.getSaintOfDay(type: type, date: date)
    }
    
    func trasportResponseHome(response: HTTPURLResponse, data: [HomePosts]) {
        DispatchQueue.main.async {
            if response.statusCode == 200 {
                self.view?.succesGetHome(data: data)
            }else{
                self.view?.failGetHome(message: "Error")
            }
        }
    }
    
    func requestSuggestions(type: String) {
        interactor?.getSuggestions(type: type)
    }
    
    func transportResponseSuggestions(response: HTTPURLResponse, data: [HomeSuggestions]) {
        DispatchQueue.main.async {
            if response.statusCode == 200 {
                self.view?.onSuccessGetSuggestions(data: data)
            }else{
                self.view?.onFialGetSuggestions(message: "")
            }
        }
    }
    
    func transportResponsePosts(response: HTTPURLResponse, data: [HomePosts]) {
        DispatchQueue.main.async {
            if response.statusCode == 200 {
                self.view?.onSuccessGetPosts(data: data)
            }else{
                self.view?.onFialGetSuggestions(message: "Fail Posts")
            }
        }
    }
    
    func requestStreaming() {
        interactor?.requestSrtreaming()
    }
    
    func onSuccessStreaming(data: [LiveModel], response: HTTPURLResponse) {
        DispatchQueue.main.async {
            if response.statusCode == 200 {
                self.view?.successStreaming(data: data)
            }else{
                self.view?.failStreaming(message: "")
            }
        }
    }
    
    func onFailStreaming(message: Error) {
        DispatchQueue.main.async {
            self.view?.failStreaming(message: message.localizedDescription)
        }
    }
    
    func onFailCarrusel(type: String){
        DispatchQueue.main.async {
            self.view?.onFailCarruselV(type: type)
        }
    }
}

extension HomePresenter{
    
    private func buildURLToDonate(params: [URLQueryItem])->String{
        let appschema = "bancoaztecadl://"
        var urlFormat = URLComponents(string: "\(appschema)")
        urlFormat?.queryItems = params
        return urlFormat?.url?.absoluteString.replacingOccurrences(of: "%3D", with: "=") ?? ""
    }
    
    private func buildStringByMask(dataToBuild:[String], maskToReplace: String, characterToReplace: Character)->String{
        var dataBuilder = maskToReplace
        for dTb in dataToBuild{
            dataBuilder = formattedByMask(text: String(dTb), maskToReplace: dataBuilder, characterToReplace: characterToReplace)
        }
        return dataBuilder
    }
  
    
    func aesEncrypt(key: String, iv: String, message: String) throws -> String{
        let data = message.data(using: .utf8)!
        let aes = try AES(key: Array<UInt8>(key.utf8), blockMode: CBC(iv: Array<UInt8>(iv.utf8)), padding: .pkcs5)
        let encryptedBytes = try aes.encrypt(data.bytes)
        let encryptedData = Data(bytes: encryptedBytes, count: Int(encryptedBytes.count))
        print("er \(encryptedData.base64EncodedString())")
        return encryptedData.base64EncodedString()
    }
    
    
    private func formattedByMask(text: String, maskToReplace: String, characterToReplace: Character) -> String {
        let letters = text.components(separatedBy: CharacterSet(charactersIn: "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 .").inverted).joined()
        var result = ""
        let index = letters.startIndex
        var tempomaskToReplace =  maskToReplace
        for ch in maskToReplace where index < letters.endIndex {
            tempomaskToReplace = String(tempomaskToReplace.dropFirst())
            if ch == characterToReplace {
                result.append(letters)
                result.append(tempomaskToReplace)
                break
            }else{
                result.append(ch)
            }
        }
        return result.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

extension Double {
    func round(to places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
