//
//  SlideUpPresentingAnimator.swift
//  zeus-ios-sdk-new-social-network
//
//  Created by Miguel Angel Vicario Flores on 12/10/20.
//  Copyright © 2020 Gabriel Briseño. All rights reserved.
//

import UIKit

internal final class SlideUpPresentingAnimator: NSObject, UIViewControllerAnimatedTransitioning {

    // MARK: - UIViewControllerAnimatedTransitioning

    internal func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return SlideUpPresentation.animationDuration
    }

    internal func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toViewController = transitionContext.viewController(forKey: .to) else {
            return
        }

        let containerView = transitionContext.containerView
        let targetFrame = containerView.bounds
        toViewController.view.frame = targetFrame

        // Create a snapshot view for transition animation.
        let snapshotView = toViewController.view.snapshotView(afterScreenUpdates: true)
        let presentedView: UIView = snapshotView ?? toViewController.view

        presentedView.frame = targetFrame.offsetBy(dx: 0, dy: targetFrame.height)
        containerView.addSubview(presentedView)

        UIView.animate(
            withDuration: transitionDuration(using: transitionContext),
            delay: 0,
            options: .curveEaseInOut,
            animations: {
                presentedView.frame = targetFrame
            }, completion: { _ in
                snapshotView?.removeFromSuperview()
                containerView.addSubview(toViewController.view)
                transitionContext.completeTransition(true)
            })
    }

}

