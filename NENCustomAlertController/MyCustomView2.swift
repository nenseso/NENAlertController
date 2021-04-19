//
//  MyCustomView2.swift
//  NENCustomAlertController
//
//  Created by nenseso zhou on 2021/4/19.
//

import UIKit

class MyCustomView2: UIView {
    
    typealias ActionClosure = (Int)->()
    
    var actionClosure: ActionClosure?
    
    static let CellReuseIdentifier = "MyCustomViewTabelviewCell"
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MyCustomView2TableViewCell.self, forCellReuseIdentifier: MyCustomView2.CellReuseIdentifier)
        return tableView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI() {
        self.backgroundColor = .white
        addSubview(tableView)
        tableView.frame = bounds
    }

}

extension MyCustomView2: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MyCustomView2.CellReuseIdentifier) as! MyCustomView2TableViewCell
        if indexPath.row == 0 {
            cell.textLabel?.text = "This is an action sheet"
        } else if indexPath.row == 1 {
            cell.textLabel?.text = "Sure"
        } else {
            cell.textLabel?.text = "Cancel"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        actionClosure?(indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
}

