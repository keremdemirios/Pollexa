//
//  HomeViewModel.swift
//  Pollexa
//
//  Created by Kerem Demir on 26.05.2024.
//

import Foundation

protocol HomeViewModelProtocol {
    var delegate: HomeViewModelDelegate? { get set }
    
    func didLoad()
}

protocol HomeViewModelDelegate: AnyObject {
    func reloadData()
    func startLoading()
    func stopLoading()
}

final class HomeViewModel {
    
    weak var delegate: HomeViewModelDelegate?
    
}

extension HomeViewModel: HomeViewModelProtocol {
    
    func didLoad() {
        delegate?.startLoading()
    }
}
