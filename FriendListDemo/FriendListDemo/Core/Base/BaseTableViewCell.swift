//
//  BaseTableViewCell.swift
//  FriendListDemo
//
//  Created by Tsai Frank on 2024/11/11.
//

import UIKit

protocol BaseTableViewCellProtocol {
    associatedtype Value
    func configureWith(value: Value)
}

// MARK: TableViewCell
class BaseTableViewCell: UITableViewCell, BaseTableViewCellProtocol {
    typealias Value = BaseTableViewCellModelProtocol
    
    func configureWith(value: Value) {}
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        selectionStyle = .none
        setupLayout()
    }
    
    func setupLayout() {}
}
