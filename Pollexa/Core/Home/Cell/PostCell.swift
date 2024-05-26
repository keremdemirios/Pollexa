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
    @IBOutlet weak var postView: UIView!
    
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
        
        configure()
    }
    
    private func configure() {
        setupView()
        setupButtons()
        setupAvatarImage()
    }

    private func setupView() {
        makeBorder(color: .clear)
        layer.cornerRadius = 25
        // TODO: View'i ayarla duzgunce biraz daha iceriden baslasin.
    }
    
    private func setupAvatarImage() {
        let radius = avatarImage.frame.size.width / 2
        avatarImage.makeBorder(color: .clear)
        avatarImage.makeCircle(radius: radius)
    }
    
    private func setupButtons() {
        let radius = firstLikeButton.frame.size.width / 2
        
        firstLikeButton.makeBorder(color: .clear)
        firstLikeButton.makeCircle(radius: radius)
        
        secondLikeButton.makeBorder(color: .clear)
        secondLikeButton.makeCircle(radius: radius)
    }
    
}
