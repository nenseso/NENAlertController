//
//  XHAlertCustomViewController.swift
//  XingHuoWangXiao_Dev
//
//  Created by nenseso zhou on 2019/11/27.
//  Copyright © 2019 XingHuoWangXiao. All rights reserved.
//

import UIKit

class XHAlertCustomViewController: UIViewController {
    
    var customView: UIView
    
    var tapDimingViewAutoDismiss = false {
        willSet {
            if style == .alert {
                self.alertTransitionDelegate.tapDimingViewAutoDismiss = newValue
            } else if style == .actionSheet {
                self.actionSheetTransitionDelegate.tapDimingViewAutoDismiss = newValue
            }
        }
    }
    
    /// 是否响应键盘遮挡, 仅支持alert
    var shouldResponseToKeyboardFrame = false {
        willSet {
            guard style == .alert else { return }
            self.alertTransitionDelegate.shouldResponseToKeyboardFrame = newValue
        }
    }
    
    var style: Style
    
    lazy var alertTransitionDelegate: XHAlterDelegate = {
        let transitionDelegate = XHAlterDelegate()
        transitionDelegate.tapDimingViewAutoDismiss = tapDimingViewAutoDismiss
        transitionDelegate.shouldResponseToKeyboardFrame = shouldResponseToKeyboardFrame
        return transitionDelegate
    }()
    
    lazy var actionSheetTransitionDelegate: XHActionSheetDelegate = {
        let transitionDelegate = XHActionSheetDelegate()
        transitionDelegate.tapDimingViewAutoDismiss = tapDimingViewAutoDismiss
        return transitionDelegate
    }()
    
    init(customView: UIView, style: Style = .alert, tapDimingViewAutoDismiss:Bool  = false, shouldResponseToKeyboardFrame: Bool = false) {
        self.customView = customView
        self.style = style
        self.tapDimingViewAutoDismiss = tapDimingViewAutoDismiss
        self.shouldResponseToKeyboardFrame = shouldResponseToKeyboardFrame
        super.init(nibName: nil, bundle: nil)
        if style == .alert {
            self.transitioningDelegate = self.alertTransitionDelegate
        } else {
            self.transitioningDelegate = self.actionSheetTransitionDelegate
        }
        
        self.modalPresentationStyle = .custom
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(customView)
        customView.layoutIfNeeded()
        view.backgroundColor = .clear
        
        customView.translatesAutoresizingMaskIntoConstraints = false
        let topCons = NSLayoutConstraint(item: customView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 0)
        let leftCons = NSLayoutConstraint(item: customView, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1.0, constant: 0)
        let bottomCons = NSLayoutConstraint(item: customView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: 0)
        let rightCons = NSLayoutConstraint(item: customView, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1.0, constant: 0)
        view.addConstraints([topCons, leftCons, bottomCons, rightCons])
        
        self.preferredContentSize = CGSize(width: customView.bounds.width, height: customView.bounds.height)

    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if self.style == .alert {
            self.preferredContentSize = CGSize(width: size.height, height: size.width)
        } else {
            if IS_LANDSCAPE {
                let size = CGSize(width: DEVICE_WIDTH, height: customView.bounds.height)
                self.preferredContentSize = size
            } else {
                let size = CGSize(width: DEVICE_HEIGHT, height: customView.bounds.height)
                self.preferredContentSize = size
            }
        }

        super.viewWillTransition(to: self.preferredContentSize, with: coordinator)

    }

}
