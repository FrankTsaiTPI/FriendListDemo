//
//  FriendListCell.swift
//  FriendListDemo
//
//  Created by Tsai Frank on 2024/11/11.
//

import Foundation
import UIKit
import Combine
import CombineCocoa

class FriendListCell: BaseTableViewCell {
    
    private lazy var starImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "iconFriendsStar")
        imageView.isHidden = true
        
        return imageView
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
    
    private lazy var statusStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 10
        
        return stackView
    }()
    
    private lazy var transferButtonBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        
        return view
    }()
    
    private lazy var transferButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("轉帳", for: .normal)
        button.setTitleColor(.hotPink, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        button.layer.cornerRadius = 2
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.hotPink.cgColor
        
        return button
    }()
    
    private lazy var invitingButtonBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.isHidden = true
        
        return view
    }()
    
    private lazy var invitingButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("邀請中", for: .normal)
        button.setTitleColor(.pinkishGrey, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        button.layer.cornerRadius = 2
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.pinkishGrey.cgColor
        
        return button
    }()
    
    private lazy var moreButtonBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        
        return view
    }()
    
    private lazy var moreButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "iconFriendsMore"), for: .normal)
        
        return button
    }()
    
    private lazy var separator: UIView = {
        let view = UIView()
        view.backgroundColor = .whiteThree
        
        return view
    }()
    
    override func setupLayout() {
        contentView.addSubview(starImageView)
        contentView.addSubview(userIconImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(separator)
        contentView.addSubview(statusStackView)
        
        statusStackView.addArrangedSubview(transferButtonBackgroundView)
        transferButtonBackgroundView.addSubview(transferButton)
        statusStackView.addArrangedSubview(invitingButtonBackgroundView)
        invitingButtonBackgroundView.addSubview(invitingButton)
        statusStackView.addArrangedSubview(moreButtonBackgroundView)
        moreButtonBackgroundView.addSubview(moreButton)
        
        userIconImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(50)
            $0.height.width.equalTo(40)
        }
        
        starImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalTo(userIconImageView.snp.leading).offset(-6)
            $0.height.width.equalTo(14)
        }
        
        nameLabel.snp.makeConstraints {
            $0.height.equalTo(60)
            $0.top.bottom.equalToSuperview()
            $0.leading.equalTo(userIconImageView.snp.trailing).offset(15)
        }
        
        separator.snp.makeConstraints {
            $0.leading.equalTo(nameLabel.snp.leading)
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(1)
            $0.height.equalTo(1)
        }
        
        statusStackView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(20)
            $0.top.equalToSuperview()
            $0.bottom.equalTo(separator.snp.top)
        }
        
        transferButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.width.equalTo(47)
            $0.height.equalTo(24)
        }
        
        invitingButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.width.equalTo(60)
            $0.height.equalTo(24)
        }
        
        moreButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.width.equalTo(18)
            $0.height.equalTo(4)
        }
    }
    
    override func configureWith(value: BaseTableViewCell.Value) {
        guard let value = value as? FriendListCellModel else { return }
        
        userIconImageView.image = UIImage(named: "iconFriendsList")
        nameLabel.text = value.friendModel.name
        starImageView.isHidden = !value.friendModel.isTop
        
        var statusRightInset: CGFloat = 0
        
        switch value.friendModel.status {
        case .pending:
            moreButtonBackgroundView.isHidden = true
            invitingButtonBackgroundView.isHidden = false
            statusRightInset = 20
        default:
            moreButtonBackgroundView.isHidden = false
            invitingButtonBackgroundView.isHidden = true
            statusRightInset = 30
        }
        
        statusStackView.snp.remakeConstraints {
            $0.trailing.equalToSuperview().inset(statusRightInset)
            $0.top.equalToSuperview()
            $0.bottom.equalTo(separator.snp.top)
        }
    }
}
