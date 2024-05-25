//
//  LoadingShowable.swift
//  Pollexa
//
//  Created by Kerem Demir on 26.05.2024.
//

import UIKit

protocol LoadingShowable where Self: UIViewController {
    func showLoading()
    func hideLoading()
}

extension LoadingShowable {
    func showLoading() {
        DispatchQueue.main.async { [weak self] in
            guard self != nil else { return }
            LoadingView.shared.startLoading()
        }
    }
    
    func hideLoading() {
        DispatchQueue.main.async { [weak self] in
            guard self != nil else { return }
            LoadingView.shared.hideLoading()
        }
    }
}
