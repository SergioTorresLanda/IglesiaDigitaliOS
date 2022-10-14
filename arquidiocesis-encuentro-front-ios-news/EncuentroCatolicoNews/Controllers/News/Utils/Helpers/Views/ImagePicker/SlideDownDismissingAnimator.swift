//
//  SlideDownDismissingAnimator.swift
//  zeus-ios-sdk-new-social-network
//
//  Created by Miguel Angel Vicario Flores on 12/10/20.
//  Copyright © 2020 Gabriel Briseño. All rights reserved.
//

import UIKit

internal final class SlideDownDismissingAnimator: NSObject, UIViewControllerAnimatedTransitioning {

    // MARK: - UIViewControllerAnimatedTransitioning

    internal func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return SlideUpPresentation.animationDuration
    }

    internal func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromViewController = transitionContext.viewController(forKey: .from) else {
            return
        }

        let currentFrame = fromViewController.view.frame
        let finalFrame = currentFrame.offsetBy(dx: 0, dy: currentFrame.height)

        // Create a snapshot view for transition animation.
        let containerView = transitionContext.containerView
        let snapshotView = fromViewController.view.snapshotView(afterScreenUpdates: true)
        let presentedView: UIView = snapshotView ?? fromViewController.view

        fromViewController.view.removeFromSuperview()
        presentedView.frame = currentFrame
        containerView.addSubview(presentedView)

        UIView.animate(
            withDuration: transitionDuration(using: transitionContext),
            delay: 0,
            options: .curveEaseInOut,
            animations: {
                presentedView.frame = finalFrame
            }, completion: { _ in
                presentedView.removeFromSuperview()
                transitionContext.completeTransition(true)
            })
    }

}

