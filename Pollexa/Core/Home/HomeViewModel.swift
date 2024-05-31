//
//  HomeViewModel.swift
//  Pollexa
//
//  Created by Kerem Demir on 26.05.2024.
//

import Foundation

protocol HomeViewModelProtocol {

    var numberOfPosts: Int { get }
    var votedPosts: [String: Bool] { get }
    var lastVoteDates: [String: Date] { get }
    var delegate: HomeViewModelDelegate? { get set }
    
    func didLoad()
    func post(at index: Int) -> Post?
    func sortPostByDate()
    func vote(for postID: String, optionIndex: Int)
}

protocol HomeViewModelDelegate: AnyObject {
    func reloadData()
    func showError(_ message: String)
    func startLoading()
    func stopLoading()
}

final class HomeViewModel {
    
    var posts = [Post]()
    var votedPosts = [String: Bool]()
    var lastVoteDates = [String: Date]()
    weak var delegate: HomeViewModelDelegate?
    
    // MARK: Fetch Posts
    fileprivate func fetchPosts() {
        
        PostProvider.shared.fetchAll { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let posts):
                DispatchQueue.main.async {
                    self.posts = posts
                    print(posts.first!)
                    self.delegate?.reloadData()
                    self.delegate?.stopLoading()
                }
            case .failure(let error):
                delegate?.showError(error.localizedDescription)
                self.delegate?.stopLoading()
            }
        }
    }
}

extension HomeViewModel: HomeViewModelProtocol {
    
    func didLoad() {
        delegate?.startLoading()
        fetchPosts()
    }
    
    func post(at index: Int) -> Post? {
        guard index < posts.count else { return nil }
        return posts[index]
    }
    
    var numberOfPosts: Int {
        return posts.count
    }
    
    func sortPostByDate() {
        posts.sort { $0.createdAt > $1.createdAt }
    }
    
    func vote(for postID: String, optionIndex: Int) {
         if let index = posts.firstIndex(where: { $0.id == postID }) {
             posts[index].vote(for: optionIndex)
             votedPosts[postID] = true
             lastVoteDates[postID] = Date()
             delegate?.reloadData()
         }
     }
}
