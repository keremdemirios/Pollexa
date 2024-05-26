//
//  PostCell.swift
//  Pollexa
//
//  Created by Kerem Demir on 26.05.2024.
//

import UIKit

final class PostCell: UICollectionViewCell {

    // MARK: Reuse Identifier
    static let reuseIdentifier = "PostCell"
    
    // MARK: IBOutlets
    
    // Up Side
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeOfSharingLabel: UILabel!
    
    // Mid Side
    @IBOutlet weak var timeOfLastVote: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    
    // Bottom Side
    @IBOutlet weak var firstImageView: UIImageView!
    @IBOutlet weak var firstLikeButton: UIButton!
    @IBOutlet weak var firstPercentageLabel: UILabel!
    
    @IBOutlet weak var secondImageView: UIImageView!
    @IBOutlet weak var secondLikeButton: UIButton!
    @IBOutlet weak var secondPercentageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    
    private func configure() {
        setupView()
    }

    private func setupView() {
        
    }
    
}
