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
          
          slideTitleLabel.adjustsFontSizeToFitWidth = true
          slideTitleLabel.minimumScaleFactor = 0.5
          slideDescriptionLabel.adjustsFontSizeToFitWidth = true
          slideDescriptionLabel.minimumScaleFactor = 0.5
          
          slideTitleLabel.numberOfLines = 0
          slideDescriptionLabel.numberOfLines = 0
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
