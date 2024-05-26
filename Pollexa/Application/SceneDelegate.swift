//
//  SceneDelegate.swift
//  Pollexa
//
//  Created by Kerem Demir on 26.05.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        self.window = UIWindow(windowScene: windowScene)
        let storyboard   = UIStoryboard(name: "Main", bundle: nil)
        guard let rootVC = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController else {
            return
        }
        
        let viewModel    = HomeViewModel()
        rootVC.viewModel = viewModel
        
        let navigationController        = UINavigationController(rootViewController: rootVC)
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
    }
}

