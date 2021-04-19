//
//  ViewController.swift
//  NENCustomAlertController
//
//  Created by nenseso zhou on 2021/4/18.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func alertAction(_ sender: Any) {
        let customView = MyCustomView1(frame: CGRect(x: 0, y: 0, width: 200, height: 30))
        let customAlertController = XHAlertCustomViewController(customView: customView, style: .alert, tapDimingViewAutoDismiss: true)
        self.present(customAlertController, animated: true, completion: nil)
    }
    
    @IBAction func actionSheetAction(_ sender: Any) {
        let customView = MyCustomView2(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 44 * 3 + self.view.safeAreaInsets.bottom))
        customView.layoutSubviews()
        let customAlertController = XHAlertCustomViewController(customView: customView, style: .actionSheet, tapDimingViewAutoDismiss: true)
        customView.actionClosure = { [unowned self] index in
            if index == 1 {
                print("sure action!")
            } else if index == 2 {
                print("cancel action")
            }
            self.presentedViewController?.dismiss(animated: true, completion: nil)
        }

        self.present(customAlertController, animated: true, completion: nil)
    }
}

