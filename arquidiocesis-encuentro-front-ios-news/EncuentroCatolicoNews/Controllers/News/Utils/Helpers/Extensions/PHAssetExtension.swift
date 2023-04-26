////
////  PHAssetExtension.swift
////  RedSocialFramework
////
////  Created by Miguel Angel Vicario Flores on 17/12/20.
////  Copyright © 2020 Gabriel Briseño. All rights reserved.
////
//

import Photos
import UIKit

internal extension BidirectionalCollection where Iterator.Element == PHAsset {
    func getData(completion: @escaping ((_ mediaResult: [MediaData]) -> Void)) {
        MediaTemp.shared.temp.removeAll()
        let group = DispatchGroup()
        
        var url: URL?
        
        let imageOptions = PHImageRequestOptions()
        imageOptions.deliveryMode = .highQualityFormat
        imageOptions.version = .original
        
        let videoOptions = PHVideoRequestOptions()
        videoOptions.deliveryMode = .highQualityFormat
        videoOptions.version = .original
        
        self.forEach { (asset) in
            print("un asset")
            let size: CGSize = CGSize(width : 500, height : 500)
            //si es imagen
            if asset.mediaType == .image {
                group.enter()
                PHImageManager.default().requestImage(for: asset, targetSize: size, contentMode: .default, options: imageOptions,
                                                      resultHandler: { (image, info) in
                    print("sale de PH IMAGE")
                    if let image = image {
                        print("sale de if let image")
                        image.accessibilityIdentifier = "Image"
                        let media = MediaData(image: image, videoURL: nil)
                        MediaTemp.shared.temp.append(media)
                    }
                    group.leave()
                })
            }else if asset.mediaType == .video {
                //Si es video...
                print("sale de if let image .video")
                //image.accessibilityIdentifier = "Video"
                group.enter()
                PHImageManager.default().requestAVAsset(forVideo: asset, options: videoOptions) { (avAsset, avaudio, info) in
                    print("sale de if let image .video PHIMAGE")
                    if let urlAsset = avAsset as? AVURLAsset {
                        print("sale de if let image .image PHIMAGE urLASSET")
                        let localVideoUrl: URL = urlAsset.url as URL
                        url = localVideoUrl
                        let media = MediaData(image: UIImage(named: "iconVideoGif", in: Bundle.local, compatibleWith: nil)!, videoURL: url)//"play"
                        MediaTemp.shared.temp.append(media)
                    }
                    group.leave()
                }
            }else{
                print("no es ni imagen ni video")
            }
        }
        
        group.notify(queue: .main, execute: {
            completion(MediaTemp.shared.temp)
        })
    }
}
