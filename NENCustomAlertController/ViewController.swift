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
        let customView = MyCustomView1(frame: CGRect(x: 0, y: 0, width: 200, height: 30))
        
        let customAlertController = XHAlertCustomViewController(customView: customView, style: .alert, tapDimingViewAutoDismiss: true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.present(customAlertController, animated: true, completion: nil)
        }
    }
    
}

