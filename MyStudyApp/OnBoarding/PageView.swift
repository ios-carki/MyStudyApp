//
//  PageView.swift
//  MyStudyApp
//
//  Created by Carki on 2022/11/07.
//

import UIKit

import SnapKit

final class PageView: BaseView {
    
    let pageCollectionView: UICollectionView = {
        let view = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: view)
        cv.isPagingEnabled = true
        view.minimumLineSpacing = 0
        cv.showsHorizontalScrollIndicator = false
        view.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        view.scrollDirection = .horizontal
        
        return cv
    }()
    
    let pageControl: UIPageControl = {
        let view = UIPageControl()
        view.isUserInteractionEnabled = false
        view.pageIndicatorTintColor = .lightGray
        view.currentPageIndicatorTintColor = .black
        return view
    }()
    
    let startButton: UIButton = {
        let view = UIButton()
        view.setTitle("시작하기", for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 14)
        view.backgroundColor = UIColor.colorGreen
        return view
    }()
    
    override func configureUI() {
        [pageCollectionView, pageControl, startButton].forEach {
            self.addSubview($0)
        }
        self.backgroundColor = .white
    }
    
    override func setConstraints() {
        
        pageCollectionView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(500)
        }
        
        pageControl.snp.makeConstraints { make in
            make.top.equalTo(pageCollectionView.snp.bottom)
            make.centerX.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(20)
        }
        
        startButton.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().offset(-50)
            make.height.equalTo(48)
        }
    }
}
