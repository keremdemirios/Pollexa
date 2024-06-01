//
//  PostCellViewModel.swift
//  Pollexa
//
//  Created by Kerem Demir on 1.06.2024.
//

import Foundation

import Foundation

protocol PostCellViewModelProtocol {
    var postID: String { get }
    var avatarImageName: String? { get }
    var username: String { get }
    var createdAt: String { get }
    var content: String { get }
    var totalVotes: String { get }
    var firstOptionImageName: String? { get }
    var secondOptionImageName: String? { get }
    var firstPercentage: String { get }
    var secondPercentage: String { get }
    var lastVoteTime: String { get }
    var voted: Bool { get }
    
    func vote(for optionIndex: Int)
}

final class PostCellViewModel: PostCellViewModelProtocol {
    private let post: Post
    private let viewModel: HomeViewModelProtocol
    
    init(post: Post, viewModel: HomeViewModelProtocol) {
        self.post = post
        self.viewModel = viewModel
    }
    
    var postID: String {
        return post.id
    }
    
    var avatarImageName: String? {
        return post.user.image_name
    }
    
    var username: String {
        return post.user.username
    }
    
    var createdAt: String {
        return post.createdAt.timeAgoDisplay()
    }
    
    var content: String {
        return post.content
    }
    
    var totalVotes: String {
        let totalVotes = post.options.reduce(0) { $0 + $1.votes }
        return "\(totalVotes) Total Votes"
    }
    
    var firstOptionImageName: String? {
        return post.options.first?.image_name
    }
    
    var secondOptionImageName: String? {
        return post.options.count > 1 ? post.options[1].image_name : nil
    }
    
    var firstPercentage: String {
        let totalVotes = post.options.reduce(0) { $0 + $1.votes }
        let firstOptionVotes = post.options.first?.votes ?? 0
        let firstPercentage = totalVotes == 0 ? 0 : Double(firstOptionVotes) / Double(totalVotes) * 100
        return String(format: "%.0f%%", firstPercentage)
    }
    
    var secondPercentage: String {
        let totalVotes = post.options.reduce(0) { $0 + $1.votes }
        let secondOptionVotes = post.options.count > 1 ? post.options[1].votes : 0
        let secondPercentage = totalVotes == 0 ? 0 : Double(secondOptionVotes) / Double(totalVotes) * 100
        return String(format: "%.0f%%", secondPercentage)
    }
    
    var lastVoteTime: String {
        guard let lastVoteDate = viewModel.lastVoteDates[post.id] else { return "LAST VOTED 1 HOUR AGO" }
        let timeInterval = -lastVoteDate.timeIntervalSinceNow
        if timeInterval < 60 {
            return "LAST VOTED JUST NOW"
        } else if timeInterval < 3600 {
            let minutes = Int(timeInterval / 60)
            return "LAST VOTED \(minutes) MINUTES AGO"
        } else {
            let hours = Int(timeInterval / 3600)
            return "LAST VOTED \(hours) HOURS AGO"
        }
    }
    
    var voted: Bool {
        return viewModel.votedPosts[post.id] ?? false
    }
    
    func vote(for optionIndex: Int) {
        viewModel.vote(for: post.id, optionIndex: optionIndex)
    }
}
31 - 21 - 13
