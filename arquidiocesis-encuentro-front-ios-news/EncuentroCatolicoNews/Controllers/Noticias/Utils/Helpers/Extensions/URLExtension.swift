//
//  URLExtension.swift
//  zeus-ios-sdk-new-social-network
//
//  Created by Miguel Angel Vicario Flores on 17/12/20.
//  Copyright © 2020 Gabriel Briseño. All rights reserved.
//

import UIKit
import Photos

public extension URL {
    func getVideoThumbnail(completion: @escaping (UIImage?) -> Void) {
        DispatchQueue.global(qos: .background).async {
            let asset: AVAsset = AVAsset(url: self)
            let imageGenerator = AVAssetImageGenerator(asset: asset)
            
            do {
                let thumbnailImage = try imageGenerator.copyCGImage(at: CMTimeMake(value: 1, timescale: 60) , actualTime: nil)
                DispatchQueue.main.async {
                    completion(UIImage(cgImage: thumbnailImage))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(UIImage())
                }
            }
        }
    }
    
    func formattedURL() -> URL {
        if self.absoluteString.hasPrefix("https://") || self.absoluteString.hasPrefix("http://") {
            return self
        } else {
            if let correctedURL = URL(string: "http://\(self.absoluteString)") {
                return correctedURL
            }
            
            return self
        }
    }
}
