//
//  HomeBuilder.swift
//  Pollexa
//
//  Created by Kerem Demir on 26.05.2024.
//

import Foundation

final class HomeBuilder {
    static func build() -> HomeViewController {
        let viewController = HomeViewController()
        let viewModel = HomeViewModel()
        viewModel.delegate = viewController
        viewController.viewModel = viewModel // Burada viewModel özelliği atanıyor
        return viewController
    }
}

