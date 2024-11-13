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
    func initialTableViewCellModels()
    func filterFriends(keyword: String)
}

protocol FriendListViewModelOutputs {
    var usersPublisher: AnyPublisher<[ManModel], Never> { get }
    var friendsPublisher: AnyPublisher<[FriendModel], Never> { get }
    var friendListCellModelPublisher: AnyPublisher<[FriendListCellModel], Never> { get }
    var inviteListCellModelPublisher: AnyPublisher<[InviteCellModel], Never> { get }
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
    
    var inviteListCellModelPublisher: AnyPublisher<[InviteCellModel], Never> {
        inviteListCellModelSubject.eraseToAnyPublisher()
    }
    
    private var manSubject = CurrentValueSubject<[ManModel], Never>([])
    private var friendSubject = CurrentValueSubject<[FriendModel], Never>([])
    private var friendListCellModelSubject = CurrentValueSubject<[FriendListCellModel], Never>([])
    private var inviteListCellModelSubject = CurrentValueSubject<[InviteCellModel], Never>([])
    
    init(manModel: [ManModel], friendModel: [FriendModel]) {
        manSubject.send(manModel)
        friendSubject.send(friendModel)
    }
    
    func initialTableViewCellModels() {
        setInviteListCellModels()
        setFriendListCellModels()
    }
    
    private func setInviteListCellModels() {
        let pendingFriends = friendSubject.value.filter { $0.status == .pending }
        let inviteCellModels: [InviteCellModel] = pendingFriends.map { InviteCellModel.init(friendModel: $0) }
        
        inviteListCellModelSubject.send(inviteCellModels)
    }
    
    private func setFriendListCellModels() {
        if friendSubject.value.isEmpty { return }
        let friends = friendSubject.value.filter { $0.status != .pending }
        let friendListCellModels: [FriendListCellModel] = friends.map { FriendListCellModel.init(friendModel: $0) }
        
        friendListCellModelSubject.send(friendListCellModels)
    }
    
    func filterFriends(keyword: String) {
        if keyword.isEmpty {
            setFriendListCellModels()
            return
        }
        
        let friends = friendSubject.value.filter { $0.status != .pending }
        let filteredFriends = friends.filter { $0.name.contains(keyword) }
        let friendListCellModels: [FriendListCellModel] = filteredFriends.map { FriendListCellModel.init(friendModel: $0) }
        
        friendListCellModelSubject.send(friendListCellModels)
    }
}
