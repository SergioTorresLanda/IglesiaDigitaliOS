//
//  CameraCompatible.swift
//  zeus-ios-sdk-new-social-network
//
//  Created by Miguel Angel Vicario Flores on 12/10/20.
//  Copyright © 2020 Gabriel Briseño. All rights reserved.
//

import UIKit

/// The CameraCompatible protocol defines the required interface of a customized camera view controller to use in ImagePickerController.
public protocol CameraCompatible: class {

    /// The camera view controller's delegate, which should be compatible with UIImagePickerController's delegate.
    var delegate: (UIImagePickerControllerDelegate & UINavigationControllerDelegate)? { get set }

    /// The UIImagePickerController compatible source type, which is always set to .camera before presenting.
    var sourceType: UIImagePickerController.SourceType { get set }

}

extension UIImagePickerController: CameraCompatible {}

