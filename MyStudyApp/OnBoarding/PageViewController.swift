//
//  PageViewController.swift
//  MyStudyApp
//
//  Created by Carki on 2022/11/07.
//

import UIKit

final class PageViewController: UIViewController {
    
    let mainView = PageView()
    
    var nowPage: Int = 0
    let pageTextData: [String] = ["위치 기반으로 빠르게\n주위 친구를 확인", "스터디를 원하는 친구를\n찾을 수 있어요", "SeSAC Study"]
    let pageImageData: Array<UIImage> = [UIImage(named: "onboarding_img1")!, UIImage(named: "onboarding_img2")!, UIImage(named: "onboarding_img3")!]
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pageCollectionViewSetting()
        pageControlSetting()
        startButtonSetting()
    }
    
    func pageCollectionViewSetting() {
        mainView.pageCollectionView.dataSource = self
        mainView.pageCollectionView.delegate = self
        
        mainView.pageCollectionView.register(CustomPageCollectionView.self, forCellWithReuseIdentifier: CustomPageCollectionView.identifier)
    }
    
    func pageControlSetting() {
        mainView.pageControl.numberOfPages = pageImageData.count
        mainView.pageControl.currentPage = nowPage
    }
    
    func startButtonSetting() {
        mainView.startButton.addTarget(self, action: #selector(startButtonClicked), for: .touchUpInside)
    }
    
    @objc func startButtonClicked() {
        let vc = LoginViewController()
        vc.modalPresentationStyle = .fullScreen //풀스크린 모달방식
        
        self.present(vc, animated: true)
    }
    
}

extension PageViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return pageImageData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomPageCollectionView.identifier, for: indexPath) as? CustomPageCollectionView else { return UICollectionViewCell() }
        
        cell.pageTopLabel.text = pageTextData[indexPath.row]
        cell.pageImage.image = pageImageData[indexPath.row]
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: mainView.pageCollectionView.frame.size.width, height: mainView.pageCollectionView.frame.size.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        nowPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
        mainView.pageControl.currentPage = nowPage
    }
    
    
}
