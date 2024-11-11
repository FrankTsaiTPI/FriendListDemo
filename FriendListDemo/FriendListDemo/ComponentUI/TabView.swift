//
//  TabView.swift
//  FriendListDemo
//
//  Created by Tsai Frank on 2024/11/11.
//

import UIKit
import Foundation
import Combine
import CombineCocoa
import SnapKit

struct Tab {
    let title: String
    var isSelected: Bool
}

class TabView: UIView {
    
    private var tabs: [Tab] = []
    private var buttons: [UIButton] = []
    private var bottomLine: UIView!
    private var selectedButton: UIButton?
    
    private let tabSelectedSubject = PassthroughSubject<Int, Never>()
    private var cancellables: Set<AnyCancellable> = []
    
    var tabSelectedPublisher: AnyPublisher<Int, Never> {
        tabSelectedSubject.eraseToAnyPublisher()
    }
    
    init (tabs: [Tab]) {
        super.init(frame: .zero)
        
        self.tabs = tabs
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        bottomLine = UIView()
        bottomLine.backgroundColor = .hotPink
        bottomLine.translatesAutoresizingMaskIntoConstraints = false
        bottomLine.layer.cornerRadius = 2
        addSubview(bottomLine)
        
        for (index, tab) in tabs.enumerated() {
            let button = UIButton(type: .custom)
            button.setTitle(tab.title, for: .normal)
            button.setTitleColor(.greyishBrown, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 13, weight: .medium)
            button.tag = index
            button.controlEventPublisher(for: .touchUpInside).sink { [weak self] in
                guard let self = self else { return }
                
                self.tabSelected(button)
            }.store(in: &cancellables)
            
            addSubview(button)
            buttons.append(button)
        }
        
        for (index, button) in buttons.enumerated() {
            button.snp.makeConstraints {
                $0.top.bottom.equalToSuperview()
            }
            
            if index == 0 {
                button.snp.makeConstraints {
                    $0.leading.equalToSuperview()
                }
            } else {
                button.snp.makeConstraints {
                    $0.leading.equalTo(buttons[index - 1].snp.trailing).offset(36)
                }
            }
        }
        
        bottomLine.snp.makeConstraints {
            $0.leading.equalTo(buttons[0].snp.leading)
            $0.trailing.equalTo(buttons[0].snp.trailing)
            $0.bottom.equalToSuperview()
            $0.height.equalTo(4)
        }
    }
    
    @objc private func tabSelected(_ sender: UIButton) {
        if sender == selectedButton {
            return
        }
        
        for (index, button) in buttons.enumerated() {
            button.isSelected = (index == sender.tag)
            tabs[index].isSelected = (index == sender.tag)
        }
        
        UIView.animate(withDuration: 0.2) {
            self.bottomLine.frame.origin.x = sender.frame.origin.x
        }
        
        selectedButton = sender
        tabSelectedSubject.send(sender.tag)
    }
}
