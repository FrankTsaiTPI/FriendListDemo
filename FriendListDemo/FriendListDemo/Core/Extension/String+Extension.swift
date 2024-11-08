//
//  String+Extension.swift
//  FriendListDemo
//
//  Created by Tsai Frank on 2024/11/7.
//

import Foundation

extension String {
    var toBool: Bool {
        self == "1" ? true : false
    }
    
    var toDate: Date? {
        let formatter = DateFormatter()
        formatter.timeZone = .init(identifier: "GMT")
        formatter.dateFormat = "yyyyMMdd"
        
        return formatter.date(from: self)
    }
}
