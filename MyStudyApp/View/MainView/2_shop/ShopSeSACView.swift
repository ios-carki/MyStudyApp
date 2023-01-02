//
//  ShopSeSACView.swift
//  MyStudyApp
//
//  Created by Carki on 2022/12/28.
//

import UIKit

import SnapKit

final class ShopSeSACView: BaseView {
    
    let cardView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    let tabView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    let boundaryView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    let sesacCollectionView: UICollectionView = {
        
        var layout = UICollectionViewFlowLayout()
        let content: CGFloat = UIScreen.main.bounds.width / 2.0
        
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 0)
        layout.itemSize = CGSize(width: content - 24, height: 280)
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        return cv
    }()
    
    override func configureUI() {
        [cardView, tabView, boundaryView, sesacCollectionView].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        
        cardView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            make.height.equalTo(172)
        }
        
        tabView.snp.makeConstraints { make in
            make.top.equalTo(cardView.snp.bottom)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(44)
        }
        
        boundaryView.snp.makeConstraints { make in
            make.top.equalTo(tabView.snp.bottom)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(1)
        }
        
        sesacCollectionView.snp.makeConstraints { make in
            make.top.equalTo(boundaryView.snp.bottom)
            make.horizontalEdges.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
    
}
