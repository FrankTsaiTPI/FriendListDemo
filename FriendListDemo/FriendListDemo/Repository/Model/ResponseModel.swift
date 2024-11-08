//
//  ResponseModel.swift
//  FriendListDemo
//
//  Created by Tsai Frank on 2024/11/7.
//

import Foundation

struct ResponseModel<T: Decodable>: Decodable {
    let response: [T]
}
