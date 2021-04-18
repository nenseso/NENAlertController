//
//  XHAlterDelegate.swift
//  XingHuoWangXiao
//
//  Created by nenseso zhou on 2019/9/3.
//  Copyright © 2019 XingHuoWangXiao. All rights reserved.
//

import UIKit

enum Style : Int {

    case actionSheet
    
    case alert
}

class XHAlterDelegate: NSObject {
    /// 点击阴影是否消失
    var tapDimingViewAutoDismiss = true
    /// 是否响应键盘遮挡
    var shouldResponseToKeyboardFrame = false
    
}

extension XHAlterDelegate: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return XHAlterAnimator()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return XHAlterAnimator()
    }
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let presentationController = XHAlertPresentationContoller(presentedViewController: presented, presenting: presenting)
        presentationController.tapDimingViewAutoDismiss = tapDimingViewAutoDismiss
        presentationController.shouldResponseToKeyboardFrame = shouldResponseToKeyboardFrame
        return presentationController
    }
}

class XHAlterAnimator: NSObject { }

extension XHAlterAnimator : UIViewControllerAnimatedTransitioning {
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
                toView.alpha = 0
                UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
                    toView.alpha = 1
                }) { (finished) in
                    let wasCancelled = transitionContext.transitionWasCancelled
                    if wasCancelled {
                        toView.removeFromSuperview()
                    }
                    transitionContext.completeTransition(!wasCancelled)
                }
                
            } else {
                UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
                    fromView.alpha = 0
                }) { (finished) in
                    let wasCancelled = transitionContext.transitionWasCancelled
                    transitionContext.completeTransition(!wasCancelled)
                }
            }
            
        }

    }

}
