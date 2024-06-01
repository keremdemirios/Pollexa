//
//  User.swift
//  Pollexa
//
//  Created by Kerem Demir on 26.05.2024.
//

import UIKit

struct User: Decodable {
    let id: String
    let username: String
    let image_name: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case username
        case imageName
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(String.self, forKey: .id)
        username = try container.decode(String.self, forKey: .username)
        image_name = try container.decode(String.self, forKey: .imageName)
    }
}

