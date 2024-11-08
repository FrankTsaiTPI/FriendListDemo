//
//  APIEndpoint.swift
//  FriendListDemo
//
//  Created by Tsai Frank on 2024/11/7.
//

import Foundation

let scheme = "https"
let host = "dimanyen.github.io"
let port = 0

struct APIEndpoint {
    var path: String
    var queryItems: [URLQueryItem] = []
    var apiId: String
    
    var url: URL {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path
        
        if port != 0 {
            components.port = port
        }
        
        if self.queryItems.count > 0 {
            components.queryItems = self.queryItems
        }

        guard let url = components.url else {
            preconditionFailure(
                "[DEVELOPE]: Invalid URL components: \(components)"
            )
        }

        return url
    }
}
