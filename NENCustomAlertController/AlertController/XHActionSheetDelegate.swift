//
//  XHActionSheetDelegate.swift
//  XingHuoWangXiao_Dev
//
//  Created by nenseso zhou on 2019/12/18.
//  Copyright © 2019 XingHuoWangXiao. All rights reserved.
//

import UIKit

class XHActionSheetDelegate: NSObject {
    /// 点击阴影是否消失
    var tapDimingViewAutoDismiss = true
}

extension XHActionSheetDelegate: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return XHActionSheetAnimator()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return XHActionSheetAnimator()
    }
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let presentationController = XHActionSheetPresentationController(presentedViewController: presented, presenting: presenting)
        presentationController.tapDimingViewAutoDismiss = tapDimingViewAutoDismiss
        return presentationController
    }
}

class XHActionSheetAnimator: NSObject { }

extension XHActionSheetAnimator : UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.2
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromVC = transitionContext.viewController(forKey: .from)
        let toVC = transitionContext.viewController(forKey: .to)
        var fromView : UIView?
        var toView : UIView?
        if let from = transitionContext.view(forKey: .from) {
            fromView = from
        } else {
            fromView = fromVC?.view
        }
        if let to = transitionContext.view(forKey: .to) {
            toView = to
        } else {
            toView = toVC?.view
        }
        
        guard let isPresenting =  toVC?.isBeingPresented else { return }
        if let toView = toView, let fromView = fromView {
            
            if isPresenting {
                transitionContext.containerView.addSubview(toView)
                let finalFrame = toView.frame
                let initialFrame = finalFrame.offsetBy(dx: 0, dy: finalFrame.height)
                toView.frame = initialFrame
                UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
                    toView.frame = finalFrame
                }) { (finished) in
                    let wasCancelled = transitionContext.transitionWasCancelled
                    if wasCancelled {
                        toView.removeFromSuperview()
                    }
                    transitionContext.completeTransition(!wasCancelled)
                }
                
            } else {
                UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
                    fromView.frame = fromView.frame.offsetBy(dx: 0, dy: fromView.frame.height)
                }) { (finished) in
                    let wasCancelled = transitionContext.transitionWasCancelled

                    transitionContext.completeTransition(!wasCancelled)
                }
            }
            
        }

    }

}
