//
//  FriendListCellModel.swift
//  FriendListDemo
//
//  Created by Tsai Frank on 2024/11/11.
//

import UIKit

class FriendListCellModel: BaseTableViewCellModel, Hashable {
    override var cellIdentifier: UITableViewCell.Type {
        FriendListCell.self
    }
    
    let friendModel: FriendModel
    
    init(friendModel: FriendModel) {
        self.friendModel = friendModel
    }
    
    static func == (lhs: FriendListCellModel, rhs: FriendListCellModel) -> Bool {
        return lhs.friendModel == rhs.friendModel
    }
    func hash(into hasher: inout Hasher) { hasher.combine(friendModel)
    }
}
