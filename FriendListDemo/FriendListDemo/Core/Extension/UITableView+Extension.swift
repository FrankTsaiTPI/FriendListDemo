//
//  UITableView+Extension.swift
//  FriendListDemo
//
//  Created by Tsai Frank on 2024/11/12.
//

import UIKit

extension UITableViewCell: ReusableView {}
extension UITableView {
    /// Register cell
    func register<T: UITableViewCell>(_ className: T.Type) {
        self.register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
    }
}
