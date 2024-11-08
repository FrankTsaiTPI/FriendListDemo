//
//  FriendListViewModel.swift
//  FriendListDemo
//
//  Created by Tsai Frank on 2024/11/7.
//

import Foundation
import Combine

protocol FriendListViewModelType {
    var inputs: FriendListViewModelInputs { get }
    var outputs: FriendListViewModelOutputs { get }
}

protocol FriendListViewModelInputs {
}

protocol FriendListViewModelOutputs {
    var usersPublisher: AnyPublisher<[ManModel], Never> { get }
    var friendsPublisher: AnyPublisher<[FriendModel], Never> { get }
}

class FriendListViewModel: FriendListViewModelType, FriendListViewModelInputs, FriendListViewModelOutputs {
    var inputs: FriendListViewModelInputs { self }
    var outputs: FriendListViewModelOutputs { self }
    
    private var manSubject = CurrentValueSubject<[ManModel], Never>([])
    private var friendSubject = CurrentValueSubject<[FriendModel], Never>([])
    
    var usersPublisher: AnyPublisher<[ManModel], Never> {
        manSubject.eraseToAnyPublisher()
    }
    
    var friendsPublisher: AnyPublisher<[FriendModel], Never> {
        friendSubject.eraseToAnyPublisher()
    }
    
    init(manModel: [ManModel], friendModel: [FriendModel]) {
        manSubject.send(manModel)
        friendSubject.send(friendModel)
    }
}
