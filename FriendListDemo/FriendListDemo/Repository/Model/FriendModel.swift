//
//  FriendModel.swift
//  FriendListDemo
//
//  Created by Tsai Frank on 2024/11/7.
//

import Foundation

struct FriendModel: Decodable, Hashable {
    let name: String
    let status: FriendStatusEnum
    let isTop: Bool
    let fid: String
    let updateDate: Date
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case status = "status"
        case isTop = "isTop"
        case fid = "fid"
        case updateDate = "updateDate"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        
        let statusCode = try container.decode(Int.self, forKey: .status)
        status = FriendStatusEnum.init(with: statusCode)
       
        isTop = try container.decode(String.self, forKey: .isTop).toBool
        fid = try container.decode(String.self, forKey: .fid)
        updateDate = try container.decode(String.self, forKey: .updateDate).toDate
    }
}
