//
//  ImagePickerControllerDelegate.swift
//  zeus-ios-sdk-new-social-network
//
//  Created by Miguel Angel Vicario Flores on 12/10/20.
//  Copyright © 2020 Gabriel Briseño. All rights reserved.
//

import UIKit
import Photos

/// The ImagePickerControllerDelegate protocol defines methods that interact with the image picker interface.
/// The delegate is responsible for dismissing the picker when the operation completes.
@objc
public protocol ImagePickerControllerDelegate: UINavigationControllerDelegate {

    /// Asks the delegate if the image picker should launch camera with certain permission status.
    func imagePickerController(_ picker: ImagePickerController, shouldLaunchCameraWithAuthorization status: AVAuthorizationStatus) -> Bool

    /// Tells the delegate that picker has finished launching camera with an array of selected assets
    @objc optional func imagePickerController(_ picker: ImagePickerController, didFinishLaunchingCameraWith assets: [PHAsset])

    /// Tells the delegate that the user picked image assets.
    func imagePickerController(_ picker: ImagePickerController, didFinishPickingImageAssets assets: [PHAsset])

    /// Tells the delegate that the user cancelled the pick operation.
    func imagePickerControllerDidCancel(_ picker: ImagePickerController)

    /// Optional. Asks the delegate for the photo album list to display. The image picker shows the camera roll and non-smart albums if not implemented.
    @objc optional func photoAlbumsForImagePickerController(_ picker: ImagePickerController) -> [PHFetchResult<PHAssetCollection>]

    /// Optional. Asks the delegate for the transitioning delegate for presenting the album list. The default transition is used if not implemented.
    @objc optional func imagePickerController(_ picker: ImagePickerController, transitioningDelegateForPresentingAlbumsViewController controller: UIViewController) -> UIViewControllerTransitioningDelegate

    /// Optional. Asks the delegate for the flag to enable the done bar button item based on the selected assets. The default behaviour `isEnabled = !assets.isEmpty`.
    @objc optional func imagePickerController(_ picker: ImagePickerController, shouldEnableDoneBarButtonItemWithSelected assets: [PHAsset]) -> Bool

    /// Optional. Tells the delegate that the user selected an image asset.
    @objc optional func imagePickerController(_ picker: ImagePickerController, didSelectImageAsset asset: PHAsset)

    /// Optional. Tells the delegate that the user deselected an image asset.
    @objc optional func imagePickerController(_ picker: ImagePickerController, didDeselectImageAsset asset: PHAsset)
}

