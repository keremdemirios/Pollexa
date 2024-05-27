//
//  HomeViewModel.swift
//  Pollexa
//
//  Created by Kerem Demir on 26.05.2024.
//


//func getCoins()
//func coin(index: Int) -> CoinElement?
//var numberOfCoins: Int { get }
//func cancelSearch()

import Foundation

protocol HomeViewModelProtocol {
    var delegate: HomeViewModelDelegate? { get set }
    
    func didLoad()
    func post(at index: Int) -> Post?
    var numberOfPosts: Int { get }
}

protocol HomeViewModelDelegate: AnyObject {
    func reloadData()
    func showError(_ message: String)
    func startLoading()
    func stopLoading()
}

final class HomeViewModel {
    
    private var posts = [Post]()
    
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
    
}
