//
//  Post.swift
//  Pollexa
//
//  Created by Kerem Demir on 26.05.2024.
//

import UIKit

struct Post: Decodable {
    let id: String
    let createdAt: Date
    let content: String
    var options: [PostOption]
    let user: User
    var voted: Bool?

    mutating func vote(for optionIndex: Int) {
        guard optionIndex < options.count else { return }
        options[optionIndex].votes += 1
        voted = true
    }
}

