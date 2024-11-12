//
//  UIView+Extension.swift
//  FriendListDemo
//
//  Created by Tsai Frank on 2024/11/12.
//

import UIKit

public protocol ReusableView {
    static var reuseIdentifier: String { get }
}

extension ReusableView where Self: UIView {
    public static var reuseIdentifier: String {
        String(describing: self)
    }
}
