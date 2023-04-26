//
//  CreatePostDelegatesMethods.swift
//  zeus-ios-sdk-new-social-network
//
//  Created by Miguel Angel Vicario Flores on 12/10/20.
//  Copyright © 2020 Gabriel Briseño. All rights reserved.
//

import UIKit
import Photos

//MARK: - ImagePickerControllerDelegate
extension RedSocial_CrearPost: ImagePickerControllerDelegate {
    public func imagePickerController(_ picker: ImagePickerController, shouldLaunchCameraWithAuthorization status: AVAuthorizationStatus) -> Bool {
        return true
    }
    
    public func imagePickerController(_ picker: ImagePickerController, didFinishPickingImageAssets assets: [PHAsset]) {
        for asset in assets{
            print("RECIBIO MEDIA TYPE::::") //no trae videos :(
            print(asset.mediaType)
        }
        assets.getData { (media) in
            print("RECIBIO MEDIA::::") //no trae videos :(
            print(String(media.count))
            self.media.append(contentsOf: media)
            picker.dismiss(animated: true, completion: nil)
        }
    }
    
    public func imagePickerControllerDidCancel(_ picker: ImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}

//MARK: - LocationFinderDelegate
extension RedSocial_CrearPost: LocationFinderDelegate {
    public func saveLocation(id: String, name: String, direction: String, coordinates: CLLocationCoordinate2D, image: UIImage?) {
        let location = LocationsResult(id: id, name: name, direction: direction, coordinates: coordinates, image: image)
        self.location = location
    }
}

//MARK: - ReactionSelectorDelegate
extension RedSocial_CrearPost: FeelingsSelectorDelegate {
    public func saveFeeling(id: Int, feeling: String, image: String) {
        let feeling = FeelingsResult(id: id, feeling: feeling, image: image)
        self.feeling = feeling
    }
}

//MARK: - EditImagesDelegate
extension RedSocial_CrearPost: EditImagesDelegate {
    public func saveImages(media: [MediaData]) {
        self.media = media
    }
}
