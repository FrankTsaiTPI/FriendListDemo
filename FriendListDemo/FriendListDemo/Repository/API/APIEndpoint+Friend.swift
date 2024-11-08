//
//  APIEndpoint+Friend.swift
//  FriendListDemo
//
//  Created by Tsai Frank on 2024/11/7.
//

import Foundation

extension APIEndpoint {
    /// 使⽤者資料
    static var man: Self {
        APIEndpoint(path: "/man.json", apiId: "man")
    }
    
    /// 好友列表1
    static var friend1: Self {
        APIEndpoint(path: "/friend1.json", apiId: "friend1")
    }
    
    /// 好友列表2
    static var friend2: Self {
        APIEndpoint(path: "/friend2.json", apiId: "friend2")
    }
    
    /// 好友列表含邀請列表
    static var friend3: Self {
        APIEndpoint(path: "/friend3.json", apiId: "friend3")
    }
    
    /// 無資料邀請/好友列表
    static var friend4: Self {
        APIEndpoint(path: "/friend4.json", apiId: "friend4")
    }
}
