//
//  OnboardingScreen.swift
//  Pollexa
//
//  Created by Kerem Demir on 1.06.2024.
//

import UIKit

final class OnboardingScreenViewController: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var skipButton: UIBarButtonItem!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var slides: [OnboardingSlide] = []
    var currentPage: Int = 0 {
        didSet {
            if currentPage == slides.count - 1 {
                nextButton.setTitle("Get Started", for: .normal)
            } else {
                nextButton.setTitle("Next", for: .normal)
            }
            updateSkipButtonVisibility()
        }
    }
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    private func configure() {
        setupNextButton()
        setupSlide()
        setupSkipButton()
    }
    
    // MARK: Funtions
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func setupSlide() {
        slides = [
                  OnboardingSlide(image: ImageHelper.image1, title: TitleHelper.title1, description: DescriptionHelper.description1),
                  OnboardingSlide(image: ImageHelper.image2, title: TitleHelper.title2, description: DescriptionHelper.description2),
                  OnboardingSlide(image: ImageHelper.image3, title: TitleHelper.title3, description: DescriptionHelper.description3)
              ]
    }
    
    private func setupNextButton() {
        nextButton.makeCircle()
    }
    
    private func setupSkipButton() {
        updateSkipButtonVisibility()
    }
    
    private func updateSkipButtonVisibility() {
        skipButton.isEnabled = currentPage != slides.count - 1
        skipButton.isHidden = currentPage == slides.count - 1 ? true : false
    }
    
    @IBAction func skipButtonAction(_ sender: Any) {
        currentPage = slides.count - 1
        let indexPath = IndexPath(item: currentPage, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        pageControl.currentPage = currentPage
        updateSkipButtonVisibility()
    }
    
    @IBAction func nextButtonAction(_ sender: Any) {
        if currentPage == slides.count - 1 {
            // Onboarding tamamlandı, ana ekrana geçiş yap
            UserDefaults.standard.set(true, forKey: "onboardingCompleted")
            
            let homeVC = HomeBuilder.build()
            
            // Navigation Controller'ı Storyboard'dan yükleyin
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let homeNavController = storyboard.instantiateViewController(withIdentifier: "HomeNavigationController") as? UINavigationController {
                homeNavController.viewControllers = [homeVC]
                homeNavController.modalPresentationStyle = .fullScreen
                self.present(homeNavController, animated: true, completion: nil)
            } else {
                fatalError("HomeNavigationController could not be instantiated from storyboard")
            }
        } else {
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            pageControl.currentPage = currentPage
        }
    }
}

// MARK: Extensions
extension OnboardingScreenViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCell.reuseIdentifier, for: indexPath) as? OnboardingCell else {
            return UICollectionViewCell()
        }
        
        cell.setup(slides[indexPath.item])
        cell.configureUI()
        
        return cell
    }
}
extension OnboardingScreenViewController: UICollectionViewDelegate {}

extension OnboardingScreenViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
    }
}

extension OnboardingScreenViewController: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
        pageControl.currentPage = currentPage
        updateSkipButtonVisibility()
    }
}
