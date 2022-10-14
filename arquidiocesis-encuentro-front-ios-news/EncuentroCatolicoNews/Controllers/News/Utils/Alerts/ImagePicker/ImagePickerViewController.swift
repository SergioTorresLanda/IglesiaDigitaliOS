//
//  ImagePickerViewController.swift
//  zeus-ios-sdk-new-social-network
//
//  Created by Miguel Angel Vicario Flores on 12/10/20.
//  Copyright © 2020 Gabriel Briseño. All rights reserved.
//

import UIKit
import Photos

open class ImagePickerViewController: ImagePickerController {
    
    //MARK: - Life cycle
    public init() {
        super.init(
            selectedAssets: [],
            configuration: ImagePickerTheme(),
            camera: UIImagePickerController.init
        )
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private struct ImagePickerTheme: ImagePickerConfigurable {

    let cancelBarButtonItem: UIBarButtonItem? = UIBarButtonItem(barButtonSystemItem: .stop, target: nil, action: nil)
    let doneBarButtonItem: UIBarButtonItem? = UIBarButtonItem(title: "Listo", style: .plain, target: nil, action: nil)
    
    let isLiveCameraViewEnabled: Bool? = false

    // MARK: - NavigationBar
    let navigationBarStyle: UIBarStyle? = .default
    let navigationBarTranslucent: Bool? = false
    let navigationBarTintColor: UIColor? =  UIColor(red: 0.10, green: 0.16, blue: 0.45, alpha: 1.00)
    let navigationBarBackgroundColor: UIColor? = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1.00)
    let photoAlbumsNavigationBarShadowColor: UIColor? = .clear

    // MARK: - NavigationBarTitle
    let navigationBarTitleFont: UIFont? = UIFont(name: "Avenir-Book", size: 15.0)
    let navigationBarTitleTintColor: UIColor? = UIColor.black
    let navigationBarTitleHighlightedColor: UIColor? = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1.00)

    // MARK: - StatusBar
    let prefersStatusBarHidden: Bool? = true
    let preferredStatusBarStyle: UIStatusBarStyle? = .lightContent
    let preferredStatusBarUpdateAnimation: UIStatusBarAnimation? = .fade

    // MARK: - ImageSelections
    let imageTagTextAttributes: [NSAttributedString.Key: Any]? = [.font : UIFont(name: "Avenir-Book", size: 15.0)!,
                                                                  .backgroundColor : UIColor(red: 0.10, green: 0.16, blue: 0.45, alpha: 1.00)]
    let selectedImageOverlayColor: UIColor? = UIColor.clear
    let allowedSelections: ImagePickerSelection? = .limit(to: 10)

    // MARK: - HintTextMargin
    let hintTextMargin: UIEdgeInsets? = .zero

    // MARK: Media Types
    var mediaType: ImagePickerMediaType? = .all

    // MARK: - Video Selections
    let videoSelectionBackgroundColor: UIColor? = nil
    let videoNormalBackgroundColor: UIColor? = nil
}

