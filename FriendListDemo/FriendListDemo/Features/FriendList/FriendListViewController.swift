//
//  FriendListViewController.swift
//  FriendListDemo
//
//  Created by Tsai Frank on 2024/11/7.
//

import UIKit
import CombineDataSources
import Combine

class FriendListViewController: BaseViewController {

    private lazy var pageStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        
        return stackView
    }()
    
    // MARK: manView
    private lazy var manView: UIView = {
        let view = UIView()
        view.backgroundColor = .white_two
        
        return view
    }()
    
    private lazy var friendListStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        
        return stackView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .greyishBrown
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        
        return label
    }()
    
    private lazy var kokoIdLabel: UILabel = {
        let label = UILabel()
        label.textColor = .greyishBrown
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.text = "設定 KOKO ID"
        
        return label
    }()
    
    private lazy var userIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "iconFemaleDefault")
       
        return imageView
    }()
    
    // MARK: noFriendsView
    private lazy var noFriendsView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.isHidden = true
        
        return view
    }()
    
    private lazy var noFriendsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "imgFriendsEmpty")
       
        return imageView
    }()
    
    private lazy var noFriendsTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .greyishBrown
        label.font = UIFont.systemFont(ofSize: 21, weight: .medium)
        label.textAlignment = .center
        label.text = "就從加好友開始吧：）"
        
        return label
    }()
    
    private lazy var noFriendsMessageLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGrey
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = "與好友們一起用 KOKO 聊起來！\n還能互相收付款、發紅包喔：）"
        
        return label
    }()
    
    private lazy var noFriendsAddFriendView: GradientView = {
        let view = GradientView()
        
        return view
    }()
    
    private lazy var noFriendsAddFriendLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .center
        label.text = "加好友"
        
        return label
    }()
    
    private lazy var noFriendsAddFriendImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "iconAddFriendWhite")
       
        return imageView
    }()
    
    private lazy var setKokoIdBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        
        return view
    }()
    
    private lazy var helpFriendFindYouLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGrey
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.text = "幫助好友更快找到你？"
        
        return label
    }()
    
    private lazy var setKokoIdButton: UIButton = {
        let button = UIButton(type: .custom)
        let underLineAttribute: [NSAttributedString.Key: Any] = [
              .font: UIFont.systemFont(ofSize: 13),
              .foregroundColor: UIColor.hotPink,
              .underlineStyle: NSUnderlineStyle.single.rawValue
          ]
        let attributedString = NSMutableAttributedString(string: "設定 KOKO ID", attributes: underLineAttribute)
        
        button.setAttributedTitle(attributedString, for: .normal)
        
        return button
    }()
    
    // MARK: tabBackgroundView
    private lazy var tabBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white_two
        
        return view
    }()
    
    private lazy var tabView: TabView = {
        let tabs: [Tab] = [Tab(title: "好友", isSelected: true),
                           Tab(title: "聊天", isSelected: false)]
        let tabView = TabView(tabs: tabs)
        
        return tabView
    }()
    
    private lazy var tabBackgroundViewSeparator: UIView = {
        let view = UIView()
        view.backgroundColor = .veryLightPink
        
        return view
    }()
    
    // MARK: searchBackgroundView
    private lazy var searchBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        
        return view
    }()
    
    private lazy var searchTextFieldBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.steel.withAlphaComponent(0.12)
        view.layer.cornerRadius = 10
        
        return view
    }()
    
    private lazy var searchIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "iconSearchBarSearchGray")
        
        return imageView
    }()
    
    private lazy var searchTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "想轉一筆給誰呢？"
        textField.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        textField.textColor = .greyishBrown
        
        return textField
    }()
    
    private lazy var searchAddFriendButton: UIButton = {
        let button = UIButton(type: .custom)
        let image = UIImage(named: "iconAddFriends")
        button.setImage(image, for: .normal)
        
        return button
    }()
    
    // MARK: list
    private lazy var friendListBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white_two
        view.isHidden = true
        
        return view
    }()
    
    private lazy var friendListTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(FriendListCell.self)
        
        return tableView
    }()
    
    private lazy var invitationBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white_two
        view.isHidden = true
        
        return view
    }()
    
    private lazy var invitationTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = .clear
        tableView.register(InviteCell.self)
        
        return tableView
    }()
    
    private let viewModel: FriendListViewModel
    private var keyboardCancellables: AnyCancellable?
    
    init(viewModel: FriendListViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.inputs.initialTableViewCellModels()
    }
    
    override func setupLayout() {
        view.backgroundColor = .white
        view.addSubview(pageStackView)
        pageStackView.addArrangedSubview(manView)
        manView.addSubview(nameLabel)
        manView.addSubview(kokoIdLabel)
        manView.addSubview(userIconImageView)
        
        pageStackView.addArrangedSubview(friendListStackView)
        
        friendListStackView.addArrangedSubview(invitationBackgroundView)
        invitationBackgroundView.addSubview(invitationTableView)
        
        friendListStackView.addArrangedSubview(tabBackgroundView)
        tabBackgroundView.addSubview(tabView)
        tabBackgroundView.addSubview(tabBackgroundViewSeparator)
        
        friendListStackView.addArrangedSubview(searchBackgroundView)
        searchBackgroundView.addSubview(searchTextFieldBackgroundView)
        searchBackgroundView.addSubview(searchAddFriendButton)
        searchTextFieldBackgroundView.addSubview(searchIconImageView)
        searchTextFieldBackgroundView.addSubview(searchTextField)
        
        friendListStackView.addArrangedSubview(friendListBackgroundView)
        friendListBackgroundView.addSubview(friendListTableView)
        
        friendListStackView.addArrangedSubview(noFriendsView)
        noFriendsView.addSubview(noFriendsImageView)
        noFriendsView.addSubview(noFriendsTitleLabel)
        noFriendsView.addSubview(noFriendsMessageLabel)
        noFriendsView.addSubview(noFriendsAddFriendView)
        noFriendsAddFriendView.addSubview(noFriendsAddFriendLabel)
        noFriendsAddFriendView.addSubview(noFriendsAddFriendImageView)
        noFriendsView.addSubview(setKokoIdBackgroundView)
        setKokoIdBackgroundView.addSubview(helpFriendFindYouLabel)
        setKokoIdBackgroundView.addSubview(setKokoIdButton)
        
        pageStackView.snp.makeConstraints {
            $0.leading.trailing.top.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        // manView
        manView.snp.makeConstraints {
            $0.height.equalTo(54)
        }
        
        nameLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(30)
            $0.top.equalToSuperview().inset(8)
            $0.trailing.equalTo(userIconImageView.snp.leading).offset(30)
        }
        
        kokoIdLabel.snp.makeConstraints {
            $0.leading.equalTo(nameLabel.snp.leading)
            $0.top.equalTo(nameLabel.snp.bottom).offset(8)
        }
        
        userIconImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(30)
            $0.height.width.equalTo(54)
        }
        
        // invitationView
        invitationBackgroundView.snp.makeConstraints {
            $0.height.equalTo(175)
        }
        
        invitationTableView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(25)
            $0.bottom.equalToSuperview().inset(10)
            $0.leading.trailing.equalToSuperview().inset(30)
        }
        
        // tabView
        tabBackgroundView.snp.makeConstraints {
            $0.height.equalTo(40)
        }
        
        tabView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(32)
            $0.trailing.top.bottom.equalToSuperview()
        }
        
        tabBackgroundViewSeparator.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        // searchBackgroundView
        searchBackgroundView.snp.makeConstraints {
            $0.height.equalTo(61)
        }
        
        searchTextFieldBackgroundView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(30)
            $0.trailing.equalTo(searchAddFriendButton.snp.leading).offset(-15)
            $0.height.equalTo(36)
        }
        
        searchAddFriendButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(30)
            $0.height.width.equalTo(24)
        }
        
        searchIconImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(10)
            $0.height.width.equalTo(14)
        }
        
        searchTextField.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(searchIconImageView.snp.trailing).offset(8)
            $0.trailing.equalToSuperview().inset(20)
        }
        
        // noFriendsView
        noFriendsImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(30)
            $0.height.equalTo(172)
            $0.width.equalTo(245)
        }
        
        noFriendsTitleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(noFriendsImageView.snp.bottom).offset(41)
            $0.leading.trailing.equalToSuperview().inset(44)
        }
        
        noFriendsMessageLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(noFriendsTitleLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(68)
        }
        
        noFriendsAddFriendView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(noFriendsMessageLabel.snp.bottom).offset(25)
            $0.width.equalTo(192)
            $0.height.equalTo(40)
        }
        
        noFriendsAddFriendLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.trailing.equalTo(noFriendsAddFriendImageView.snp.leading).offset(16)
        }
        
        noFriendsAddFriendImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(8)
            $0.height.width.equalTo(24)
        }
        
        setKokoIdBackgroundView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(noFriendsAddFriendView.snp.bottom).offset(37)
        }
        
        helpFriendFindYouLabel.snp.makeConstraints {
            $0.leading.top.bottom.equalToSuperview()
        }
        
        setKokoIdButton.snp.makeConstraints {
            $0.leading.equalTo(helpFriendFindYouLabel.snp.trailing).offset(5)
            $0.trailing.top.bottom.equalToSuperview()
        }
        
        friendListTableView.snp.makeConstraints {
            $0.leading.trailing.top.bottom.equalToSuperview()
        }
    }
    
    override func bindUI() {
        keyboardCancellables = handleKeyboardNotifications()
        keyboardStatusSubject
            .dropFirst()
            .sink { [weak self] height in
                guard let self = self else { return }
                
                self.pageStackView.snp.remakeConstraints {
                    $0.leading.trailing.top.equalTo(self.view.safeAreaLayoutGuide)
                    $0.bottom.equalToSuperview().inset(height)
                }
            }.store(in: &cancellables)
        
        searchAddFriendButton.tapPublisher
            .receive(on: RunLoop.main)
            .sink { button in
                print("searchAddFriendButton tapped")
            }.store(in: &cancellables)
        
        tabView.tabSelectedPublisher.sink { tabTag in
            print("selected tab: \(tabTag)")
        }.store(in: &cancellables)
        
        noFriendsAddFriendView.tapViewSubject.sink {
            print("noFriendsAddFriendView tapped")
        }.store(in: &cancellables)
        
        searchTextField.textPublisher
            .dropFirst()
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] text in
                guard let self = self else { return }
                
                self.viewModel.inputs.filterFriends(keyword: text ?? "")
            }.store(in: &cancellables)
    }
    
    override func bindViewModel() {
        viewModel.outputs.usersPublisher.sink { [weak self] manModel in
            guard let self = self else { return }
            print(" MAN : \(manModel)")
            if let man = manModel.first {
                self.nameLabel.text = man.name
                self.kokoIdLabel.text = man.kokoid
            }
            
        }.store(in: &cancellables)
        
        viewModel.outputs.friendsPublisher.sink { [weak self] friendModel in
            guard let self = self else { return }
            print(" Friend : \(friendModel)")
            
            self.friendListBackgroundView.isHidden = friendModel.isEmpty
            self.searchBackgroundView.isHidden = friendModel.isEmpty
            self.noFriendsView.isHidden = !friendModel.isEmpty
            self.invitationBackgroundView.isHidden = friendModel.filter({ $0.status == .pending }).isEmpty
            
        }.store(in: &cancellables)
        
        viewModel.outputs.friendListCellModelPublisher
            .receive(on: RunLoop.main)
            .bind(subscriber: friendListTableView.rowsSubscriber(cellIdentifier: FriendListCell.reuseIdentifier, cellType: FriendListCell.self, cellConfig: { cell, indexPath,  cellModel in

                cell.configureWith(value: cellModel)
            })).store(in: &cancellables)
        
        viewModel.outputs.inviteListCellModelPublisher
            .receive(on: RunLoop.main)
            .bind(subscriber: invitationTableView.rowsSubscriber(cellIdentifier: InviteCell.reuseIdentifier, cellType: InviteCell.self, cellConfig: { cell, indexPath,  cellModel in

                cell.configureWith(value: cellModel)
            })).store(in: &cancellables)
    }
}
