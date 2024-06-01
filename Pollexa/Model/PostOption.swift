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
        let image_name: String
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
            image_name = try container.decode(String.self, forKey: .imageName)
            votes = try container.decode(Int.self, forKey: .votes)
        }
    }
}
