//
//  ShopSeSACView.swift
//  MyStudyApp
//
//  Created by Carki on 2022/12/28.
//

import UIKit

import SnapKit

final class ShopSeSACView: BaseView {
    
    let sesacCollectionView: UICollectionView = {
        
        var layout = UICollectionViewFlowLayout()
        let content: CGFloat = UIScreen.main.bounds.width / 2.0
        
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        layout.estimatedItemSize = CGSize(width: content - 30, height: 32)
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        return cv
    }()
    
    override func configureUI() {
        self.addSubview(sesacCollectionView)
    }
    
    override func setConstraints() {
        
        sesacCollectionView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
    }
    
}
