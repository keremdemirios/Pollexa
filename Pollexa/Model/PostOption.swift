//
//  PostOption.swift
//  Pollexa
//
//  Created by Kerem Demir on 26.05.2024.
//

import UIKit

extension Post {
    
    struct PostOption: Decodable {
        // MARK: Types
        let id: String
        let image: UIImage
        var votes: Int
        
        // MARK: Properties
        enum CodingKeys: String, CodingKey {
            case id
            case imageName
            case votes
        }
        
        // MARK: Life Cycle
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            id = try container.decode(String.self, forKey: .id)
            
            let imageName = try container.decode(String.self, forKey: .imageName)
            votes = try container.decode(Int.self, forKey: .votes)
            
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
}
