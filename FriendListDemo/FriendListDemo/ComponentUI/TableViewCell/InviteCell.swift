//
//  InviteCell.swift
//  FriendListDemo
//
//  Created by Tsai Frank on 2024/11/12.
//

import UIKit
import Combine
import CombineCocoa

class InviteCell: BaseTableViewCell {

    private lazy var shadowedBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        
        return view
    }()
    
    private lazy var userIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = UIColor.greyishBrown
        
        return label
    }()
    
    private lazy var descLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.textColor = UIColor.lightGrey
        label.text = "邀請你成為好友：）"
        
        return label
    }()
    
    private lazy var agreeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "btnFriendsAgree"), for: .normal)
        
        return button
    }()
    
    private lazy var deleteButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "btnFriendsDelete"), for: .normal)
        
        return button
    }()
    
    var cancellables: Set<AnyCancellable> = []
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        shadowedBackgroundView.layer.shadowColor = UIColor.black.withAlphaComponent(0.1).cgColor
        shadowedBackgroundView.layer.shadowOpacity = 1
        shadowedBackgroundView.layer.shadowOffset = CGSize(width: 0, height: 6)
        shadowedBackgroundView.layer.shouldRasterize = true
    }
    
    override func setupLayout() {
        contentView.backgroundColor = .clear
        contentView.addSubview(shadowedBackgroundView)
        shadowedBackgroundView.addSubview(userIconImageView)
        shadowedBackgroundView.addSubview(nameLabel)
        shadowedBackgroundView.addSubview(descLabel)
        shadowedBackgroundView.addSubview(agreeButton)
        shadowedBackgroundView.addSubview(deleteButton)
        
        shadowedBackgroundView.snp.makeConstraints {
            $0.leading.trailing.top.equalToSuperview()
            $0.bottom.equalToSuperview().inset(10)
        }
        
        userIconImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(15)
            $0.height.width.equalTo(40)
        }
        
        nameLabel.snp.makeConstraints {
            $0.leading.equalTo(userIconImageView.snp.trailing).offset(15)
            $0.top.equalToSuperview().inset(14)
            $0.height.equalTo(22)
            $0.trailing.equalTo(agreeButton.snp.leading).offset(15)
        }
        
        descLabel.snp.makeConstraints {
            $0.leading.equalTo(nameLabel.snp.leading)
            $0.trailing.equalTo(nameLabel.snp.trailing)
            $0.top.equalTo(nameLabel.snp.bottom).offset(2)
            $0.bottom.equalToSuperview().inset(14)
        }
        
        deleteButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(15)
            $0.height.width.equalTo(30)
        }
        
        agreeButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalTo(deleteButton.snp.leading).offset(-15)
            $0.height.width.equalTo(30)
        }
    }
    
    override func configureWith(value: BaseTableViewCell.Value) {
        guard let value = value as? InviteCellModel else { return }
        cancellables.removeAll()
    
        userIconImageView.image = UIImage(named: "iconFriendsList")
        nameLabel.text = value.friendModel.name
        
        agreeButton.tapPublisher
            .sink {
                value.agreeButtonTapped()
            }.store(in: &cancellables)
        
        deleteButton.tapPublisher
            .sink {
                value.deleteButtonTapped()
            }.store(in: &cancellables)
    }
}
