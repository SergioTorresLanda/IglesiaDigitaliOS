//
//  Parameters.swift
//  zeus-ios-sdk-new-social-network
//
//  Created by Miguel Angel Vicario Flores on 12/10/20.
//  Copyright © 2020 Gabriel Briseño. All rights reserved.
//

import UIKit

/// A struct with placeholders that `ImagePickerConfigurable` requires.
public struct ImagePickerParameters: ImagePickerConfigurable {

    /// Returns a configuration instance with default parameters.
    public init() {}

    // MARK: - Navigation Item

    /// A custom bar button item displayed on the left (or leading) edge of the navigation bar when the receiver is the top navigation item.
    public var cancelBarButtonItem: UIBarButtonItem?

    /// A custom bar button item displayed on the right (or trailing) edge of the navigation bar when the receiver is the top navigation item.
    public var doneBarButtonItem: UIBarButtonItem?

    // MARK: - Navigation Bar

    /// The navigation bar style that specifies its appearance.
    public var navigationBarStyle: UIBarStyle?

    /// A Boolean value indicating whether the navigation bar is translucent.
    public var navigationBarTranslucent: Bool?

    /// The tint color to apply to the navigation items and bar button items.
    public var navigationBarTintColor: UIColor?

    /// The navigation bar background color (barTintColor).
    public var navigationBarBackgroundColor: UIColor?

    /// The color of navigation bar 1px shadow when the album list is presented.
    public var photoAlbumsNavigationBarShadowColor: UIColor?

    // MARK: - Navigation Bar Title View

    /// The font for the navigation title view.
    public var navigationBarTitleFont: UIFont?

    /// The tint color of the the navigation title view.
    public var navigationBarTitleTintColor: UIColor?

    /// The background color of the navigation title view when selected.
    public var navigationBarTitleHighlightedColor: UIColor?

    // MARK: - Status Bar

    /// Specifies whether ImagePickerController prefers the status bar to be hidden or shown.
    public var prefersStatusBarHidden: Bool?

    /// The preferred status bar style for ImagePickerController.
    public var preferredStatusBarStyle: UIStatusBarStyle?

    /// Specifies the animation style to use for hiding and showing the status bar for ImagePickerController.
    public var preferredStatusBarUpdateAnimation: UIStatusBarAnimation?

    // MARK: - Image Selections

    /// The text attributes for the tag on selected images.
    public var imageTagTextAttributes: [NSAttributedString.Key: Any]?

    /// The overlay mask color on selected images.
    public var selectedImageOverlayColor: UIColor?

    /// Specifies the number of photo selections is allowed in ImagePickerController.
    public var allowedSelections: ImagePickerSelection?

    // MARK: - Hint Label

    /// The margin for the text of the hint label.
    public var hintTextMargin: UIEdgeInsets?

    // MARK: - Live Camera View

    /// Specifies whether the camera button shows a live preview.
    public var isLiveCameraViewEnabled: Bool?

    // MARK: - Media Types

    /// Specifies the supported media types
    public var mediaType: ImagePickerMediaType?

    // MARK: - Video Selections

    /// Selected background color for video type cell
    public var videoSelectionBackgroundColor: UIColor?

    /// Normal background color for video type cell
    public var videoNormalBackgroundColor: UIColor?
}

