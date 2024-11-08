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
        
        let manPublisher = NetworkManager.shared.fetchData(endpoint: manEndpoint, responseModel: ManModel.self)
        let nofriendPublisher = NetworkManager.shared.fetchData(endpoint: noFriendEndpoint, responseModel: FriendModel.self)
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
        
    }
    
    private func fetchFriendWithInvite() {
        
    }
}

struct PageTypeItem: Hashable {
    let title: String
    let pageType: PageTypeEnum
}
