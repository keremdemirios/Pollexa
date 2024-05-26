//
//  HomeViewController.swift
//  Pollexa
//
//  Created by Kerem Demir on 26.05.2024.
//

import UIKit

final class HomeViewController: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet weak var headerItem: UIView!
    @IBOutlet weak var postsCollectionView: UICollectionView!
    
    // MARK: View Model
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
        setupHeaderView()
        setupPostsCollectionView()
    }
    
    private func setupView() {
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Discover"
    }
    
    private func setupAvatar() {
        let avatarImage                    = UIImage(named: "avatar_1")
        let avatarImageView                = UIImageView(image: avatarImage)
        
        // Frame boyutlarını ayarla
        let size: CGFloat = 40
        avatarImageView.frame              = CGRect(x: 0, y: 0, width: 80, height: 80)
        avatarImageView.layer.borderWidth  = 1
        avatarImageView.layer.borderColor  = UIColor.red.cgColor
        avatarImageView.layer.cornerRadius = size / 2
        avatarImageView.contentMode        = .scaleAspectFit
        avatarImageView.clipsToBounds      = true

        let imageItem                      = UIBarButtonItem(customView: avatarImageView)
        let negativeSpacer                 = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        negativeSpacer.width               = -16
        
        navigationItem.leftBarButtonItems = [negativeSpacer, imageItem]
    }
    private func setupHeaderView() {
        headerItem.makeBorder(color: .clear)
        headerItem.layer.cornerRadius = headerItem.frame.size.width / 16
    }
    private func setupPostsCollectionView() {
        postsCollectionView.delegate   = self
        postsCollectionView.dataSource = self
        postsCollectionView.collectionViewLayout = createLayout(for: postsCollectionView.frame.size.width, scrollDirection: .vertical)
        postsCollectionView.register(UINib(nibName: "PostCell", bundle: nil), forCellWithReuseIdentifier: PostCell.reuseIdentifier)
    }
    
    private func createLayout(for height: Double, scrollDirection: UICollectionView.ScrollDirection) -> UICollectionViewLayout {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = scrollDirection
        let width = UIScreen.main.bounds.width
        flowLayout.itemSize = CGSize(width: width, height: height)
        flowLayout.minimumLineSpacing = 8
        flowLayout.minimumInteritemSpacing = 0
        return flowLayout
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

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PostCell.reuseIdentifier, for: indexPath) as? PostCell else {
            return UICollectionViewCell()
        }
        // TODO: Configure Cell
        
        return cell
    }
}

extension HomeViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // TODO: Kullanilmacayak kaldir.
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = postsCollectionView.frame.size.width
        return CGSize(width: collectionViewWidth, height: 331)
    }
}
