//
//  String+Utils.swift
//  EncuentroCatolicoNewFormation
//
//  Created by Alejandro on 20/10/22.
//

import Foundation

extension String{
    func embedAndPlayYoutubeURL() -> String{
        self.contains("youtube") ? self.replacingOccurrences(of: "watch?v=", with: "embed/") + "?autoplay=1" : self
    }
    
    func embedYoutubeURL() -> String{
        self.contains("youtube") ? self.replacingOccurrences(of: "watch?v=", with: "embed/") : self
    }
    
    func getYouTubeThubnailFromURL() -> String {
        var videoID = ""
        
        videoID = self.replacingOccurrences(of: "https://www.youtube.com/watch?v=", with: "")
        
        if self.contains("&list="){
            let array = videoID.components(separatedBy: "&list=")
            if array.count > 0{
                videoID = array[0]
                videoID = "https://img.youtube.com/vi/\(videoID)/0.jpg"
                return videoID
            }
            
            return self
        }
        
        videoID = "https://img.youtube.com/vi/\(videoID)/0.jpg"
        
        return videoID
    }
}
