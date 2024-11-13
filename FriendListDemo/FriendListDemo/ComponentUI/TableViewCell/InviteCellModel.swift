//
//  InviteCellModel.swift
//  FriendListDemo
//
//  Created by Tsai Frank on 2024/11/12.
//

import UIKit
import Combine

class InviteCellModel: BaseTableViewCellModel, Hashable {
    override var cellIdentifier: UITableViewCell.Type {
        InviteCell.self
    }
    
    let friendModel: FriendModel
    let agreeButtonTappedSubject = PassthroughSubject<Void, Never>()
    let deleteButtonTappedSubject = PassthroughSubject<Void, Never>()
    
    init(friendModel: FriendModel) {
        self.friendModel = friendModel
    }
    
    static func == (lhs: InviteCellModel, rhs: InviteCellModel) -> Bool {
        return lhs.friendModel == rhs.friendModel
    }
    
    func hash(into hasher: inout Hasher) { hasher.combine(friendModel)
    }
    
    func agreeButtonTapped() {
        agreeButtonTappedSubject.send(())
    }
    
    func deleteButtonTapped() {
        deleteButtonTappedSubject.send(())
    }
}
