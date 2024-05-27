//
//  Post.swift
//  Pollexa
//
//  Created by Kerem Demir on 26.05.2024.
//

import UIKit

struct Post: Decodable {
    
    // MARK: - Properties
    let id        : String
    let createdAt : Date
    let content   : String
    let options   : [Option]
    let user      : User
}

