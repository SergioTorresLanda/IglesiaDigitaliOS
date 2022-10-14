//
//  ModalPresentationController.swift
//  zeus-ios-sdk-new-social-network
//
//  Created by Miguel Angel Vicario Flores on 07/09/20.
//  Copyright © 2020 Gabriel Briseño. All rights reserved.
//

import UIKit

public class ModalPresentationController: UIPresentationController {
    
    //MARK: - Properties
    public let blurEffectView: UIVisualEffectView!
    public var hasSetPointOrigin = false
    public var pointOrigin: CGPoint?
    
    //MARK: - Life cycle
    override public init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        let blurEffect = UIBlurEffect(style: .dark)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.blurEffectView.isUserInteractionEnabled = true
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerAction))
        self.presentedView?.subviews.first?.addGestureRecognizer(panGesture)
        //self.presentedView?.addGestureRecognizer(panGesture)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureRecognizerAction))
        self.presentedView?.subviews.second?.addGestureRecognizer(tapGesture)
    }
  
    override public var frameOfPresentedViewInContainerView: CGRect {
        CGRect(origin: CGPoint(x: 0, y: 0),
               size: CGSize(width: self.containerView!.frame.width,
                            height: self.containerView!.frame.height))
    }
    
      override public func presentationTransitionWillBegin() {
          self.blurEffectView.alpha = 0
          self.containerView?.addSubview(blurEffectView)
          self.presentedViewController.transitionCoordinator?.animate(alongsideTransition: { (UIViewControllerTransitionCoordinatorContext) in self.blurEffectView.alpha = 0.5
          }, completion: { (UIViewControllerTransitionCoordinatorContext) in })
      }
    
      override public func dismissalTransitionWillBegin() {
          self.presentedViewController.transitionCoordinator?.animate(alongsideTransition: { (UIViewControllerTransitionCoordinatorContext) in self.blurEffectView.alpha = 0
          }, completion: { (UIViewControllerTransitionCoordinatorContext) in self.blurEffectView.removeFromSuperview()})
      }
  
    override public func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        
        presentedView!.subviews.first?.roundCorners(corners: [.layerMinXMinYCorner], radius: 80)
    }

    override public func containerViewDidLayoutSubviews() {
        super.containerViewDidLayoutSubviews()
        
        presentedView?.frame = frameOfPresentedViewInContainerView
        blurEffectView.frame = containerView!.bounds
        
        if !hasSetPointOrigin {
            hasSetPointOrigin = true
            pointOrigin = frameOfPresentedViewInContainerView.origin
        }
    }
    
    //MARK: - Methods
    @objc private func panGestureRecognizerAction(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: self.presentingViewController.view)
        guard translation.y >= 0 else { return }

        self.presentedView?.frame.origin = CGPoint(x: 0, y: (self.pointOrigin?.y ?? 0) + translation.y)

        if sender.state == .ended {
            let dragVelocity = sender.velocity(in: self.presentedView)
            if dragVelocity.y >= 500 {
                self.presentingViewController.dismiss(animated: true, completion: nil)
            } else {
                UIView.animate(withDuration: 0.3) {
                    self.presentedView?.frame.origin = self.pointOrigin ?? CGPoint(x: 0, y: 400)
                }
            }
        }
    }
    
    @objc private func tapGestureRecognizerAction(sender: UIPanGestureRecognizer) {
        self.presentingViewController.dismiss(animated: true, completion: nil)
    }
    
}
