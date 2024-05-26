//
//  HomeViewController.swift
//  Pollexa
//
//  Created by Kerem Demir on 26.05.2024.
//

import UIKit

final class HomeViewController: UIViewController {
    
    var viewModel: HomeViewModelProtocol! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel?.didLoad()
        configure()
    }
    
    private func configure() {
        setupView()
        setupAvatar()
    }
    
    private func setupView() {
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Discover"
    }
    
    private func setupAvatar() {
        let avatarImage = UIImage(named: "avatar_1")
        let avatarImageView = UIImageView(image: avatarImage)
        
        // Frame boyutlarını ayarla
        let size: CGFloat = 40
        avatarImageView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        avatarImageView.layer.borderWidth = 1
        avatarImageView.layer.borderColor = UIColor.red.cgColor
//        avatarImageView.contentMode = .scaleToFill
        avatarImageView.contentMode = .scaleAspectFit
        avatarImageView.clipsToBounds = true
        
        // Yuvarlak köşeler ve border ayarları
        avatarImageView.layer.cornerRadius = size / 2
        avatarImageView.layer.borderWidth = 2.0
//        avatarImageView.layer.borderColor = UIColor.white.cgColor
        
        // UIBarButtonItem oluşturma
        let imageItem = UIBarButtonItem(customView: avatarImageView)
        
        // Negatif boşluk oluşturma ve ayarlama
        let negativeSpacer = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        negativeSpacer.width = -16
        
        // NavigationItem'ın sol bar buton öğelerini ayarlama
        navigationItem.leftBarButtonItems = [negativeSpacer, imageItem]
    }


    
    @IBAction func addBarButtonItemAction(_ sender: Any) {
        print("Added.")
    }
}

// MARK: Extensions
extension HomeViewController: HomeViewModelDelegate, LoadingShowable {
    func reloadData() {
        //
    }
    
    func startLoading() {
//        showLoading()
    }
    
    func stopLoading() {
        hideLoading()
    }
}
