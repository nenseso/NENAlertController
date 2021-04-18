//
//  MyCustomView1.swift
//  NENCustomAlertController
//
//  Created by nenseso zhou on 2021/4/18.
//

import UIKit

class MyCustomView1: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        self.backgroundColor = .lightGray
        
        let label = UILabel()
        label.text = "I'm a custom view"
        label.textAlignment = .center
        addSubview(label)
        label.frame = bounds
        
        layer.cornerRadius = 10
        layer.masksToBounds = true
    }

}
