//
//  NetworkError.swift
//  FriendListDemo
//
//  Created by Tsai Frank on 2024/11/8.
//

enum NetworkError: Error {
    case invalidResponse
    case statusCodeError(Int)
    case decodingError(Error)
}

