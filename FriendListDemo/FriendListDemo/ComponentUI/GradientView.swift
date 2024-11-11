//
//  GradientView.swift
//  FriendListDemo
//
//  Created by Tsai Frank on 2024/11/11.
//

import UIKit
import Combine

class GradientView: UIView {
    
    let tapViewSubject = PassthroughSubject<Void, Never>()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupTapPublisher()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupView()
        setupTapPublisher()
    }

    private func setupView() {
        isUserInteractionEnabled = true
        layer.cornerRadius = 20

        layer.shadowColor = UIColor.appleGreen40.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 1, height: 1)
        layer.shadowRadius = 5
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.frogGreen.cgColor, UIColor.booger.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.frame = bounds
        gradientLayer.cornerRadius = layer.cornerRadius
        
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func setupTapPublisher() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewDidTapped))
        addGestureRecognizer(tapGesture)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        if let gradientLayer = self.layer.sublayers?.first as? CAGradientLayer {
            gradientLayer.frame = self.bounds
        }
    }
    
    @objc func viewDidTapped(_ sender: UITapGestureRecognizer) {
        tapViewSubject.send()
    }
}
