//
//  OnboardingHelper.swift
//  Pollexa
//
//  Created by Kerem Demir on 1.06.2024.
//

import UIKit

struct OnboardingSlide {
    let image: UIImage?
    let title: String
    let description: String
}

struct ImageHelper {
    static let image1 = UIImage(named: "onboarding1")
    static let image2 = UIImage(named: "onboarding2")
    static let image3 = UIImage(named: "onboarding3")
}

struct TitleHelper {
    static let title1 = "Welcome to Pollexa !"
    static let title2 = "Feeling Indecisive About Your Choices ?"
    static let title3 = "Share Your Dilemma and Get Quick Answers!"
}

struct DescriptionHelper {
    static let description1 = "Discover a community-driven platform where you can get answers to your toughest choices. Let's get started!"
    static let description2 = "Can't decide between options? You're not alone. Our app helps you find the best answers."
    static let description3 = "Post your queries and receive prompt responses from our community to make better decisions faster."
}
