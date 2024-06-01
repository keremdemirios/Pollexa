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
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let rootVC: UIViewController
        
        if UserDefaults.standard.bool(forKey: "onboardingCompleted") {
            let homeVC = HomeBuilder.build()
            let homeNavController = storyboard.instantiateViewController(withIdentifier: "HomeNavigationController") as! UINavigationController
            homeNavController.viewControllers = [homeVC]
            rootVC = homeNavController
        } else {
            let onboardingVC = storyboard.instantiateViewController(withIdentifier: "OnboardingScreenViewController")
            let onboardingNavController = storyboard.instantiateViewController(withIdentifier: "OnboardingNC") as! UINavigationController
            onboardingNavController.viewControllers = [onboardingVC]
            rootVC = onboardingNavController
        }
        
        self.window?.rootViewController = rootVC
        self.window?.makeKeyAndVisible()
    }
    
}

