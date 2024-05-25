//
//  LoadingView.swift
//  Pollexa
//
//  Created by Kerem Demir on 26.05.2024.
//

import UIKit

class LoadingView {
    //MARK: - Properties
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    static let shared = LoadingView()
    var blurView: UIVisualEffectView = UIVisualEffectView()
    
    //MARK: - Lifecycle
    
    private init() {
        configure()
    }
    
    //MARK: - Method
    
    func configure() {
        blurView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        blurView.alpha = 0.5
        blurView.translatesAutoresizingMaskIntoConstraints = false
        blurView.frame = UIWindow(frame: UIScreen.main.bounds).frame
        activityIndicator.center = blurView.center
        activityIndicator.color = .tintColor
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .large
        blurView.contentView.addSubview(activityIndicator)
    }
    
    func startLoading() {
        if let window = UIApplication.shared.connectedScenes.map({ $0 as? UIWindowScene }).compactMap({ $0 }).first?
            .windows.first
        {
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                window.addSubview(self.blurView)
                self.blurView.translatesAutoresizingMaskIntoConstraints = false
                self.activityIndicator.startAnimating()
            }
        }
    }
    
    func hideLoading() {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            self.blurView.removeFromSuperview()
            self.activityIndicator.stopAnimating()
        }
    }
}


