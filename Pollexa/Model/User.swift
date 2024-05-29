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
    let image: UIImage
    
    enum CodingKeys: String, CodingKey {
        case id
        case username
        case imageName
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(String.self, forKey: .id)
        username = try container.decode(String.self, forKey: .username)
        
        let imageName = try container.decode(String.self, forKey: .imageName)
        
        if let image = UIImage(named: imageName) {
            self.image = image
        } else {
            throw DecodingError.dataCorrupted(.init(
                codingPath: [CodingKeys.imageName],
                debugDescription: "An image with name \(imageName) could not be loaded from the bundle.")
            )
        }
    }
}

