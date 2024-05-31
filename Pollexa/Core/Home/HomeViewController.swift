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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
           
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
        let avatarImage = UIImage(named: "avatar_1")
        let avatarImageView = UIImageView(image: avatarImage)
        
        let size: CGFloat = 34
        avatarImageView.frame = CGRect(x: 0, y: 0, width: size, height: size)
        avatarImageView.layer.borderWidth = 1
        avatarImageView.layer.borderColor = UIColor.clear.cgColor
        avatarImageView.layer.cornerRadius = size / 2
        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.layer.masksToBounds = true
        avatarImageView.clipsToBounds = true
        
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: size, height: size))
        containerView.addSubview(avatarImageView)

        let imageItem = UIBarButtonItem(customView: containerView)
        let negativeSpacer = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        negativeSpacer.width = -16
        
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
        postsCollectionView.backgroundColor = .systemGray6
    }
    
    private func createLayout(for height: Double, scrollDirection: UICollectionView.ScrollDirection) -> UICollectionViewLayout {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = scrollDirection
        let width = UIScreen.main.bounds.width
        flowLayout.itemSize = CGSize(width: width, height: height)
        flowLayout.minimumLineSpacing = 8
        flowLayout.minimumInteritemSpacing = 8
        return flowLayout
    }
    
    @IBAction func addBarButtonItemAction(_ sender: Any) {
        print("Added.")
    }
}

// MARK: Extensions
extension HomeViewController: HomeViewModelDelegate, LoadingShowable {
    
    func reloadData() {
        DispatchQueue.main.async {
            self.viewModel.sortPostByDate()
            self.postsCollectionView.reloadData()
        }
    }
    
    func showError(_ message: String) {
        showAlert(title: "Error", message: message)
    }
    
    func startLoading() {
        showLoading()
    }
    
    func stopLoading() {
        hideLoading()
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfPosts
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PostCell.reuseIdentifier, for: indexPath) as? PostCell else {
            return UICollectionViewCell()
        }
        
        if let post = viewModel.post(at: indexPath.item) {
            cell.configure(with: post)
        }
        
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
    
}
