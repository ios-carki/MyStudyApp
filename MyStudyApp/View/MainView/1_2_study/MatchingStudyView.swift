//
//  MatchingStudyView.swift
//  MyStudyApp
//
//  Created by Carki on 2022/11/16.
//

import UIKit

import SnapKit

final class MatchingStudyView: BaseView {
    
    let keywordCollectionView: UICollectionView = {
        let view = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: view)
        cv.isPagingEnabled = true
        view.minimumLineSpacing = 0
        cv.showsHorizontalScrollIndicator = false
        view.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        view.scrollDirection = .horizontal
        
        return cv
    }()
    
    let searchSesacButton: UIButton = {
        let view = UIButton()
        view.setTitle("새싹 찾기", for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 14)
        view.backgroundColor = .colorGreen
        view.layer.cornerRadius = 8
        return view
    }()
    
    override func configureUI() {
        [keywordCollectionView, searchSesacButton].forEach {
            self.addSubview($0)
        }
        self.backgroundColor = .white
    }
    
    override func setConstraints() {
        keywordCollectionView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview()
        }
        
        searchSesacButton.snp.makeConstraints { make in
            make.top.equalTo(keywordCollectionView.snp.bottom)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.bottom.equalTo(safeAreaLayoutGuide).offset(-16)
            make.height.equalTo(48)
        }
    }
}
