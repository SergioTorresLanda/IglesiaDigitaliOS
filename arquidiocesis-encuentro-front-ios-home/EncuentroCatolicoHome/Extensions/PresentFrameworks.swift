//
//  PresentFrameworks.swift
//  EncuentroCatolicoHome
//
//  Created by Diego Martinez on 23/02/21.
//

import Foundation
import UIKit

//MARK: - PresenterMethods
extension HomeViewController {
    /*func openLogin() {
        let view = LoginRouter.createModule()
        view.modalPresentationStyle = .fullScreen
        self.present(view, animated: true)
    }*/
}

extension UIImageView {
    func DownloadStaticImageH(_ uri : String) {
        guard let url = URL(string: uri) else {return}
        
        let task = URLSession.shared.dataTask(with: url) {responseData,response,error in
            //print("->>  response: ", response)
            //print("->>  error: ", error)

            if error == nil {
                if let data = responseData {
                    
                    DispatchQueue.main.async {
                        self.image = UIImage(data: data)
                       
                        print("Fin del hilo imagen muestra")
                    }
                    
                }else {
                    print("no data")
                }
            }else{
                print("error")
            }
        }
        task.resume()
    }
}

extension String{
    func embedAndPlayYoutubeURL() -> String{
        if self.contains("youtube"){
            return self.replacingOccurrences(of: "watch?v=", with: "embed/") + "?autoplay=1"
        }else{
            return self
        }
    }
    
    func embedYoutubeURL() -> String{
        if self.contains("youtube"){
            return self.replacingOccurrences(of: "watch?v=", with: "embed/")
        }else{
            return self
        }
    }
    
    func getYouTubeThubnailFromURL() -> String{
        var videoID = ""
        videoID = self.replacingOccurrences(of: "https://www.youtube.com/watch?v=", with: "")
        if self.contains("&list="){
            let array = videoID.components(separatedBy: "&list=")
            if array.count > 0{
                videoID = array[0]
                videoID = "https://img.youtube.com/vi/\(videoID)/0.jpg"
                return videoID
            }else{
                return self
            }
        }else{
            videoID = "https://img.youtube.com/vi/\(videoID)/0.jpg"
            return videoID
        }
    }
}
