//
//  PhotoDetailViewController.swift
//  zeus-ios-sdk-new-social-network
//
//  Created by Miguel Angel Vicario Flores on 12/10/20.
//  Copyright © 2020 Gabriel Briseño. All rights reserved.
//

import UIKit
import Photos

internal final class PhotoDetailViewController: UIViewController {

    internal init(asset: PHAsset) {
        self.asset = asset
        super.init(nibName: nil, bundle: Bundle.local)
    }

    required init?(coder aDecoder: NSCoder) {
        self.asset = PHAsset()
        super.init(coder: aDecoder)
    }

    private let asset: PHAsset
    private let imageView = UIImageView()
    private var imageRequestID: PHImageRequestID?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        imageView.frame = view.bounds
        imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        imageView.contentMode = .scaleAspectFill
        view.addSubview(imageView)

        let imageSize = CGSize(
            width: view.bounds.height * UIScreen.main.scale,
            height: view.bounds.height * UIScreen.main.scale
        )

        let options = PHImageRequestOptions()
        options.isNetworkAccessAllowed = true

        imageRequestID = PHCachingImageManager.default().requestImage(
            for: asset,
            targetSize: imageSize,
            contentMode: .aspectFill,
            options: options
        ) { [weak self] image, _ in
            self?.imageView.image = image
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        imageRequestID.map(PHCachingImageManager.default().cancelImageRequest)
    }

}
