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
    
    @IBOutlet weak var totalVotesLabel: UILabel!
    
    private var postID: String?
    
    private var viewModel: PostCellViewModelProtocol?
    private var timer: Timer?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupImageViews()
        setupAvatarImage()
    }
    
    private func configure() {
        setupView()
        setupButtons()
    }
    
    private func setupView() {
        makeBorder(color: .clear)
        layer.cornerRadius = 25
    }
    
    private func setupAvatarImage() {
        avatarImage.layoutIfNeeded()
        let radius = avatarImage.frame.size.width / 2
        avatarImage.makeBorder(color: .clear)
        avatarImage.layer.cornerRadius = radius
        avatarImage.layer.masksToBounds = true
        avatarImage.clipsToBounds = true
        avatarImage.contentMode = .scaleAspectFill
    }
    
    private func setupImageViews() {
        DispatchQueue.main.async {
            self.firstImageView.clipsToBounds = true
            self.secondImageView.clipsToBounds = true
            self.firstImageView.contentMode = .scaleAspectFill
            self.secondImageView.contentMode = .scaleAspectFill
            
            let radius = self.firstImageView.frame.size.height / 10
            self.firstImageView.makeBorder(color: .clear)
            self.firstImageView.roundCorners(corners: [.topLeft, .bottomLeft], radius: radius)
            
            self.secondImageView.makeBorder(color: .clear)
            self.secondImageView.roundCorners(corners: [.topRight, .bottomRight], radius: radius)
        }
    }
    
    private func setupButtons() {
        let radius = firstLikeButton.frame.size.width / 2
        firstLikeButton.makeBorder(color: .clear)
        firstLikeButton.makeCircle(radius: radius)
        secondLikeButton.makeBorder(color: .clear)
        secondLikeButton.makeCircle(radius: radius)
    }
    
    func configure(with viewModel: PostCellViewModelProtocol) {
        self.viewModel = viewModel
        updateVoteVisibility(voted: viewModel.voted)
        
        if let avatarImageName = viewModel.avatarImageName {
            avatarImage.image = UIImage(named: avatarImageName)
        } else {
            avatarImage.image = nil
        }
        
        nameLabel.text = viewModel.username
        timeOfSharingLabel.text = viewModel.createdAt
        questionLabel.text = viewModel.content
        totalVotesLabel.text = viewModel.totalVotes
        
        if let firstOptionImageName = viewModel.firstOptionImageName {
            firstImageView.image = UIImage(named: firstOptionImageName)
        } else {
            firstImageView.image = nil
        }
        
        if let secondOptionImageName = viewModel.secondOptionImageName {
            secondImageView.image = UIImage(named: secondOptionImageName)
        } else {
            secondImageView.image = nil
        }
        
        firstPercentageLabel.text = viewModel.firstPercentage
        secondPercentageLabel.text = viewModel.secondPercentage
        timeOfLastVote.text = viewModel.lastVoteTime
    }
    
    func updateVoteVisibility(voted: Bool) {
        firstLikeButton.isHidden = voted
        secondLikeButton.isHidden = voted
        firstPercentageLabel.isHidden = !voted
        secondPercentageLabel.isHidden = !voted
    }
    
    // MARK: Actions
    @IBAction func firstLikeButtonAction(_ sender: UIButton) {
        viewModel?.vote(for: 0)
    }
    
    @IBAction func secondLikeButtonAction(_ sender: UIButton) {
        viewModel?.vote(for: 1)
    }
}
