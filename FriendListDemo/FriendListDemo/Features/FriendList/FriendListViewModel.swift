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
    func setFriendListCellModels()
    func filterFriends(keyword: String)
}

protocol FriendListViewModelOutputs {
    var usersPublisher: AnyPublisher<[ManModel], Never> { get }
    var friendsPublisher: AnyPublisher<[FriendModel], Never> { get }
    var friendListCellModelPublisher: AnyPublisher<[FriendListCellModel], Never> { get }
}

class FriendListViewModel: FriendListViewModelType, FriendListViewModelInputs, FriendListViewModelOutputs {
    var inputs: FriendListViewModelInputs { self }
    var outputs: FriendListViewModelOutputs { self }
    
    var usersPublisher: AnyPublisher<[ManModel], Never> {
        manSubject.eraseToAnyPublisher()
    }
    
    var friendsPublisher: AnyPublisher<[FriendModel], Never> {
        friendSubject.eraseToAnyPublisher()
    }
    
    var friendListCellModelPublisher: AnyPublisher<[FriendListCellModel], Never> {
        friendListCellModelSubject.eraseToAnyPublisher()
    }
    
    private var manSubject = CurrentValueSubject<[ManModel], Never>([])
    private var friendSubject = CurrentValueSubject<[FriendModel], Never>([])
    private var friendListCellModelSubject = CurrentValueSubject<[FriendListCellModel], Never>([])
    
    init(manModel: [ManModel], friendModel: [FriendModel]) {
        manSubject.send(manModel)
        friendSubject.send(friendModel)
    }
    
    func setFriendListCellModels() {
        if friendSubject.value.isEmpty { return }
        
        let friendListCellModels: [FriendListCellModel] = friendSubject.value.map { FriendListCellModel.init(friendModel: $0) }
        friendListCellModelSubject.send(friendListCellModels)
    }
    
    func filterFriends(keyword: String) {
        if keyword.isEmpty {
            setFriendListCellModels()
            return
        }
        
        let filteredFriends = friendSubject.value.filter { $0.name.contains(keyword) }
        let friendListCellModels: [FriendListCellModel] = filteredFriends.map { FriendListCellModel.init(friendModel: $0) }
        friendListCellModelSubject.send(friendListCellModels)
    }
}
