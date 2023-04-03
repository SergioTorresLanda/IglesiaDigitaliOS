//
//  LocationUserPerm.swift
//  EncuentroCatolico
//
//  Created by 4n4rk0z on 12/11/21.
//

import Foundation


class LocationUserPerm: NSObject {
    
    let userID: String
    init(userID: String) {
        self.userID = userID
        super.init()
    }
    
    
    struct ProfileDetailImgH: Codable {
        var data: USerH?
    }
    
    struct USerH: Codable {
        var User: ProfileComponentsH?
    }
    
    struct ProfileComponentsH: Codable {
        var image: String?
        var community: CommunityComponents?
        var location_id: Int?
        var location_modules: [LocationComponents]?
        var profile: String?
        
    }
    
    struct CommunityComponents: Codable {
        var id: Int?
        var name: String?
        var status: String?
    }
    
    struct LocationComponents: Codable {
        var id: Int?
        var name: String?
        var modules: [String]?
    }
    
    
    
    func getUserDetail() {
        let defaults = UserDefaults.standard
        let idUser = defaults.integer(forKey: "id")
        print(idUser, "qwertyuiop")
        guard let endpoint: URL = URL(string: "\(APIType.shared.Auth())/user/detail/\(idUser)") else {
            print("Error formando url")
            return
        }
        
        var request = URLRequest(url: endpoint)
        
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let tksession = UserDefaults.standard.string(forKey: "idToken")
        request.setValue("Bearer \( tksession ?? "")", forHTTPHeaderField: "Authorization")
        
        let tarea = URLSession.shared.dataTask(with: request) { data, response, error in
            
            //print("->  respuesta Status Code: ", response as Any)
            //print("->  error: ", error as Any)

            if error != nil {
                print("Hubo un error 052")
                return
            }
            
            do {
                
                if data != nil {
                    let contResponse : ProfileDetailImgH = try JSONDecoder().decode(ProfileDetailImgH.self, from: data!)
                    print(response)
                    self.successLoadImg(dataResponse: contResponse)
                }
                
            }catch{
                APIType.shared.refreshToken()
                print("error al obtener detalle del usuario", error.localizedDescription)
            }
            
        }
        tarea.resume()
    }
    
    
    func successLoadImg(dataResponse: ProfileDetailImgH){
            let locationComponentsModules = dataResponse.data?.User?.location_modules?.first?.modules
            
            switch dataResponse.data?.User?.profile {
            case "DEAN_PRIEST":
                UserDefaults.standard.setValue(true, forKey: "isComm")
            case "DEVOTED_ADMIN":
                if ((locationComponentsModules?.contains{ $0 == "SOS"}) == true){
                    UserDefaults.standard.setValue(true, forKey: "isComm")
                }else{
                    UserDefaults.standard.setValue(false, forKey: "isComm")
                }
            default:
                break
            }
            
        }
    
    
}
