//
//  InitialViewModel.swift
//  FriendListDemo
//
//  Created by Tsai Frank on 2024/11/7.
//

import Foundation
import Combine

protocol InitialViewModelType {
    var inputs: InitialViewModelInputs { get }
    var outputs: InitialViewModelOutputs { get }
}

protocol InitialViewModelInputs {
    func fetchPageTypeItems()
    func fetchFriendList(pageType: PageTypeEnum)
}

protocol InitialViewModelOutputs {
    var pageTypeItemsPublisher: AnyPublisher<[PageTypeItem], Never>  { get }
    var pageTypeItemValue: [PageTypeItem] { get }
    var manAndFriendPublisher: AnyPublisher<([ManModel], [FriendModel]), Never> { get }
    var errorPublisher: AnyPublisher<Error, Never> { get }
}

class InitialViewModel: InitialViewModelType, InitialViewModelInputs, InitialViewModelOutputs {
    var inputs: InitialViewModelInputs { self }
    var outputs: InitialViewModelOutputs { self }
    
    var pageTypeItemsPublisher: AnyPublisher<[PageTypeItem], Never> {
        return pageTypeItems.eraseToAnyPublisher()
    }
    
    var pageTypeItemValue: [PageTypeItem] {
        pageTypeItems.value
    }
    
    var manAndFriendPublisher: AnyPublisher<([ManModel], [FriendModel]), Never> {
        return manAndFriendSubject.eraseToAnyPublisher()
    }
    
    var errorPublisher: AnyPublisher<Error, Never> {
        return errorSubject.eraseToAnyPublisher()
    }
    
    private var pageTypeItems = CurrentValueSubject<[PageTypeItem], Never>([])
    private var manAndFriendSubject = PassthroughSubject<([ManModel], [FriendModel]), Never>()
    private var errorSubject = PassthroughSubject<Error, Never>()
    private var cancellables = Set<AnyCancellable>()
    private var networkManager: NetworkManager
    
    init(networkManager: NetworkManager = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func fetchPageTypeItems() {
        let noFriend = PageTypeItem(title: "無好友", pageType: .NoFriend)
        let friendWithoutInvite = PageTypeItem(title: "好友列表無邀請", pageType: .FriendWithoutInvite)
        let friendWithInvite = PageTypeItem(title: "好友列表含邀請好友", pageType: .FriendWithInvite)
        
        pageTypeItems.send([noFriend, friendWithoutInvite, friendWithInvite])
    }
    
    func fetchFriendList(pageType: PageTypeEnum) {
        switch pageType {
        case .NoFriend:
            fetchNoFirend()
        case .FriendWithoutInvite:
            fetchFriendWithoutInvite()
        case .FriendWithInvite:
            fetchFriendWithInvite()
        }
    }
    
    private func fetchNoFirend() {
        let manEndpoint: APIEndpoint = .man
        let noFriendEndpoint: APIEndpoint = .friend4
        
        let manPublisher = networkManager.fetchData(endpoint: manEndpoint, responseModel: ManModel.self)
        let nofriendPublisher = networkManager.fetchData(endpoint: noFriendEndpoint, responseModel: FriendModel.self)
        Publishers.Zip(manPublisher, nofriendPublisher)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.errorSubject.send(error)
                case .finished:
                    break
                }
            }, receiveValue: { manModel, friendModel in
                self.manAndFriendSubject.send((manModel, friendModel))
            }).store(in: &cancellables)
    }
    
    private func fetchFriendWithoutInvite() {
        let manEndpoint: APIEndpoint = .man
        let friend1Endpoint: APIEndpoint = .friend1
        let friend2Endpoint: APIEndpoint = .friend2
        
        let manPublisher = networkManager.fetchData(endpoint: manEndpoint, responseModel: ManModel.self)
        let friend1Publisher = networkManager.fetchData(endpoint: friend1Endpoint, responseModel: FriendModel.self)
        let friend2Publisher = networkManager.fetchData(endpoint: friend2Endpoint, responseModel: FriendModel.self)
        
        Publishers.Zip3(manPublisher, friend1Publisher, friend2Publisher)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    self.errorSubject.send(error)
                case .finished:
                    break
                }
            } receiveValue: { manModel, friend1Model, friend2Model in
                let combinedFriendModel = friend1Model + friend2Model
                var removeDuplicated = Dictionary(combinedFriendModel.map { ($0.fid, $0) }) { lhs, rhs in
                    return lhs.updateDate > rhs.updateDate ? lhs : rhs
                }.map { $0.value }
                
                removeDuplicated.sort { lhs, rhs in
                    return lhs.fid < rhs.fid
                }
                self.manAndFriendSubject.send((manModel, removeDuplicated))
            }.store(in: &cancellables)
    }
    
    private func fetchFriendWithInvite() {
        let manEndpoint: APIEndpoint = .man
        let friendWithInviteEndpoint: APIEndpoint = .friend3
        
        let manPublisher = networkManager.fetchData(endpoint: manEndpoint, responseModel: ManModel.self)
        let friendWithInvitePublisher = networkManager.fetchData(endpoint: friendWithInviteEndpoint, responseModel: FriendModel.self)
        Publishers.Zip(manPublisher, friendWithInvitePublisher)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.errorSubject.send(error)
                case .finished:
                    break
                }
            }, receiveValue: { manModel, friendModel in
                self.manAndFriendSubject.send((manModel, friendModel))
            }).store(in: &cancellables)
    }
}

struct PageTypeItem: Hashable {
    let title: String
    let pageType: PageTypeEnum
}
