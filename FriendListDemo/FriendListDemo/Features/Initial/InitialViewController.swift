//
//  InitialViewController.swift
//  FriendListDemo
//
//  Created by Tsai Frank on 2024/11/7.
//

import UIKit
import CombineDataSources

class InitialViewController: BaseViewController {
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        return tableView
    }()
    
    var viewModel: InitialViewModelType = InitialViewModel()
    
    init(viewModel: InitialViewModelType, tableView: UITableView? = nil) {
        super.init(nibName: nil, bundle: nil)
        
        self.viewModel = viewModel
        self.tableView = tableView ?? self.tableView
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.inputs.fetchPageTypeItems()
    }
    
    override func setupLayout() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.leading.trailing.top.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func bindUI() {
        tableView.didSelectRowPublisher
            .sink { [weak self] indexPath in
                guard let self = self else { return }
                
                self.showLoading()
                let selectedItem = self.viewModel.outputs.pageTypeItemValue[indexPath.row]
                self.viewModel.inputs.fetchFriendList(pageType: selectedItem.pageType)
            }.store(in: &cancellables)
    }

    override func bindViewModel() {
        viewModel.outputs.pageTypeItemsPublisher
            .receive(on: RunLoop.main)
            .bind(subscriber: tableView.rowsSubscriber(cellIdentifier: "Cell", cellType: UITableViewCell.self) { cell, indexPath, item in
                cell.textLabel?.text = item.title
            })
            .store(in: &cancellables)
        
        viewModel.outputs.manAndFriendPublisher
            .receive(on: RunLoop.main)
            .sink { [weak self] manModel, friendModel in
                guard let self = self else { return }
                
                self.dismissLoading()
                self.toNext(manModel: manModel, friendModel: friendModel)
            }.store(in: &cancellables)
        
        viewModel.outputs.errorPublisher
            .receive(on: RunLoop.main)
            .sink { [weak self] error in
                guard let self = self else { return }
                
                self.showCommonErrorAlert(message: error.localizedDescription)
            }.store(in: &cancellables)
    }
}

extension InitialViewController {
    func toNext(manModel: [ManModel], friendModel: [FriendModel]) {
        let viewModel = FriendListViewModel(manModel: manModel, friendModel: friendModel)
        let friendListViewController = FriendListViewController(viewModel: viewModel)
        navigationController?.pushViewController(friendListViewController, animated: true)
    }
}
