//
//  SlideUpPresentationController.swift
//  zeus-ios-sdk-new-social-network
//
//  Created by Miguel Angel Vicario Flores on 12/10/20.
//  Copyright © 2020 Gabriel Briseño. All rights reserved.
//

import UIKit

internal final class SlideUpPresentationController: UIPresentationController {

    override func presentationTransitionWillBegin() {
        adjustContainerFrame()
    }

    // MARK: - UITraitEnvironment

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        if previousTraitCollection != nil {
            // Update the frame for the container view after device rotation.
            adjustContainerFrame()
        }
    }

    // MARK: - Private

    private func adjustContainerFrame() {
        // Calculate the presented frame that doesn't cover the navigation bar.
        let targetFrame: CGRect

        if let navigationBar = presentingViewController.view.subviews.filter({ $0 is UINavigationBar }).first {
            targetFrame = presentingViewController.view.frame.divided(atDistance: navigationBar.frame.maxY, from: .minYEdge).remainder
        } else {
            targetFrame = presentingViewController.view.frame
        }

        containerView?.frame = targetFrame
    }

}

