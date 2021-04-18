//
//  XHActionSheetPresentationController.swift
//  XingHuoWangXiao_Dev
//
//  Created by nenseso zhou on 2019/12/18.
//  Copyright © 2019 XingHuoWangXiao. All rights reserved.
//

import UIKit

class XHActionSheetPresentationController: UIPresentationController {
    var dimmingView : UIView?
       
    var tapDimingViewAutoDismiss = true


    override func presentationTransitionWillBegin() {
       
        presentedView?.layer.cornerRadius = 12

        dimmingView = UIView.init(frame: self.containerView?.bounds ?? CGRect.zero)
        if let dimmingView = dimmingView {
        dimmingView.backgroundColor = .black
        dimmingView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        let tapGes = UITapGestureRecognizer(target: self, action: #selector(tapAction(_:)))
           
        dimmingView.addGestureRecognizer(tapGes)
        containerView?.addSubview(dimmingView)
        let transitionCoordinator = self.presentingViewController.transitionCoordinator
        dimmingView.alpha = 0.0
        transitionCoordinator?.animate(alongsideTransition: { (context) in
           dimmingView.alpha = 0.5
           }, completion: nil)
        }

    }

    override func presentationTransitionDidEnd(_ completed: Bool) {
       if completed == false {
           dimmingView = nil
       }
    }

    override func dismissalTransitionWillBegin() {
       let transitionCoordinator = self.presentingViewController.transitionCoordinator
       transitionCoordinator?.animate(alongsideTransition: { (context) in
           self.dimmingView?.alpha = 0.0
       }, completion: nil)
    }

    override func dismissalTransitionDidEnd(_ completed: Bool) {
       if completed == true {
           dimmingView = nil
       }
    }
    
    // MARK: - Action
    @objc func tapAction(_ sender: Any) {
        if tapDimingViewAutoDismiss == true {
            presentingViewController.dismiss(animated: true, completion: nil)
        }
    }


    // MARK: -Layout
    override func preferredContentSizeDidChange(forChildContentContainer container: UIContentContainer) {
       super.preferredContentSizeDidChange(forChildContentContainer: container)
       
       if container === presentedViewController {
           containerView?.setNeedsLayout()
       }
    }

    override func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
       if container === presentedViewController {
           return (container as! UIViewController).preferredContentSize
       } else {
           return super.size(forChildContentContainer: container, withParentContainerSize: parentSize)
       }
    }


    override var frameOfPresentedViewInContainerView: CGRect {
       
       let size = self.presentedViewController.preferredContentSize
       let bounds = (self.presentedViewController.traitCollection.verticalSizeClass == .regular) ? CGRect(x: 0, y: 0, width: DEVICE_WIDTH, height: DEVICE_HEIGHT) : CGRect(x: 0, y: 0, width: DEVICE_HEIGHT, height: DEVICE_WIDTH)
       let containerBounds = containerView?.bounds ?? bounds
       return CGRect(x: (containerBounds.width - size.width) * 0.5, y: containerBounds.height - size.height, width: size.width, height: size.height)
    }

    override func containerViewWillLayoutSubviews() {
       super.containerViewWillLayoutSubviews()
       if let dimmingView = dimmingView {
           dimmingView.frame = containerView?.bounds ?? CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
       }
       presentedView?.frame = frameOfPresentedViewInContainerView
    }
}
