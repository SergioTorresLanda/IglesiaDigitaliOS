//
//  SlideUpPresentation.swift
//  zeus-ios-sdk-new-social-network
//
//  Created by Miguel Angel Vicario Flores on 12/10/20.
//  Copyright © 2020 Gabriel Briseño. All rights reserved.
//

import UIKit

internal final class SlideUpPresentation: NSObject, UIViewControllerTransitioningDelegate {

    internal static let animationDuration = 0.3

    // MARK: - UIViewControllerTransitioningDelegate

    internal func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return SlideUpPresentationController(presentedViewController: presented, presenting: presenting)
    }

    internal func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SlideUpPresentingAnimator()
    }

    internal func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SlideDownDismissingAnimator()
    }

}

