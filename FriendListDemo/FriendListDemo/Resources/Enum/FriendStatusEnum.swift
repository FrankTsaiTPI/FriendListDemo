//
//  FriendStatusEnum.swift
//  FriendListDemo
//
//  Created by Tsai Frank on 2024/11/7.
//

import Foundation

enum FriendStatusEnum {
    /// 邀請送出
    case invited
    /// 已完成
    case accepted
    /// 邀請中
    case pending
    /// 無
    case none
    
    init(with statusCode: Int) {
        switch statusCode {
        case 0:
            self = .invited
        case 1:
            self = .accepted
        case 2:
            self = .pending
        default:
            self = .none
        }
    }
}
