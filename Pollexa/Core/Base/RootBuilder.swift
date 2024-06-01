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
        return navController
    }
}

