//
//  NearUserView.swift
//  MyStudyApp
//
//  Created by Carki on 2022/11/26.
//

import UIKit

import SnapKit

final class NearUserView: BaseView {
    
    let tabMenuCollectionView: UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        let content: CGFloat = UIScreen.main.bounds.width
        
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        //layout.estimatedItemSize = CGSize(width: content, height: 44)
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        return cv
    }()
    
    let highlightBar: UIView = {
        let view = UIView()
        view.backgroundColor = .colorGreen
        return view
    }()
    
    let underLineBar: UIView = {
        let view = UIView()
        view.backgroundColor = .colorGray2
        return view
    }()
    
    let pagerCollectionView: UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        let content: CGFloat = UIScreen.main.bounds.width
        
//        layout.minimumLineSpacing = 0
//        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//        layout.estimatedItemSize = CGSize(width: content, height: 44)
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.bounces = false
        cv.isPagingEnabled = true
        cv.showsHorizontalScrollIndicator = false
        return cv
    }()
    
    override func configureUI() {
        [tabMenuCollectionView, highlightBar, underLineBar, pagerCollectionView].forEach {
            self.addSubview($0)
        }
        self.backgroundColor = .white
    }
    
    override func setConstraints() {
        
        tabMenuCollectionView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(44)
        }
        
        highlightBar.snp.makeConstraints { make in
            make.top.equalTo(tabMenuCollectionView.snp.bottom).offset(0)
            make.height.equalTo(3)
        }
        
        underLineBar.snp.makeConstraints { make in
            make.bottom.equalTo(pagerCollectionView.snp.top)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(1)
        }
        
        pagerCollectionView.snp.makeConstraints { make in
            make.top.equalTo(highlightBar.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
    
}
