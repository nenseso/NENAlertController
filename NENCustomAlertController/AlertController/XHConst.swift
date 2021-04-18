//
//  XHConst.swift
//  NENCustomAlertController
//
//  Created by nenseso zhou on 2021/4/18.
//

import UIKit

/// 是否横竖屏
/// 用户界面横屏了才会返回YES
var IS_LANDSCAPE: Bool {
    get {
        return UIApplication.shared.statusBarOrientation.isLandscape
    }
}

/// 屏幕宽度，会根据横竖屏的变化而变化
var SCREEN_WIDTH : CGFloat {
    get {
        UIScreen.main.bounds.width
    }
}

/// 屏幕高度，会根据横竖屏的变化而变化
var SCREEN_HEIGHT : CGFloat {
    get {
        UIScreen.main.bounds.height
    }
}

/// 屏幕宽度，跟横竖屏无关
let DEVICE_WIDTH = (IS_LANDSCAPE ? SCREEN_HEIGHT : SCREEN_WIDTH)

/// 屏幕高度，跟横竖屏无关
let DEVICE_HEIGHT = (IS_LANDSCAPE ? SCREEN_WIDTH : SCREEN_HEIGHT)

