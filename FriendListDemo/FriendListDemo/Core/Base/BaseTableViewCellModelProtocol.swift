//
//  BaseTableViewCellProtocol.swift
//  FriendListDemo
//
//  Created by Tsai Frank on 2024/11/11.
//

import UIKit

protocol BaseTableViewCellModelProtocol {
    var cellIdentifier: UITableViewCell.Type { get }
}

class BaseTableViewCellModel: BaseTableViewCellModelProtocol {
    var cellIdentifier: UITableViewCell.Type {
        BaseTableViewCell.self
    }
    
    private var internalIdentifier: String = ""
    var identifier: String {
        get {
            guard internalIdentifier.isEmpty == false else {
                internalIdentifier = String(describing: cellIdentifier) + "/" + UUID().uuidString
                return internalIdentifier
            }
            
            return internalIdentifier
        }
        set {
            internalIdentifier = newValue
        }
    }
}
