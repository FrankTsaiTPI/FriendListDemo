//
//  BaseViewController.swift
//  FriendListDemo
//
//  Created by Tsai Frank on 2024/11/7.
//

import UIKit
import SnapKit
import Combine
import CombineCocoa

class BaseViewController: UIViewController {

    var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupLayout()
        bindUI()
        bindViewModel()
    }
    
    func setupLayout() { }
    
    func bindUI() { }
    
    func bindViewModel() { }
    
    func showCommonErrorAlert(message: String) {
        let cancelAction = UIAlertAction(title: "OK", style: .cancel)
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    func showLoading() {
        guard let keyWindow = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else { return }
        
        let loadingView = UIView(frame: keyWindow.bounds)
        loadingView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = loadingView.center
        activityIndicator.startAnimating()
        
        loadingView.addSubview(activityIndicator)
        loadingView.tag = 999 // for remove
        
        keyWindow.addSubview(loadingView)
    }
    
    func dismissLoading() {
        guard let keyWindow = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else { return }
        for subview in keyWindow.subviews where subview.tag == 999 {
            subview.removeFromSuperview()
        }
    }
}
