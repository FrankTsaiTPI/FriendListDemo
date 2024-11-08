//
//  FriendListViewController.swift
//  FriendListDemo
//
//  Created by Tsai Frank on 2024/11/7.
//

import UIKit

class FriendListViewController: BaseViewController {

    private let viewModel: FriendListViewModel
    
    init(viewModel: FriendListViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func setupLayout() {
        view.backgroundColor = .white
    }
    
    override func bindUI() {
        
    }
    
    override func bindViewModel() {
        viewModel.outputs.usersPublisher.sink { manModel in
            print(" MAN : \(manModel)")
        }.store(in: &cancellables)
        
        viewModel.outputs.friendsPublisher.sink { friendModel in
            print(" Friend : \(friendModel)")
        }.store(in: &cancellables)
    }
}
