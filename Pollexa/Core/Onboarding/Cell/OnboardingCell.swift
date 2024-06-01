//
//  OnboardingCell.swift
//  Pollexa
//
//  Created by Kerem Demir on 1.06.2024.
//

import UIKit

final class OnboardingCell: UICollectionViewCell {
    
    // MARK: Identifier
    static let reuseIdentifier = "OnboardingCell"
    
    // MARK: IBOutlets
    
    @IBOutlet weak var slideImageView: UIImageView!
    @IBOutlet weak var slideTitleLabel: UILabel!
    @IBOutlet weak var slideDescriptionLabel: UILabel!
    
    func configureUI() {
        slideImageView.layer.cornerRadius = slideImageView.frame.size.width / 5
    }
    
    func setup(_ slide: OnboardingSlide) {
        slideTitleLabel.text = slide.title
        slideDescriptionLabel.text = slide.description
        
        if let image = slide.image {
            slideImageView.isHidden = false
            slideImageView.image = image
            slideImageView.contentMode = .scaleAspectFit
        }
    }
}
