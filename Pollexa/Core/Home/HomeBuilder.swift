//
//  HomeBuilder.swift
//  Pollexa
//
//  Created by Kerem Demir on 26.05.2024.
//

import UIKit

final class HomeBuilder {
    static func build() -> HomeViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController else {
            fatalError("HomeViewController could not be instantiated from storyboard")
        }
        let viewModel = HomeViewModel()
        viewModel.delegate = viewController
        viewController.viewModel = viewModel
        return viewController
    }
}

