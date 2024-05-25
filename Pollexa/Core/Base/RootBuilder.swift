//
//  RootBuilder.swift
//  Pollexa
//
//  Created by Kerem Demir on 26.05.2024.
//

import UIKit

final class RootBuilder {
    static func build() -> UINavigationController {
        let navController = UINavigationController(rootViewController: HomeViewController())
//        let appearance = UINavigationBarAppearance()
//        appearance.titleTextAttributes = [
//            .font: UIFont.boldSystemFont(ofSize: 24),
//            .foregroundColor: UIColor.tintColor
//        ]
//        navController.navigationBar.standardAppearance = appearance
//        navController.navigationBar.scrollEdgeAppearance = appearance
//        navController.navigationBar.tintColor = .tintColor
        return navController
    }
}

