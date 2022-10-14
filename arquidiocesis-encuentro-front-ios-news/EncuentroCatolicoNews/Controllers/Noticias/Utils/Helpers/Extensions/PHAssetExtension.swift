////
////  PHAssetExtension.swift
////  RedSocialFramework
////
////  Created by Miguel Angel Vicario Flores on 17/12/20.
////  Copyright © 2020 Gabriel Briseño. All rights reserved.
////
//
//
//import Photos
//
//internal extension BidirectionalCollection where Iterator.Element == PHAsset {
//    func getData(completion: @escaping ((_ mediaResult: [MediaData]) -> Void)) {
//        MediaTemp.shared.temp.removeAll()
//        let group = DispatchGroup()
//
//        var url: URL?
//
//        let imageOptions = PHImageRequestOptions()
//        imageOptions.deliveryMode = .highQualityFormat
//        imageOptions.version = .original
//
//        let videoOptions = PHVideoRequestOptions()
//        videoOptions.deliveryMode = .highQualityFormat
//        videoOptions.version = .original
//
//        self.forEach { (asset) in
//            let size: CGSize = CGSize(width : 500, height : 500)
//            group.enter()
//            PHImageManager.default().requestImage(for: asset, targetSize: size, contentMode: .default, options: imageOptions,
//                                                  resultHandler: { (image, info) in
//                if let image = image {
//                    if asset.mediaType == .image {
//                        image.accessibilityIdentifier = "Image"
//                        let media = MediaData(image: image, videoURL: nil)
//                        MediaTemp.shared.temp.append(media)
//                    } else if asset.mediaType == .video {
//                        image.accessibilityIdentifier = "Video"
//                        group.enter()
//                        PHImageManager.default().requestAVAsset(forVideo: asset, options: videoOptions) { (avAsset, avaudio, info) in
//                            if let urlAsset = avAsset as? AVURLAsset {
//                                let localVideoUrl: URL = urlAsset.url as URL
//                                url = localVideoUrl
//                                let media = MediaData(image: image, videoURL: url)
//                                MediaTemp.shared.temp.append(media)
//                            }
//
//                            group.leave()
//                        }
//                    }
//
//
//                }
//                group.leave()
//            })
//        }
//
//        group.notify(queue: .main, execute: {
//            completion(MediaTemp.shared.temp)
//        })
//    }
//}
