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
    
    private var post: Post?
    private var voted: Bool = false
    private var timer: Timer?
    private var lastVoteDate: Date?
    
    // MARK: Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configure()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupImageViews()
    }
    
    // MARK: Configure
    private func configure() {
        setupView()
        setupButtons()
        setupAvatarImage()
    }
    
    
    // MARK: Functions
    private func setupView() {
        makeBorder(color: .red)
        layer.cornerRadius = 25
        updateVoteVisibility(voted: false)
        // TODO: View'i ayarla duzgunce biraz daha iceriden baslasin.
    }
    
    private func setupAvatarImage() {
        let radius = avatarImage.frame.size.width / 2
        avatarImage.makeBorder(color: .clear)
        avatarImage.makeCircle(radius: radius)
    }
    
    private func setupImageViews() {
        DispatchQueue.main.async {
            self.firstImageView.clipsToBounds  = true
            self.secondImageView.clipsToBounds = true
            self.firstImageView.contentMode    = .scaleAspectFill
            self.secondImageView.contentMode   = .scaleAspectFill
            
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
    
    func configure(with post: Post) {
        self.post = post
        
        avatarImage.image = post.user.image
        nameLabel.text = post.user.username
        timeOfSharingLabel.text = post.createdAt.timeAgoDisplay()
        questionLabel.text = post.content
        
        let totalVotes = post.options.reduce(0) { $0 + $1.votes }
        totalVotesLabel.text = String("\(totalVotes) Total Votes")
        
        let firstOptionVotes = post.options.first?.votes ?? 0
        let secondOptionVotes = post.options.count > 1 ? post.options[1].votes : 0
        
        if let firstOption = post.options.first {
            firstImageView.image = firstOption.image
            
            let firstPercentage = totalVotes == 0 ? 0 : Double(firstOptionVotes) / Double(totalVotes) * 100
            firstPercentageLabel.text = String(format: "%.0f%%", firstPercentage)
        }
        
        if post.options.count > 1 {
            secondImageView.image = post.options[1].image
            
            let secondPercentage = totalVotes == 0 ? 0 : Double(secondOptionVotes) / Double(totalVotes) * 100
            secondPercentageLabel.text = String(format: "%.0f%%", secondPercentage)
        }
    }
    
    
    private func updateVoteVisibility(voted: Bool) {
        firstLikeButton.isHidden = voted
        secondLikeButton.isHidden = voted
        
        firstPercentageLabel.isHidden = !voted
        secondPercentageLabel.isHidden = !voted
    }
    
    
    private func vote(for optionIndex: Int) {
        guard var post = post else { return }
        
        post.options[optionIndex].votes += 1
        configure(with: post)
        
        self.voted = true
    }
    
    private func handleVoteAction() {
        lastVoteDate = Date()
        updateLastVoteTime()
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 60, target: self, selector: #selector(updateLastVoteTime), userInfo: nil, repeats: true)
    }
    
    @objc private func updateLastVoteTime() {
        guard let lastVoteDate = lastVoteDate else { return }
        
        let timeInterval = -lastVoteDate.timeIntervalSinceNow
        
        if timeInterval < 60 {
            timeOfLastVote.text = "LAST VOTED JUST NOW"
        } else if timeInterval < 3600 {
            let minutes = Int(timeInterval / 60)
            timeOfLastVote.text = "LAST VOTED \(minutes) MINUTES AGO"
        } else {
            let hours = Int(timeInterval / 3600)
            timeOfLastVote.text = "LAST VOTED \(hours) HOURS AGO"
        }
    }
    
    // MARK: Actions
    @IBAction func firstLikeButtonAction(_ sender: UIButton) {
        print("First image liked.")
        vote(for: 0)
        updateVoteVisibility(voted: true)
        handleVoteAction()
    }
    
    @IBAction func secondLikeButtonAction(_ sender: UIButton) {
        print("Second image liked.")
        vote(for: 1)
        updateVoteVisibility(voted: true)
        handleVoteAction()
    }
}
